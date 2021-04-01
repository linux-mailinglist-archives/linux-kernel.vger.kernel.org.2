Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F6351AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhDASCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:02:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52730 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbhDARpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131EUOwa043580;
        Thu, 1 Apr 2021 14:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wqAWeuP8pgtH8tcRXg6w3pb7HUuw1+zzkXuZ1BFgBPY=;
 b=QmPAOcPWtEtNaGTh1AhcIKkjFWCcDjA7qmsTl4FJbdbHxlALnkkHQzjbIX1R8dAdZ0SV
 HNOou25aJjLlRRkaWWqrUm8PHtJnf3Adxu7wEGBp6QiABwKPKP+YhwxEaUTbE5SLheVs
 3zkzkOYdLz4ujhqO1oRDmQ6WHgxBHvLrWjVupoiGZ+KcIK8mC4G9SCZ9sg3hmoACWv/0
 YvKC7x8ZNQrAD/owh+laK/1C0o4vuXaQvxuFAU7sAhBvYO4A4KAGYxWYcLAH02Cs/cgd
 1TQ/jYzNUVUUugSCFlJTSGv7GinfsrX6YEIC0oqEdhUpzzmsrHN30PExNG3AJwEK320x VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37n2akj2k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 14:32:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131EOhWe074615;
        Thu, 1 Apr 2021 14:32:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37n2pam94k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 14:32:46 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 131EWivu016975;
        Thu, 1 Apr 2021 14:32:44 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 07:32:43 -0700
Date:   Thu, 1 Apr 2021 17:32:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
Message-ID: <20210401143235.GV2065@kadam>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
 <20210401095017.GR2065@kadam>
 <20210401135536.GA1691@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401135536.GA1691@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010100
X-Proofpoint-ORIG-GUID: 13N7doJFI8bwWPWRhNo0DEDJrsYq0KTW
X-Proofpoint-GUID: 13N7doJFI8bwWPWRhNo0DEDJrsYq0KTW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:55:37PM +0200, Fabio Aiuto wrote:
> 
> Hi Dan,
> 
> I have the following:
> 
>  	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
> +	;
> 
> will I leave
> 
> 	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> 		;
> 
> or just
> 
> 	rtw_createbss_cmd(adapter);
> 
> ?
> 
> what's best from the static analysis point of view?
> 
> smatch and sparse says nothing about that.

rtw_createbss_cmd() can only fail if this allocation fails:

	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));

In current kernels, that size of small allocation will never fail.  But
we alway write code as if every allocation can fail.

Normally when an allocation fails then we want to return -ENOMEM and
clean up.  But this code is an event handler for firmware events and
there isn't any real clean up to do.  Since there is nothing we can do
then this is basically working and fine.

How I would write this is:

			ret = rtw_createbss_cmd(adapter);
			if (ret != _SUCCESS)
				goto unlock;
		}
	}
unlock:
	spin_unlock_bh(&pmlmepriv->lock);
}

That doesn't change how the code works but it signals to the the reader
what your intention is.  If we just remove the error handling then it's
ambiguous.

			rtw_createbss_cmd(adapter);
		}
	}
	<-- Futurue programmer decides to add code here then figuring
            that rtw_createbss_cmd() can fail is a problem.

	spin_unlock_bh(&pmlmepriv->lock);
}

But for something like this which is maybe more subtle than just a
straight delete of lines of code, then consider pulling it out into its
own separate patch.  That makes it easier to review.  Put all the stuff
that I said in the commit message:

---
[PATCH] tidy up some error handling

The RT_TRACE() output is not useful so we want to delete it.  In this
case there is no cleanup for rtw_createbss_cmd() required or even
possible.  I've deleted the RT_TRACE() output and added a goto unlock
to show that we can't continue if rtw_createbss_cmd() fails.

---

> 
> Checkpatch too seems to ignore it, maybe the first one is good,
> but I would like to be sure before sending another over 40 patches
> long patchset.

Don't send 40 patches.  Just send 10 at a time until you get a better
feel for which ones are going to get applied or not. :P  It's not
arbitrary, and I'm definitely not trying to NAK your patches.  Once you
learn the rules I hope that it's predictable and straight forward.

regards,
dan carpenter

