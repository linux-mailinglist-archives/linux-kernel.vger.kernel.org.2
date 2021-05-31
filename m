Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1700395538
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhEaGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:04:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhEaGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:04:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14V5tO26168235;
        Mon, 31 May 2021 06:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RkCuyZTIfKbViKm2ct9HBLI3OxZ3FAU3iXystEzKEg0=;
 b=neOutlWnexDUZ9NuqcTeX3al4f2v/hTFBJu5ObjZVsxQcts06N1H+VESTRt5qRTYuzx2
 BJBcwRgtF0pxVM/psprqW33LTjwgjDhFSsh5n4gcKT9viCMrc34Ub51+ba2A7V1ZOTB8
 F0hAA3bARJRIFoNmVn/NEx/RT3PJa7DL5p0w6DJzm0iL+oEcGGyPV3P75ugh7lHFiLMk
 PHCUxkChHKdL+5223xFQwTjzqGVBUkoTMwrb5Fba/oqnunEfpv4wZPrOnY6y9IEYiS7h
 av2wpZOQLFq7OMzZYSrPE4SzV40yw8ENIstQNWoTVUpsGkla7xTfainIzh7GPszUh//o sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38udjmj2rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 06:02:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14V61vsm070675;
        Mon, 31 May 2021 06:02:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38uaqv4reh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 06:02:36 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14V62Zis071211;
        Mon, 31 May 2021 06:02:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 38uaqv4re2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 May 2021 06:02:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14V62WW9000518;
        Mon, 31 May 2021 06:02:32 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 May 2021 23:02:31 -0700
Date:   Mon, 31 May 2021 09:02:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8188eu: remove dummy wext handlers
Message-ID: <20210531060223.GV1955@kadam>
References: <20210529121346.8422-1-martin@kaiser.cx>
 <20210529121346.8422-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529121346.8422-2-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: vwzM8NlYJXgd2I2ClWWuw44mKaAUpva9
X-Proofpoint-ORIG-GUID: vwzM8NlYJXgd2I2ClWWuw44mKaAUpva9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10000 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105310044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 02:13:45PM +0200, Martin Kaiser wrote:
> Remove the wext handlers that link to an empty dummy function.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> If no handler is installed for a wext ioctl, the wext core will return
> -ENOTSUPP to user space. The dummy function returned -1. It could be argued
> that this change breaks the user space ABI.
> 
> However, it's rather unlikely that an application expects a particular wlan
> driver and chipset when it configures a wireless network. Checking for
> errno==1 explicitly will already be non-portable as most other drivers set
> errn==ENOTSUPP for non-existing ioctls.
> 

The patch is good, but next time, just put all this commentary in the
commit message.  It has to do with the impact of the patch on userspace
and it's helpful for the reviewers.  Some reviewers won't need it, but
I try to target my commit messages at developers who aren't subsystem
experts.  I also like that it shows you thought about it.

I recently saw someone claim that "anyone who can review these patches
will already know what the <SOMETHING> acronym stands for so that's why
I didn't explain."  And I was like, "Oh wow...  That's a harsh burn on
me!"

regards,
dan carpenter

