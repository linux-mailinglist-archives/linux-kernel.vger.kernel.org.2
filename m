Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE306347CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhCXPsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:48:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhCXPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:48:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lP5kI-0004y5-II; Wed, 24 Mar 2021 15:48:34 +0000
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: x86/kprobes: Use int3 instead of debug trap for single-step
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <37cd1689-d192-dd89-af7c-eaf074b5f911@canonical.com>
Date:   Wed, 24 Mar 2021 15:48:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis on linux-next using Coverity has detected an issue in
the following commit:

commit 6256e668b7af9d81472e03c6a171630c08f8858a
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Wed Mar 3 00:25:46 2021 +0900

    x86/kprobes: Use int3 instead of debug trap for single-step

The analysis is as follows:

160        switch (opcode & 0xf0) {
161        case 0x60:
162                /* can't boost "bound" */
163                return (opcode != 0x62);
164        case 0x70:
165                return 0; /* can't boost conditional jump */
166        case 0x90:
167                return opcode != 0x9a;  /* can't boost call far */
168        case 0xc0:
169                /* can't boost software-interruptions */
170                return (0xc1 < opcode && opcode < 0xcc) || opcode ==
0xcf;
171        case 0xd0:
172                /* can boost AA* and XLAT */
173                return (opcode == 0xd4 || opcode == 0xd5 || opcode ==
0xd7);
174        case 0xe0:
175                /* can boost in/out and absolute jmps */
176                return ((opcode & 0x04) || opcode == 0xea);
177        case 0xf0:
178                /* clear and set flags are boostable */
179                return (opcode == 0xf5 || (0xf7 < opcode && opcode <
0xfe));

   dead_error_condition: The switch governing value opcode & 0xf0 cannot
be 255.
  undefined (#1 of 1): Logically dead code (DEADCODE)
  dead_error_begin: Execution cannot reach this statement: case 255:

180        case 0xff:
181                /* indirect jmp is boostable */
182               return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;

the case 0xff statement can never be reached because the switch
statement is acting on opcode & 0xf0.

Colin
