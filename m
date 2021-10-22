Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D7437A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhJVPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhJVPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:40:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB3C0432C7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:37:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v8so3948229pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tlB4K3HvAORgyqubeozQQGUWGfAg8IwBn63hJf+yjfY=;
        b=RViuZVo2fobIACL6d+M0VCvQakeby94xgn2AdisE5+IWbq/gil+TduV13hkeUM7N3X
         uX77LhZUOyApfB17PCxXmKxj/WrKu9/KBTujYLxT6eX2VtPojOBiCjdRoqOqimnd8BBr
         uorbnCpUkva7eT1mNXAs6LdgIn+e6/3v+VeUBPsQunDj4Ul7HKbTZGUUky6Kcw2p7K9A
         b60U2OY4DmBP2x8tWj8FnYuUNNXD9CC5HM4648mN/yJf9WtGfNpoyY4XD8VQ/xKs70dL
         rx3q2EtggeZ9M3RkNQp8IPUJuYmJuXhMUTxncdta8t8x3t19j843+jvmvubLYzubzZp+
         JuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tlB4K3HvAORgyqubeozQQGUWGfAg8IwBn63hJf+yjfY=;
        b=t03yVYMAh+VOCF7CVAiK0XOCnFSb6JN5RWLD3uwimmmqjLvpBT1gT7p1euSRZjsJ/B
         uxRcdqOWzajNDEft9OzOmuZJvmO0sXL0+9+xK1gLuyKWHC3BRhQhH6Soz2902O6wz3+I
         yGBqWsuBX5ALbzW9OiAMNp4bbnEE8p5gTd2LDhfZKhpjcxWJvKNEqU8J0CgR0G7gozt9
         ABA1e6cY/GRG5/TwiBqAl/5/KVP54wLZC6CXA56PixkwWAV5ccpKyBc6APCQmgpspH3P
         K8GFB7zS1iT4z0Pkjfy9WixjeKcTxvAfaTjBVPqV0GN2eUw5sMon2ErRQ8/n7pKekK8H
         fvEg==
X-Gm-Message-State: AOAM532RGdxPulhUx367eOdOdTzGar5d34BmGOlQqXdr8XmgO/iIgoUw
        UItNi8bCvPf9BJ7EKLi1qzPksU//KnY=
X-Google-Smtp-Source: ABdhPJxpezdeS9jkRZQOhc/pA0eCuqciKY3kF6GZQP1CUq3TitgsULTZMN1FlwA62xtrgKoxeS5NCQ==
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr702539pfj.79.1634917032347;
        Fri, 22 Oct 2021 08:37:12 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id x129sm10347541pfc.140.2021.10.22.08.37.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:37:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] mm: use correct VMA flags when freeing page-tables
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20211021200643.770f9d7bd3469b2ec9d6c401@linux-foundation.org>
Date:   Fri, 22 Oct 2021 08:37:08 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FD4A068-1332-49C8-A47C-B292EDA35F9B@gmail.com>
References: <20211021122322.592822-1-namit@vmware.com>
 <20211021200643.770f9d7bd3469b2ec9d6c401@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2021, at 8:06 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 21 Oct 2021 05:23:22 -0700 Nadav Amit <nadav.amit@gmail.com> =
wrote:
>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Consistent use of the mmu_gather interface requires a call to
>> tlb_start_vma() and tlb_end_vma() for each VMA. free_pgtables() does =
not
>> follow this pattern.
>>=20
>> Certain architectures need tlb_start_vma() to be called in order for
>> tlb_update_vma_flags() to update the VMA flags (tlb->vma_exec and
>> tlb->vma_huge), which are later used for the proper TLB flush to be
>> issued. Since tlb_start_vma() is not called, this can lead to the =
wrong
>> VMA flags being used when the flush is performed.
>>=20
>> Specifically, the munmap syscall would call unmap_region(), which =
unmaps
>> the VMAs and then frees the page-tables. A flush is needed after
>> the page-tables are removed to prevent page-walk caches from holding
>> stale entries, but this flush would use the flags of the VMA flags of
>> the last VMA that was flushed. This does not appear to be right.
>=20
> Any thoughts on what the worst-case end-user cisible effects of this
> would be?
>=20
> Again, I'm wondering about the desirability of a -stable backport.

This issue is not relevant for x86, which I am most familiar with, hence =
my
limited understanding of the impact on specific architectures.

In general, a TLB flush is needed after the page-tables are released
(in contrast to PTE removal) to prevent a speculative page-walk that =
might
access IO pages or install bogus entries. Such speculative page-walks =
have
been reported (on x86) as causing a machine-check. [1]

If a certain architecture has different page-walk caches for executable =
and
non-executable pages (i.e., different page-walk caches for iTLB and =
dTLB) or
for different page sizes, it might not perform the necessary TLB flush =
on the
proper TLB.

Looking at the code, we can see MIPS=E2=80=99s flow of:

tlb_flush()
->flush_tlb_range()
->local_flush_tlb_page()
->flush_micro_tlb_vm()

which calls flush_micro_tlb() only if (vma->vm_flags & VM_EXEC). So
MIPS cares about the VM_EXEC. Yet, it is not certain MIPS might be
affected.

For an architecture to be affected it needs to have all the following
properties:

1. Be able to experience hardware failure/exceptions on speculative
   page-walks.

2. Have separate page-walk caches for exec/data or huge/small pages.

3. Flush the TLBs based on VM_EXEC and VM_HUGETLB.

=46rom the code, MIPS has the 3rd property and presumably the 2nd, but =
it is
not certain it has the 1st.

I did not mark it as stable, since I am not sure such an architecture
exists.



[1] =
https://lore.kernel.org/lkml/tip-b956575bed91ecfb136a8300742ecbbf451471ab@=
git.kernel.org/=
