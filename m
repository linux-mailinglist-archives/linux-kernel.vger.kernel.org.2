Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26DB377D92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhEJIBi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 May 2021 04:01:38 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:3575 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230049AbhEJIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:01:30 -0400
X-AuditID: 0a580157-bebff70000027901-3d-6098e8167e7f
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 59.16.30977.618E8906; Mon, 10 May 2021 16:00:22 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 16:00:22 +0800
Date:   Mon, 10 May 2021 16:00:21 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: Re: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has
 already been poisoned
Message-ID: <20210510160021.648b41db@alex-virtual-machine>
In-Reply-To: <20210510072128.GA3504859@hori.linux.bs1.fc.nec.co.jp>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
        <20210427062953.2080293-3-nao.horiguchi@gmail.com>
        <20210507173852.0adc5cc4@alex-virtual-machine>
        <20210510072128.GA3504859@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXCFcHoryv2YkaCwaTHOhZz1q9hs/i84R+b
        xdf1v5gtbt4ysbi8aw6bxb01/1ktzu9ay2qxat4dZouLjQcYLc5MK7J4c+Eei8Wz1qssDjwe
        31v7WDx2zrrL7rFgU6nH4j0vmTw2repk89j0aRK7x4kZv1k8XlzdyOLxft9VNo/Np6s9Pm+S
        C+CO4rJJSc3JLEst0rdL4MpYuew6W8Eq44onMx6wNjDO0+hi5OSQEDCRmD6zn6WLkYtDSGA6
        k8Sx2y9YIZznjBLT191hA6liEVCV2D9vITOIzQZk77o3ixXEFhFIklg8+ysTSAOzwGlmiYtN
        PUwgCWGBOIlHa36zdzFycPAKWElMmu8GEuYUcJboO7GbHWLBXUaJqRuvgdXzC4hJ9F75zwRS
        LyFgL/F4vSJImFdAUOLkzCcsIDazgKZE63aQkSC2tsSyha/B7hESUJQ4vOQXO8Q38hJ3f09n
        hLBjJZoO3GKbwCg8C8moWUhGzUIyagEj8ypGluLcdMNNjJCYC9/BOK/po94hRiYOxkOMEhzM
        SiK8oh3TEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzKm2ZkSAkkJ5YkpqdmlqQWgSTZeLglGpg
        cpq1Vvh//PM7Ke6Wob6m3+89XenyOcyiZB9PcqB84oFPXDuDai/EfQ8rvtAZrJccnim5+47o
        /gspbWHZa6054jfO15Zr+Nn5vPLdD9sj1y/Ytc2aqzFx5trbPIv6+Ct1HN8HH/bW3638f09R
        VMh5tVX8gs/fWWRFxaVMLp9z2GIGD4/SFE5znsiGtxO5z26LXMZme9H6zX2vB5ITGJTEHzvu
        WbyEU8689u+/+zeDZ3p3XXm8jLO5NbtT821SieRUDjbWDf4Zh7IOL7Rcfa50ovoOse8/M7b7
        7rqRsyh49gHZHP5M3dZdnMtLrXeyls5inB60zfx1p5OCodXCha0PN8oUlEXp/ml/vGK/9JwY
        JZbijERDLeai4kQA5OcA2igDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 07:21:28 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Fri, May 07, 2021 at 05:38:52PM +0800, Aili Yao wrote:
