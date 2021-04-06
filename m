Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE913549DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbhDFBE4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Apr 2021 21:04:56 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:53077 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235801AbhDFBEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:04:55 -0400
X-AuditID: 0a580155-f6dff70000015057-ce-606bb3ada819
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id B5.22.20567.DA3BB606; Tue,  6 Apr 2021 09:04:45 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 6 Apr 2021
 09:04:45 +0800
Date:   Tue, 6 Apr 2021 09:04:44 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>
CC:     Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Message-ID: <20210406090444.2a69b9e2@alex-virtual-machine>
In-Reply-To: <20210405135017.GA6504@hori.linux.bs1.fc.nec.co.jp>
References: <3690ece2101d428fb9067fcd2a423ff8@intel.com>
        <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
        <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
        <20210309100421.3d09b6b1@alex-virtual-machine>
        <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
        <20210309143534.6c1a8ec5@alex-virtual-machine>
        <20210331192540.2141052f@alex-virtual-machine>
        <20210401153320.GA426964@agluck-desk2.amr.corp.intel.com>
        <20210402091820.04d7c3e0@alex-virtual-machine>
        <a10c7838216e4a10b4fd5ebb0f1108a1@intel.com>
        <20210405135017.GA6504@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXCFcHor7t2c3aCwZYn0hZz1q9hs/i6/hez
        xeVdc9gs7q35z2pxsfEAo8WZaUUWby7cY3Fg91i85yWTx6ZPk9g9Tsz4zeLx4upGFo/3+66y
        eWw+Xe3xeZNcAHsUl01Kak5mWWqRvl0CV8a9zavYC5byV5xd95K1gbGTp4uRk0NCwERiz9vV
        7F2MXBxCAtOZJG7smcAC4bxklNi1qY0JpIpFQEVi5btvzCA2m4CqxK57s1hBikQE2hgl1q85
        zwbiMAt8YZJYcm4j0CwODmGBYInV8/VBGngFrCTu974CG8Qp4CBx6O4xVogNx1kkjkxdwAqS
        4BcQk+i98p8J4iZ7ibYtixghmgUlTs58wgJiMwtoSrRu/80OYWtLLFv4GuwiIQFFicNLfrFD
        9CpJHOmewQZhx0o0HbjFNoFReBaSUbOQjJqFZNQCRuZVjCzFuelGmxghERK6g3FG00e9Q4xM
        HIyHGCU4mJVEeHf0ZicI8aYkVlalFuXHF5XmpBYfYpTmYFES59XmTk8QEkhPLEnNTk0tSC2C
        yTJxcEo1MBm/m71TIY7j8c3b+ks/3VY63Jjq8WB57/Obe95/Z9bcv5td8WRv7pPpX2rWsTgZ
        TuVJ/PxflvNP6B3F3selvNPnFve18d9INOA1tFssmralrab5mA1/5JbknwWPjJS/S5vkJ7w9
        3yv/6Ke4S82reT0LXXc58L9NZ1ZNnfttXefU5AVin3k9P59aqz3BT/5O8dM+b+ULK+4Yd89L
        cno67/L2zyb520xrRA7pck45a7nlH+scL7Gsg6fvWf/lnHMs5cDvVHbr0/XCM48+q1woZuRv
        bFW7fA/3lfcnBe0VklfvE2wU3/T7pDTv+8R/thMO+vOddbq1piGn1vCXj9lxAZOQAKmbugtT
        dc496Dwdmq7EUpyRaKjFXFScCACFuqPk/wIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2021 13:50:18 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> On Fri, Apr 02, 2021 at 03:11:20PM +0000, Luck, Tony wrote:
> > >> Combined with my "mutex" patch (to get rid of races where 2nd process returns
> > >> early, but first process is still looking for mappings to unmap and tasks
> > >> to signal) this patch moves forward a bit. But I think it needs an
> > >> additional change here in kill_me_maybe() to just "return" if there is a
> > >> EHWPOISON return from memory_failure()
> > >> 
> > > Got this, Thanks for your reply!
> > > I will dig into this!
> > 
> > One problem with this approach is when the first task to find poison
> > fails to complete actions. Then the poison pages are not unmapped,
> > and just returning from kill_me_maybe() gets into a loop :-(
> 
> Yes, that's the pain point.  We need send SIGBUS to the current process in
> "already haredware poisoned" case of memory_failure().  SIGBUS should
> contain the error virtual address, but unfortunately walking the page table
> or using p->mce_vaddr is not always reliable now.
> 
> So as a second-best approach, we can extend the "walking page table"
> approach such that we walk over the whole virtual address space to make sure
> that the number of entries pointing to the error page is exactly 1.
> If that's the case, then we can confidently send SIGBUS with it.  If we find
> multiple entries pointing to the error page, then we give up guessing, then
> send a nomral SIGBUS to the current process.  That's not worse than now,
> and I think we need wait in the hope that the virtual address will be
> available in MCE handler.
> 
> Anyway I'll try to write a patch for this.

Yeah, previous patch didn't adress the multiple virtual address issue, If there is a way to fix that,
That would be great!

-- 
Thanks!
Aili Yao
