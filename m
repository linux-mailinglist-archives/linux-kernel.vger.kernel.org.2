Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB456371204
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhECHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 03:32:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56544 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhECHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 03:32:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1437PpsP188783;
        Mon, 3 May 2021 07:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jF4jydaayjmcCdELLifeH/fFop5ytzcJb9OREThMsPo=;
 b=nuwueWodT69+Hrm2DcU+ZiRKeA3MLY4gdnHBZo5IKIwSpPtV9+flEaAhKty9bwDiVnwn
 n1+5LAe5pU0dr+10EhGklQzL9qruur5cmaBLBuT+4Ehbo369zRKtJc8g6loyy/kV4xDL
 F3caTrySdyk09ZeD8CDaA+UxNwrZXzVDu2QEVsby0fik11/T+8xLw5LTW4WN7zxqm9xq
 /Jd3kZJAeLG5yKQpjvzD/Jlghjf9ulLqkR7cXnQYFRys9kHAVUSjW7rTdNuWr82oavqm
 RbL3u0wvbUAhcaLAPcgbLEyRIddPUuTQsRAQg3rYyfZgVVoAS4+8+qJRso9XY1lKuHiF PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 388vgbjtrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:31:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1437LIgr171771;
        Mon, 3 May 2021 07:31:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 388w1c8an1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:31:39 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1437SqP7003087;
        Mon, 3 May 2021 07:31:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 388w1c8ams-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:31:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1437VcKC009733;
        Mon, 3 May 2021 07:31:38 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 00:31:38 -0700
Date:   Mon, 3 May 2021 10:31:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/43] staging: rtl8723bs: remove unused ASSERT macro
Message-ID: <20210503073132.GM1981@kadam>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
 <f13bc57cc3a821c40443dddc38258b87962774a7.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13bc57cc3a821c40443dddc38258b87962774a7.1619794331.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 1CRHJLewekGOmNAgobGn21_iqdA5nbec
X-Proofpoint-ORIG-GUID: 1CRHJLewekGOmNAgobGn21_iqdA5nbec
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 04:56:38PM +0200, Fabio Aiuto wrote:
> remove unused do nothing ASSERT macro definition.
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
> index 8ae9948fb0c6..78b9b4548dcb 100644
> --- a/drivers/staging/rtl8723bs/hal/odm_debug.h
> +++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
> @@ -92,7 +92,6 @@
>  	#define RT_DISP(dbgtype, dbgflag, printstr)
>  
>  #ifndef ASSERT
> -	#define ASSERT(expr)
>  #endif

Presumably you're going to delete the #ifndef/endif in the next patch
but it should have been done in one step here.  (No need to resend.  For
future reference only).

regards,
dan carpenter

