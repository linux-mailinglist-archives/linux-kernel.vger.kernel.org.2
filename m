Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A0E31EE38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhBRS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:26:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhBRQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:02:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFsDZ2112412;
        Thu, 18 Feb 2021 16:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=re0AgduDc5MORj6d0mAbSQpCdoy7EE3lsvXNuGddlUA=;
 b=glkujHk+UnRLV3HjGI3+ruqbbgQ1mN2uVv2dRbaStOLSpPz0lRWpaYBvmBMewXRzjbq8
 Tr800OEVtEW4vnCPmCmCzfsy9cLETOTVxeNSPe75rCvtJSvhY27OnYrncmEugUZ6UHap
 BHrS7WrJ7fuR8mdnTWDPSkbzeoanEyDLwkQJc8b/ciNLdSNyEAtkYZeSfO6xgUcDBe1G
 DiH+S+QjbTW/P4G/ANDBvE4hkH2jezgM0vNknpkJ97OzKkC2IWJQnse6OqqZ90ZtrroE
 15a6F2ptbSm33+sakYRGOWjOjUVqCIlMBn+zrB894T1DrPgVmLAgLOqfQCMxhtsReNr5 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnpbte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 16:01:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFoFRO074820;
        Thu, 18 Feb 2021 16:01:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36prp1q29q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 16:01:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11IG1N6P013704;
        Thu, 18 Feb 2021 16:01:24 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Feb 2021 08:01:23 -0800
Date:   Thu, 18 Feb 2021 19:01:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix comparisons - put constant on right side- eudyptula
Message-ID: <20210218160114.GM2087@kadam>
References: <20210218155422.7-1-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218155422.7-1-fuzzybritches@protonmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 03:54:29PM +0000, Kurt Manucredo wrote:
> 
> Dear linux kernel developers,
> 
> for my eudyptula challenge it is required of me to fix a coding style
> issue in the staging area in linux-next. I am aware that it is in
> general frowned upon when submitting these sorts of patches. However, to
> finish my 10th challenge I was tasked to do exactly that. So I ask you
> kindly to pull this patch if possible.
> 
> Thank you for your time,

These patches are fine in staging.

regards,
dan carpenter
