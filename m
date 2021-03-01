Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6095932777E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhCAGYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:24:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhCAGYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:24:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1216F2iI066076;
        Mon, 1 Mar 2021 06:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=94V1zPtUuobxNqoS0Ro+KRCx183gIqYdwW7R0oRnJhU=;
 b=JBXMgdWgqzL9fl70cny8n49h2g4oW5QdE+BSCNppgeIytBZC2OvntuEVLQqO5gS9zRWx
 +TxbTo27BT3pvGMx6sy9L9WmuK7I1Q19f2JpYdjfopTd2eBNCMKYyguTkZoOgH2FUw4Z
 ITMMXK14uMNWyPlcoIsPAP4xl1vkrlzLnu1Sdueoo+N+M+hYlcDqHHHsGMvlfrr5XjDq
 aD2taU3KFgIX5kvBaGaER5WxcPowGmOrGy8veogFA+kk0TFgfK23aCZ63ouvtaP4V+aV
 agfMAQ61ugVgn63aHPh4qAc8PAwCNdQBnPIQs/20/aFsLhXLEcEaiHlKZReDEss4VMQB cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ye1m2mb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 06:23:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1216EsZk176857;
        Mon, 1 Mar 2021 06:23:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36yyyx1e0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 06:23:15 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1216NEJh030944;
        Mon, 1 Mar 2021 06:23:14 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 28 Feb 2021 22:23:13 -0800
Date:   Mon, 1 Mar 2021 09:23:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Fox Chen <foxhlchen@gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Fixed indentation and coding style
Message-ID: <20210301062306.GJ2087@kadam>
References: <20210227220233.10259-1-chakravarthikulkarni2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210227220233.10259-1-chakravarthikulkarni2021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 03:32:30AM +0530, chakravarthikulkarni wrote:
> @@ -795,14 +795,14 @@ struct RunInThread_param {
>  
>  
>  /*
> -
> -Result:
> -0x00: success
> -0x01: sucess, and check Response.
> -0x02: cmd ignored due to duplicated sequcne number
> -0x03: cmd dropped due to invalid cmd code
> -0x04: reserved.
> -
> +*
> +*Result:
> +*0x00: success
> +*0x01: sucess, and check Response.
> +*0x02: cmd ignored due to duplicated sequcne number
> +*0x03: cmd dropped due to invalid cmd code
> +*0x04: reserved.
> +*
>  */

This indenting style is wrong.  There should be a spaces around the '*'
character:

/*
 * Result:
 * 0x00: success
 * 0x01: sucess, and check Response.
 * 0x02: cmd ignored due to duplicated sequcne number
 * 0x03: cmd dropped due to invalid cmd code
 * 0x04: reserved.
 */

regards,
dan carpenter

