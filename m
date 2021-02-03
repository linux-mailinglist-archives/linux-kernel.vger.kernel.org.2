Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD330E3DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBCUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:08:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBCUIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:08:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113K4EEq064527;
        Wed, 3 Feb 2021 20:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vZEiDU8hQT1UhocoLYdWh7SyEagKbQkYSVRWu2mgg74=;
 b=H7jrVtQ4rlAoqdfgK2tbVUqouj8mPov9s4UpOnZn1tUG6Ve4R7S57r6fp0FGSY17hX4W
 1AgHjIMp2maWZXS7RSNxzGVv2iokb8NRx6XpU80GX7kIkyJTdsJjEYjDFwV35gdKycC5
 TLq335ZPD9zx+8k7L1vMgObSpyRJHEXrcvZGBrVnYTT9f2TLVKeryl8lhCeCFFk7cB6v
 RWPceW+x5yodpsaXo3yWhYu733hpbJdQlivA83EFK41rR62cLxs0DPLcYVuSonJXqTwD
 PJElzy78ZsYcDm4k4ZqHRqfJPoTvK1+fAAulGyRmVeLX3UzmYt24IixC7vvEDrug/zlz HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvr4qa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 20:07:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113JuHNM179710;
        Wed, 3 Feb 2021 20:05:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36dh7u2rwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 20:05:42 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 113K5c8j029149;
        Wed, 3 Feb 2021 20:05:39 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Feb 2021 12:05:37 -0800
Date:   Wed, 3 Feb 2021 23:05:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        James Hu <james.hu@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc: bcm-vk: Fix a couple error codes in probe()
Message-ID: <20210203200529.GH20820@kadam>
References: <YBpyEbmz00rjvT9S@mwanda>
 <55880105-a097-0268-de54-478d7dbae084@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55880105-a097-0268-de54-478d7dbae084@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030117
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 11:15:35AM -0800, Scott Branden wrote:
> Thanks Dan,
> 
> On 2021-02-03 6:42 a.m., Dan Carpenter wrote:
> > These errors should return negative error codes instead of returning
> > success.
> Do you have a script running to report such issues or just manually reviewing
> to find such paths?

Yeah.  This is a new Smatch check.  The heuristic is this:

	<-- ret is not set within 3 lines of the goto
	goto label;  <-- we hit a goto


	return 0;  <-- success path right before the cleanup block

label:	<-- labels
	return ret;  <-- This return has to sometimes returns negatives

regards,
dan carpenter

