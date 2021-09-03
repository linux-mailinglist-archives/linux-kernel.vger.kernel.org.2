Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9744006AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbhICUeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhICUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:34:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA234C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 13:33:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so619294lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIdOCwskLhI0m4Y2FZRTnOUO+8ZEDMLcxJfUG+PYvsE=;
        b=elj3tFd6Azm9vkuRGF+FrmR71fOH2ItuvYsMvpUWC4tTW+kE9P9mmsuv21eqppFMNT
         OVOeJXFeNwUr1u4luok6uLL6cLGY45GR0Uo54NN8xZs0s2622ASNm0G2rjlW8mGOI5RB
         bDAq4/XAt2wl3feYfbjdMrARbuXCN3pOs/p3pO5Ju2RIysueURvBes8LXn9z1ogrCv2i
         7IuS/nyX5ebUC5BKHYXO1YTTkzTqehPTere1t8wl57nl6YAm0isSNrR+lhanyaUVzWaY
         cOqSwCiSO3wvalKuTPcXQl4gcVjT9PqmNUgwG0gM0FcJ3t1sX4lW9bHNNuLrsFf2zjTQ
         n+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIdOCwskLhI0m4Y2FZRTnOUO+8ZEDMLcxJfUG+PYvsE=;
        b=VbZOE4rixaH1SinYjv6/9opI0yTgul6gKmQIoFmxkyFy+jt/qzk0bgBmJwlw+jhism
         1Rr7m33PHCRrJXuKepq4n+h3pblcUOSjWrLBLSJww9xv80QzPo3Vjrt73lQ0Q7HC6QuP
         Q+Ah1iIoDAM0nhvnGt/Nhmg2J4g21Pr7Uk+H1TMHFYmJiT+uAXhcN+kR+VJONh3QuI2+
         1p9vMApu35nPcYj8uLhNYRJsnS6H3QyLNkziG5MY+Hemj2yAb+Y3XM2gQB7cYt2gCeuD
         tDSZLoiufIGw2vSIzsKW1n5IbIdNlUg4/87w7e5mrjzWIaopaLhqxlPWYUBXJnfVPi8K
         RSeg==
X-Gm-Message-State: AOAM533xe49cSBAUpvilzmVIT1zH2xWDsvsoHLgELSsd3n1Pmf9qHkUk
        NCTNM/vnQ7BRj/Rmd2YBK1a+oS4w3TX9iuqbUjF6OpSD14PYtA==
X-Google-Smtp-Source: ABdhPJybDor+zVy/06ynl2HCn/3r7iQr2WBBZejKayn8CxV4gBUWz2lh/Sb6wJsZCF/ZDPOCHR/e5G1kkFqL5PlGXSk=
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr577564ljc.30.1630701202021;
 Fri, 03 Sep 2021 13:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210902172404.3517626-1-daeho43@gmail.com> <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
In-Reply-To: <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 3 Sep 2021 13:33:11 -0700
Message-ID: <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>         if (f2fs_need_seq_seg(sbi))
>                 return 0;
>
> static inline bool f2fs_need_seq_seg(struct f2fs_sb_info *sbi)
> {
>         return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_FIXED_BLK;
> }
>

Do you need this in select_policy(), either?
Like,
        if (f2fs_need_rand_seg(sbi))
                p->offset = prandom_u32() % (MAIN_SECS(sbi) *
sbi->segs_per_sec);
        else if (f2fs_need_seq_seg(sbi))
                p->offset = 0;

> One more concern... we'd better to save fragment_remained_hole as well
> as fragment_remained_chunk,  otherwise, if fragment_chunk_size +
> fragment_hole_size > 512, fragment hole will be truncated to 512 -
> fragment_chunk_size due to we won't create hole with enough size as
> seg->next_blkoff has crossed end of current segment.
>

Sorry, I don't get it. You mean making fragment_remained_hole as a
global variable?
Maybe, we run into the same race condition issue you told before for
fragment_remained_chunk.
Could you clarify this more?

Thanks,
