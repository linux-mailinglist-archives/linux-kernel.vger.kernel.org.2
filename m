Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED184377A69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhEJDOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:14:39 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:24858 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhEJDOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:14:35 -0400
X-AuditID: 0a580155-c83ff700000401e3-69-6098a4d94623
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 57.D3.00483.9D4A8906; Mon, 10 May 2021 11:13:29 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 11:13:28 +0800
Date:   Mon, 10 May 2021 11:13:28 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        <yaoaili126@gmail.com>
Subject: Re: [PATCH v7] mm/gup: check page hwpoison status for memory
 recovery failures.
Message-ID: <20210510111328.1eef98f0@alex-virtual-machine>
In-Reply-To: <20210406104123.451ee3c3@alex-virtual-machine>
References: <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
        <20210318044600.GJ3420@casper.infradead.org>
        <20210318133412.12078eb7@alex-virtual-machine>
        <20210319104437.6f30e80d@alex-virtual-machine>
        <20210320003516.GC3420@casper.infradead.org>
        <20210322193318.377c9ce9@alex-virtual-machine>
        <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
        <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
        <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
        <20210331104303.145aea53@alex-virtual-machine>
        <20210331043231.GA26013@hori.linux.bs1.fc.nec.co.jp>
        <9f49c415-a75a-1ea3-b80c-5ba512331de6@redhat.com>
        <20210406102346.3890ceb2@alex-virtual-machine>
        <20210406104123.451ee3c3@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXCFcHor3tzyYwEg5PT2SzmrF/DZnF51xw2
        i3tr/rNaPGu9yuLA4rFz1l12j02fJrF7nJjxm8Xj8ya5AJYoLpuU1JzMstQifbsErowD0+ex
        FBwTq1h4ZTdzA2OTUBcjJ4eEgInE1fZ5bF2MXBxCAtOZJK7/fs0C4TxnlFg05xozSBWLgKrE
        vlNPWUFsNiB7171ZQDYHh4hAhkR3Yw1IPbPAfkaJhqZ57CA1wgJREr96u1hAbF4BK4lrW7aB
        9XIKWEu0zN0M1iskcJpV4jwXSJhfQEyi98p/JpCwhIC9xOP1ihCdghInZz4Bm8IsoCNxYtUx
        ZghbXmL72zlgtpCAosThJb/YIX6Rl7j7ezojhB0r0XTgFtsERuFZSEbNQjJqFpJRCxiZVzGy
        FOemG21ihAR46A7GGU0f9Q4xMnEwHmKU4GBWEuEV7ZiWIMSbklhZlVqUH19UmpNafIhRmoNF
        SZz388zJCUIC6YklqdmpqQWpRTBZJg5OqQam7fd1L7/pTzPoW5u6z/ruik2v7zFMeKOlZzXt
        3YOH9oqtLjxB24MWda9rvFzMGKgluCqDYYLOD/YNi8UW7Wj2MyouMjAyEYqVO6e5e3Wmg/0W
        aTXuAwmvrl1/zKeV39BQ6aIVnLTr4rkt9SE7HbaWxn+Mfl3WYmUuuO62caX8W7YZlxI8v6V8
        Odeyvy03PSe9yPLfX027Kws4bjnu+mN/0O774usn12TtX74hx9fP5v/2xT48rIb8r367u1z8
        IbE1+EaMwqvdp+fuDTB7LXdhycmOkuo/Jicl9e3UuQyVrne8zzW2axab1fqlascZ6+dBvlvS
        I2smBOTql6+WM7Dt/h1bLSkkE23y5gOP2xElluKMREMt5qLiRACVNes/3wIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 10:41:23 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> When we call get_user_pages() to pin user page in memory, there may be
> hwpoison page, currently, we just handle the normal case that memory
> recovery jod is correctly finished, and we will not return the hwpoison
> page to callers, but for other cases like memory recovery fails and the
> user process related pte is not correctly set invalid, we will still
> return the hwpoison page, and may touch it and lead to panic.
> 
> In gup.c, for normal page, after we call follow_page_mask(), we will
> return the related page pointer; or like another hwpoison case with pte
> invalid, it will return NULL. For NULL, we will handle it in if (!page)
> branch. In this patch, we will filter out the hwpoison page in
> follow_page_mask() and return error code for recovery failure cases.
> 
> We will check the page hwpoison status as soon as possible and avoid doing
> followed normal procedure and try not to grab related pages.
> 
> Changes since v6:
> - Fix wrong page pointer check in follow_trans_huge_pmd();
> 
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>

After considering more, I still insist that we should take more care to treat the case that kernel touched  user hwpoison pages.

Usually when process touched the hwpoison page, it will be killed, and no other bad consequence will happen. while in a case, kernel touches
the user process hwpoison page, It should be one more serious issue than the user process's access, the error return nor Null return is
not sufficient and reasonable for me.

There will be some doubt places, 
1) should the user process be killed first? 
2) if error returned, the process can correctly process it?  It seems there is no way the process can finish that. 
3) if NULL returned, job continue again? the data integrity will be guaranteed?  I doubted that.

There are so many arguements about the CopyIn patch from intel that the process should killed or not...
And this gup module seems more compicated and have the same question. 
When error returned or NULL return from gup, in some way and some scenario, this will make the hw issue even more complicated.

Yes, there is a flag FOLL_HWPOISON, but this flag seems be designed for different return values that the process can accept,
it is not designed to decide kernel to panic or not;

Currently I have no other scenario like coredump case. And I havn't one good way to fix this leak in a graceful way.

Maybe, For some scenario, the kernel recovery thing for user process is wrong and not deserved.

I have a lot of other works to do and have not much time to continue on this thread, And I insist my original post.

There should be a better option for this issue, when the better option is ready, this patch can and should be reverted.

Thanks!
Aili Yao


