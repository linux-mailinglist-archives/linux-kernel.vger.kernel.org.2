Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76D35105C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhDAHuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:50:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35086 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhDAHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:49:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1317nCoJ087870;
        Thu, 1 Apr 2021 07:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=SA7wCCNN+mAeWw8tOf7p23ED4+d4WG2ymIuZDIXJ7Xw=;
 b=x+yzm4tYG06gGnAwPrBDLz/1BJhaIPEtOVe3cAPBdiWcbZc7yxugtQm5Fh2wOW/TnzBv
 HUXHrOYZA+FvM3LKbyPPmUr5eCHXlEgbeDD2inUfisFY5VosH7UFW9ZkfPT/4MARBY5n
 Solv6vumnpD3a6ZEA4mq3w2g+rCm088rml8zwO42IIMvwQAEt2eR1M899UCewvu70u33
 +LOG07a6R806G4aS7hQmYXkE/Xcvx7ZV+fqcfaeMOkerUMxOdbXJdHlggkEHq+CjAR2I
 tW22K7ahNAIKa+SyyNt2Tm7NbhaxigEFt3Ax5L43yc2L7gsGE03JSnSx8WNL8Up8LEYZ ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37n30s8s18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 07:49:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1317egNm082688;
        Thu, 1 Apr 2021 07:49:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37n2pa5msv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 07:49:21 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1317nEsA005753;
        Thu, 1 Apr 2021 07:49:18 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 00:49:14 -0700
Date:   Thu, 1 Apr 2021 10:49:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     chenlifu <chenlifu@huawei.com>
Cc:     Russell King <linux@armlinux.org.uk>, heying24@huawei.com,
        yuehaibing@huawei.com, weiyongjun1@huawei.com,
        johnny.chenyi@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] i2c: gpio: use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210401074905.GQ2065@kadam>
References: <20210327095228.105123-1-chenlifu@huawei.com>
 <fec9295e-c5d6-13ee-23f5-13b593d2fd2e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fec9295e-c5d6-13ee-23f5-13b593d2fd2e@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010053
X-Proofpoint-GUID: SGcL9X88jdvImiMwP0_StNqprF49Esev
X-Proofpoint-ORIG-GUID: SGcL9X88jdvImiMwP0_StNqprF49Esev
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:38:30AM +0800, chenlifu wrote:
> Kindly pinging ...
> 
> Best Regards,
> Chen Lifu
> 
> 在 2021/3/27 17:52, Chen Lifu 写道:

It's to early to start asking for a response.  Please wait at least two
weeks.  (Probably four weeks if the merge window was open).

regards,
dan carpenter


