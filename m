Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6B3A9572
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhFPI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:58:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40498 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFPI6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:58:36 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623833789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+YJbraTckGoIzQJuhroEkJcqJl6d5bQUuomKW+cWkA=;
        b=cvEGLO1AAG37eHCyTRMYO3XyIA89+4HGa4vs6OwZ7xBm98tdRqQJmy5m2tWuItrn6ycm4P
        uAiIrWJVd7fdmPSzfmiJIDc268wi7tbnC6HGCflobBGrZjGwP7VeaA9iaxd/TKUYWIc6dh
        W7OmbxKSn7HDvol+n0uVW4PsOzTKh8lZ7F2XFZz6ue/ccnbERUZh8VqPrcdinX3LMxPmib
        npPVYXHuglpaPdYK25tfOu414url6O51KYDGp+pitxenkjHTM/hOzcmvIJpDVwf2SAG3Kn
        tOO78OKFOeYCdbhfJHLZSp3fwyzlgYLkQf3NC7LVtSAdmIUsrTLRhZICeYnOlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623833789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+YJbraTckGoIzQJuhroEkJcqJl6d5bQUuomKW+cWkA=;
        b=XiW2nS+aWroAjDGkUmMoJ3Qm85HdOw9w+9DiwkhdtgSR8VvNMQWr1jeEkAYaYHa7sPXglT
        fK7mcG1HdI/cpiDw==
To:     "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 45/52] x86/fpu: Dont restore PKRU in fpregs_restore_userspace()
In-Reply-To: <89da2d23-7de8-8dee-5b6a-361b7ceeae8e@intel.com>
References: <20210614154408.673478623@linutronix.de> <20210614155358.277290739@linutronix.de> <89da2d23-7de8-8dee-5b6a-361b7ceeae8e@intel.com>
Date:   Wed, 16 Jun 2021 10:56:27 +0200
Message-ID: <878s3agpc4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2021 at 17:52, Yu-cheng Yu wrote:
> On 6/14/2021 8:44 AM, Thomas Gleixner wrote:
>> +		 * If PKRU is enabled, then the PKRU value is already
>> +		 * correct because it was either set in switch_to() or in
>> +		 * flush_thread(). So it is excluded because it might be
>> +		 * not up to date in current->thread.fpu.xsave state.
>> +		 */
>> +		__restore_fpregs_from_fpstate(&fpu->state,
>> +					      xfeatures_mask_restore_user());
>
> This needs to be xfeatures_mask_restore_user() | 
> xfeatures_mask_supervisor().

Indeed. Good catch!

Thanks,

        tglx
