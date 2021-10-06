Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCB4237F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhJFG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:29:35 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37181 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229797AbhJFG3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:29:34 -0400
Received: from [192.168.0.2] (ip5f5ae933.dynamic.kabel-deutschland.de [95.90.233.51])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D2B2B61E64784;
        Wed,  6 Oct 2021 08:27:39 +0200 (CEST)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <YVxjgFScCZNwliMi@zn.tnic>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <946736c0-d3bc-ed87-70bc-93c0c3cb998a@molgen.mpg.de>
Date:   Wed, 6 Oct 2021 08:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVxjgFScCZNwliMi@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Borislav,


Thank you for your reply.

Am 05.10.21 um 16:38 schrieb Borislav Petkov:
> On Tue, Oct 05, 2021 at 04:29:41PM +0200, Paul Menzel wrote:
>> Selecting the symbol `AMD_MEM_ENCRYPT` – as
>> done in Debian 5.13.9-1~exp1 [1] – also selects
>> `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it defaults to yes,
> 
> I'm assuming that "selecting" is done automatically: alldefconfig,
> olddefconfig?
> 
> Because CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT only depends on
> CONFIG_AMD_MEM_ENCRYPT and former can be disabled in oldconfig or
> menuconfig etc.

Sorry for being unclear. Distributions want to enable support for that 
feature, but as long as it breaks systems, it should be opt-in via the 
Linux kernel command line, and not opt-out. Also the Kconfig help texts 
do not mention anything about these problems, and the AMDGPU log message 
is of level info and not error. It’d be even better, if the message 
would contain the information, how to disable SME (`mem_encrypt=off`).


Kind regards,

Paul
