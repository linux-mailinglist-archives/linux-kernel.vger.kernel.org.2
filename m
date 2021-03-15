Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0D33B030
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCOKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:44:59 -0400
Received: from smtp69.ord1c.emailsrvr.com ([108.166.43.69]:41595 "EHLO
        smtp69.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbhCOKog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1615805074;
        bh=xlOfUEowI6NCZiO+ZHuwX6ae9Gxb/RcMpL8ZU4SGWU8=;
        h=Subject:To:From:Date:From;
        b=lbgRdHoy4kG9XgEwL6I8BMAihM46vUOJUmFupDZcf6jZ4mw3hpebCWoz+LTuwoDrm
         oDCSAv97lMioLo74LkVq7O8UkwATw9KLcofj1KqXr0dFVKISYSIZ4eGhcHyfulbyj+
         A6UfvvSTEm7o/VP/esH+0n9wpDiDsDnZGpvvk1i0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 76D6D6016D;
        Mon, 15 Mar 2021 06:44:33 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: replace slash in name
To:     Tong Zhang <ztong0001@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210314035757.2740146-1-ztong0001@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <5d7a5e1c-35ab-58cb-ebcd-da5b280c802e@mev.co.uk>
Date:   Mon, 15 Mar 2021 10:44:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314035757.2740146-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: e06d8992-0b05-4806-b625-31fc857a83a4-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2021 03:57, Tong Zhang wrote:
> request_irq() wont accept a name which contains slash so we need to
> repalce it with something else -- otherwise it will trigger a warning
> and the entry in /proc/irq/ will not be created
> 
> [    1.565966] name 'pci-das6402/16'
> [    1.566149] WARNING: CPU: 0 PID: 184 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
> [    1.568923] RIP: 0010:__xlate_proc_name+0x93/0xb0
> [    1.574200] Call Trace:
> [    1.574722]  proc_mkdir+0x18/0x20
> [    1.576629]  request_threaded_irq+0xfe/0x160
> [    1.576859]  auto_attach+0x60a/0xc40 [cb_pcidas64]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/staging/comedi/drivers/cb_pcidas64.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
> index fa987bb0e7cd..662d6ffb8f60 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas64.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
> @@ -677,7 +677,7 @@ static const int bytes_in_sample = 2;
>  
>  static const struct pcidas64_board pcidas64_boards[] = {
>  	[BOARD_PCIDAS6402_16] = {
> -		.name		= "pci-das6402/16",
> +		.name		= "pci-das6402-16",
>  		.ai_se_chans	= 64,
>  		.ai_bits	= 16,
>  		.ai_speed	= 5000,
> @@ -693,7 +693,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
>  		.has_8255	= 1,
>  	},
>  	[BOARD_PCIDAS6402_12] = {
> -		.name		= "pci-das6402/12",	/* XXX check */
> +		.name		= "pci-das6402-12",	/* XXX check */
>  		.ai_se_chans	= 64,
>  		.ai_bits	= 12,
>  		.ai_speed	= 5000,
> @@ -709,7 +709,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
>  		.has_8255	= 1,
>  	},
>  	[BOARD_PCIDAS64_M1_16] = {
> -		.name		= "pci-das64/m1/16",
> +		.name		= "pci-das64-m1-16",
>  		.ai_se_chans	= 64,
>  		.ai_bits	= 16,
>  		.ai_speed	= 1000,
> @@ -725,7 +725,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
>  		.has_8255	= 1,
>  	},
>  	[BOARD_PCIDAS64_M2_16] = {
> -		.name = "pci-das64/m2/16",
> +		.name = "pci-das64-m2-16",
>  		.ai_se_chans	= 64,
>  		.ai_bits	= 16,
>  		.ai_speed	= 500,
> @@ -741,7 +741,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
>  		.has_8255	= 1,
>  	},
>  	[BOARD_PCIDAS64_M3_16] = {
> -		.name		= "pci-das64/m3/16",
> +		.name		= "pci-das64-m3-16",
>  		.ai_se_chans	= 64,
>  		.ai_bits	= 16,
>  		.ai_speed	= 333,
> @@ -984,7 +984,7 @@ static const struct pcidas64_board pcidas64_boards[] = {
>  		.has_8255	= 0,
>  	},
>  	[BOARD_PCIDAS4020_12] = {
> -		.name		= "pci-das4020/12",
> +		.name		= "pci-das4020-12",
>  		.ai_se_chans	= 4,
>  		.ai_bits	= 12,
>  		.ai_speed	= 50,
> 

Userspace applications can use these strings to determine the board
type, so changing the strings would break those applications.

I suggest passing the comedi driver name "cb_pcidas" to request_irq()
for now.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
