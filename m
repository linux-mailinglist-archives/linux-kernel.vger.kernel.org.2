Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E423533B05F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCOKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:51:25 -0400
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:55870 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhCOKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1615805455;
        bh=qNSWJAmTWvGZ7FuISpDDGYcC/3dLC5XiaoLB4U8iWvo=;
        h=Subject:To:From:Date:From;
        b=Vmp7FwuVC2hCyzknfWB1lKhy7aWJG2qZOGw3wzGrD2Fk6idMpN0xHpXGyhDrAhNry
         i1tMPJ1Hebt+KEyf+5JTXBmMVJ58cQtBfWbNBZEfeyzHiGguid5gHBd+zJg3rGn63s
         CF3EFpA6CgtcrE+fLIGlsczrM6sgeTFKgai0Sa7I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 257F460170;
        Mon, 15 Mar 2021 06:50:54 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: cb_pcidas: replace slash in name
To:     Tong Zhang <ztong0001@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210314040221.2740750-1-ztong0001@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <393f3925-9dbf-72e5-4d9b-2e213a6a71cb@mev.co.uk>
Date:   Mon, 15 Mar 2021 10:50:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314040221.2740750-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 789b242b-2a41-4a30-9d6c-90dcc59bfe98-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2021 04:02, Tong Zhang wrote:
> request_irq() wont accept a name which contains slash so we need to
> repalce it with something else -- otherwise it will trigger a warning
> and the entry in /proc/irq/ will not be created
> 
> [    1.630764] name 'pci-das1602/16'
> [    1.630950] WARNING: CPU: 0 PID: 181 at fs/proc/generic.c:180 __xlate_proc_name+0x93/0xb0
> [    1.634009] RIP: 0010:__xlate_proc_name+0x93/0xb0
> [    1.639441] Call Trace:
> [    1.639976]  proc_mkdir+0x18/0x20
> [    1.641946]  request_threaded_irq+0xfe/0x160
> [    1.642186]  cb_pcidas_auto_attach+0xf4/0x610 [cb_pcidas]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/staging/comedi/drivers/cb_pcidas.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/staging/comedi/drivers/cb_pcidas.c
> index d740c4782775..df0960d41cff 100644
> --- a/drivers/staging/comedi/drivers/cb_pcidas.c
> +++ b/drivers/staging/comedi/drivers/cb_pcidas.c
> @@ -230,7 +230,7 @@ struct cb_pcidas_board {
>  
>  static const struct cb_pcidas_board cb_pcidas_boards[] = {
>  	[BOARD_PCIDAS1602_16] = {
> -		.name		= "pci-das1602/16",
> +		.name		= "pci-das1602-16",
>  		.ai_speed	= 5000,
>  		.ao_scan_speed	= 10000,
>  		.fifo_size	= 512,
> @@ -248,7 +248,7 @@ static const struct cb_pcidas_board cb_pcidas_boards[] = {
>  		.has_ao		= 1,
>  	},
>  	[BOARD_PCIDAS1602_12] = {
> -		.name		= "pci-das1602/12",
> +		.name		= "pci-das1602-12",
>  		.ai_speed	= 3200,
>  		.ao_scan_speed	= 4000,
>  		.fifo_size	= 1024,
> @@ -257,12 +257,12 @@ static const struct cb_pcidas_board cb_pcidas_boards[] = {
>  		.is_1602	= 1,
>  	},
>  	[BOARD_PCIDAS1200_JR] = {
> -		.name		= "pci-das1200/jr",
> +		.name		= "pci-das1200-jr",
>  		.ai_speed	= 3200,
>  		.fifo_size	= 1024,
>  	},
>  	[BOARD_PCIDAS1602_16_JR] = {
> -		.name		= "pci-das1602/16/jr",
> +		.name		= "pci-das1602-16-jr",
>  		.ai_speed	= 5000,
>  		.fifo_size	= 512,
>  		.is_16bit	= 1,
> 

As for cb_pcidas64, the board name may be used by user-space
applications, so this may break those applications.

I suggest passing the comedi driver name "cb_pcidas" to request_irq()
for now.  (It can also be reached via dev->driver->driver_name .)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
