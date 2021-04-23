Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3681E3690ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbhDWLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 07:15:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43980 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhDWLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:15:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NB6s9s000522;
        Fri, 23 Apr 2021 11:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=e6UoQ3Sz9f7WFV5mtRzwBcTj28OvIA+hDg21SLUc3pg=;
 b=WV1aqczTtVCGOctNcVgMq0APAnFZY/m01vdaccfTLxp493RIPB2iMJl+pqD21GboS5ym
 wcIFNRP0Q0FgB75HBBL+P6Mz7CLlOVATLAMgXvsGE0VeHiBuFuapt2aZKkXzW0hWzDli
 DFAJTggJrXUl1CrZPKb5+sM3Hjmw9qLCa8/YuDD6J7M7mg36ysTNlp0tmbdUN7di4IAZ
 d8+NNC6nPMNGbuvv4RcI+mIUTj150KSkENNJMGsJMekuXLaMuW+iIflL+lySfrWaywv2
 v6O8BdTeqfspw16h91XKe4DZmOjiMcQyoZ+FGj5Oc1LSXcZmPi5uqGjdL4hXd25jakSg OA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 382uth0pj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:14:41 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NBEQ8Y004911;
        Fri, 23 Apr 2021 11:14:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 383cbf0y7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:14:40 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NB5ZX0146618;
        Fri, 23 Apr 2021 11:14:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 383cbf0y6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:14:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13NBEZVa012333;
        Fri, 23 Apr 2021 11:14:35 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 04:14:34 -0700
Date:   Fri, 23 Apr 2021 14:14:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
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
Message-ID: <20210423111425.GT1959@kadam>
References: <YIE90PSXsMTa2Y8n@mwanda>
 <59596244622c4a15ac8cc0747332d0be@AcuMS.aculab.com>
 <877dktuvmz.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dktuvmz.fsf@osv.gnss.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: buI5O6n7g4zgWO5D-JTNuvwpixakMr6V
X-Proofpoint-GUID: buI5O6n7g4zgWO5D-JTNuvwpixakMr6V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:45:40PM +0300, Sergey Organov wrote:
> David Laight <David.Laight@ACULAB.COM> writes:
> 
> > From: Dan Carpenter
> >> Sent: 22 April 2021 10:12
> >> 
> >> The intent here was to return negative error codes but it actually
> >> returns positive values.  The problem is that type promotion with
> >> ternary operations is quite complicated.
> >> 
> >> "ret" is an int.  "copied" is a u32.  And the snoop_file_read() function
> >> returns long.  What happens is that "ret" is cast to u32 and becomes
> >> positive then it's cast to long and it's still positive.
> >> 
> >> Fix this by removing the ternary so that "ret" is type promoted directly
> >> to long.
> >> 
> >> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> index 210455efb321..eceeaf8dfbeb 100644
> >> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> >> @@ -94,8 +94,10 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
> >>  			return -EINTR;
> >>  	}
> >>  	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
> >> +	if (ret)
> >> +		return ret;
> >> 
> >> -	return ret ? ret : copied;
> >> +	return copied;
> >
> > I wonder if changing it to:
> > 	return ret ? ret + 0L : copied;
> >
> > Might make people think in the future and not convert it back
> > as an 'optimisation'.
> 
> It rather made me think: "what the heck is going on here?!"
> 
> Shouldn't it better be:
> 
>  	return ret ? ret : (long)copied;
> 
> or even:
> 
>         return ret ?: (long)copied;

I work with Greg a lot and his bias against ternaries has rubbed off a
bit.  They're sort of Perl-ish.  And I have nothing against Perl.  It's
a perfectly fine programming language, but when I write Perl I write it
in C.

regards,
dan carpenter
