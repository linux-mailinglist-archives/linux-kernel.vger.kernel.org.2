Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3F3958CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhEaKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:18:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 03:16:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622456214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP/7cHDjM7AcyJT0WqOBpKhECSitGh7KPRl8GthYiCA=;
        b=0/Aob5Vgmmyc+nNO0ibkrtD6SKUV81urd1poAdJQq0E6QgJ7IVTVBzz2oALXMcMyDUVv/3
        eFRmkmF8eXTZdi6qd+pzWmlqdKp0KEOOOdr4o6sp7VdtidOo1wmQk9QWhTaTs+cRxlY3OJ
        k4iR54Z0HZT2rXBBXA+d5kGL4JltZBixqCoWufgxLa65muWnoGY/xD3XO5InjUk/e42a/Y
        ROVPWmHYgTQn9vEDwbZbY5K6/EsHGuwsAwUvEeCtaZDyUSl06Zsiny4Hu1g4uadYFdCHHz
        pjT2nh3GwdgQX5de/TA33ooJ/Om0a15zzvLheuyWAfs0HCRigYBvtf2xISt7EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622456214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP/7cHDjM7AcyJT0WqOBpKhECSitGh7KPRl8GthYiCA=;
        b=2TcAlmkjnAj+YI85xX7piawpzztpkiaVA21gzmInASwrMGzjuHy8XqP/zXThQejPR+9L22
        SBeOo3NY5dLL9BBg==
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()
In-Reply-To: <YLShmFEzddfm7WQs@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com> <1600187413-163670-10-git-send-email-fenghua.yu@intel.com> <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLShmFEzddfm7WQs@zn.tnic>
Date:   Mon, 31 May 2021 12:16:54 +0200
Message-ID: <87y2bv438p.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31 2021 at 10:43, Borislav Petkov wrote:
> On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
>> #2 is broken beyond repair. The comment in the code claims that it is safe
>>    to invoke this in an IPI, but that's just wishful thinking.
>> 
>>    FPU state of a running task is protected by fregs_lock() which is
>>    nothing else than a local_bh_disable(). As BH disabled regions run
>>    usually with interrupts enabled the IPI can hit a code section which
>>    modifies FPU state and there is absolutely no guarantee that any of the
>>    assumptions which are made for the IPI case is true.
>
> ... so on a PASID system, your trivial reproducer would theoretically
> fire the same way and corrupt FPU state just as well.

This is worse and you can't selftest it because the IPI can just hit in
the middle of _any_ FPU state operation and corrupt state.

Thanks,

        tglx
