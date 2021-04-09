Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814C9359695
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhDIHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:41:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44944 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229751AbhDIHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:41:44 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1397axb0012005;
        Fri, 9 Apr 2021 09:40:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=n06VPaXv/86nkAfO+Ew799xc9jm8nPwhGU0C5uayBqo=;
 b=1RA8xsujC5lSSS18IpKAI7zlKhO5HqRRLX8P+prNVx+GAvyBdI36ADgSxKkowBZ2Q5xQ
 jNxeqn6AOotH1CcVFV75WwUIuUql3AAfEoglVH5/7Z5on6nkoTD9yVnWizPzIcjqalxq
 jNeX4ZfivWEJZSkZp0Ec/cX+Bw6y06TOr4FYQYXWI6kBJIUW4O+RIL/ed48ub4clXJrN
 iQAzLEiyvgDsagp4p6osTuHJAefJ4fug62DNG3kEK+AGC8H3Ipb7dhe0kExRyapZErzA
 N/c1iuY11Wxh35H+n1LPCDlldFVpGU/X0GxTGSPquR00mAowcyY21E3aU6NuVPcwC7Pp +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37tj4d8a3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 09:40:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB76210002A;
        Fri,  9 Apr 2021 09:40:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 584B721CA9E;
        Fri,  9 Apr 2021 09:40:56 +0200 (CEST)
Received: from lmecxl0889.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 09:40:55 +0200
Subject: Re: [PATCH -next] ASoC: sti: sti_uniperif: add missing
 MODULE_DEVICE_TABLE
To:     Chen Lifu <chenlifu@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20210409015953.259688-1-chenlifu@huawei.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <228beb65-2cd3-f2fe-92c8-5a4d3c0a4d33@foss.st.com>
Date:   Fri, 9 Apr 2021 09:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409015953.259688-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_04:2021-04-08,2021-04-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 3:59 AM, Chen Lifu wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

> ---
>  sound/soc/sti/sti_uniperif.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
> index 67315d9b352d..e3561f00ed40 100644
> --- a/sound/soc/sti/sti_uniperif.c
> +++ b/sound/soc/sti/sti_uniperif.c
> @@ -97,6 +97,7 @@ static const struct of_device_id snd_soc_sti_match[] = {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, snd_soc_sti_match);
>  
>  int  sti_uniperiph_reset(struct uniperif *uni)
>  {
> 
