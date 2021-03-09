Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A881C331CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhCICZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:25:40 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:13960 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhCICZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:25:07 -0500
X-AuditID: 0a580157-47bff70000021a79-0a-6046d5e39743
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 45.13.06777.3E5D6406; Tue,  9 Mar 2021 09:56:51 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 10:25:03 +0800
Date:   Tue, 9 Mar 2021 10:25:02 +0800
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
Message-ID: <20210309102502.27af8da9@alex-virtual-machine>
In-Reply-To: <20210309101452.281af49d@alex-virtual-machine>
References: <20210308174912.4ac9029a@alex-virtual-machine>
        <8F3F763F-59CC-4E25-B4DE-89CD0632F754@amacapital.net>
        <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
        <20210309101452.281af49d@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsXCFcGooPv4qluCwZwLPBafN/xjs3ixoZ3R
        YtpGcYvLu+awWdxb85/VYvXaBlaL87vWslpcOrCAyeJi4wFGi+O9B5gsNm+aymzx5sI9Fosf
        Gx6zOvB6fG/tY/G4/+Yvi8fmFVoei/e8ZPLYtKqTzWPTp0nsHu/OnWP3mHcy0OPF1Y0sHu/3
        XWXz+LxJzuNEyxfWAJ4oLpuU1JzMstQifbsErozOl1IFszkrpkz/wNLA+I+ti5GTQ0LAROLF
        vyMsXYxcHEIC05kkTh+6zAThvGSUePLxCTNIFYuAisSzTZtZQGw2AVWJXfdmsYLYIgJqEpcW
        P2AGaWAWaGeRaLv5ih0kISyQLHFm0gNGEJtXwEpi65UPYM2cAtYS0y/cZYfYcIlR4tecX2CT
        +AXEJHqv/GeCuMleom3LIqhmQYmTM5+ANTML6EicWHWMGcKWl9j+dg6YLSSgKHF4yS92iF4l
        iSPdM6B+i5VYNu8V6wRG4VlIRs1CMmoWklELGJlXMbIU56YbbmKExGL4DsZ5TR/1DjEycTAe
        YpTgYFYS4fU77pYgxJuSWFmVWpQfX1Sak1p8iFGag0VJnLfluGuCkEB6YklqdmpqQWoRTJaJ
        g1OqgSn3RXFEIOt+Pu3iXIaTbrm9IS7xT+czvJQ0tY3TdbMoFvt/y4vR9rukao9AjNC51uqs
        PR8nm1+rjZr/MTS5bt+THr0Pl5mL/nImRP1ab1dzU7PhT4ZQsdeC1PJPukXhk6Runt8W7yeS
        waln8n/H7n9eO6e8L/iVqMdYuPl2Wu+E4qd8KyZNPy4Tk8rPvkTracnBI88Ptf4Vnn9LcblY
        R6Pt48u3etO2q92aOoftjPD/Q7duKHH2Jt3jvXLc34y9bGmQaO9e28On7u00+z6j9tsO1b+X
        Lfbw2PtKmNz7pn13ZY75TFbzZ0Hz9mewNPgcbtsVFrG37WO3/Dm2O+nZB5bM8OKzy4pztD97
        zLh5jxJLcUaioRZzUXEiAKAz7UA0AwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 10:14:52 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Mon, 8 Mar 2021 18:31:07 +0000
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > > Can you point me at that SIGBUS code in a current kernel?    
> > 
> > It is in kill_me_maybe().  mce_vaddr is setup when we disassemble whatever get_user()
> > or copy from user variant was in use in the kernel when the poison memory was consumed.
> > 
> >         if (p->mce_vaddr != (void __user *)-1l) {
> >                 force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
> > 
> > Would it be any better if we used the BUS_MCEERR_AO code that goes into siginfo?
> > 
> > That would make it match up better with what happens when poison is found
> > asynchronously by the patrol scrubber. I.e. the semantics are:
> > 
> > AR: You just touched poison at this address and need to do something about that.
> > AO: Just letting you know that you have some poison at the address in siginfo.
> > 
> > -Tony  
> 
> Is the kill action for this scenario in memory_failure()?

Does the current logic kill the process twice for this scenario ?
I am confused.

-- 
Thanks!
Aili Yao
