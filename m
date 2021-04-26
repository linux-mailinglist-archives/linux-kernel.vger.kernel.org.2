Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8236B7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhDZRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhDZRPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:15:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC243C061574;
        Mon, 26 Apr 2021 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mr0akJrcmWA5NRctjoUq+9kKNEsJVgQWrJHErM3KLvI=; b=XJyf6e3iBC20aoTSmPzgfUCI/J
        1axUejYi8d9imWJGD/6uUj86JRfUDR2feyl7ltF1feUeTZGyzHfStCuV9dA5HeC6xZxZ1zCjBfKzS
        b9YP+XLOFxaDAZh2nVxOw3F7B6uEiAYu4iAOP8Hh3J9bxEfD1M8ngsdbo4gYoTnl5ZtrRmdMwDSBg
        FDqeYkPYniXsK3NUeNGrj1JLq5xQSFsrYYvMk/z7GHdsif3eFuDtnBoBIbtqT8R9GAFKB80Ka/PF6
        /gkoI7aeh1mVN4HVs6WdrYHjO8RiXaHJtHHWRf0M+sL84vGzf06yoW1BCc7f1UhjotUEsVIgFvt9L
        rsY4NZBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb4ng-005tRv-6K; Mon, 26 Apr 2021 17:13:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44F0230013E;
        Mon, 26 Apr 2021 19:13:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C779238B73AD; Mon, 26 Apr 2021 19:13:33 +0200 (CEST)
Date:   Mon, 26 Apr 2021 19:13:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     David Malcolm <dmalcolm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        yuanzhaoxiong@baidu.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YIb0vYQMEs9HRjPl@hirez.programming.kicks-ass.net>
References: <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
 <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net>
 <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com>
 <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net>
 <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com>
 <20210409213949.GA33256@worktop.programming.kicks-ass.net>
 <YIFilwwzWiSDZU6b@hirez.programming.kicks-ass.net>
 <20210422170820.GB27473@gate.crashing.org>
 <YIG3I+ojW+bc+o4l@hirez.programming.kicks-ass.net>
 <20210422183151.GD27473@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422183151.GD27473@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 01:31:51PM -0500, Segher Boessenkool wrote:
> It sounds like you want it to behave like attribute((pure)) already is
> documented as doing.  Please open a PR?  https://gcc.gnu.org/bugs.html
> (We need buildable stand-alone example code, with what flags to use, and
> something like what should happen and what did happen).


Something like so?

---

gcc (Debian 10.2.1-6) 10.2.1 20210110

Clear fail on both counts, the first emits _3_ nops, where 1 is
expected, and the second emits the nop _inside_ the loop.

0000000000001180 <elide_branches>:
1180:       48 83 ec 08             sub    $0x8,%rsp
1184:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
1189:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
118e:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
1193:       48 83 c4 08             add    $0x8,%rsp
1197:       c3                      retq
1198:       0f 1f 84 00 00 00 00 00         nopl   0x0(%rax,%rax,1)
11a0:       48 8d 3d 5d 0e 00 00    lea    0xe5d(%rip),%rdi        # 2004 <_IO_stdin_used+0x4>
11a7:       31 c0                   xor    %eax,%eax
11a9:       e8 a2 fe ff ff          callq  1050 <printf@plt>
11ae:       eb d9                   jmp    1189 <elide_branches+0x9>
11b0:       48 8d 3d 5a 0e 00 00    lea    0xe5a(%rip),%rdi        # 2011 <_IO_stdin_used+0x11>
11b7:       48 83 c4 08             add    $0x8,%rsp
11bb:       e9 80 fe ff ff          jmpq   1040 <puts@plt>
11c0:       48 8d 3d 45 0e 00 00    lea    0xe45(%rip),%rdi        # 200c <_IO_stdin_used+0xc>
11c7:       31 c0                   xor    %eax,%eax
11c9:       e8 82 fe ff ff          callq  1050 <printf@plt>
11ce:       eb be                   jmp    118e <elide_branches+0xe>

