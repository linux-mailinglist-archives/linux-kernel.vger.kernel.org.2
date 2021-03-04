Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11CE32D6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhCDPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:43:17 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:50914 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhCDPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:43:04 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 10:43:04 EST
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id AA5D9A3E1F;
        Thu,  4 Mar 2021 15:36:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo05-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo05-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LIophxBCAoQh; Thu,  4 Mar 2021 15:36:15 +0000 (UTC)
Received: from mail.gonehiking.org (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        by mailout.easymail.ca (Postfix) with ESMTPA id 51EE9A3E0E;
        Thu,  4 Mar 2021 15:36:07 +0000 (UTC)
Received: from [192.168.1.4] (rhapsody.internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 1DBC93EF3E;
        Thu,  4 Mar 2021 08:36:07 -0700 (MST)
To:     zuoqilin1@163.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
References: <20210304055120.2221-1-zuoqilin1@163.com>
From:   Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH] scsi: FlashPoint: Fix typo issue
Message-ID: <17dada31-8b62-3dc4-752d-965f4fe702ab@gonehiking.org>
Date:   Thu, 4 Mar 2021 08:36:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304055120.2221-1-zuoqilin1@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/21 10:51 PM, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>
> 
> Change 'defualt' to 'default'.
> 
> Signed-off-by: zuoqilin <zuoqilin@yulong.com>
> ---
>  drivers/scsi/FlashPoint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
> index 24ace18..f479c54 100644
> --- a/drivers/scsi/FlashPoint.c
> +++ b/drivers/scsi/FlashPoint.c
> @@ -4534,7 +4534,7 @@ static void FPT_phaseBusFree(u32 port, unsigned char p_card)
>   *
>   * Function: Auto Load Default Map
>   *
> - * Description: Load the Automation RAM with the defualt map values.
> + * Description: Load the Automation RAM with the default map values.
>   *
>   *---------------------------------------------------------------------*/
>  static void FPT_autoLoadDefaultMap(u32 p_port)
> 

Acked-by: Khalid Aziz <khalid@gonehiking.org>

I will accept this patch this time, but I really would like patches that
fix only typos to fix more than just one typo, preferably all the typos
in the file. There are more typos in that file.

Thanks,
Khalid
