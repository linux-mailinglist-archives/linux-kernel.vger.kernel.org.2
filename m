Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820E936F188
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhD2VEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhD2VE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:04:29 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED60C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:03:42 -0700 (PDT)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 13TKhZUM008426;
        Thu, 29 Apr 2021 22:03:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=n0L6msrOcJTH6F5oPZAFsPXWOXyqbONZZ+dhNx0/9aU=;
 b=AowOkg9KW6fAWs+L8SRWWBYEMmkOYwmLiCtdgqfDvrxCVwVnu38SBUm6CHqsLSzkFC6z
 u7oVkLDiakoQIuafZh+Jw+vkpauNTfSxbDNLcHi3tBhUletLfGMwWUiK9+SQjv/AO9wA
 0oZurww2zXHWlc/6pLY/PAOzKApdAFETYLQfcyd6+C3EdoShA1zTtyYr4ooSnjyaz/oP
 oAOcMCNDm+nweSmJ6PuNFeDuCTJIfef815ieCROmAHu1XYTzitiqpTjHP/wOmeDlKOoY
 so9ShiMwXvMmBsv174Co5mZIHzizsC26zJEcexBaKB5yjWQ+T2VLPVMYIjAZb8uZeDoa kQ== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050096.ppops.net-00190b01. with ESMTP id 3883fwsphj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 22:03:41 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 13TKp7xF003451;
        Thu, 29 Apr 2021 17:03:40 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 3877q8bq0b-1;
        Thu, 29 Apr 2021 17:03:40 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 202464471F;
        Thu, 29 Apr 2021 21:03:40 +0000 (GMT)
Subject: Re: [PATCH 1/2] dyndbg: avoid calling dyndbg_emit_prefix when it has
 no work
To:     Jim Cromie <jim.cromie@gmail.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20210428010031.571623-1-jim.cromie@gmail.com>
 <20210428010031.571623-2-jim.cromie@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <f2e4773e-45a2-c4cb-24cb-fc8119f10a3a@akamai.com>
Date:   Thu, 29 Apr 2021 17:03:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428010031.571623-2-jim.cromie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_11:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290134
X-Proofpoint-ORIG-GUID: OELZtakVMndXn3b9tmh3sUEq3exMcNdp
X-Proofpoint-GUID: OELZtakVMndXn3b9tmh3sUEq3exMcNdp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_11:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290134
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.19)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On 4/27/21 9:00 PM, Jim Cromie wrote:
> Wrap function in a static-inline one, which checks flags to avoid
> calling the function unnecessarily.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/linux/dynamic_debug.h | 9 +++++++++
>  lib/dynamic_debug.c           | 9 ++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index a57ee75342cf..173535e725f7 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -32,6 +32,15 @@ struct _ddebug {
>  #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
>  #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
>  #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
> +
> +#define _DPRINTK_FLAGS_INCL_ANYSITE		\
> +	(_DPRINTK_FLAGS_INCL_MODNAME		\
> +	 | _DPRINTK_FLAGS_INCL_FUNCNAME		\
> +	 | _DPRINTK_FLAGS_INCL_LINENO)
> +#define _DPRINTK_FLAGS_INCL_ANY			\
> +	(_DPRINTK_FLAGS_INCL_ANYSITE		\
> +	 | _DPRINTK_FLAGS_INCL_TID)
> +

I'm not sure it's worth having an unused define here by dynamic_debug.c.

I would prefer to just have _DPRINTK_FLAGS_INCL_ANY that has all the flags
in a single define.

>  #if defined DEBUG
>  #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
>  #else
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c70d6347afa2..613293896e47 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -586,7 +586,7 @@ static int remaining(int wrote)
>  	return 0;
>  }
>  
> -static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
> +static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
>  {
>  	int pos_after_tid;
>  	int pos = 0;
> @@ -618,6 +618,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
>  	return buf;
>  }
>  
> +static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
> +{
> +	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
> +		return __dynamic_emit_prefix(desc, buf);
> +	return buf;
> +}
> +

hmmm - looking at __dynamic_emit_prefix() it starts by doing:


 589 static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 590 {
 591         int pos_after_tid;
 592         int pos = 0;
 593
 594         *buf = '\0';


So now we are missing the string termination if no flags are set...

Thanks,

-Jason

>  void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
>  {
>  	va_list args;
> 
