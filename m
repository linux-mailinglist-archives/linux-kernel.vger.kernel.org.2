Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F093828A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhEQJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:46:09 -0400
Received: from smtp123.ord1d.emailsrvr.com ([184.106.54.123]:46483 "EHLO
        smtp123.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236048AbhEQJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1621244691;
        bh=Ky0k15pYrXoRi4n022IA3FwHLKrMjFRnfsmjESInMSM=;
        h=Subject:To:From:Date:From;
        b=Bwz+7USREJQJzWim2tQXLi+po423nGzNip45a2sY8IdaN7vqmcGeh1yemDPw2BZ3A
         cG8b1HG4Q3ls73TpHhkmNItaS314D8b/wHq2j7HCM2X25ZeLBZbsZ5e5/AISmic8hO
         +yQ3cD05u5HR74OEwY5zAYX+3Ex1F2HD8vls1kf4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 22EE6C013E;
        Mon, 17 May 2021 05:44:51 -0400 (EDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_-next_v2=5d_staging=3a_comedi=3a_Remove_un?=
 =?UTF-8?Q?used_variable_=e2=80=98min=5ffull=5fscale=e2=80=99_and_function_?=
 =?UTF-8?B?J2dldF9taW5fZnVsbF9zY2FsZXMn?=
To:     Bixuan Cui <cuibixuan@huawei.com>, linux-kernel@vger.kernel.org
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        grandmaster@al2klimov.de
References: <20210514085214.53941-1-cuibixuan@huawei.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <517e8f75-3faa-b564-5252-d5a3812f15f9@mev.co.uk>
Date:   Mon, 17 May 2021 10:44:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514085214.53941-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Classification-ID: 01367736-6624-42f6-9047-a85a2febd174-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2021 09:52, Bixuan Cui wrote:
> The variable ‘min_full_scale’ and function 'get_min_full_scales' are
> not used, So delete them.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
> Changes from v2:
> * Delete function 'get_min_full_scales'
> 
>   drivers/comedi/drivers/jr3_pci.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
> index 7a02c4fa3cda..f963080dd61f 100644
> --- a/drivers/comedi/drivers/jr3_pci.c
> +++ b/drivers/comedi/drivers/jr3_pci.c
> @@ -186,19 +186,6 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
>   	set_s16(&sensor->command_word0, 0x0a00);
>   }
>   
> -static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
> -{
> -	struct six_axis_t result;
> -
> -	result.fx = get_s16(&sensor->min_full_scale.fx);
> -	result.fy = get_s16(&sensor->min_full_scale.fy);
> -	result.fz = get_s16(&sensor->min_full_scale.fz);
> -	result.mx = get_s16(&sensor->min_full_scale.mx);
> -	result.my = get_s16(&sensor->min_full_scale.my);
> -	result.mz = get_s16(&sensor->min_full_scale.mz);
> -	return result;
> -}
> -
>   static struct six_axis_t get_max_full_scales(struct jr3_sensor __iomem *sensor)
>   {
>   	struct six_axis_t result;
> @@ -504,10 +491,8 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
>   			result = poll_delay_min_max(20, 100);
>   		} else {
>   			/* Set full scale */
> -			struct six_axis_t min_full_scale;
>   			struct six_axis_t max_full_scale;
>   
> -			min_full_scale = get_min_full_scales(sensor);
>   			max_full_scale = get_max_full_scales(sensor);
>   			set_full_scales(sensor, max_full_scale);
>   
> 

I'm pretty sure this is OK.  The min_full_scale registers are just 
informational.  The driver used to print the values, but not since 
commit a1d16659538a ("staging: comedi: jr3_pci: remove noisy printk") so 
this code is now redundant.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
