Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62741923A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhI0KdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhI0KdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:33:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:31:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k24so17378369pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HtxhxA6meUImIIHC4/23ng+l1TP2cniMkNWzkjyF/iA=;
        b=LXx4yFUpzLbI0HXR9Y5FD3o4P9EHoA5w7yA1gJrz7Sb2LuHe7j+VbBuJ4L/mNUzara
         6TKYitNGrdTgA8XVyI3OtZaFp5W4EvnPKGtlvcGel3fIs7tXYiwh1ENwdoNp2f+q0864
         0TbLT/H0PkbVmAT+5y2kDErd4wxxZzs/YCrrwyhODHvl8c6UxH6OfAMJ5SLKaQOEewbH
         +ECtGJVLKZ9irspFvEsxlwDLrkpKJMjHVhp8x99MhmqvKp//GnwRrsaNdSJ4BSV3h+b+
         7SermQiGsMB2FdMxO377pJNwwGXQAD+00A/v3tpJ573IfKhaT8jV6svrFEkh8LzOmT/c
         6ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HtxhxA6meUImIIHC4/23ng+l1TP2cniMkNWzkjyF/iA=;
        b=7Rr0ZQqGTTvUq4xGiIFGAyRtKSkt9pS2hXge9dEY3HIuqWAX6acw40jIcwd8mB/0dT
         uxrxMThbZ0eWStILck9Vcpk2YBpSY6NP0zTPzMkMDPXvWOQ4mLbcLqKAlB7Q+WDGjNud
         3EgEiCzEs4pUg3ElobTuTYvxAx0QL3TzCz2ccH/FPw3nTb1WIyoJzE/qjjryHhAeUu39
         EJpmy+z9deKO/fpVysfau0MAcRRhLKKgxrVKM0Jcns39yHLKCKE+0LhjC8LGVNXKeU50
         0mKeGchmVLtfezrJzdiGhKN8cFMH1kt7oXv4BmjRM8Yfcf5d7FPLPYXYKDp36GHwyn7c
         iIoA==
X-Gm-Message-State: AOAM531103M7f4wxifpqxJ0rvkWtOEHN8xnrG4wPnSaPPRiamZADFsWG
        YetZkJ+irpOqkEJ2z1Fo2TU=
X-Google-Smtp-Source: ABdhPJxEgiJ/+ilfc4k4aCeWursLDLsRDFPSWG35UzaJxfmw7a9IDWSFSr9sAjUzjSkdifNyn5ioBQ==
X-Received: by 2002:a63:8541:: with SMTP id u62mr15840859pgd.308.1632738683465;
        Mon, 27 Sep 2021 03:31:23 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id b23sm16959276pfi.135.2021.09.27.03.31.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:31:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 4/8] mm/madvise: define madvise behavior in a struct
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927093103.g3cszw75gfctwtzk@box.shutemov.name>
Date:   Mon, 27 Sep 2021 03:31:21 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48D4E700-0005-46D4-8EAA-B839D8449C66@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-5-namit@vmware.com>
 <20210927093103.g3cszw75gfctwtzk@box.shutemov.name>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 2:31 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Sun, Sep 26, 2021 at 09:12:55AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> The different behaviors of madvise are different in several ways, =
which
>> are distributed across several functions. Use the design pattern from
>> iouring in order to define the actions that are required for each
>> behavior.
>>=20
>> The next patches will get rid of old helper functions that are =
modified
>> in this patch and the redundant use of array_index_nospec(). The next
>> patches will add more actions for each leaf into the new struct.
>>=20
>> No functional change is intended.
>>=20
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Colin Cross <ccross@google.com>
>> Cc: Suren Baghdasarya <surenb@google.com>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> mm/madvise.c | 168 =
+++++++++++++++++++++++++++++++++------------------
>> 1 file changed, 109 insertions(+), 59 deletions(-)
>>=20
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 17e39c70704b..127507c71ba9 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -29,6 +29,7 @@
>> #include <linux/swapops.h>
>> #include <linux/shmem_fs.h>
>> #include <linux/mmu_notifier.h>
>> +#include <linux/nospec.h>
>>=20
>> #include <asm/tlb.h>
>>=20
>> @@ -39,6 +40,101 @@ struct madvise_walk_private {
>> 	bool pageout;
>> };
>>=20
>> +struct madvise_info {
>> +	u8 behavior_valid: 1;
>> +	u8 process_behavior_valid: 1;
>> +	u8 need_mmap_read_only: 1;
>> +};
>> +
>> +static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] =3D=
 {
>=20
> MADV_SOFT_OFFLINE+1 smells bad.

I can set another constant instead and let the compiler shout if =
anything
outside the array is initialized.

>=20
> And I don't like the change in general. Given that MADV_SOFT_OFFLINE =
is
> 101, the array will be mostly empty.

Seriously, these is less than 128B - two cachelines. Perhaps they should
be aligned. But this whole change should have no effect on code/data =
size.

>=20
> I donno. I don't see any improvement with the patch. But maybe it's =
only me.

The following patches make it clearer when TLBs flushes are batched and
when mmap_lock is not taken (which is by the way not clear from the =
code).

I could have added two more functions for that and it would have taken
me less time. I do not think the end result of having ~5 different
functions to figure out the actions needed for each behavior would be
as clear.=
