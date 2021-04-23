Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BBA369B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbhDWUPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhDWUPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619208880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPiSTsL8TiObPGwF4YH7BB+/X0Qk9VUlPRyHxvfkG+U=;
        b=Zm+x4fWvUMNy+zoBIVdJU5lBtuap8neZWMZ4o7t/kZOacM1B9UbnoNm/2bIGsYAFZRipEK
        f1ANL5AaE9sX7HeFnEl6qImYFTkx08X4mmOYkKAJJSKV4/9Yola0QskJEDnATNyFj6dH7b
        DKs6aW27uYF1TOrHbwGBBIoZi7yIGa8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-tkv1k6STMnaY8c9OsPOqHA-1; Fri, 23 Apr 2021 16:14:38 -0400
X-MC-Unique: tkv1k6STMnaY8c9OsPOqHA-1
Received: by mail-wr1-f71.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so15492246wrl.15
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 13:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kPiSTsL8TiObPGwF4YH7BB+/X0Qk9VUlPRyHxvfkG+U=;
        b=Zhnzm0OBoMtCaFyaXU8hlR3hA2Eu4QXSVkDmCjYo98GAh+ViyIXO50szpPyXMeQ1UY
         eHa5WMJAxYWQVPff27yNvFMd9ZZ/fSjsKsllHh5VpEvmFtFVQR7JE6jVn2pI6PLs1V2v
         8cHe5RrXG125X/m0ULvAux2uCi/Kf9o1pf7xzqJIuo4tFBDsMvPkgXlZvo4NRFqN35+D
         izfgFJkhPaHA5cxab9a9/a79QHLJtnTYofMjOEcoHjH2fzLoIMdH7h5UBGLjrPF65kwv
         bdqMaf+P3PyuBBumvQX43A4ajiYuBd2XDtn28+BYPvIJYSECQISgA4U6k9BK9UvyIzhn
         NlCQ==
X-Gm-Message-State: AOAM532qS2FSibfyyrYzbgdFTbnt/4O7XGu01VUdnlUdZxKaQr4CLSyI
        ZRYEpcHNY4yKVFLV9lyV2UNV1Ix0JYFmHgRDpwK0ndim8kyrOMastoeXJbjl9iSxc1Tke6bql78
        OEdyLSv0LDkMRCC3u0lzCxB8u
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr6889802wro.16.1619208876781;
        Fri, 23 Apr 2021 13:14:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS1qAa/j7zcr+DtFN+X2GWOzkZj3CTy5jb00vUo5xDAoIFKiSI5gTfVmMkq6tnjXpLfUWn/g==
X-Received: by 2002:adf:f0cc:: with SMTP id x12mr6889783wro.16.1619208876551;
        Fri, 23 Apr 2021 13:14:36 -0700 (PDT)
Received: from redhat.com (212.116.168.114.static.012.net.il. [212.116.168.114])
        by smtp.gmail.com with ESMTPSA id s14sm9819112wrm.51.2021.04.23.13.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 13:14:35 -0700 (PDT)
Date:   Fri, 23 Apr 2021 16:14:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com,
        stefanha@redhat.com, file@sect.tu-berlin.de, ashish.kalra@amd.com,
        martin.radev@aisec.fraunhofer.de, konrad.wilk@oracle.com,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
Message-ID: <20210423161114-mutt-send-email-mst@kernel.org>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <20210422063128.GB4176641@infradead.org>
 <0c61dcbb-ac5b-9815-a4a1-5f93ae640011@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c61dcbb-ac5b-9815-a4a1-5f93ae640011@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:19:16PM +0800, Jason Wang wrote:
> 
> 在 2021/4/22 下午2:31, Christoph Hellwig 写道:
> > On Wed, Apr 21, 2021 at 11:21:10AM +0800, Jason Wang wrote:
> > > The behaivor for non DMA API is kept for minimizing the performance
> > > impact.
> > NAK.  Everyone should be using the DMA API in a modern world.  So
> > treating the DMA API path worse than the broken legacy path does not
> > make any sense whatsoever.
> 
> 
> I think the goal is not treat DMA API path worse than legacy. The issue is
> that the management layer should guarantee that ACCESS_PLATFORM is set so
> DMA API is guaranteed to be used by the driver. So I'm not sure how much
> value we can gain from trying to 'fix' the legacy path. But I can change the
> behavior of legacy path to match DMA API path.
> 
> Thanks

I think before we maintain different paths with/without ACCESS_PLATFORM
it's worth checking whether it's even a net gain. Avoiding sharing
by storing data in private memory can actually turn out to be
a net gain even without DMA API.

It is worth checking what is the performance effect of this patch.


-- 
MST

