Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5763387F77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351488AbhERSTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351480AbhERSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621361872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEtj3b1h+TVtthMLR2Vm0iC3HKcMa5FleveLxh8rZu8=;
        b=dGsgC6aJfIYZEhIoGgrPrHGstWXwIUx6U1WKy660r3//nMi23wA+IpVOUP5vjd9HWBlzAt
        uTprC29+RsyQs/Y6cRqOEGap5J5C3lOWzZAuOrdSlcK9jXun2y2J96XhQ8hoG7nmRg5Ijp
        RpqPPHYDl+BX0G2125W2td4/Slt1R1s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-gGtPzTuYN2alGP2CS7kVDw-1; Tue, 18 May 2021 14:17:50 -0400
X-MC-Unique: gGtPzTuYN2alGP2CS7kVDw-1
Received: by mail-wr1-f72.google.com with SMTP id p11-20020adfc38b0000b0290111f48b8adfso2459522wrf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEtj3b1h+TVtthMLR2Vm0iC3HKcMa5FleveLxh8rZu8=;
        b=Gm/cTugiANBFQfvRbwvDhQrDL0J+D5xihTCeV+k73/nIXPzRnEMtIVovJZUNy/btBa
         nEne9g7WYPbphXoM972Qm+eM69XvhSsje+aAjcsYZCVu58HuNWLc+dlrCLv69c3DG2b+
         VyA/M5CABcQWHknAAHAZkjEeaW0KlD3NILeEDNBcipc51sz0tWAU8jGkZseryEPLu4I2
         afqfHSkmkrNsfNnLGR9lb7lDDLgl2zy8NCJ8W7sfjntf4INScqOPxmB2mXnLNrIiY9JZ
         tr/kFFp1tpL/b1C6WM4Od6Oe3bltP04o/pZ/M8cdJvaru4e566u88l2PxLy1Ub7rib13
         omWw==
X-Gm-Message-State: AOAM533hWXCJOhLrDUs71lS2NBLk/SkEeJBFGoAT7tFc4Y6u3+dmcHIt
        XYOPW2jE4LUcPGFjqucRhre0RXNQ+tuJRhWrGZFy6s8+QscJCGYS1IaoY8NtkFAMpnRc7JhFGBo
        lMVKOAyJnPjz68zePxaBo4agiL17vArfkfDBD17c6
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr6362258wmq.164.1621361868423;
        Tue, 18 May 2021 11:17:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4tpMc0UiqFTnD6zHyjW8xwzSKubIEvzJUVyYl99FmY+w/NnEBD4LvzThF6zY7u8mIvEHhYDLFA7ELxxXlu6g=
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr6362238wmq.164.1621361868198;
 Tue, 18 May 2021 11:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000018cf5d05c2949b75@google.com> <20210518084625.1200-1-hdanton@sina.com>
In-Reply-To: <20210518084625.1200-1-hdanton@sina.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 18 May 2021 20:17:36 +0200
Message-ID: <CAHc6FU4totOX-S7r3BsZJ+n67MfCgTdC=_DL3XfC4NE0kRZgEw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in gfs2_glock_shrink_scan
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+34ba7ddbf3021981a228@syzkaller.appspotmail.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 18, 2021 at 10:49 AM Hillf Danton <hdanton@sina.com> wrote:
> When put, glock is removed from lru by calling gfs2_glock_remove_from_lru()
> in __gfs2_glock_put(), and check GLF_LRU under lru_lock.
>
> On the shrink scan path, GLF_LRU is cleared under lru_lock but because of
> cond_resched_lock(&lru_lock) in gfs2_dispose_glock_lru() progress on the put
> side can be made without deleting glock from lru.
>
> Keep GLF_LRU across the race window opened by cond_resched_lock(&lru_lock) to
> ensure correct behavior on both sides - clrear GLF_LRU after list_del under
> lru_lock.

can you please resend with a Signed-off-by tag and a valid patch (---
line missing)?

Thanks,
Andreas

> +++ x/fs/gfs2/glock.c
> @@ -1772,6 +1772,7 @@ __acquires(&lru_lock)
>         while(!list_empty(list)) {
>                 gl = list_first_entry(list, struct gfs2_glock, gl_lru);
>                 list_del_init(&gl->gl_lru);
> +               clear_bit(GLF_LRU, &gl->gl_flags);
>                 if (!spin_trylock(&gl->gl_lockref.lock)) {
>  add_back_to_lru:
>                         list_add(&gl->gl_lru, &lru_list);
> @@ -1817,7 +1818,6 @@ static long gfs2_scan_glock_lru(int nr)
>                 if (!test_bit(GLF_LOCK, &gl->gl_flags)) {
>                         list_move(&gl->gl_lru, &dispose);
>                         atomic_dec(&lru_count);
> -                       clear_bit(GLF_LRU, &gl->gl_flags);
>                         freed++;
>                         continue;
>                 }
>

