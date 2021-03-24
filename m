Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952EC34858B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhCXXur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235088AbhCXXub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A65A619B4;
        Wed, 24 Mar 2021 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629831;
        bh=/cDQs2Wm+IJwdVfwGz/NvxfCVp4bq/H+IHnjqrO53Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkQDdL96zAvUCO8Sa/jFnOc8wXMbH5/V6h4XNWGbomTXXsJ9Y9of6NwEkLdaBt1fu
         Py+cqcfMUe2BpLZITLQiEN+JctYoBU5k0WUOmEVV5KyJpaAPUsuTf28UtG7Xk1q8CW
         1hX0oPkJx9wzpnPQLUeo3zkv7MYdRImcKzs8s7ef7wtfGlF872rvDJcfeS3a0Y02Iy
         yXPE8tAE2DYHgKiZ6tKyJPj1PidgD1qM676dpotE/WViCXOYP3E41tCTVexLpw4wiY
         om24ZA6y/IHlNYg8g+YWw47iJPL8iFtGiTuTd09AtRgZ8P05Fu8BYrHPD/MoB+OOR2
         813b7edMAifBw==
Date:   Thu, 25 Mar 2021 08:50:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] x86/kprobes: Remove dead code
Message-Id: <20210325085026.22e615dc8d721610b77ec9ec@kernel.org>
In-Reply-To: <20210325075654.98e4a89c1ce5d25f47b87b78@kernel.org>
References: <20210324173641.GA404706@LEGION>
        <5fcd5b04-0fab-3672-c5d2-6e8f73f93bbc@canonical.com>
        <20210325075654.98e4a89c1ce5d25f47b87b78@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 07:56:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 24 Mar 2021 17:50:16 +0000
> Colin Ian King <colin.king@canonical.com> wrote:
> 
> > On 24/03/2021 17:36, Muhammad Usama Anjum wrote:
> > > The condition in switch statement `opcode & 0xf0` cannot evaluate to
> > > 0xff. So this case statement will never execute. Remove it.
> > > 
> > > Fixes: 6256e668b7 ("x86/kprobes: Use int3 instead of debug trap for single-step")
> > > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> > > ---
> > >  arch/x86/kernel/kprobes/core.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > index 89d9f26785c7..3b7bcc077020 100644
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -177,9 +177,6 @@ int can_boost(struct insn *insn, void *addr)
> > >  	case 0xf0:
> > >  		/* clear and set flags are boostable */
> > >  		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
> > > -	case 0xff:
> > > -		/* indirect jmp is boostable */
> > > -		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> > >  	default:
> > >  		/* CS override prefix and call are not boostable */
> > >  		return (opcode != 0x2e && opcode != 0x9a);
> > > 
> > 
> > The 0xff case was added with some form of intention to be executed so I
> > suspect removing it is not an appropriate fix.
> 
> Right, it must be moved under the case 0xf0. Something like this.
> 
> case 0xf0:
> 	if (opcde == 0xff) {
> 		/* indirect jmp is boostable */
> 		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> 	}

Hmm, wait. I think there is no reason don't use range case.
I think the root cause of this issue is using masked opcode for
switching. Let me clean it up.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
