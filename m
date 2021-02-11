Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645A4318F95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBKQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:10:41 -0500
Received: from pv50p00im-zteg10021301.me.com ([17.58.6.46]:55011 "EHLO
        pv50p00im-zteg10021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhBKPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1613056714;
        bh=Spixzkgr31UYD6OOSHfazV/DOQhxzGDJYf6HOkWLy7k=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
        b=wXKuw5XSFw35oaCdosnpg3oZr+R+gyRO5Ogp81FGM8/MRyK+siEOn2G31T0vb4pYo
         mnM7i00xC4lFFDcPuXS0yI7TtLDgkMuoR3o6Yr2XlJ9OGjMQQ7VGnp31VakAGHAhtX
         SDKNdPI/aeT6stRaVB2NdVbzaMIxPhiLxPN/bY9qwv6OZt02BxIbDmR8CidWkXme+b
         EvK/2kKU27uH5cUsOEbhc38phMs/lHJJzKtmw2DmeBKAk5F66qYjz5zgtjPfvC/tJy
         Hb88tFMAJfQLB0npzqFGkvsTMRXgwSMsfpK9o06Y+wjrQTqTx/OXpf5w5FvOHe+aiO
         I+uTV6Ca9nQFw==
Received: from [192.168.31.114] (unknown [45.250.50.68])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id B32AECC03E2;
        Thu, 11 Feb 2021 15:18:31 +0000 (UTC)
Subject: Re: [PATCH] staging: vt6656: Fixed alignment with issue in rf.c
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        oscar.carter@gmx.com, tvboxspy@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210211134548.84956-1-pritthijit.nath@icloud.com>
From:   Pritthijit Nath <pritthijit.nath@icloud.com>
Message-ID: <bf7da60f-d981-7c2b-ee35-52a8b766e2d2@icloud.com>
Date:   Thu, 11 Feb 2021 20:48:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211134548.84956-1-pritthijit.nath@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102110133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/21 7:15 pm, Pritthijit Nath wrote:
> This change fixes a checkpatch CHECK style issue for "Alignment should match open parenthesis".
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> ---
>  drivers/staging/vt6656/rf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> index 5b8da06e3916..bcd4d467e03a 100644
> --- a/drivers/staging/vt6656/rf.c
> +++ b/drivers/staging/vt6656/rf.c
> @@ -687,7 +687,7 @@ static int vnt_rf_set_txpower(struct vnt_private *priv, u8 power,
>  
>  			if (hw_value < ARRAY_SIZE(vt3226d0_lo_current_table)) {
>  				ret = vnt_rf_write_embedded(priv,
> -					vt3226d0_lo_current_table[hw_value]);
> +							    vt3226d0_lo_current_table[hw_value]);
>  				if (ret)
>  					return ret;
>  			}
> 

I am resubmitting this patch. Pardon the typo in the subject line.

thanks,
Pritthijit
