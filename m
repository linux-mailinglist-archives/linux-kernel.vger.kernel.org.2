Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB693762F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhEGJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:39:58 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:3247 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231753AbhEGJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:39:57 -0400
X-AuditID: 0a580157-bd3ff70000027901-55-60950aad6cc8
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id CB.1D.30977.DAA05906; Fri,  7 May 2021 17:38:53 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 17:38:52 +0800
Date:   Fri, 7 May 2021 17:38:52 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     <linux-mm@kvack.org>, Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, <linux-kernel@vger.kernel.org>,
        <yaoaili126@gmail.com>
Subject: Re: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has
 already been poisoned
Message-ID: <20210507173852.0adc5cc4@alex-virtual-machine>
In-Reply-To: <20210427062953.2080293-3-nao.horiguchi@gmail.com>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
        <20210427062953.2080293-3-nao.horiguchi@gmail.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsXCFcHor7uWa2qCwZUDEhZz1q9hs/i84R+b
        xdf1v5gtbt4ysbi8aw6bxb01/1ktzu9ay2qxat4dZouLjQcYLc5MK7J4c+Eei8Wz1qssDjwe
        31v7WDx2zrrL7rFgU6nH4j0vmTw2repk89j0aRK7x4kZv1k8XlzdyOLxft9VNo/Np6s9Pm+S
        C+CO4rJJSc3JLEst0rdL4MrY+r+NrWC5csXHN+tYGxh7ZboYOTkkBEwkzr78w97FyMUhJDCd
        SWLTy/WsEM4zRomv5w6wglSxCKhIPLo6iQnEZhNQldh1bxZYXERAV2LCtl5GkAZmgX9MEpOu
        HgArEhaIk3i05jc7iM0rYCXx+s99NhCbU8BeYv77bmYQW0igWGL2zblgNfwCYhK9V/4D9XIA
        nWQv8Xi9IkSroMTJmU9YQGxmAR2JE6uOMUPY8hLb386BGqMocXjJL3aIb+Ql7v6ezghhx0o0
        HbjFNoFReBaSUbOQjJqFZNQCRuZVjCzFuemGmxghMRe+g3Fe00e9Q4xMHIyHGCU4mJVEeE8v
        mpwgxJuSWFmVWpQfX1Sak1p8iFGag0VJnLdxJlBKID2xJDU7NbUgtQgmy8TBKdXAFBvd8P60
        b+DCrOkXLr+0fvf21uVJp+TFghh/8GhrdkR2qs6uPnPuvyerpme1Vf8p/+tvne2N3cov7rmk
        tnxr1UqerO9ylmpPst6+ejTvtc5WrzMJl1evC+CS/PRhqmJtxxon6WvfZguxt7o9W+169WrP
        Ak3WflNWTdXpfF/mWgne/9m+wGC2jrjJuehJgnWugQvNXzFOXcB9zTNOVLThYkPlAd0pxTK2
        gYwdKXMUL874U6OsPCW4//GOL47R2QmHbN6sXf2ay3zHatnnNqLF3XFVfiIGRdMme046fz/9
        f/GcP4tqtA4EcSiJLNmo0eW5sTzSKvp/7t15EW1Lt2cFX9ap9/g+h0NR/8/G/zEnlViKMxIN
        tZiLihMBOu4oKCgDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 15:29:53 +0900
Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When memory_failure() is called with MF_ACTION_REQUIRED on the
> page that has already been hwpoisoned, memory_failure() could fail
> to send SIGBUS to the affected process, which results in infinite
> loop of MCEs.
> 
> Currently memory_failure() returns 0 if it's called for already
> hwpoisoned page, then the caller, kill_me_maybe(), could return
> without sending SIGBUS to current process.  An action required MCE
> is raised when the current process accesses to the broken memory,
> so no SIGBUS means that the current process continues to run and
> access to the error page again soon, so running into MCE loop.
> 
> This issue can arise for example in the following scenarios:
> 
>   - Two or more threads access to the poisoned page concurrently.
>     If local MCE is enabled, MCE handler independently handles the
>     MCE events.  So there's a race among MCE events, and the
>     second or latter threads fall into the situation in question.
> 
>   - If there was a precedent memory error event and memory_failure()
>     for the event failed to unmap the error page for some reason,
>     the subsequent memory access to the error page triggers the
>     MCE loop situation.
> 
> To fix the issue, make memory_failure() return some error code when the
> error page has already been hwpoisoned.  This allows memory error
> handler to control how it sends signals to userspace.  And make sure
> that any process touching a hwpoisoned page should get a SIGBUS (if
> possible) with the error virtual address, even in "already hwpoisoned"
> path of memory_failure() as is done in page fault path.
> 
> kill_accessing_process() does pagetable walk to find the error virtual
> address.  If multiple virtual addresses are found in the pagetable walk,
> no one knows which address is the correct one, so we fall back to sending
> SIGBUS in kill_me_maybe() without error address info as we do now.
> This corner case is left to be solved in the future.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Sorry for my late response, I just get time to rethink the pagewalk patch. Please let me share my thoughts, 
If anything wrong, just point out, thanks!

This whole pagewalk patch is meant to fix invalid virtual address along SIGBUS, For this invalid virtual address issue,
It seems this is one existing issue before this race issue is posted. while the issue is not fixed for a long time.

Then I think why this issue is not fixed, maybe just no process will care this virtual address as it will be killed.
Maybe virtual guest will need this address to forward it to vCPU, but untill now the memory recovery function in the VM doesn't
work at all, and without this address, It seems not a big impact though.

Maybe there are some other cases will care the virtual address, if anyone knows, just point out.

But invalid virtual address is still no good.

Before this, I post one RFC patch try to fix this issue with one knowing issue:it failed for mutiple pte entry;
Then this patch is posted trying to address this.

First I read this patch, I think this method is good and right and i test it. But now I think it again, I am wondering even the process
have multi pte entry and wrong virtuall address, but it still pointing to the same page, right?
If the process won't exit and get the wrong virtual address, what wrong action will it do? Do I miss some thing? 
while I can just think the virtual machine example, but the qemu will translate the wrong virtual address to right guest physical address? 
I am not sure VM will have multi pte entry?

And I think the virtual address along SIGBUS is not mean to backtrace the code, it just want to tell where the error memory is, for multi pte
entry, one virtual address for the same physical page is not enough?

Compare this patch with my RFC patch, difference:
1.This patch will just fix the race issue's invalid virtual address. while my RFC patch will cover all the error case for recovery;
2.For multi entry, this patch will do one force_sig with no other infomation, But the RFC patch will take one possible right address, I don't know which one is better.

And if this multi pte entry is one real issue, it seems the normal recovey work will aslo trigger this, would it be better to fix that first?

Thanks!
Aili Yao




