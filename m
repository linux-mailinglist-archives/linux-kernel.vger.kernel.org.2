Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A23348E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCYKvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:51:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34288 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhCYKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:51:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PAml4B047691;
        Thu, 25 Mar 2021 10:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=p2pVh/GarV+SSYuz6AKALq2b748OF7eFUk/PJ9yVAYY=;
 b=faUdxoez6LJoIsWK4dKLHITjESkXqi6YeVh7iUHPeMF2VrsNaucF3avuz3ioMok2oaoc
 xMi4yR3tdFQokCd5rXXqVfVMScaaV9IFsacRH4jOlV4xbDm7zHN5uzCe/qCFHjiNCrwr
 0WvwNsYBlXoVzFTtvgD9lVZPCEh3jh3H7cP9/nKvN+JJYBHK7wH8NgDdPSc6n99wv7yM
 C14kRQieFfBc2XN3JDaHKgVKDFO8dekC4FqJNICRBPjCAFPCvfR5qYU5wee/LHyQBVr8
 6c1r20Kv1pKzoEoir+23kw42vHIS+I98QT5/Wq+E2VUms/zam2wI0h51VtGVO45nYaKC 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8frdtx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 10:51:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PAoG9n010831;
        Thu, 25 Mar 2021 10:51:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37dttugwq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 10:51:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12PAox18010326;
        Thu, 25 Mar 2021 10:50:59 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Mar 2021 03:50:58 -0700
Date:   Thu, 25 Mar 2021 13:50:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jian Dong <dj0227@163.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        greybus-dev@lists.linaro.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  staging: greybus: fix fw is NULL but dereferenced
Message-ID: <20210325105050.GW1717@kadam>
References: <1616667566-58997-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616667566-58997-1-git-send-email-dj0227@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250081
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit description is not clear but this patch doesn't change how
the code works, it just silences a static checker false positive.

Just ignore the false positive.  Always just ignore static checkers
when they are wrong.

regards,
dan carpenter

