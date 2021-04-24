Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F018369FE1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhDXG4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:56:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51756 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244260AbhDXGsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:48:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13O6Ou7e083276;
        Sat, 24 Apr 2021 06:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B2e0yO5JEDbjpt9UVoxx75p29kZv7siwpuysnfs6zd0=;
 b=ZVALcXpwgYy2uwAYcSB9lBXh9F2N79cE9+O5Gd1IE7ytBiH89/dQNy1d1cZjFg8C2wih
 5nM6PIeaTPU41Ev0jgvyfiMYal8nXzDnxX/d8ptnTcLiYgQyu1z+//6BM1OEK8bYbMlP
 4WoMrcgxekKZUr0QtRwaQixT/d15+uYkItQzwx4UxGw7YtWCX6XSuWObZhn/zGDFOPZi
 V3xMdfZsx0hRLKr9YVi/Q+LKfLTNoLcZlTE6nZWYOIVln2E/LRDYVBFWzB46U6rSqx57
 VWvWUUaPkbb9MjFGa9PUDPmXwLIkN+gYsW7NAIUF4LMU1eHhy67wwxmpQXbuEuseI7fk xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 384ars04ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 06:43:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13O6PZJj164989;
        Sat, 24 Apr 2021 06:43:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 384b5164m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 06:43:17 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13O6hHsP019326;
        Sat, 24 Apr 2021 06:43:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 384b5164kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 06:43:17 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13O6hDjr030484;
        Sat, 24 Apr 2021 06:43:16 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 23:43:13 -0700
Date:   Sat, 24 Apr 2021 09:43:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scpi: prevent ternary sign expansion bug
Message-ID: <20210424064307.GV1959@kadam>
References: <YIE7pdqV/h10tEAK@mwanda>
 <20210422174631.aruiqqqx3szboqdp@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422174631.aruiqqqx3szboqdp@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: UjpaBYuHQzR7qtW6xmIOkAwv1T9BSn8T
X-Proofpoint-GUID: UjpaBYuHQzR7qtW6xmIOkAwv1T9BSn8T
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9963 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:46:31PM +0100, Sudeep Holla wrote:
> (dropping Tixy as I am sure it will bounce, he left/retired from Linaro
> long back)
> 
> On Thu, Apr 22, 2021 at 12:02:29PM +0300, Dan Carpenter wrote:
> > How type promotion works in ternary expressions is a bit tricky.
> > The problem is that scpi_clk_get_val() returns longs, "ret" is a int
> > which holds a negative error code, and le32_to_cpu() is an unsigned int.
> 
> Agreed.
> 
> > We want the negative error code to be cast to a negative long.  But
> > because le32_to_cpu() is an u32 then "ret" is type promoted to u32 and
> > becomes a high positive and then it is promoted to long and it is still
> > a high positive value.
> >
> 
> Thanks a lot for finding and fixing the bug!
> 
> > Fix this by getting rid of the ternary.
> >
> > Fixes: 8cb7cf56c9fe ("firmware: add support for ARM System Control and Power Interface(SCPI) protocol")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/firmware/arm_scpi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> > index d0dee37ad522..3bf61854121d 100644
> > --- a/drivers/firmware/arm_scpi.c
> > +++ b/drivers/firmware/arm_scpi.c
> > @@ -552,8 +552,10 @@ static unsigned long scpi_clk_get_val(u16 clk_id)
> >
> >  	ret = scpi_send_message(CMD_GET_CLOCK_VALUE, &le_clk_id,
> >  				sizeof(le_clk_id), &rate, sizeof(rate));
> > +	if (ret)
> > +		return ret;
> 
> This could be still an issue, ideally I would prefer to pass the return
> value via argument pointer and always return success/failure as return
> value. Can't remember any reason for this. Since this is old interface
> with limited platform to test, I think returning 0 as clock rate on error
> should be fine as Cristain suggested. If you agree with that, I can
> fix up when applying. 
> 

That sounds great.  Thanks.

regards,
dan carpenter

