Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F795368234
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhDVOL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhDVOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:11:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFE4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:10:49 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i81so45918965oif.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=600yFqdvLD6QPDeXvLbZtVFaRxpf+lbCpMUSy9z+aew=;
        b=l0At3nLZ1t+yqC//2RYbMYuu11jD3AJPgV2m+fCvGiTGSloUt+jiPiiVetXXYXYnj2
         D4dlqS/3mYmyxrJtAnVZreuk1X83dnHn0VV/BIQ5E85XIDErxPO9g/jGqJN1Ct1JG3xL
         7wox/dvT+hI6sc9ta5DvUzT0cTbbrCb3458UA3yzCMLTr73STov7KKXtDmRcUFtdW1ZR
         j/j0izHpcnxxUoXuz/V/kVhYWNTAxVRv6a4Bn/6vv0YZVL2bJZ/TRN3S4ena8pJa843s
         xaGV72FyWORcIV6HpQTI50k7RSgNFBvrk7Lh+wcZbNfvIeN7bStml3ZkKXx1Y7QjvHUb
         6Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=600yFqdvLD6QPDeXvLbZtVFaRxpf+lbCpMUSy9z+aew=;
        b=KRG4OVdF6vBhgt2HtCalBKBxb6Ra2WRC9KaCBvnpQEjrDgXh70Zz5IQRlS27e+mgbd
         FG9o0VbvdQ6jTdtuHGdBHFRdpmTbrhhZqHpudzhE9GdrgxhJiP7YFciBXyp+/NlxVc9S
         fZ/TykryrH1kf5NXUveWckIMchiQh+rEzxxCMYGR+cx5mBq9CtCtgPtup54+p7Rk1fTc
         2XLzRVPiI7aXjuz8O9z12604z5GiXcXH3QJPjsGCsFSBdXS0f/ska3MUPSDGxiOxnZqO
         6sNsEuZJMyBF8YdFq8KIFKLl5fDtP62RWQQk1uNs60+2AHIzKbICkXEIgf+0XoFFumtS
         Pxiw==
X-Gm-Message-State: AOAM533sfEpMEfSKsVX4Jd1tTpHuWWs1qm7CkD49AhINxO6kF7q7ZkvC
        75n7lFwziRZ91Sb4qpA43eW89KxddQekBQ+lxz3baw==
X-Google-Smtp-Source: ABdhPJzLqfWX/hkWVpkfSOPUWXCJQ76VlJkSCdMWODVYg3w/XYdzkxR48j5tAkftxScDWQ40rQSlAatrGtreiVwrv5E=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr2377466oif.121.1619100648941;
 Thu, 22 Apr 2021 07:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcas5p2.samsung.com>
 <1619079317-1131-1-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1619079317-1131-1-git-send-email-maninder1.s@samsung.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 22 Apr 2021 16:10:37 +0200
Message-ID: <CANpmjNOT7xVbv4P1n3X24-HH8VMBs7Ny33DFYbzjO6Gqza2mZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/kasan: avoid duplicate KASAN issues from reporting
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 at 11:17, Maninder Singh <maninder1.s@samsung.com> wrote:
>
> when KASAN multishot is ON and some buggy code hits same code path
> of KASAN issue repetetively, it can flood logs on console.
>
> Check for allocaton, free and backtrace path at time of KASAN error,
> if these are same then it is duplicate error and avoid these prints
> from KASAN.

On a more fundamental level, I think this sort of filtering is the
wrong solution to your problem. One reason why it's good that
multishot is off by default is, because _every_ KASAN report is
critical and can destabilize the system. Therefore, any report after
the first one might be completely bogus, because the system is in a
potentially bad state and its behaviour might be completely random.

The correct solution is to not leave the system running, fix the first
bug found, continue; rinse and repeat. Therefore, this patch adds a
lot of code for little benefit.

The much simpler solution that will likely yield a similar result is
to simply define an upper bound on the number of reports if multishot
is on. Because if I've seen 1000 reports, I already know the system is
completely trashed and whatever else it's reporting might just be
random.

Thanks,
-- Marco
