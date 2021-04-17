Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316F362DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhDQFsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 01:48:25 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:55433 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229614AbhDQFsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 01:48:24 -0400
X-AuditID: 0a580157-f07ff700000551c1-47-607a76884173
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 5D.90.20929.8867A706; Sat, 17 Apr 2021 13:47:52 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 17 Apr
 2021 13:47:51 +0800
Date:   Sat, 17 Apr 2021 13:47:51 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     <linux-mm@kvack.org>, Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v1 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Message-ID: <20210417134751.0bee9e73@alex-virtual-machine>
In-Reply-To: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LhimD01+0oq0owePCUy2LO+jVsFp83/GOz
        +Lr+F7PF5V1z2CzurfnPanF+11pWi1Xz7jBbXGw8wGhxZlqRxZsL91gcuDy+t/axeOycdZfd
        Y/Gel0wem1Z1snls+jSJ3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83yQVwRXHZpKTmZJalFunb
        JXBlHG2+xliwS6yifelhtgbGc4JdjJwcEgImEj8WvmDsYuTiEBKYziQx4+psNgjnOaPE38UL
        mUCqWARUJbYsnMoMYrMB2bvuzWIFsUUEdCUmbOsF62YWeMAkMf/0TjaQhLBAqMTl7ktgNq+A
        lcS+NTvBBnEK2Euc2XaIEcQWErCT2Nm4CszmFxCT6L3yH6iGA+gke4nH6xUhWgUlTs58wgJi
        MwvoSJxYdYwZwpaX2P52DjPEGEWJw0t+sUN8Iy9x9/d0Rgg7VqLpwC22CYzCs5CMmoVk1Cwk
        oxYwMq9iZCnOTTfcxAiJrPAdjPOaPuodYmTiYDzEKMHBrCTCa9xZkSDEm5JYWZValB9fVJqT
        WnyIUZqDRUmcVzu9LEFIID2xJDU7NbUgtQgmy8TBKdXAFMWbW/R5fvr9jKmPD7JpBOZP0Zo7
        yaksxclpJ6vFM16zmj7n6tXm/CI1jbUrFHWjd0+bOvffi/mrBB7d0Gi6+jaPcdVUpnr3St/K
        Pr62A7s8t3c8mGp7x1mSp9ORZcvJnwcN9W6+2nB4zSrxZV0cZ5ifXtw0rYxl1v9UiwmNRtPY
        OJpn/zhhMOndhCTWoP0Z7bw19xjna/zoX2/5LZGNj6erujDyfWyX8/bfxjfvfWrOnbq0ene+
        7H7HDa+YujnmGLRmrAksTfzQLHeVW9Jwukb88k7jcPHjPA+fLm0XEZ1zfMaqy+WiIr2MCiku
        Dfs73m9a+bt6nVO16AolBq8rd3MUSjeLO6qLb6ji2hGoxFKckWioxVxUnAgARF3BthsDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 07:43:17 +0900
Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> Hi,
> 
> I wrote this patchset to materialize what I think is the current
> allowable solution mentioned by the previous discussion [1].
> I simply borrowed Tony's mutex patch and Aili's return code patch,
> then I queued another one to find error virtual address in the best
> effort manner.  I know that this is not a perfect solution, but
> should work for some typical case.
> 
> My simple testing showed this patchset seems to work as intended,
> but if you have the related testcases, could you please test and
> let me have some feedback?
> 
> Thanks,
> Naoya Horiguchi
> 
> [1]: https://lore.kernel.org/linux-mm/20210331192540.2141052f@alex-virtual-machine/
> ---
> Summary:
> 
> Aili Yao (1):
>       mm,hwpoison: return -EHWPOISON when page already
> 
> Naoya Horiguchi (1):
>       mm,hwpoison: add kill_accessing_process() to find error virtual address
> 
> Tony Luck (1):
>       mm/memory-failure: Use a mutex to avoid memory_failure() races
> 
>  arch/x86/kernel/cpu/mce/core.c |  13 +++-
>  include/linux/swapops.h        |   5 ++
>  mm/memory-failure.c            | 166 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 178 insertions(+), 6 deletions(-)

Hi Naoya,

Thanks for your patch and complete fix for this race issue.

I test your patches, mainly it worked as expected, but in some cases it failed, I checked  it
and find some doubt places, could you help confirm it?

1. there is a compile warning:
static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
			      unsigned long end, struct mm_walk *walk)
{
	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
	int ret;    ---- here

It seems this ret may not be initialized, and some time ret may be error retruned?

and for this:
static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
				unsigned long poisoned_pfn, struct to_kill *tk)
{
	unsigned long pfn;

I think it better to be initialized too.

2. In the function hwpoison_pte_range():
if (pfn <= hwp->pfn && hwp->pfn < pfn + PMD_SIZE) this check seem we should use PMD_SIZE/PAGE_SIZE or some macro like this?

3. unsigned long hwpoison_vaddr = addr + (hwp->pfn << PAGE_SHIFT & ~PMD_MASK); this seems not exact accurate?

4. static int set_to_kill(struct to_kill *tk, unsigned long addr, short shift)
{
	if (tk->addr) {    --- I am not sure about this check and if it will lead failure.
		return 1;
	}
In my test, it seems sometimes it will hit this branch, I don't know it's multi entry issue or multi posion issue.
when i get to this fail, there is not enough log for this, but i can't reproduce it after that.

wolud you help confirm this and if any changes, please post again and I will do the test again.

Thansk
Aili Yao
