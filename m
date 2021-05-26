Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DE390D52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhEZAe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhEZAe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:34:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D48A61417;
        Wed, 26 May 2021 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621989206;
        bh=HDyj3Lt2w9z4WJtu0hesbCgJr4a66qSh8QOFDKrJ9J4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Fw0xWHOgUOyrHsTIO7DU5D9aHyHimascPwNN6oTKh4scMils2AJyWsvx7jeM+ss4P
         pGPNvgzE2d1ms38fwUaLIs4XYa5hQ0csX+Em0NMbY+LVsHe5moaME2cN1Td3ejMtoJ
         RWW1siysaGxzgppItsnTps2dI6EI/C7tUk361i/UJDTyLkz3A5WgJlgZsfQjCsKOZC
         AaRXd6RMQekkhPDJXQI1kWnzdlNZVZoDWooIxora1A9CVN0I2kjvVy6MEOL6CakQN4
         L6OdLSvGtH5sLMXKSoroY9vObNQSLUTx3kX1vccNvIEhWu7znmpMfdJqkW/3pO6i1F
         35vMeimHFG6Qg==
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
To:     syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com
References: <0000000000004c453905c30f8334@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
Date:   Tue, 25 May 2021 17:33:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0000000000004c453905c30f8334@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 1:51 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    45af60e7 Merge tag 'for-5.13-rc2-tag' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1591e9f7d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2067e764dbcd10721e2e
> compiler:       Debian clang version 11.0.1-2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be6bd1d00000

Hi syz people and x86 people-

I entirely believe that this bug is real and that syzbot bisected it
correctly, but I'm puzzled by the reproducer.  It says:

ptrace$setregs(0xd, r0, 0x0, &(0x7f0000000080))

I would really, really expect this to result from PTRACE_SETREGSET or
PTRACE_SETFPREGS, but this is PTRACE_SETREGS.


Am I missing something really obvious here?
