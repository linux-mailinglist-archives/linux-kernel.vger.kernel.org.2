Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C735F4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351348AbhDNNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:25:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57012 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbhDNNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:25:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EDNjjr028959;
        Wed, 14 Apr 2021 13:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=QG+ETTa5+7MrCPV6Jb0N5h1kmH0uaW+IKUcdij7mO9A=;
 b=h78lQwZ1FxM31/tuhyxZ+ZU7h6bexYUp5dvP6HO+6s5viux8AJ0F7/ItpsgkXvHLzKda
 +amICd2TNILAaxllMB14vdcfn6/0gEKtCqN7bdZ2syExnhkJKQrk+lt0ESs5TeunWUOI
 cHaG2MKkmFa2wNa8c8pssqn/3Ag9lrGcndcXgenVyqSkERvTsiMFUQjLk0N1xZY9OXkZ
 OoJJmr/Zco1Hv26cWSBfVHb4FWxMN3ZdQiBu/DE6G41QTaHmfm/hfpX8Ndq1tep3vV+c
 NLFfgTAtplYNgR1ckKHugoskZk+zu21tFM+4x78aitkskh9BfpkfFwG12ybWRlmVpqWu 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbjh7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 13:24:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EDLcAB074613;
        Wed, 14 Apr 2021 13:24:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37unsty88w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 13:24:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13EDOL0x026035;
        Wed, 14 Apr 2021 13:24:21 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 06:24:21 -0700
Date:   Wed, 14 Apr 2021 16:24:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414132414.GE6048@kadam>
References: <20210414115243.32716-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414115243.32716-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140091
X-Proofpoint-GUID: VW4z5hvcMF_GoM0KuAk3vaqp9tiOWZ_y
X-Proofpoint-ORIG-GUID: VW4z5hvcMF_GoM0KuAk3vaqp9tiOWZ_y
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1031 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:52:43PM +0200, Fabio M. De Francesco wrote:
> Removed the led_blink_hdl() function (declaration and definition).
> Declared dummy_function() in include/rtw_mlme_ext.h and defined it in
> core/rtw_cmd.c. Changed the second parameter of GEN_MLME_EXT_HANDLER
> macro to make use of dummy_function().
> 
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 4 +++-
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
>  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 3 ++-
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 0297fbad7bce..7b6102a2bb2c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -87,6 +87,8 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
>  };
>  
> +u8 dummy_functioni(struct adapter *var0, u8 *var1) { return 0; }
> +
>  static struct cmd_hdl wlancmds[] = {
>  	GEN_DRV_CMD_HANDLER(0, NULL) /*0*/
>  	GEN_DRV_CMD_HANDLER(0, NULL)
> @@ -150,7 +152,7 @@ static struct cmd_hdl wlancmds[] = {
>  
>  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
>  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
> -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
> +	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), dummy_function) /*60*/

No, no.  Don't create a dummy function. Do it like so:

	GEN_DRV_CMD_HANDLER(0, NULL) /* 60 */

regards,
dan carpenter

