Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDA368F08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbhDWIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:45:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46942 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhDWIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:45:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13N7YRu1116214;
        Fri, 23 Apr 2021 07:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=m3JeTi6J35HzEswBhx5voKhbB6HEkBdhD3wdLMfUT8g=;
 b=FmBtSoUYF6vzKT0pzsKNOwKIOezU1BoknLx9bvT+3QPiZDS0xHblZ5BrNXZqVAwXahbn
 s71U4ocgL1UH55cux616xgxXmPqCfA4Qqe9ANgUEFfYEz3Zew/v1kYJrayALJsZ6eSeg
 sT4Gc838usPzJL8qrENr8hfkuzqmAG92C/j+2BmqrL/XrEolUjhheEarNIKqTXa9Q4sB
 9PsADLASXvGzzOZGyXi9uo2lzKHOfMu/3VYAnBiAJFLMFj113XtN1AoXLV/T0hK3MCmk
 SRyEA0TNhMmCYTExD+/QQuy3QBMAR92lPG+VD2BEtHjDJ4pnM9B72K5BSVu/z+tYHkW1 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37yveaq6j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 07:43:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13N7fuqL126007;
        Fri, 23 Apr 2021 07:43:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 383ccf9r0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 07:43:39 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13N7hcbl129407;
        Fri, 23 Apr 2021 07:43:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 383ccf9r03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 07:43:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13N7hWFQ026962;
        Fri, 23 Apr 2021 07:43:32 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 07:43:31 +0000
Date:   Fri, 23 Apr 2021 10:43:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        =?iso-8859-1?Q?Aur=E9lien?= Aptel <aaptel@suse.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Patrick Venture <venture@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Lippert <rlippert@google.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] soc: aspeed: fix a ternary sign expansion bug
Message-ID: <20210423074322.GQ1959@kadam>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: QIJeQIlXU4SEZZ588_PY18DvFPxhwW7s
X-Proofpoint-ORIG-GUID: QIJeQIlXU4SEZZ588_PY18DvFPxhwW7s
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:21:40PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 22 April 2021 10:12
> > 
> > The intent here was to return negative error codes but it actually
> > returns positive values.  The problem is that type promotion with
> > ternary operations is quite complicated.
> > 
> > "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> > returns long.  What happens is that "ret" is cast to u32 and becomes
> > positive then it's cast to long and it's still positive.
> > 
> > Fix this by removing the ternary so that "ret" is type promoted directly
> > to long.
> > 
> > Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 210455efb321..eceeaf8dfbeb 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
> >  			return -EINTR;
> >  	}
> >  	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> > +	if (ret)
> > +		return ret;
> > 
> > -	return ret ? ret : copied;
> > +	return copied;
> 
> I wonder if changing it to:
> 	return ret ? ret + 0L : copied;
> 
> Might make people think in the future and not convert it back
> as an 'optimisation'.

This is from a Smatch test that Aurélien Aptel requested.  The test is
pretty good quality with few false positives so I will push it soon.

If someone converts it back then I expect the checker will catch it.

regards,
dan carepnter

