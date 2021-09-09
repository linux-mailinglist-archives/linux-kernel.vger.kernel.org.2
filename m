Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DEC4047D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhIIJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhIIJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631179953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6oxYI9ut8npw7lFLZ/z3EUqhsCOkpfGiXzm3CrP2Pc=;
        b=hx8ktJsYHfshQC0D+JvZytQIVzVKJgiRIRKF2vk/Vhwzv40gxVeHHiVqGfkDSVuw5vRjff
        bw24jIqwaZMS/ImmOZeujXb8di+EFSnYIxRAonqT1D3pR8xnMBxB/VRhJUIsqCkC91yldT
        XGOikG1iOjW1+LoDY0zjtb+VkOZ7HCg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-020vJ4ZGOtCbFQsYtFUdvQ-1; Thu, 09 Sep 2021 05:32:32 -0400
X-MC-Unique: 020vJ4ZGOtCbFQsYtFUdvQ-1
Received: by mail-lf1-f71.google.com with SMTP id bq3-20020a056512150300b003ee49c29389so496121lfb.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6oxYI9ut8npw7lFLZ/z3EUqhsCOkpfGiXzm3CrP2Pc=;
        b=WbWOiMpzsV8UO+rE68PUfH7+6VkgZ+LaeFeiXi6uDYuosMsDYoucFCDTKntZZ5k4Pn
         wT7hzYPnCugjAvUi0lXeElzgTUG/xvR2+nzimv41TqBcKVT0NwjpmEro+7cuWQ4Kte5C
         uGU3aDwckoYfNEoNzomcgvn5pkw+Z8GGVd4OuDFJdywNQvi+Y4mh3F2zn35YbTYO9MdT
         +zFbqQiuvSaO1442JD21T5fsDUbm1hMRx80ox4yXmF+B+8kbkDDf5jS36LwVxpO6TsoA
         1CCQ/EnJvj6mfQhIOsEyeWCPn/jRABbOftt3kjq4y79NipYt73skL70WJiBXs9+JFcaQ
         Pxgg==
X-Gm-Message-State: AOAM532maEe3/rRoQXX+DEM9B2MTEa7olR2M2aza0gOg61OxJXV8Kj21
        TubbOEGd0vHX0kOac0GlhaBfWFGrWKGPTB/j60yPxjeZAcCm6bOBB8VbFj9cDfqcO0fNDyRhwu2
        lP/0aHYQNZyAiQ+fGlBF6fPxZkB7yokRHVvOAdgkf
X-Received: by 2002:a05:6512:2001:: with SMTP id a1mr1631116lfb.498.1631179950932;
        Thu, 09 Sep 2021 02:32:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl0hlu0tmaQ2CMyDCL+WTPdOq32+SzUOb2yeoKq+vIsS1TTq4pXoe92IahEto4NDmVJCxLKpcU5CL4QNu/9Hg=
X-Received: by 2002:a05:6512:2001:: with SMTP id a1mr1631107lfb.498.1631179950780;
 Thu, 09 Sep 2021 02:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com> <20210909051706-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210909051706-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 17:32:20 +0800
Message-ID: <CACGkMEuSX6McCf2hcZJNKVj_1errDQGN9uPGhYWo55fsB5NKBw@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 5:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> > On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This new callback is used to indicate whether the vring size can be
> > > change or not. It is useful when we have a legacy virtio pci device as
> > > the vdpa device for there is no way to negotiate the vring num by the
> > > specification.
> >
> > So I'm not sure it's worth bothering. E.g what if we just fail
> > VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> >
> > Thanks
>
> More importantly is there and actual plan for supporting
> legacy devices? I don't think they currently work at a number
> of levels.

I think the answer is no, it would introduce a lot of burdens.

Thanks

>
> --
> MST
>

