Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF125455F21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhKRPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 10:16:38 -0500
Received: from foss.arm.com ([217.140.110.172]:42004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhKRPQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 10:16:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AFC4D6E;
        Thu, 18 Nov 2021 07:13:37 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF3F3F766;
        Thu, 18 Nov 2021 07:13:36 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:13:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: extable: remove unsed ex_handler_t definition
Message-ID: <20211118151317.GA9977@lakrids.cambridge.arm.com>
References: <20211118200249.73172ce5@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118200249.73172ce5@xhacker>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:02:49PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> The type ex_handler_t is defined but not used, remove it.

It's probably worth saying:

| The ex_handler_t type was introduced in commit:
|
|   d6e2cc5647753825 ("arm64: extable: add `type` and `data` fields")
| 
| ... but has never been used, and is unnecessary. Remove it.

... as this was a leftover from a prior version of that patch, and in
the form merged in mainline it was redundant becuase we moved to using
an enumerated type rather than a function pointer in the ex_table_entry.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

With or without the wording above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/mm/extable.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index c3d53811a15e..c0181e60cc98 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -10,9 +10,6 @@
>  #include <asm/asm-extable.h>
>  #include <asm/ptrace.h>
>  
> -typedef bool (*ex_handler_t)(const struct exception_table_entry *,
> -			     struct pt_regs *);
> -
>  static inline unsigned long
>  get_ex_fixup(const struct exception_table_entry *ex)
>  {
> -- 
> 2.33.0
> 
> 
