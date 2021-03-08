Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDA330A82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCHJtq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Mar 2021 04:49:46 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:46845 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230039AbhCHJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:49:15 -0500
X-AuditID: 0a580155-713ff700000550c6-67-6045ebaa5450
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 7E.F0.20678.AABE5406; Mon,  8 Mar 2021 17:17:30 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 8 Mar 2021
 17:49:12 +0800
Date:   Mon, 8 Mar 2021 17:49:12 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        <yangfeng1@kingsoft.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210308174912.4ac9029a@alex-virtual-machine>
In-Reply-To: <CALCETrWFXgOtFYycpY7A5Z1yM2oiZwP4sRh4e7Rfu32N85Kxig@mail.gmail.com>
References: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com>
        <59469ECC-5316-4074-98EF-52FFF7940818@amacapital.net>
        <20210303202402.384265a3@alex-virtual-machine>
        <20210303205129.0a66f7a7@alex-virtual-machine>
        <CALCETrWFXgOtFYycpY7A5Z1yM2oiZwP4sRh4e7Rfu32N85Kxig@mail.gmail.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsXCFcGooLvqtWuCwfLvQhafN/xjs3ixoZ3R
        YtpGcYvLu+awWdxb85/VYvXaBlaL87vWslpcOrCAyeJi4wFGi+O9B5gsNm+aymzx5sI9Fosf
        Gx6zOvB6fG/tY/G4/+Yvi8fmFVoei/e8ZPLYtKqTzWPTp0nsHu/OnWP3mHcy0OPF1Y0sHu/3
        XWXz+LxJzuNEyxfWAJ4oLpuU1JzMstQifbsEroyew+0sBacEKiZfPcnewPiQp4uRk0NCwESi
        /fYWpi5GLg4hgelMEm1HfrGAJIQEXjJK/Jok2MXIwcEioCKx5T0TSJhNQFVi171ZrCC2iICm
        xMsp81lAepkFXjJLbHszixkkISyQLHFm0gNGEJtXwEpi/eFrYHFOgUCJTdtesEAsm8kk0f/q
        H1iCX0BMovfKfyaIi+wl2rYsgmoWlDg58wnYQcxA21q3/2aHsLUlli18zQxxqKLE4SW/2CF6
        lSSOdM9gg7BjJZbNe8U6gVF4FpJRs5CMmoVk1AJG5lWMLMW56UabGCGRGLqDcUbTR71DjEwc
        jIcYJTiYlUR4e3ucE4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz7j3mmiAkkJ5YkpqdmlqQWgST
        ZeLglGpgcrI5oHCji3d3+PtvHBVLN10+stnkmb2xzSOnu6o7oj49lFG/t+6giOcytRvz/C54
        al4tunCjfFPIyrsL450tvggfZd89pSi5/d3x5xMn/7ju9HKd3u9l+y4pvxI6Z50xX1zr+Jy9
        H3cVff5+6apD4hPBSc2bM+TKLb44HxLfumya9xmT66u4f2+NUUldPztVMNTzts+BuVPvr6tN
        2rW3OGrHG8PDbKHPLYO3XZvcMuP4L3573dXJnCanUtNXyRnW8+Q2Pn1h/27G7psz7+7b0vd9
        +W8N422x7tui5F3YW/jj11sKCWyyFL1dzarOwjf/9ZwX7/pm3n13qIbxTLXAIX4z9uCpfvfl
        hAUz3Y60rYpTYinOSDTUYi4qTgQA81gYLDMDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2021 11:16:24 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > > > >> Some programs may use read(2), write(2), etc as ways to check if
> > > > >> memory is valid without getting a signal.  They might not want
> > > > >> signals, which means that this feature might need to be configurable.  
> > > > >
> > > > > That sounds like an appalling hack. If users need such a mechanism
> > > > > we should create some better way to do that.
> > > > >  
> > > >
> > > > Appalling hack or not, it works. So, if we’re going to send a signal to user code that looks like it originated from a bina fide architectural recoverable fault, it needs to be recoverable.  A load from a failed NVDIMM page is such a fault. A *kernel* load is not. So we need to distinguish it somehow.  
> > >
> > > Sorry for my previous mis-understanding, and i have some questions:
> > > if programs use read,write to check if if memory is valid, does it really want to cover the poison case?  
> 
> I don't know.
> 
> > > When for such a case, an error is returned,  can the program realize it's hwposion issue not other software error and process correctly?  
> 
> Again, I don't know.  But changing the API like this seems potentialy
> dangerous and needs to be done with care.
> 
> > >
> > > if this is the proper action, the original posion flow in current code from read and write need to change too.
> > >  
> >
> > Sorry, another question:
> >   When programs use read(2), write(2) as ways to check if memory is valid, does it really want to check if the user page the program provided is valid, not the destination or disk space valid?  
> 
> They may well be trying to see if their memory is valid.

Thanks for your reply, and I don't know what to do.
For current code, if user program write to a block device(maybe a test try) and if its user copy page corrupt when in kernel copy, the process is killed with a SIGBUS.
And for the page fault case in this thread, the process is error returned.

-- 
Thanks!
Aili Yao
