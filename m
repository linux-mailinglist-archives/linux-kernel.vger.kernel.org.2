Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F974047A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhIIJTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232344AbhIIJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631179108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Krg9n2n4lgxmyAY3a21a0zB1D/G0I7D/mxMTX6GAsu0=;
        b=TyPXTRSHe94X6YbqT9B4IEyLN57CuXHalZdYuYPjhrKX4t/Is+lusXqX6+LQcdEjA1BHzw
        bHLk1vkft3cV0egxV0xiVp4uZ0z/hHxuJMwTjaQyLcIzbCkmMKUdCKEXzKEmg3GSxDnm3Y
        JjquqVV2uxmyI0fkXGPJFMRc2D5DCAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-GwuC6Js2Ot2fUbUQma4jhA-1; Thu, 09 Sep 2021 05:18:27 -0400
X-MC-Unique: GwuC6Js2Ot2fUbUQma4jhA-1
Received: by mail-wm1-f70.google.com with SMTP id g18-20020a1c4e12000000b002fa970d2d8dso490395wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Krg9n2n4lgxmyAY3a21a0zB1D/G0I7D/mxMTX6GAsu0=;
        b=AhHsWVaZqNdgoaOoIqP7jC1v6GnXAYOKVYNeFsPAtJkOrZOD20H8rmJQhESRwclOP6
         XYnrgPyp47voONZ+eNqEb87L1Qmt4Ecnz01VX7/k+S/s7Jo9ueIqvklX/CuvJTBKcagW
         rcxeEtOHYde7+Rv4rdIQf4GIJEs+ngtMWOQFCz8L6CH62p0n3IRtC6hCo9EZuLmPFljv
         KRp2/Zc+QqTn2mHT/iXDp2CXTeiabmshwxLA/WuBSfZxusiSbbFn+8jO4nL5VGZMO93B
         oe8q3VJAU/+GSbvGo5+lwB0DAfP3xGzztZxHWFyMF8q4bph2gvl2EiqZcSj8W4C7IMA2
         AI5g==
X-Gm-Message-State: AOAM5336nW0mgjnaXU1WYolk2qNvjtHhPfbRohJkrwEM0YIGOnLefukb
        0e5+O57QmNVSCo+Knyy6KAsG3W9mfpZyo3jDgzpvhb+qNtUGXqHKjJtxpmVcIHAzmbZ8yqS4bGw
        miBCuUifB5bi5OMtlP2ck/N3l
X-Received: by 2002:adf:ea90:: with SMTP id s16mr2310722wrm.235.1631179105917;
        Thu, 09 Sep 2021 02:18:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFjAq21nDbpWPPjrbsJfaoxNYRTgyf2/ZBVzU5v/LEOsfI5v4OEI9flJnqQ6AXpadGjfF5Ug==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr2310707wrm.235.1631179105696;
        Thu, 09 Sep 2021 02:18:25 -0700 (PDT)
Received: from redhat.com (bzq-84-108-84-219.cablep.bezeqint.net. [84.108.84.219])
        by smtp.gmail.com with ESMTPSA id e8sm1263084wrc.96.2021.09.09.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:18:24 -0700 (PDT)
Date:   Thu, 9 Sep 2021 05:18:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in
 vdpa_config_ops
Message-ID: <20210909051706-mutt-send-email-mst@kernel.org>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> >
> > This new callback is used to indicate whether the vring size can be
> > change or not. It is useful when we have a legacy virtio pci device as
> > the vdpa device for there is no way to negotiate the vring num by the
> > specification.
> 
> So I'm not sure it's worth bothering. E.g what if we just fail
> VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> 
> Thanks

More importantly is there and actual plan for supporting
legacy devices? I don't think they currently work at a number
of levels.

-- 
MST

