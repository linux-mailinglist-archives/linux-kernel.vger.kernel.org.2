Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33463C6015
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhGLQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGLQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:08:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9CC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:05:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 649AC36E;
        Mon, 12 Jul 2021 16:05:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 649AC36E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626105923; bh=avoTmWG4/cNzjoU8PdqKzykPRnIrmsIkQM1F+9arOfo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=soKLZTSv8Lsp7C8aTzlWy+PDFN+itI0KohW5cpxzutE5dUZGUIsCpFLURs7B3aDxZ
         cqHa9mryOTflJEhqtcvWSaxeEio95XTcsLQ7uFhXe9PXsN9+fGMwSiF6OzziuGvqQH
         vlnn2MqYK5ORuIbGsXIzAbgIHbucT0VB3Z9C/exWY0QaJY5LmvIXgAkgtCymMAXWLO
         Q6nG2RriOBaqm7wvbttHkSyQ38eiOJX022MLl4fjnF3PjPyn6e29V4iSjai/dOetGG
         QaKLPpypqloh8yarM1MKVoUizy6ahlXg0T7U670P8vjzwIFZ4QKMuLbus7gi8055ou
         LIams0e4XDXGw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/features: Update the
 ARCH_HAS_TICK_BROADCAST entry
In-Reply-To: <YN2nqOVHgGDt4Iid@gmail.com>
References: <YN2nqOVHgGDt4Iid@gmail.com>
Date:   Mon, 12 Jul 2021 10:05:22 -0600
Message-ID: <87pmvnqzzx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> Risc-V gained support recently.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  Documentation/features/time/arch-tick-broadcast/arch-support.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
> index 8639fe8315f5..8dcaab070c7b 100644
> --- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
> +++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: |  ok  |
>      |       sparc: | TODO |

Applied, thanks.

jon
