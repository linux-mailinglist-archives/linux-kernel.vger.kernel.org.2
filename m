Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7487C45D91F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhKYLYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:24:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhKYLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:22:40 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637839167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ma5VbatWNFQZCLFlfHQQnL8bQbyHFoYfeKADC16NCw=;
        b=4ePzyve3BV8W3Ri0w2FAt94m/sR5E2beQ9Uzi+snKcGE1+C9sSemwZdCWvyOdNjoJOG9tc
        L5/g99loi2VqkMdpDQ8IdFbluX4ZM/ugzVUhvMjE+QintyM0hWvSUlxwGrs5/Q05fS6YDR
        nWcKWslu0wvP6/Cq/wEe9IFSOxVCcWbvmx1OGDMH/1z4nbz84KP/gysD5enVRBaLP2pffu
        1KO/uSL7KpyKmJD7meAq9RdoU1eBZ5WQoQ2LLsOYyEcesTjMHz7lG3A9C6rc1d7FFvIJGv
        mdp+iWt3SkrHeBODGzbJqr5fFflFFFYW8wIEr6ltneHooGZQd02seIViPWBCMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637839167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ma5VbatWNFQZCLFlfHQQnL8bQbyHFoYfeKADC16NCw=;
        b=NXTbV8DDLwaeOj+cBZrvOlV2D4CmfDV75T/cGw6iKtVmqnEoQEAFdJ/LixPiuBWQtghkmD
        +xPVaQ4L7mjRytCw==
To:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 08/18] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20211113005051.GN3538886@iweiny-DESK2.sc.intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-9-ira.weiny@intel.com>
 <20211113005051.GN3538886@iweiny-DESK2.sc.intel.com>
Date:   Thu, 25 Nov 2021 12:19:26 +0100
Message-ID: <8735nkmqip.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12 2021 at 16:50, Ira Weiny wrote:
> On Tue, Aug 03, 2021 at 09:32:21PM -0700, 'Ira Weiny' wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
>> 
>> The PKRS MSR is not managed by XSAVE.  It is preserved through a context
>> switch but this support leaves exception handling code open to memory
>> accesses during exceptions.
>> 
>> 2 possible places for preserving this state were considered,
>> irqentry_state_t or pt_regs.[1]  pt_regs was much more complicated and
>> was potentially fraught with unintended consequences.[2]  However, Andy
>> came up with a way to hide additional values on the stack which could be
>> accessed as "extended_pt_regs".[3]
>
> Andy,
>
> I'm preparing to send V8 of this PKS work.  But I have not seen any feed back
> since I originally implemented this in V4[1].
>
> Does this meets your expectations?  Are there any issues you can see with this
> code?
>
> I would appreciate your feedback.

Not Andy here, but I'll respond to the patch in a minute.

Thanks,

        tglx
