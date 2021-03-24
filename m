Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6F347329
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCXIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:04:12 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:49749 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232453AbhCXIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:03:30 -0400
X-AuditID: 0a580155-20dff7000005482e-e4-605aea6072db
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id D5.77.18478.06AEA506; Wed, 24 Mar 2021 15:29:36 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 24 Mar
 2021 16:03:26 +0800
Date:   Wed, 24 Mar 2021 16:03:26 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     <qemu-devel@nongnu.org>
CC:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <sunhao2@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210324160326.555b4464@alex-virtual-machine>
In-Reply-To: <20210324105950.714fd8a6@alex-virtual-machine>
References: <20210222180819.3998fe33@alex-virtual-machine>
        <20210222102206.GC29063@zn.tnic>
        <20210222192146.76ffec84@alex-virtual-machine>
        <20210222201723.0fcec589@alex-virtual-machine>
        <20210222122241.GA10880@zn.tnic>
        <20210222203549.0e54c26f@alex-virtual-machine>
        <20210222124550.GB10880@zn.tnic>
        <20210223102755.13cbdffd@alex-virtual-machine>
        <20210223094300.GA26060@zn.tnic>
        <20210223175640.5708c7ed@alex-virtual-machine>
        <20210223100538.GB26060@zn.tnic>
        <20210223192711.0b517745@alex-virtual-machine>
        <9232988079334ab8801cccec6557f9c3@intel.com>
        <20210224103921.3dcf0b65@alex-virtual-machine>
        <20210324105950.714fd8a6@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsXCFcGooJvwKirBYOUKcYvPG/6xWUzbKG5x
        edccNotLBxYwWRzv3cFisXnTVGaLNxfusVj82PCY1YHD43trH4vH4j0vmTw2repk83h37hy7
        x5Nrm5k83u+7yubxeZOcx4mWL6wBHFFcNimpOZllqUX6dglcGR/uvWcrWCNX0T1lEUsD42Lx
        LkZODgkBE4l3t9tZuhi5OIQEpjNJtB//xgrhvGKUOPlhPyNIFYuAqsSyCSuYQGw2IHvXvVms
        ILaIgLRE/5x2dpAGZoEOZonVR6YxdzFycAgLhEosmVYIUsMrYCXR/ngrC4jNKWAtsXfVN2aI
        BQtYJebv6gQbxC8gJtF75T8TxEn2Em1bFjFCNAtKnJz5BKyZWUBH4sSqY8wQtrzE9rdzwGwh
        AUWJw0t+sUP0Kkkc6Z7BBmHHSiyb94p1AqPwLCSjZiEZNQvJqAWMzKsYWYpz0402MUKiJnQH
        44ymj3qHGJk4GA8xSnAwK4nwtoRHJAjxpiRWVqUW5ccXleakFh9ilOZgURLnDdACSgmkJ5ak
        ZqemFqQWwWSZODilGpgEtyYHngpmdRdMZ7nxZsvl77emuqRO3je57pCJgLfI4Z6nufMKrFMc
        5kwN/+AWeS/hb++21xZBtru0ry7eOfle2o99HxdtzDo6Lb1yhhA3yzPOx5dud4mInbqw+e/i
        A3sXFRhlhJWsWB6x5KLXohM1Rx8UvH129MbZRKvZnWfuSly9psPavCz3QwZz+sZbnwS1stqT
        Snc0LG33+TfnU7Xo8abU509ufrj57oxLwlIr1QVF3Hf1p8+qlch8W1fc+fr0fr+mqoJFD+do
        VU12yLA+9afy697Q2H274nyT7Lt+6fafn8p3+k2cz4e7OfVCv8SsshV5P7yziPgftcHIrvsp
        /4MfCyNFLMymGMned2g3VWIpzkg01GIuKk4EAFQtMKgJAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 10:59:50 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Wed, 24 Feb 2021 10:39:21 +0800
> Aili Yao <yaoaili@kingsoft.com> wrote:
> 
> > On Tue, 23 Feb 2021 16:12:43 +0000
> > "Luck, Tony" <tony.luck@intel.com> wrote:
> >   
> > > > What I think is qemu has not an easy to get the MCE signature from host or currently no methods for this
> > > > So qemu treat all AR will be No RIPV, Do more is better than do less.      
> > > 
> > > RIPV would be important in the guest in the case where the guest can fix the problem that caused
> > > the machine check and return to the failed instruction to continue.
> > > 
> > > I think the only case where this happens is a fault in a read-only page mapped from a file (typically
> > > code page, but could be a data page). In this case memory-failure() unmaps the page with the posion
> > > but Linux can recover by reading data from the file into a new page.
> > > 
> > > Other cases we send SIGBUS (so go to the signal handler instead of to the faulting instruction).
> > > 
> > > So it would be good if the state of RIPV could be added to the signal state sent to qemu. If that
> > > isn't possible, then this full recovery case turns into another SIGBUS case.    
> > 
> > This KVM and VM case of failing recovery for SRAR is just one scenario I think,
> > If Intel guarantee that when memory SRAR is triggered, RIPV will always be set, then it's the job of qemu to
> > set the RIPV instead.
> > Or if When SRAR is triggered with RIPV cleared, the same issue will be true for host.
> > 
> > And I think it's better for VM to know the real RIPV value, It need more work in qemu and kernel if possible.
> > 
> > Thanks
> > Aili Yao  
> 
> ADD this topic to qemu list, this is really one bad issue.
> 
> Issue report:
> when VM receive one SRAR memory failure from host, it all has RIPV cleared, and then vm process it and trigger one panic!
> 
> Can any qemu maintainer fix this?
> 
> Suggestion:
> qemu get the true value of RIPV from host, the inject it to VM accordingly.

Sorry for my previous description, I may not describe the issue clearly,
I found this issue when I do memory SRAR test for kvm virtual machine, the step is:

1. Inject one uncorrectable error to one specific memory address A.
2. Then one user process in the VM access the address A and trigger a MCE exception to host.
3. In do_machine_check() kernel will check the related register and do recovery job from memory_failure();
4. Normally a BUS_MCEERR_AR SIGBUS is sent to the specifc core triggering this error.
5. Qemu will take control, and will inject this event to VM, all infomation qume can get currently is the Error code
   BUS_MCEERR_AR and virtual address, in the qemu inject function:
    if (code == BUS_MCEERR_AR) {
        status |= MCI_STATUS_AR | 0x134;
        mcg_status |= MCG_STATUS_EIPV;
    } else {
        status |= 0xc0;
        mcg_status |= MCG_STATUS_RIPV;
    }
    For BUS_MCEERR_AR case, MCG_STATUS_RIPV will always be cleared.

6. Then in VM kernel, do_machine_check will got this:
	if (!(m.mcgstatus & MCG_STATUS_RIPV))
		kill_current_task = 1;
   then go to force_sig(SIGBUS) without calling memory_failure();
   so for now, the page is not marked hwpoison.

7  The VM kernel want to exit to user mode and then process the SIGBUS signal.
   As SIGBUS is a fatal signal, the coredump related work will be called.

8. Then coredump will get the user space mapped memory dumped, include the error page.

9. Then UE is triggered again, and qemu will take control again, then inject this UE event to VM and
   this time the error is triggered in kernel code, then VM panic.

I don't know how can this issue be fixed cleanly, maybe qemu developers may help on this. 
If qemu can fix this, that will be great!

-- 
Thanks!
Aili Yao