> > On Tue, 27 Apr 2021 15:29:53 +0900
> > Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:
> >   
> > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > 
> > > When memory_failure() is called with MF_ACTION_REQUIRED on the
> > > page that has already been hwpoisoned, memory_failure() could fail
> > > to send SIGBUS to the affected process, which results in infinite
> > > loop of MCEs.
> > > 
> > > Currently memory_failure() returns 0 if it's called for already
> > > hwpoisoned page, then the caller, kill_me_maybe(), could return
> > > without sending SIGBUS to current process.  An action required MCE
> > > is raised when the current process accesses to the broken memory,
> > > so no SIGBUS means that the current process continues to run and
> > > access to the error page again soon, so running into MCE loop.
> > > 
> > > This issue can arise for example in the following scenarios:
> > > 
> > >   - Two or more threads access to the poisoned page concurrently.
> > >     If local MCE is enabled, MCE handler independently handles the
> > >     MCE events.  So there's a race among MCE events, and the
> > >     second or latter threads fall into the situation in question.
> > > 
> > >   - If there was a precedent memory error event and memory_failure()
> > >     for the event failed to unmap the error page for some reason,
> > >     the subsequent memory access to the error page triggers the
> > >     MCE loop situation.
> > > 
> > > To fix the issue, make memory_failure() return some error code when the
> > > error page has already been hwpoisoned.  This allows memory error
> > > handler to control how it sends signals to userspace.  And make sure
> > > that any process touching a hwpoisoned page should get a SIGBUS (if
> > > possible) with the error virtual address, even in "already hwpoisoned"
> > > path of memory_failure() as is done in page fault path.
> > > 
> > > kill_accessing_process() does pagetable walk to find the error virtual
> > > address.  If multiple virtual addresses are found in the pagetable walk,
> > > no one knows which address is the correct one, so we fall back to sending
> > > SIGBUS in kill_me_maybe() without error address info as we do now.
> > > This corner case is left to be solved in the future.
> > > 
> > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>  
> > 
> > Sorry for my late response, I just get time to rethink the pagewalk patch. Please let me share my thoughts, 
> > If anything wrong, just point out, thanks!  
> 
> Thank you for the feedback.
> 
> > 
> > This whole pagewalk patch is meant to fix invalid virtual address along SIGBUS, For this invalid virtual address issue,
> > It seems this is one existing issue before this race issue is posted. while the issue is not fixed for a long time.
> > 
> > Then I think why this issue is not fixed, maybe just no process will care this virtual address as it will be killed.
> > Maybe virtual guest will need this address to forward it to vCPU, but untill now the memory recovery function in the VM doesn't
> > work at all, and without this address, It seems not a big impact though.
> > 
> > Maybe there are some other cases will care the virtual address, if anyone knows, just point out.
> > 
> > But invalid virtual address is still no good.
> > 
> > Before this, I post one RFC patch try to fix this issue with one knowing issue:it failed for mutiple pte entry;
> > Then this patch is posted trying to address this.
> > 
> > First I read this patch, I think this method is good and right and i test it. But now I think it again, I am wondering even the process
> > have multi pte entry and wrong virtuall address, but it still pointing to the same page, right?  
> 
> Yes, it is.
> 
> > If the process won't exit and get the wrong virtual address, what wrong action will it do?  
> 
> I have no clear idea.  Typical action for the SIGBUS is to kill the process with
> some logging, so the obviously wrong action like killing wrong process never happens.
> A possible wrong result is invalid address in log, which might not be critical.
> 
> > while I can just think the virtual machine example, but the qemu will translate the wrong virtual address to right guest physical address? 
> > I am not sure VM will have multi pte entry?  
> 
> As long as I know, qemu maintains one-to-one mapping between host virtual address
> and guest physical address, so no multi entry issue should happen around qemu.
> 
> > 
> > And I think the virtual address along SIGBUS is not mean to backtrace the code, it just want to tell where the error memory is, for multi pte
> > entry, one virtual address for the same physical page is not enough?
> > 
> > Compare this patch with my RFC patch, difference:
> > 1.This patch will just fix the race issue's invalid virtual address. while my RFC patch will cover all the error case for recovery;
> > 2.For multi entry, this patch will do one force_sig with no other infomation, But the RFC patch will take one possible right address, I don't know which one is better.
> > 
> > And if this multi pte entry is one real issue, it seems the normal recovey work will aslo trigger this, would it be better to fix that first?  
> 
> Assuming that your RFC is https://lore.kernel.org/lkml/20210317162304.58ff188c@alex-virtual-machine/,
> it simply uses the first-found virtual address.  I start thinking that this
> approach could be fine.  And it's easy to change the patch with this approach.
> I have no preference, so if you like, I switch to the "first-found" approach.

Hi Naoya:
  Thanks for your reply!
  Yes, you can change to that RFC approach, but there may be some un-indentified issuees, and need more considerations though.
  And there may be other method to address this, you can also dig into that, get it realized and posted.
  I am OK with any option.
  But for here, From the beginning, I thinks the invalid address issue and race issue are two different issues, may have some
relationship but still two issues in my mind.
  whould you please seperate this series patches into three again?
  Great Thanks!

Aili Yao!
