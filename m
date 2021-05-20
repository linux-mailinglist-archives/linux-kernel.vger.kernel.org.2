Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25CD38B5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhETSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:20:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12162 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbhETSUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:20:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KIHQrx008470;
        Thu, 20 May 2021 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=P1PCfq+88bRk1jzcl/1m4R3g0NBoKcpJah2+UdUJDrs=;
 b=n4WTOq3tHWXOI/7/YR/zZNtf4PXTIL3UakfOfkXEV/hiOMBtf3olt2i81FNuSyZ782WP
 z6jt7u5sdjvsSMze6CCAjIk5yE79tW6dkLkMPNkAKxOQf0Zhu9woC42qkyf0MhMy10+p
 CB8kN78u0xGdZ5QVQqiVXg6XlUYe9jMj/tESM3O/Vg+V3ShfiW8gz4QD231Owb18e5SL
 fyQun5iIbg2F3M6rpqiWoR875bczZNEbF8ae8yD/OW3C1RFEqXagdf40QnqXzk5X/tvP
 OGxMjOLbi2svtOi7j0W4yz/xEHE1/jk3soR98vWQPglSEK4VUtwKfVPEk+3R+5gqRk1Z tg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4ukrjua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 18:18:55 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14KIGwrm194892;
        Thu, 20 May 2021 18:18:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38nry0gv1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 18:18:54 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14KIHwnm008074;
        Thu, 20 May 2021 18:18:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38nry0guxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 18:18:53 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14KIIpSe014675;
        Thu, 20 May 2021 18:18:51 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 May 2021 11:18:50 -0700
Date:   Thu, 20 May 2021 21:18:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Sean Behan <codebam@riseup.net>,
        Colin Ian King <colin.king@canonical.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Fixed coding style in places where
 lines should not end in '('
Message-ID: <20210520181838.GI1955@kadam>
References: <20210520174701.8370-1-hridayhegde1999@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520174701.8370-1-hridayhegde1999@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: eCZpwk2BxM9I-mePFBIOfN_D670Ko-z2
X-Proofpoint-ORIG-GUID: eCZpwk2BxM9I-mePFBIOfN_D670Ko-z2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 10:46:57AM -0700, Hriday Hegde wrote:
> The fixes were for the following checkpatch outputs:
> 
> CHECK: Lines should not end with a '('
> 1076: FILE: drivers/staging/emxx_udc/emxx_udc.c:1076:
> +				_nbu2ss_writel(
> 
> CHECK: Lines should not end with a '('
> 1228: FILE: drivers/staging/emxx_udc/emxx_udc.c:1228:
> +		length = _nbu2ss_readl(
> 
> CHECK: Lines should not end with a '('
> 1465: FILE: drivers/staging/emxx_udc/emxx_udc.c:1465:
> +			regdata = _nbu2ss_readl(
> 
> Signed-off-by: Hriday Hegde <hridayhegde1999@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 741147a4f0fe..8364316c1d25 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -1073,8 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>  		i_word_length = length / sizeof(u32);
>  		if (i_word_length > 0) {
>  			for (i = 0; i < i_word_length; i++) {
> -				_nbu2ss_writel(
> -					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
> +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1]
> +					.EP_WRITE,
>  					p_buf_32->dw);

No, this is worse than before.

regards,
dan carpenter

