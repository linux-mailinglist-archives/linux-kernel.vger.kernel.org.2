Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F313249DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 05:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhBYEsf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Feb 2021 23:48:35 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12347 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbhBYEr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 23:47:59 -0500
X-AuditID: 0a580157-f39ff7000005df43-90-603725882e1d
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 5F.A1.57155.88527306; Thu, 25 Feb 2021 12:20:24 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 25 Feb
 2021 12:47:12 +0800
Date:   Thu, 25 Feb 2021 12:47:11 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        "HORIGUCHI =?UTF-8?B?TkFPWUE=?=( =?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <yangfeng1@kingsoft.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210225124711.35b31965@alex-virtual-machine>
In-Reply-To: <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com>
References: <20210223204436.1df73153@alex-virtual-machine>
        <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
        <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsXCFcGooNuhap5gcOGdpcXnDf/YLF5saGe0
        mLZR3OLyrjlsFvfW/Ge1WL22gdXi/K61rBaXDixgsrjYeIDR4njvASaLzZumMlu8uXCPxeLH
        hsesDrwe31v7WDzuv/nL4rF5hZbH4j0vmTw2repk89j0aRK7x7tz59g95p0M9HhxdSOLx/t9
        V9k8Pm+S8zjR8oU1gCeKyyYlNSezLLVI3y6BK+NETx9jwVnhittHXrA1MC7g72Lk5JAQMJH4
        13GdEcQWEpjOJHHvm2sXIxeQ/YpRou/JbjaQBIuAqsS9U3vBbDYge9e9WawgtoiAmsSlxQ+Y
        QRqYBRYyS3x48hqsSFggWeLMpAdgU3kFrCTOr10EZnMKuEl0rz7IDLFhHaPEnPWbwBr4BcQk
        eq/8Z4I4yV6ibcsiqGZBiZMzn7CA2MwCmhKt23+zQ9jaEssWvmaGOFtR4vCSX+wQvUoSR7pn
        sEHYsRLL5r1incAoPAvJqFlIRs1CMmoBI/MqRpbi3HTDTYyQWAzfwTiv6aPeIUYmDsZDjBIc
        zEoivJv/mSYI8aYkVlalFuXHF5XmpBYfYpTmYFES55ViM08QEkhPLEnNTk0tSC2CyTJxcEo1
        MM3YEO7777Xmj8+PVS+t/fVo7ZXjc+Y+4fovc0GSS+DwCs13lzLjbDtclgeGt+7h6JWd+unL
        xXdiD1cxBaaqz27N//5wwwavZXdeMfG9XfHFy3PyxQufX3k4dmXxL1vxY6v/5LSM/fek/X/K
        Me188WCKNIPM5JdHlCPE5/msaTgems8e9CnkEsshkzMPD7EIbNPlnf6lwa55/kNV5qRbcTIe
        P3ITHuT1qVdJBbL1LehQnmo8eT1rXaZbXLvWU6sDipxLvzomuPlpqdw3zzmQbZj3Xv/4r/S0
        1ZtECth+ytRu+a976dOdWTeXy09ffn9izB/lvx+j+oSW+GbnCK4uu+t4ZHn8rgUTli8QuKWi
        edJEiaU4I9FQi7moOBEA4HFBwTQDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 08:42:59 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> On Tue, Feb 23, 2021 at 07:33:46AM -0800, Andy Lutomirski wrote:
> >   
> > > On Feb 23, 2021, at 4:44 AM, Aili Yao <yaoaili@kingsoft.com> wrote:
> > > 
> > > ﻿On Fri, 5 Feb 2021 17:01:35 +0800
> > > Aili Yao <yaoaili@kingsoft.com> wrote:
> > >   
> > >> When one page is already hwpoisoned by MCE AO action, processes may not
> > >> be killed, processes mapping this page may make a syscall include this
> > >> page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
> > >> mode it may be fixed by fixup_exception, current code will just return
> > >> error code to user code.
> > >> 
> > >> This is not sufficient, we should send a SIGBUS to the process and log
> > >> the info to console, as we can't trust the process will handle the error
> > >> correctly.
> > >> 
> > >> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> > >> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > >> ---
> > >> arch/x86/mm/fault.c | 62 +++++++++++++++++++++++++++++----------------
> > >> 1 file changed, 40 insertions(+), 22 deletions(-)
> > >>   
> > > Hi luto;
> > >  Is there any feedback?  
> > 
> > At the very least, this needs a clear explanation of why your proposed behavior is better than the existing behavior.  
> 
> The explanation is buried in that "can't trust the process" line.
> 
> E.g. user space isn't good about checking for failed write(2) syscalls.
> So if the poison was in a user buffer passed to write(fd, buffer, count)
> sending a SIGBUS would be the action if they read the poison directly,
> so it seems reasonable to send the same signal if the kernel read their
> poison for them.
> 
> It would avoid users that didn't check the return value merrily proceeding
> as if everything was ok.

Hi luto:
   I will add more infomation:
   Even if the process will check return value of syscall like write, I don't think
process will take proper action for this.
   In test example, the return value will be errno is 14 (Bad Address), the process may not realize
this is a hw issue, and may take wrong action not as expected.
   And totally, A hw error will rarely happen, and the hw error hitting this branch will be
more unlikely, the impaction without this patch is quite minor, but this is still not good enough, we should
make it better, right?

Thanks
Aili Yao
    