00000000000011d0 <hoist>:
11d0:       53                      push   %rbx
11d1:       31 db                   xor    %ebx,%ebx
11d3:       eb 16                   jmp    11eb <hoist+0x1b>
11d5:       0f 1f 00                nopl   (%rax)
11d8:       89 de                   mov    %ebx,%esi
11da:       48 8d 3d 36 0e 00 00    lea    0xe36(%rip),%rdi        # 2017 <_IO_stdin_used+0x17>
11e1:       31 c0                   xor    %eax,%eax
11e3:       83 c3 01                add    $0x1,%ebx
11e6:       e8 65 fe ff ff          callq  1050 <printf@plt>
11eb:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
11f0:       b8 0a 00 00 00          mov    $0xa,%eax
11f5:       39 c3                   cmp    %eax,%ebx
11f7:       7c df                   jl     11d8 <hoist+0x8>
11f9:       bf 0a 00 00 00          mov    $0xa,%edi
11fe:       5b                      pop    %rbx
11ff:       e9 2c fe ff ff          jmpq   1030 <putchar@plt>
1204:       0f 1f 40 00             nopl   0x0(%rax)
1208:       b8 05 00 00 00          mov    $0x5,%eax
120d:       eb e6                   jmp    11f5 <hoist+0x25>
120f:       90                      nop

---

/* gcc -O2 -o pure-fail pure-fail.c */

#include <stdio.h>
#include <stdbool.h>

#define __pure		                __attribute__((__pure__))

#define __stringify_1(x...)	#x
#define __stringify(x...)	__stringify_1(x)

#ifndef __x86_64__
#define BYTES_NOP4	0x8d,0x74,0x26,0x00
#define BYTES_NOP5	0x3e,BYTES_NOP4
#else
#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0x00
#endif

# define __ASM_FORM(x)	" " __stringify(x) " "
# define __ASM_FORM_RAW(x)     __stringify(x)
# define __ASM_FORM_COMMA(x) " " __stringify(x) ","

#ifndef __x86_64__
/* 32 bit */
# define __ASM_SEL(a,b) __ASM_FORM(a)
# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
#else
/* 64 bit */
# define __ASM_SEL(a,b) __ASM_FORM(b)
# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
#endif

#define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
					  inst##q##__VA_ARGS__)
#define __ASM_REG(reg)         __ASM_SEL_RAW(e##reg, r##reg)

#define _ASM_PTR	__ASM_SEL(.long, .quad)
#define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)

#define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)

/* --- */

struct static_key {
	int enabled;
};

#define STATIC_KEY_INIT_TRUE	{ .enabled = 1, }
#define STATIC_KEY_INIT_FALSE	{ .enabled = 0, }

static __always_inline __pure bool arch_static_branch(struct static_key * const key, const bool branch)
{
	asm_volatile_goto("1:"
		".byte " __stringify(BYTES_NOP5) "\n\t"
		".pushsection __jump_table,  \"aw\" \n\t"
		_ASM_ALIGN "\n\t"
		".long 1b - ., %l[l_yes] - . \n\t"
		_ASM_PTR "%c0 + %c1 - .\n\t"
		".popsection \n\t"
		: :  "i" (key), "i" (branch) : : l_yes);

	return false;
l_yes:
	return true;
}


static __always_inline __pure bool static_key_false(struct static_key * const key)
{
	return arch_static_branch(key, false);
}

static __always_inline __pure bool static_key_true(struct static_key * const key)
{
	return !arch_static_branch(key, true);
}



/* --- */


static struct static_key key_A = STATIC_KEY_INIT_FALSE;

/*
 * Expect:
 *
 *	if (static_key_false(&key_A)) {
 *		printf("ponies ");
 *		printf("are ");
 *		printf("small\n");
 *	}
 */
void elide_branches(void)
{
	if (static_key_false(&key_A))
		printf("ponies ");
	if (static_key_false(&key_A))
		printf("are ");
	if (static_key_false(&key_A))
		printf("small\n");
}


/* --- */

static struct static_key key_B = STATIC_KEY_INIT_TRUE;

static __pure int count(void)
{
	if (static_key_true(&key_B))
		return 10;
	return 5;
}

/*
 * Expect:
 *
 *	tmp = count();
 *	for (i = 0; i < tmp; i++)
 *		printf("%d, ", i);
 *	printf("\n");
 */
void hoist(void)
{
	int i;

	for (i = 0; i < count(); i++)
		printf("%d, ", i);
	printf("\n");
}


/* --- */

int main(int argc, char **argv)
{
	elide_branches();
	hoist();

	return 0;
}
