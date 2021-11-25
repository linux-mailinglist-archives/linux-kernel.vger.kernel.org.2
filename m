Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA145DD68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354504AbhKYPat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:30:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbhKYP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:28:48 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637853933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ScN0yZJ9DZrfZrU9bEQf2Vg3+YysYzBmCXrDw5SbvI=;
        b=YE/yEWqDEOy+qF2FEZAfhspZGSfX33lbs9F9pxlG3hCFCCziJvGlP47svWrSUyTz5dv56i
        nEWu9G4BOmeyeAFDSM/tZPqUB0CHip5bP86yHW8gbQoMDfepKtwSDc3MBcXf0/VWXOm/8I
        1GT0fitRJpSr6qLFep1PdQo7OEvjMCuCfGEsTiwjQ1ypNuEIeOd512ffqJTrivsv11dRvM
        Y6PySfjhDOtKDmzXa6raADo8CH/DXi6Bai+5mO6oWzaIs5pnWmpAdJ4TgvZsA9A8ErfXwt
        JEsWAZCJxTcNP+mdqlpK0FhChwPK99jmlR/lh0CcB6Mpl3SqWXGbfBbvV8gjqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637853933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ScN0yZJ9DZrfZrU9bEQf2Vg3+YysYzBmCXrDw5SbvI=;
        b=PX3lkAHehFpJ5BUzLqbVMbfTtqKYVTSfZgmsEAnqxCRL1EjZfzcsfZW11y6bxaJzOMhAKV
        t7WAUHINCW/1IRCQ==
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 07/18] x86/pks: Preserve the PKRS MSR on context switch
In-Reply-To: <20210804043231.2655537-8-ira.weiny@intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-8-ira.weiny@intel.com>
Date:   Thu, 25 Nov 2021 16:25:32 +0100
Message-ID: <87fsrkl0k3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2021 at 21:32, ira weiny wrote:
> @@ -658,6 +659,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in();
>  
> +	pkrs_write_current();

This is invoked from switch_to() and does this extra get/put_cpu_ptr()
dance in the write function for no reason. Can you please stop sticking
overhead into the hotpath just because?

Thanks,

        tglx
