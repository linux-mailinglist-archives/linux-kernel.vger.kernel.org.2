Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075693639CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhDSDop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:44:45 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:1064 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232753AbhDSDoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:44:44 -0400
X-AuditID: 0a580155-2a3ff70000061b1d-0e-607cfc7ad776
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id BD.FF.06941.A7CFC706; Mon, 19 Apr 2021 11:43:54 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Apr
 2021 11:43:54 +0800
Date:   Mon, 19 Apr 2021 11:43:53 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2 3/3] mm,hwpoison: add kill_accessing_process() to
 find error virtual address
Message-ID: <20210419114353.3fdeb3ba@alex-virtual-machine>
In-Reply-To: <20210419023658.GA1962954@u2004>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
        <20210417134751.0bee9e73@alex-virtual-machine>
        <20210419010955.GA17180@hori.linux.bs1.fc.nec.co.jp>
        <20210419023658.GA1962954@u2004>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LhimD01636U5NgcOuftsWc9WvYLD5v+Mdm
        8XX9L2aLy7vmsFncW/Of1eL8rrWsFqvm3WG2uNh4gNHizLQiizcX7rE4cHl8b+1j8dg56y67
        x+I9L5k8Nq3qZPPY9GkSu8eJGb9ZPF5c3cji8X7fVTaPzaerPT5vkgvgiuKySUnNySxLLdK3
        S+DK2LX9CHPBPoGKg6u3szYw/uTpYuTkkBAwkdjas42li5GLQ0hgOpPEks+H2SCc54wSG67t
        ZQapYhFQlXh4egcbiM0GZO+6N4sVxBYR0JWYsK2XEaSBWeAks0TTt8dMIAlhgVSJrR8msncx
        cnDwClhJNE9SAAlzAtVv6/3PDrHgJKPEjg/XwBbwC4hJ9F75zwRSLyFgL/F4vSJImFdAUOLk
        zCcsIDazgI7EiVXHmCFseYntb+eA2UICihKHl/xih/hGXuLu7+mMEHasRNOBW2wTGIVnIRk1
        C8moWUhGLWBkXsXIUpybbrSJERJZoTsYZzR91DvEyMTBeIhRgoNZSYT3fm1NghBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHea6ZAKYH0xJLU7NTUgtQimCwTB6dUA1OIySqzd8KpDE/jDNLub2ha
        v0tpKdfx65YsIusF1Bw7xFpSrv6Py828fLDw5fa+vK7pL4vez9h6uOEW77SpSa6vvq2drLiu
        xy5y4ndx75azqrsmpRkb1/6wur9w6XcVvQbWA83TPOvmvBK5tne+5JGzeXu1TxfHNMT7JN0+
        +tjpldYER52qqopT2p9eqtu5/po567R2+rM8xmyl7ZKT2pcsZL65eaLRVcfOlzdO35NYNmlB
        lPLsVV4cV3nvHJDysEkOSmn6vcV8pf6nxbp8u5O+3J88t3/5lVmy0/YrZ9U9DvsuGPxgY6uC
        xtwsvZbc4pyLrVa186cs2CrbGicv717MtemVsPPm+dLNRxeaaM1VYinOSDTUYi4qTgQAyV2e
        LxsDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 11:36:58 +0900
Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> > > 2. In the function hwpoison_pte_range():
> > > if (pfn <= hwp->pfn && hwp->pfn < pfn + PMD_SIZE) this check seem we should use PMD_SIZE/PAGE_SIZE or some macro like this?  
> > 
> > Thanks, that's right.  HPAGE_PMD_NR seems to fit here.
> > We also need "#ifdef CONFIG_TRANSPARENT_HUGEPAGE" to use it.  
> 
> I found that the #ifdef is not necessary because the whole
> "if (ptl)" is compiled out.  So I don't add #ifdef.
> 
> Here's the v2 of 3/3.
> 
> Aili, could you test with it?
> 
> Thanks,
> Naoya Horiguchi
> 

I tested this v2 version, In my test, this patches worked as expected and the previous
issues didn't happen again.

Test-by: Aili Yao <yaoaili@kingsoft.com>

Thanks,
Aili Yao

> -----
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Tue, 13 Apr 2021 07:26:25 +0900
> Subject: [PATCH v2 3/3] mm,hwpoison: add kill_accessing_process() to find error
>  virtual address
> 
> The previous patch solves the infinite MCE loop issue when multiple
> MCE events races.  The remaining issue is to make sure that all threads
> processing Action Required MCEs send to the current processes the
> SIGBUS with the proper virtual address and the error size.
> 
> This patch suggests to do page table walk to find the error virtual
> address.  If we find multiple virtual addresses in walking, we now can't
> determine which one is correct, so we fall back to sending SIGBUS in
> kill_me_maybe() without error info as we do now.  This corner case needs
> to be solved in the future.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
> change log v1 -> v2:
> - initialize local variables in check_hwpoisoned_entry() and
>   hwpoison_pte_range()
> - fix and improve logic to calculate error address offset.
> ---
>  arch/x86/kernel/cpu/mce/core.c |  13 ++-
>  include/linux/swapops.h        |   5 ++
>  mm/memory-failure.c            | 147 ++++++++++++++++++++++++++++++++-
>  3 files changed, 161 insertions(+), 4 deletions(-)
> 


