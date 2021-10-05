Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8758E422B09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhJEObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:31:36 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:47265 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234899AbhJEObe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:31:34 -0400
Received: from [192.168.0.2] (ip5f5ae91d.dynamic.kabel-deutschland.de [95.90.233.29])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EF0BD61EA1936;
        Tue,  5 Oct 2021 16:29:41 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Subject: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on Ryzen:
 amdgpu: SME is not compatible with RAVEN
Message-ID: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
Date:   Tue, 5 Oct 2021 16:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tom, dear Linux folks,


Selecting the symbol `AMD_MEM_ENCRYPT` – as done in Debian 5.13.9-1~exp1 
[1] – also selects `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it defaults 
to yes, causing boot failures on AMD Raven systems. On the MSI B350M 
MORTAR with AMD Ryzen 3 2200G, Linux logs and the AMDGPU graphics 
driver, despite being loaded, does not work, and the framebuffer driver 
is used instead.

     [   19.679824] amdgpu 0000:26:00.0: amdgpu: SME is not compatible 
with RAVEN

It even causes black screens on other systems as reported to the Debian 
bug tracking system *Black screen on AMD Ryzen based systems (AMDGPU 
related when AMD Secure Memory Encryption not disabled -- 
mem_encrypt=off)* [2].

Should the default be changed?


Kind regards,

Paul


[1]: 
https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/changelog#L1138
[2]: https://bugs.debian.org/994453
