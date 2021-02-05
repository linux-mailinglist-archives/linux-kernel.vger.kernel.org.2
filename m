Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15556310456
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhBEFHK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Feb 2021 00:07:10 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:9457 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBEFHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:07:07 -0500
X-AuditID: 0a580157-f21ff7000005df43-bc-601ccc9040ed
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id F6.84.57155.09CCC106; Fri,  5 Feb 2021 12:41:52 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 13:06:16 +0800
Date:   Fri, 5 Feb 2021 13:06:16 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "YANGFENG1@kingsoft.com" <YANGFENG1@kingsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210205130616.6d876846@alex-virtual-machine>
In-Reply-To: <20210204072555.GA22850@hori.linux.bs1.fc.nec.co.jp>
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
        <20210204072555.GA22850@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXCFcGooDvhjEyCwcqpbBafN/xjs3ixoZ3R
        YtpGcYvLu+awWdxb85/V4vyutawWlw4sYLK42HiA0eJ47wEmi82bpjJbvLlwj8Xix4bHrA48
        Ht9b+1g8Nq/Q8li85yWTx6ZVnWwemz5NYvd4d+4cu8e8k4EeL65uZPF4v+8qm8fnTXIeJ1q+
        sAZwR3HZpKTmZJalFunbJXBl3Nt5m7ngHX/Fn+nT2BsY9/F0MXJySAiYSJx8M4eli5GLQ0hg
        OpPE2h/LGCGcl4wSTfc2sINUsQioSLQcuMEGYrMJqErsujeLFcQWEUiSWDz7KxNIA7PADhaJ
        qxO/gBUJCyRLtJ5+ANbMK2Al0XSyAyzOKeAosX/zHLBmIYFCiS8zIYbyC4hJ9F75zwRxkr1E
        25ZFjBC9ghInZz5hAbGZBTQlWrf/ZoewtSWWLXzNDDFHUeLwkl/sEL1KEke6Z7BB2LESy+a9
        Yp3AKDwLyahZSEbNQjJqASPzKkaW4tx0w02MkLgL38E4r+mj3iFGJg7GQ4wSHMxKIryJbVIJ
        QrwpiZVVqUX58UWlOanFhxilOViUxHnFHPkShATSE0tSs1NTC1KLYLJMHJxSDUx1f5e3XuaZ
        LvPBtn5JwcpLXa5zL00RWp+z4WLUoqrutl9u6WxPYy/6G/4V94jjfal7//fm2g2J1n/8ldVU
        a6eLqH0Nc927/Vlq8P5JOtfLWfO8673ytSLY/tyqqAlRPzn5Psfmeavd7y0ozMqJyd3CWd3P
        P9O2qLJ44u3HDctyc/+oRRrcm9XWeXcjf13hl8dWdz9p2bjMitp+teaf0Kc9DVsP5C++sapp
        3Zf21VduMLSopIXmTd1+JPFoiV7Hm6msRpZ+0m738lu4uVnWTDitlW21c93rFTsFHvYeypJL
        2XAtdX+Rx9TjM56WGMrxcx84Jqn0NESgTu977jwl//VGBSJBxobs1gvm9HatOKnEUpyRaKjF
        XFScCABSn5XVKgMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 07:25:55 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> Hi Aili,
> 
> On Mon, Feb 01, 2021 at 04:17:49PM +0800, Aili Yao wrote:
> > When one page is already hwpoisoned by AO action, process may not be
> > killed, the process mapping this page may make a syscall include this
> > page and result to trigger a VM_FAULT_HWPOISON fault, if it's in kernel
> > mode it may be fixed by fixup_exception. Current code will just return
> > error code to user process.
> > 
> > This is not sufficient, we should send a SIGBUS to the process and log
> > the info to console, as we can't trust the process will handle the error
> > correctly.
> > 
> > Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > ---  
> ...
> 
> > @@ -662,12 +662,32 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> >  		 * In this case we need to make sure we're not recursively
> >  		 * faulting through the emulate_vsyscall() logic.
> >  		 */
> > +
> > +		if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
> > +		    fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> > +			unsigned int lsb = 0;
> > +
> > +			pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
> > +				current->comm, current->pid, address);
> > +
> > +			sanitize_error_code(address, &error_code);
> > +			set_signal_archinfo(address, error_code);
> > +
> > +			if (fault & VM_FAULT_HWPOISON_LARGE)
> > +				lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
> > +			if (fault & VM_FAULT_HWPOISON)
> > +				lsb = PAGE_SHIFT;
> > +
> > +			force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);  
> 
> This part contains some duplicated code with do_sigbus(), so some refactoring (like
> adding a common function) would be more helpful.

Yes, agree, I will modify this and rebase to the big fault series from tip.

Thanks
Aili Yao

