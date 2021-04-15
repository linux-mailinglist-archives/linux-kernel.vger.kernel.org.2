Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539293605CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhDOJdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:33:54 -0400
Received: from smtp77.ord1d.emailsrvr.com ([184.106.54.77]:59506 "EHLO
        smtp77.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhDOJdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1618479208;
        bh=9ZxMqQGHg/U+iZDqYJkCnUEhtfcxjaaIwoqqzMJU6Ag=;
        h=Subject:To:From:Date:From;
        b=h54RIO7dDPt/I6rz88luIy4DNP2NUm8kwWzbpm0WIOxChA9SKU7E3bA3EQQ1FQQ7Q
         lk3ZLW/4Q/VbGk3TAV2zREzbD/gZVn8hRL6jd/Fhf1/kOVb3F4NCyJKUvrgglmUYPw
         WxFqZZHHAipmHcq4ZI79KE4ffb136tDNwYemf5Us=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 046B72006B;
        Thu, 15 Apr 2021 05:33:26 -0400 (EDT)
Subject: Re: [PATCH 48/57] staging: comedi: drivers: jr3_pci: Remove set but
 unused variable 'min_full_scale'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Anders Blomdell <anders.blomdell@control.lth.se>,
        linux-staging@lists.linux.dev
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-49-lee.jones@linaro.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <9ccd6fe2-91ce-3a0d-d652-567ecf6b8b0a@mev.co.uk>
Date:   Thu, 15 Apr 2021 10:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414181129.1628598-49-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Classification-ID: 84ebef2c-bc97-4c86-ad8d-95289a422c21-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 19:11, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/staging/comedi/drivers/jr3_pci.c: In function ‘jr3_pci_poll_subdevice’:
>   drivers/staging/comedi/drivers/jr3_pci.c:507:22: warning: variable ‘min_full_scale’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Anders Blomdell <anders.blomdell@control.lth.se>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/staging/comedi/drivers/jr3_pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
> index 7a02c4fa3cda8..afa2f8d5c8c0c 100644
> --- a/drivers/staging/comedi/drivers/jr3_pci.c
> +++ b/drivers/staging/comedi/drivers/jr3_pci.c
> @@ -504,10 +504,9 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
>   			result = poll_delay_min_max(20, 100);
>   		} else {
>   			/* Set full scale */
> -			struct six_axis_t min_full_scale;
>   			struct six_axis_t max_full_scale;
>   
> -			min_full_scale = get_min_full_scales(sensor);
> +			get_min_full_scales(sensor);
>   			max_full_scale = get_max_full_scales(sensor);
>   			set_full_scales(sensor, max_full_scale);
>   
> 

get_min_full_scales() could be removed altogether.  It was only being 
called originally so the driver could printk the values, but those 
printks have since been removed.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
