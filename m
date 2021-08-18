Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D743F0EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhHRXhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234911AbhHRXhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CC5C60EB5;
        Wed, 18 Aug 2021 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629329807;
        bh=5Lj0Qxd8zsNRLRPROniWdCTodJIrsY34z78eCvvVxrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nLxnwZJLUOmBhQ1Jm2pMwV/E+UGgOMHN0ZdWu48WnJ/IXn+ezvzTU8grz6CTMWFTV
         NMAmOff0Crf6iOsxlyN/M6usuHa6efFi8krzM/SjW9fgcq6yuQ1D02UGzOkBisNo1w
         t9mVRjleLX7QuT9Cx/zkrOvY1TMS5tQKOR4tSa7kiPGW1rWFLIFi9MzF3+UG6KSts4
         deK8U8s/BHF9v23q5NDc3i/xdODc/L1xf0jlbEk5EoTI/tAWytg9wY5ZfY/3ToYjzM
         SpBZjdZePHqUVYnnTdwUvTptnmkDk2Nh1WU/vHOiQpVd2GWmz3bk+oiQfdc3z8CSgi
         GZYVb9hbyyIig==
Date:   Thu, 19 Aug 2021 08:36:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: uniphier: make arrays mul and div static const,
 makes object smaller
Message-Id: <20210819083644.6c88a29eef5926eca76cffcb@kernel.org>
In-Reply-To: <20210818151746.38520-1-colin.king@canonical.com>
References: <20210818151746.38520-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 16:17:46 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays mul and div on the stack but instead make them
> static const. Makes the object code smaller by 4 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   16226    4984      64   21274    531a ./sound/soc/uniphier/aio-cpu.o
> 
> After:
>    text    data     bss     dec     hex filename
>   16062    5144      64   21270    5316 ./sound/soc/uniphier/aio-cpu.o
> 
> (gcc version 10.2.0)

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/uniphier/aio-cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
> index cf9814130067..4e8d5f7532ba 100644
> --- a/sound/soc/uniphier/aio-cpu.c
> +++ b/sound/soc/uniphier/aio-cpu.c
> @@ -128,8 +128,8 @@ static const struct uniphier_aio_spec *find_spec(struct uniphier_aio *aio,
>  static int find_divider(struct uniphier_aio *aio, int pll_id, unsigned int freq)
>  {
>  	struct uniphier_aio_pll *pll;
> -	int mul[] = { 1, 1, 1, 2, };
> -	int div[] = { 2, 3, 1, 3, };
> +	static const int mul[] = { 1, 1, 1, 2, };
> +	static const int div[] = { 2, 3, 1, 3, };
>  	int i;
>  
>  	if (!is_valid_pll(aio->chip, pll_id))
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
