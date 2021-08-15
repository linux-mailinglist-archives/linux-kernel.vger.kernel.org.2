Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB83EC7BE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhHOGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:51:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57920 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHOGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:51:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GnScm1Dk2z1qwGb;
        Sun, 15 Aug 2021 08:51:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GnScl6phrz1qqkg;
        Sun, 15 Aug 2021 08:51:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hHSQV9_8Ah4W; Sun, 15 Aug 2021 08:51:18 +0200 (CEST)
X-Auth-Info: GWNgGf1u5wZ3SJAJGg4o0/Ef+Whqz2y6LrK66NNI+d1HWkCmWlUNECf3gZjZXuRE
Received: from tiger.home (ppp-46-244-191-201.dynamic.mnet-online.de [46.244.191.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 15 Aug 2021 08:51:18 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
        id 286DA5153E; Sun, 15 Aug 2021 08:51:18 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word
 copy if size < 9*SZREG
References: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
        <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
X-Yow:  ..Am I in a SOAP OPERA??
Date:   Sun, 15 Aug 2021 08:51:18 +0200
In-Reply-To: <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com> (Akira
        Tsukamoto's message of "Fri, 30 Jul 2021 22:52:44 +0900")
Message-ID: <87bl5z42vt.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 30 2021, Akira Tsukamoto wrote:

>  .Lword_copy:
> -        /*
> -	 * Both src and dst are aligned, unrolled word copy
> +	/*
> +	 * Both src and dst are aligned
> +	 * None unrolled word copy with every 1*SZREG iteration
> +	 *
> +	 * a0 - start of aligned dst
> +	 * a1 - start of aligned src
> +	 * t0 - end of aligned dst
> +	 */
> +	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
> +	addi	t0, t0, -(SZREG) /* not to over run */
> +1:
> +	REG_L	a5, 0(a1)
> +	addi	a1, a1, SZREG
> +	REG_S	a5, 0(a0)
> +	addi	a0, a0, SZREG
> +	bltu	a0, t0, 1b

This is missing fixups.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
