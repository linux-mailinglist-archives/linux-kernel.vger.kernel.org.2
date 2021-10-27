Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4043C48E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhJ0IEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:04:02 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43198 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhJ0IDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:03:16 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HfLhx2vHqz1qwdr;
        Wed, 27 Oct 2021 10:00:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HfLhx1z0dz1qqkG;
        Wed, 27 Oct 2021 10:00:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id lnOeicQQ8Db8; Wed, 27 Oct 2021 10:00:32 +0200 (CEST)
X-Auth-Info: x+8QjqTD1V1ACKg/WDk8SUlDVnu/BmJKfvIHSrNqoqQSSJ4hj/hMiZjB0S6pDmtP
Received: from igel.home (ppp-46-244-163-205.dynamic.mnet-online.de [46.244.163.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 27 Oct 2021 10:00:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 901CE2C0C9B; Wed, 27 Oct 2021 10:00:31 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: Make CONFIG_RELOCATABLE user selectable
References: <20211026212847.43108-1-palmer@dabbelt.com>
X-Yow:  My ELBOW is a remote FRENCH OUTPOST!!
Date:   Wed, 27 Oct 2021 10:00:31 +0200
In-Reply-To: <20211026212847.43108-1-palmer@dabbelt.com> (Palmer Dabbelt's
        message of "Tue, 26 Oct 2021 14:28:47 -0700")
Message-ID: <87mtmuaodc.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 26 2021, Palmer Dabbelt wrote:

> +config RELOCATABLE
> +	bool "Build a relocatable kernel"
> +	depends on MMU && 64BIT && !XIP_KERNEL
> +	help
> +          This builds a kernel as a Position Independent Executable (PIE),
> +          which retains all relocation metadata required to relocate the
> +          kernel binary at runtime to a different virtual address than the
> +          address it was linked at.
> +          Since RISCV uses the RELA relocation format, this requires a
> +          relocation pass at runtime even if the kernel is loaded at the
> +          same address it was linked at.

When in doubt, do what?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
