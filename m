Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C403F46AF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhHWIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbhHWIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:36:11 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0F4C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:35:29 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z2so16367665iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tx8bMR+lOBd3awFoR8CVCTlGLN+f7fEbT8oVJPyVcwE=;
        b=wB2fZ7WIH8cS/s5QYqSkhN1A1R05CYxpfXGOZ6Q9GX4SPnyavyRgNjLtejPrSFfv8i
         2gcTeRqoX3sd5/543IQ9Ir9RL+iQWkFIFCa6/SLb8SU2COeWbXisaL9W4P/rMrqe7D5X
         dJwy+yRwkcqPDfMI1960O03TgtU+E+iDBdJOPMbkN2PtpGaJ24e5Ss51RQgBQgM1ezAN
         OOrorPMHkCCCtmue4vjKfozHobJmsJK3d+w2XNFNhZ4SF/0LPJDunmpjwBU4+1f4OWRi
         UYswgxDhbqt7WxMMVLOOIiLPRzrJ3H4IVdgyvP8PS5fGNTnAF/d5eonouGqGd7RRA3It
         6WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx8bMR+lOBd3awFoR8CVCTlGLN+f7fEbT8oVJPyVcwE=;
        b=s/eFxzxmNJU8yrVb9Ty3XoStvMrJ/ERenCGLLX0W9ZslW7q+T0MfRl1w+Jb5H4Wnaq
         soRvVgyeHZK5vtqnnNhC47hjl99nhNHdqoXQzYvi8YcfpMWnwrvAmv4skvSLPgFedtQS
         BfI0LnrWGrzLcZ6lQbwMcHIntt6vrn8RQXIXOWTlZmHpteb5IfLHdcFDUe5GhWyLMfHn
         g/hy6ZRGKf7Jk/DyHxX6v3zIZKEGf1msxIp0N5/OQYsf0xdEFtYRsQf0/UDNlTEQqdVj
         zBggtAO9zMg9BmPhDY9rmiJ1C+2S+Bb0v7uvoDX32J4rWZjjLxyJG/TLnjqfW+obrILk
         Z8MQ==
X-Gm-Message-State: AOAM531O4M0xruij0YLd+obACFGWNRC8jNFH6j6RFXJVa3jSfei9GJtr
        Q8w3tYejf8Qxctcd65tBE1jziSESR14NXiC497kC
X-Google-Smtp-Source: ABdhPJw0ZmW0dfx4FroLX5jChLmPb98AUNjMizR5s7Juwr0xoX1wJm0RFwAjxQCpfMfS8TLzBw+DT+expp8kywb95Us=
X-Received: by 2002:a92:c887:: with SMTP id w7mr10433450ilo.129.1629707728687;
 Mon, 23 Aug 2021 01:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com> <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
In-Reply-To: <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 16:35:17 +0800
Message-ID: <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/23/2021 7:31 AM, Yongji Xie wrote:
> > On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/9/2021 1:16 PM, Xie Yongji wrote:
> >>> An untrusted device might presents an invalid block size
> >>> in configuration space. This tries to add validation for it
> >>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> >>> feature bit if the value is out of the supported range.
> >> This is not clear to me. What is untrusted device ? is it a buggy device ?
> >>
> > A buggy device, the devices in an encrypted VM, or a userspace device
> > created by VDUSE [1].
> >
> > [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
>
> if it's a userspace device, why don't you fix its control path code
> instead of adding workarounds in the kernel driver ?
>

VDUSE kernel module would not touch (be aware of) the device specific
configuration space. It should be more reasonable to fix it in the
device driver. There is also some existing interface (.validate()) for
doing that.

And regardless of userspace device, we still need to fix it for other cases.

Thanks,
Yongji
