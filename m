Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347EA36D009
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhD1Arv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:47:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45847 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhD1Aru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:47:50 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 13S0klxe959418
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Apr 2021 17:46:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 13S0klxe959418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021032801; t=1619570813;
        bh=dmXauy4p/ZbgFoR9+NLZaIKYk51ve+/9HGzgV4ivmlo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=H1c9xSxVl6ReDt1lyolUEzmpdZcBKTlHspe6Xu3xLQtDTNgN0FGOXYTpVobb1DbFt
         NmXpyUu/n+m5XxTu2w61n8l5p3A/r7trSh56C4VJJHEOX9D4+pqvPPd1wej8TyWjiN
         CUnGRcXxsPjjU34RhitKOYldu+yOowDuap/vzvhK4kYCxy5Ta+GwvSF/HBS2TBGpqm
         uNi6YwFXJaRTk/HJ3XEoJAASqkLMfBQRdhMsvzdLw97LmW8lZiVLF/lmK8l7WFLtoN
         EuG53rdhc8JwC+PuAMq0TECMmXWNHT3thsZ5lGbgI0UkSPI5CppDRRQ8d3t3DbMyuY
         OGFk2IYygp1Rg==
Subject: Re: pt_regs->ax == -ENOSYS
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
 <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
 <CALCETrW7Vu5ZU-Lv4RRG5DSGxMBJmDMqpvP7kqO16DwajproBQ@mail.gmail.com>
 <3626eea3-524e-4dbd-78dd-9ade5a346a08@zytor.com>
 <CALCETrWzL=jgnWd+6YuBo02GG8vTvsG22sXGaUQCc37vwQ6HdA@mail.gmail.com>
 <3a502aae-4124-5cb2-1dac-bc18b8158fbe@zytor.com>
Message-ID: <87bda691-9201-06cd-9850-c92a05a399c7@zytor.com>
Date:   Tue, 27 Apr 2021 17:46:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3a502aae-4124-5cb2-1dac-bc18b8158fbe@zytor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 5:20 PM, H. Peter Anvin wrote:
> 
> We *used* to truncate the system call number; that was unsigned. It 
> causes massive headache to ptrace if a 32-bit ptrace wants to write -1, 
> which is a bit hacky.
> 
> I would personally like to see orig_ax to be the register passed in and 
> for the truncation to happen by syscall_get_nr().
> 
> I also note that kernel/seccomp.c and the tracing infrastructure all 
> expect a signed int as the system call number. Yes, orig_ax is a 64-bit 
> field, but so are the other register fields which doesn't necessarily 
> directly reflect the value of an argument -- like, say, %rdi in the case 
> of sys_write - it is an int argument so it gets sign extended; this is 
> *not* reflected in ptrace.
> 
>      -hpa

We could even do this, to make it perhaps harder to mess up:

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 409f661481e1..4e8e5c2e35f4 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -41,7 +41,10 @@ struct pt_regs {
  	unsigned short gs;
  	unsigned short __gsh;
  	/* On interrupt, this is the error code. */
-	unsigned long orig_ax;
+	union {
+		unsigned long orig_ax;
+		int syscall_nr;
+	};
  	unsigned long ip;
  	unsigned short cs;
  	unsigned short __csh;
@@ -78,7 +81,10 @@ struct pt_regs {
   * On syscall entry, this is syscall#. On CPU exception, this is error 
code.
   * On hw interrupt, it's IRQ number:
   */
-	unsigned long orig_ax;
+	union {
+		unsigned long orig_ax;
+		int syscall_nr;
+	};
  /* Return frame for iretq */
  	unsigned long ip;
  	unsigned long cs;
