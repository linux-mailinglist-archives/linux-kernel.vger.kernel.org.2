Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F85331CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCICO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:14:57 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:13958 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCICO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:14:56 -0500
X-AuditID: 0a580157-463ff70000021a79-54-6046d380849f
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 7C.E2.06777.083D6406; Tue,  9 Mar 2021 09:46:40 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 10:14:52 +0800
Date:   Tue, 9 Mar 2021 10:14:52 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210309101452.281af49d@alex-virtual-machine>
In-Reply-To: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
References: <20210308174912.4ac9029a@alex-virtual-machine>
        <8F3F763F-59CC-4E25-B4DE-89CD0632F754@amacapital.net>
        <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsXCFcGooNtw2S3B4HajkcXnDf/YLF5saGe0
        mLZR3OLyrjlsFvfW/Ge1WL22gdXi/K61rBaXDixgsrjYeIDR4njvASaLzZumMlu8uXCPxeLH
        hsesDrwe31v7WDzuv/nL4rF5hZbH4j0vmTw2repk89j0aRK7x7tz59g95p0M9HhxdSOLx/t9
        V9k8Pm+S8zjR8oU1gCeKyyYlNSezLLVI3y6BK+Pe5yWsBSfZK851bGRqYHzB2sXIySEhYCJx
        6PlOli5GLg4hgelMEjde3WWEcF4ySuzauZkdpIpFQEWib98jZhCbTUBVYte9WWDdIgJqEpcW
        P2AGaWAWaGeRaLv5CqxBWCBZ4sykB4wgNq+AlcTWPxuBVnBwcApYSvRPTodYsJBR4ufvQ2CD
        +AXEJHqv/GeCOMleom3LIqheQYmTM5+wgNjMAjoSJ1YdY4aw5SW2v50DZgsJKEocXvKLHaJX
        SeJI9ww2CDtWYtm8V6wTGIVnIRk1C8moWUhGLWBkXsXIUpybbriJERKL4TsY5zV91DvEyMTB
        eIhRgoNZSYTX77hbghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeluOuCUIC6YklqdmpqQWpRTBZ
        Jg5OqQYmzbNND/KYcyd/a1l3tZ3Nak6X+PVFdsHtx6b69M3ufjWZR3bzlE4LnWbx389n33Po
        2Gkatzo8a82TJyZtFip/V764NKfue87d++27bdSerlvx80R/EvvvBW/uuE1YuncKp8X/GX1r
        fPm2fcvN3jaz0fh0mhp70n1x2/O/4nJmPt2p0710B1vOoTOC9a+LjnauSpab/XHZxrS2n0Jt
        bu8fSO2dlt626BTjSpWnEu1J+5bMeympo8S2qeWQzcpmt/45h5J027dm/pv0mMlcfWVLhtJx
        3pcrlQ688Z5RzVYvc+dqpmZqxBnXom+TVYQYgrZdlxOVnG7x1ORJSornBa6tvPZVWfvL6ss3
        1czYFPpgkRJLcUaioRZzUXEiAJeOtqg0AwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 18:31:07 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > Can you point me at that SIGBUS code in a current kernel?  
> 
> It is in kill_me_maybe().  mce_vaddr is setup when we disassemble whatever get_user()
> or copy from user variant was in use in the kernel when the poison memory was consumed.
> 
>         if (p->mce_vaddr != (void __user *)-1l) {
>                 force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
> 
> Would it be any better if we used the BUS_MCEERR_AO code that goes into siginfo?
> 
> That would make it match up better with what happens when poison is found
> asynchronously by the patrol scrubber. I.e. the semantics are:
> 
> AR: You just touched poison at this address and need to do something about that.
> AO: Just letting you know that you have some poison at the address in siginfo.
> 
> -Tony

Is the kill action for this scenario in memory_failure()?

-- 
Thanks!
Aili Yao
