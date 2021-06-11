Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD73A48D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFKSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFKSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0316661002;
        Fri, 11 Jun 2021 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623437153;
        bh=VQlhv40kLT15P4nje8ck5f/GQevWqLbHEI4fDMZhF4c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FbuB77RoFU6bHKmQ1e3Mpfqkr8DroBwAzoLQmab3a7zb/anCxG3wG/borVX5Nso+x
         4p97B1XkGkpDH4Sofw4Hl7i2o+SEByvbG37M/4rRbN5EpQCC8T6uYqjhJSy1fCOMlt
         fDRCJaRsIOvlGtFW2EgUJw4w0ULtdED1md5vShko/Va576UlSBLawNCpv0MYCrwoAt
         KOpgu+6qGYVU8OzejPBCqsW5PKHmq+No8MEg4ZB8Pzu4Ez7ZRIz4n5H6fkencBpcz1
         FIoL+XUgIti7aX6GyhrCxfABJZm7dBWLwpmy4U9BGGqu9skxnzFvoQYQFqzKLiPdmp
         fs9q3qKw2oIpA==
Subject: Re: [patch 06/41] x86/fpu: Sanitize xstateregs_set()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.614604526@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <ae886c48-3c6c-a646-a140-ee26c57abf93@kernel.org>
Date:   Fri, 11 Jun 2021 11:45:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611163111.614604526@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 9:15 AM, Thomas Gleixner wrote:
> xstateregs_set() operates on a stopped task and tries to copy the provided
> buffer into the tasks fpu.state.xsave buffer.
> 
> Any error while copying or invalid state detected after copying results in
> wiping the target tasks FPU state completely including supervisor states.
> 
> That's just wrong. The caller supplied invalid data or has a problem with
> unmapped memory, so there is absolutely no justification to corrupt the
> target state.
> 
> @@ -1146,14 +1146,16 @@ int copy_kernel_to_xstate(struct xregs_s
>  	 */
>  	xsave->header.xfeatures |= hdr.xfeatures;
>  
> +	/* mxcsr reserved bits must be masked to zero for security reasons. */
> +	xsave->i387.mxcsr &= mxcsr_feature_mask;

This comment is vague.  At least it should say:

A subsequent XRSTOR(S) will fail if MXCSR has bits set that are not
accepted by the current CPU.  Mask out unsupported bits.

But a much nicer fix IMO would be to just return an error.

--Andy
