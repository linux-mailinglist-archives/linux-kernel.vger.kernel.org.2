Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223C1364B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhDSUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhDSUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:33:17 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:32:47 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id a11so1469348vkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hZIM+x23q0A7UAi2bLceHdWLfsqyYiEeL8Ivzgxf6vI=;
        b=bBeMgwnbZMMu0gE4mk9GFkiorCqXAKTvE45soY4o1fvNiBkfqj8H7aQ5SfEL77FQ7t
         nqXhsJpW0e/la0/iqsnbeeqOsVobBbzjQG9Kei7s2d+QJ/Au2nsJtFc6r6DBZp3NFzSV
         tw/Fztic2l0Ejp+/ArbfzmOIONJauF991A0EcnwbM/yB9S5e1bDTqtZYM1jts8OQLNWN
         qfiiYtsV4QrODCCrL4l1Az8ApDtYfNikE8rmhkiy24U8NN4o4UtRDFn+gkFO83pJFkkp
         VytK19MCX5Qo9SsqCdxV6KXpLti9mgp7wu5lKLRsMwvv88DESrXik2gLQk8iAMiHUMQK
         7H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hZIM+x23q0A7UAi2bLceHdWLfsqyYiEeL8Ivzgxf6vI=;
        b=g0WjQ8/12FI7IAsMNHDMvJe8PairD7iRtWC8vahT9po08p/C+LSW63yI5/GyHRGiyP
         N/UDuAe5BuIoLQfofZ4g9D79f+1HXqGflQtTtC+KlrTYPpxQwO3+w909YCSoB5terq3V
         gCqmZ+pIErSQXtdc15TpyTAIAisLw9ysFVJOo93Dx/q/j/XU4bKPaO6xrezEbO14PKq7
         EQ2ATDQfBxIIixZXYT0gKzUp8AykrXikmAv0H+Cgz+EKSoQc4aXpeikCkxCeiUy8YEHS
         CmHmIDfdLpxUdyaiv77W5Evy432Dlo5PZ9aokYrehVcgzBEU9ovQ2ObXRDOLIG7RrsQc
         UlUQ==
X-Gm-Message-State: AOAM532yg7IagQZrLq4H0L1LDrUdZEWu/TMWbeQ3wYbdoJ4Lvp8AoK4q
        WEMf70/qV7AiBKaOyByzdDuzgWbWz1+T7IUIISYtUg==
X-Google-Smtp-Source: ABdhPJx5VwlGTJo82ed//GvPXquJ1foNXE2IGpGAdcHZpn2hmm+zqbcuHnIvIltGvbDg/Ju8ZOeLGMgVdqvinYCAEFk=
X-Received: by 2002:ac5:c185:: with SMTP id z5mr16995254vkb.19.1618864365806;
 Mon, 19 Apr 2021 13:32:45 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Mon, 19 Apr 2021 13:32:35 -0700
Message-ID: <CAPcxDJ7fKHF69T6jepX+yVP=+t43i9hQD3W6SaaDLk9_UBy9uw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, x86 <x86@kernel.org>,
        yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 10:08:52 -0700, Tony Luck wrote:
> KVM apparently passes a machine check into the guest. Though it seems
> to be misisng the MCG_STATUS information to tell the guest whether this
> is an "Action Required" machine check, or an "Action Optional" (i.e.
> whether the poison was found synchonously by execution of the current
> instruction, or asynchronously).

The KVM_X86_SET_MCE ioctl takes a parameter of struct kvm_x86_mce, hypervisor
can set with necessary semantics.

1140 #ifdef KVM_CAP_MCE
1141 /* x86 MCE */
1142 struct kvm_x86_mce {
1143         __u64 status;
1144         __u64 addr;
1145         __u64 misc;
1146         __u64 mcg_status;
1147         __u8 bank;
1148         __u8 pad1[7];
1149         __u64 pad2[3];
1150 };
1151 #endif

> > Are we documenting somewhere: "if your process gets a SIGBUS and this
> > and that, which means your page got offlined, you should do this and
> > that to recover"?

> Essentially it boils down to:
> SIGBUS handler gets additional data giving virtual address that has gone away

> 1) Can the application replace the lost page?
> Use mmap(addr, MAP_FIXED, ...) to map a fresh page into the gap
> and fill with replacement data. This case can return from SIGBUS
> handler to re-execute failed instruction
> 2) Can the application continue in degraded mode w/o the lost page?
> Hunt down pointers to lost page and update structures to say
> "this data lost". Use siglongjmp() to go to preset recovery path
> 3) Can the application shut down gracefully?
> Record details of the lost page. Inform next-of-kin. Exit.
> 4) Default - just exit
Two possible addition to these great points:
5) If for some reason the page cannot be unmapped (e.g.,
either losing to much memory like hugetlbfs 1G pages, or
THP split failure for SHMEM THP), kernel maintains a
consistent semantic (i.e., MCE SIGBUS with vaddr) to all future
accesses from user space, by leaving the hwpoisoned page
mapped or in the radix tree.
6). If for some reason the vaddr is not available upon the
first MCE recovery and page is unmapped, kernel provides
correct semantic (MCE SIGBUS with vaddr) in subsequent
page faults from user space accessing the same vaddr.
