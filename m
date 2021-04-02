Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FECB352747
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhDBIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:14:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:14:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1328EW3x097496;
        Fri, 2 Apr 2021 08:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rV/d0BWPQv1Dyf4Fb6LO4a5omks30fG0hHqowlxHrxE=;
 b=CYjgc2wVnL7K0PLX+QN5BfR4vqDhzS7Bd7cnwix7/PgH51bBRIHcd81qi4vE4kTIC/7W
 3TTE6qIUOnoCchJMjwcPkLGg99nL7NjtIwOzhP1AeUdIP/OgcnaR5ce9DpJ8zqnZqcKY
 S/UfuGbyuxIVJjpLcUSiXzLup/pdUKIoYjCXeNgY6YA0lLZ+jKwEcMzWeIck3oQQn+eS
 8gGa8vXRlC3/ZCCXQztdm6AwjrsPopCG0Vv+Whi2xLU/nHXxszA/H/+6Mtgck+0UQoEU
 G+ICRNy/HJL8Jnr1I5zp0XOtC4VZiHjM0DMAlMU+fi6/R4VJlMDBKgXPXTFORw5tUwvN zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37n2a041e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 08:14:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1328B0qk034706;
        Fri, 2 Apr 2021 08:14:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37n2ac8gr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 08:14:36 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1328EZd1013303;
        Fri, 2 Apr 2021 08:14:35 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 02 Apr 2021 01:14:27 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20210402081420.GU2088@kadam>
Date:   Fri, 2 Apr 2021 08:14:20 +0000 (UTC)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
 <20210401095017.GR2065@kadam> <20210401135536.GA1691@agape.jhs>
 <20210401143235.GV2065@kadam> <20210401215114.GA15992@agape.jhs>
In-Reply-To: <20210401215114.GA15992@agape.jhs>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020057
X-Proofpoint-GUID: tinFqQjXJNZlA7teBRe3gwlYLKbtVEdf
X-Proofpoint-ORIG-GUID: tinFqQjXJNZlA7teBRe3gwlYLKbtVEdf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:51:15PM +0200, Fabio Aiuto wrote:
> On Thu, Apr 01, 2021 at 05:32:36PM +0300, Dan Carpenter wrote:
> > On Thu, Apr 01, 2021 at 03:55:37PM +0200, Fabio Aiuto wrote:
> > > 
> > > Hi Dan,
> > > 
> > > I have the following:
> > > 
> > >  	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > > -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
> > > +	;
> > > 
> > > will I leave
> > > 
> > > 	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > > 		;
> > > 
> > > or just
> > > 
> > > 	rtw_createbss_cmd(adapter);
> > > 
> > > ?
> > > 
> > > what's best from the static analysis point of view?
> > > 
> > > smatch and sparse says nothing about that.
> > 
> > rtw_createbss_cmd() can only fail if this allocation fails:
> > 
> > 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
> > 
> > In current kernels, that size of small allocation will never fail.  But
> > we alway write code as if every allocation can fail.
> > 
> > Normally when an allocation fails then we want to return -ENOMEM and
> > clean up.  But this code is an event handler for firmware events and
> > there isn't any real clean up to do.  Since there is nothing we can do
> > then this is basically working and fine.
> > 
> > How I would write this is:
> > 
> > 			ret = rtw_createbss_cmd(adapter);
> > 			if (ret != _SUCCESS)
> > 				goto unlock;
> > 		}
> > 	}
> > unlock:
> > 	spin_unlock_bh(&pmlmepriv->lock);
> > }
> > 
> > That doesn't change how the code works but it signals to the the reader
> > what your intention is.  If we just remove the error handling then it's
> > ambiguous.
> > 
> > 			rtw_createbss_cmd(adapter);
> > 		}
> > 	}
> > 	<-- Futurue programmer decides to add code here then figuring
> >             that rtw_createbss_cmd() can fail is a problem.
> > 
> > 	spin_unlock_bh(&pmlmepriv->lock);
> > }
> > 
> > But for something like this which is maybe more subtle than just a
> > straight delete of lines of code, then consider pulling it out into its
> > own separate patch.  That makes it easier to review.  Put all the stuff
> > that I said in the commit message:
> > 
> > ---
> > [PATCH] tidy up some error handling
> > 
> > The RT_TRACE() output is not useful so we want to delete it.  In this
> > case there is no cleanup for rtw_createbss_cmd() required or even
> > possible.  I've deleted the RT_TRACE() output and added a goto unlock
> > to show that we can't continue if rtw_createbss_cmd() fails.
> > 
> > ---
> > 
> > > 
> > > Checkpatch too seems to ignore it, maybe the first one is good,
> > > but I would like to be sure before sending another over 40 patches
> > > long patchset.
> > 
> > Don't send 40 patches.  Just send 10 at a time until you get a better
> > feel for which ones are going to get applied or not. :P  It's not
> > arbitrary, and I'm definitely not trying to NAK your patches.  Once you
> > learn the rules I hope that it's predictable and straight forward.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Hi Dan,
> 
> sorry again. In this case:
> 
> @@ -828,10 +829,11 @@ void rtw_surveydone_event_callback(struct adapter *adapter, u8 *pbuf)
>  
>                                         pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
>  
> -                                       if (rtw_createbss_cmd(adapter) != _SUCCESS)
> -                                               ;
> -
>                                         pmlmepriv->to_join = false;
> +
> +                                       ret = rtw_createbss_cmd(adapter);
> +                                       if (ret != _SUCCESS)
> +                                               goto unlock;
>                                 }
>                         }
> 
> I decided to move the set to false of pmlepriv->to_join before 
> the rtw_createbss_cmd(). In old code that statement was executed
> unconditionally and seems not to be tied to the failure of 
> rtw_createbss_cmd().
> 
> The eventual goto would skip this instruction so I moved it
> before.
> 
> What do you think?

So when you're sending patches like this which have the potential to
change the behavior then we want to see your thought process explained a
bit in the message.

For example, when I'm reviewing patches in my email client, then I don't
know if rtw_createbss_cmd() uses pmlmepriv->to_join.  It turns out it
doesn't.  I also don't know what ->to_join is for really.  Your patch
preserves the original logic, but it's not totally clear that the
original code was correct.  See how it's done in rtw_do_join():

drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
   107                                  rtw_generate_random_ibss(pibss);
   108  
   109                                  if (rtw_createbss_cmd(padapter) != _SUCCESS) {
   110                                          RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>do_goin: rtw_createbss_cmd status FAIL***\n "));
   111                                          ret =  false;
   112                                          goto exit;
   113                                  }
   114  
   115                                  pmlmepriv->to_join = false;
   116  

So you could make an argument that the original code is wrong.

Also rtw_createbss_cmd() can't actually fail.

The other option is to replace that particular RT_TRACE() with a dev_err()
message.  Another option is to just skip that one and come back to it
later.  Maybe the code will be more clear after we have cleaned it up.

It doesn't matter so long as the commit message defends your choice then
probably we would accept any of these patches.

regards,
dan carpenter
