Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8203484F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbhCXW6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238916AbhCXW6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:58:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A24C61993;
        Wed, 24 Mar 2021 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616626697;
        bh=ezCo20ETO8LEbH5Iz7de5teIdeRrmAeqj5HFZv228Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O9ADnl4rcVMJI8iZVsqsEGFrHdmqtdWF/tv3JeoBsAb98Md0eHjQH+ABk8I6nh8+C
         pRn0j9MYdlYNMM5XRNor5h5PrlikaaVNnpXrIOamRM5NIImaOXZXH8fKRfZh/1sTuv
         XS+0BKcx6x/9MvqXMMk2uACJUHMIxmsmbIElDd21lcjddN4g6XUAiKQslEcpiZYlPR
         qwpKJOgx3tvF4RAGkFQrBwzUVAjwqKgXwUtfvNEk7aG19DKUMdl8BXS4NUVJbOGnw6
         YazcQeJcI9szM7oIXi4gcJC7v9ed7tjjVKR4lS0Y1Ntx/d2h2LF6ksDpBW4hI/EH7z
         LhAjAm756sZsA==
Date:   Thu, 25 Mar 2021 07:58:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: x86/kprobes: Use int3 instead of debug trap for single-step
Message-Id: <20210325075814.a66606773b47482b56e9d596@kernel.org>
In-Reply-To: <37cd1689-d192-dd89-af7c-eaf074b5f911@canonical.com>
References: <37cd1689-d192-dd89-af7c-eaf074b5f911@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 15:48:34 +0000
Colin Ian King <colin.king@canonical.com> wrote:

> Hi,
> 
> Static analysis on linux-next using Coverity has detected an issue in
> the following commit:
> 
> commit 6256e668b7af9d81472e03c6a171630c08f8858a
> Author: Masami Hiramatsu <mhiramat@kernel.org>
> Date:   Wed Mar 3 00:25:46 2021 +0900
> 
>     x86/kprobes: Use int3 instead of debug trap for single-step
> 
> The analysis is as follows:
> 
> 160        switch (opcode & 0xf0) {
> 161        case 0x60:
> 162                /* can't boost "bound" */
> 163                return (opcode != 0x62);
> 164        case 0x70:
> 165                return 0; /* can't boost conditional jump */
> 166        case 0x90:
> 167                return opcode != 0x9a;  /* can't boost call far */
> 168        case 0xc0:
> 169                /* can't boost software-interruptions */
> 170                return (0xc1 < opcode && opcode < 0xcc) || opcode ==
> 0xcf;
> 171        case 0xd0:
> 172                /* can boost AA* and XLAT */
> 173                return (opcode == 0xd4 || opcode == 0xd5 || opcode ==
> 0xd7);
> 174        case 0xe0:
> 175                /* can boost in/out and absolute jmps */
> 176                return ((opcode & 0x04) || opcode == 0xea);
> 177        case 0xf0:
> 178                /* clear and set flags are boostable */
> 179                return (opcode == 0xf5 || (0xf7 < opcode && opcode <
> 0xfe));
> 
>    dead_error_condition: The switch governing value opcode & 0xf0 cannot
> be 255.
>   undefined (#1 of 1): Logically dead code (DEADCODE)
>   dead_error_begin: Execution cannot reach this statement: case 255:
> 
> 180        case 0xff:
> 181                /* indirect jmp is boostable */
> 182               return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> 
> the case 0xff statement can never be reached because the switch
> statement is acting on opcode & 0xf0.

Good catch! It must be under the case 0xf0...

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
