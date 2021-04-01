Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41473512BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhDAJvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:51:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDAJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:50:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1319kG33019371;
        Thu, 1 Apr 2021 09:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=le2CN1auiZcjfeDiPWiULarZytNQ/KTrJUO/ek0InTQ=;
 b=jt6f6H6J7wXrAk2z50xIoCdF0ETksqsZzKyd/a+96NuVgI6J8jbzFeD2EkRfKQvvKKzE
 ZodY9S+a9w2UI7xar6Ab5rhbLKk4y6fsIwg+PudA3MV0ybBShXH3K1Wn4OPJJpNijica
 kVJGddpWwq6sikiNXBvO5/+s3Qjd7kCESQjxecYD/pn//Ta9Wt5MKGxynYZ5ZPGmiUk9
 bn/5ncM7TWibHW3Mmz2QIJV/9JX+I6a1IIp2Cg72et/gIHejJIt+2BsK41DpBem6snDZ
 d8VRQh0HvM1UV1+iS6lq+h42ojZi+NcqHF3cFdpQlZKnrWQOtlse7bbjxqbh4AelH+IF 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37n2akh7ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 09:50:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1319jiZb014457;
        Thu, 1 Apr 2021 09:50:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37n2as1uff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 09:50:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1319oQLu003574;
        Thu, 1 Apr 2021 09:50:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 09:50:26 +0000
Date:   Thu, 1 Apr 2021 12:50:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
Message-ID: <20210401095017.GR2065@kadam>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010067
X-Proofpoint-ORIG-GUID: 0TTPdwEtSO6lSbd4mdl82MP_WubY26oA
X-Proofpoint-GUID: 0TTPdwEtSO6lSbd4mdl82MP_WubY26oA
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:20:38AM +0200, Fabio Aiuto wrote:
> @@ -677,9 +663,8 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
>  	u8 res = _SUCCESS;
>  
>  	if (pmlmepriv->assoc_ssid.SsidLength == 0)
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for Any SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
> +		;
>  	else
> -		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
>  
>  	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));

This is a bug.  Smatch has a check for this which hopefully would have
detected it (I haven't tested).

There are some more similar issues below as well.  So generally the rule
is don't adjust the indenting if it's not related to your patch.  In
some cases you have been fixing the indenting but it should be done in
a separate patch.  But the other rule is that if your patch introduces
a checkpatch warning then you need to fix it in the same patch.  In
this block the whole if statement should be removed.  But also if you
have something like:

	if (foo) {
		RT_TRACE(blha blah blah);
		return;
	}

Then checkpatch will complain that the the curly braces are not
required.  (Checkpatch might not complain for your patch but it will
complain when we re-run it with the -f option over the whole file).  So
you should update this to:

	if (foo)
		return;

That's all considered part of deleting the RT_TRACE().  Also if there
are empty curly braces then delete those in the same patch.

I have looked over patches 1-7 and those seem basically fine.  I'm not
going to review any further into this patchset because you're going to
have to redo them and I will be reviewing the v2 set later anyway.  So
just look it over yourself and check for any similar issues.

regards,
dan carpenter

