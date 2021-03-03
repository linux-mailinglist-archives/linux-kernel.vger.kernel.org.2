Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DE32BD61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452670AbhCCPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:52:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351440AbhCCLJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:09:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123B93mE095247;
        Wed, 3 Mar 2021 11:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JVV2RdFAzl94FboSBZ9aI+jhE/NQ+v7ieH2rJcjJbUM=;
 b=iRsH1GwX0xW6d0629L8L4PvWlqqcU8JfmYK0WnlMKzB/YkmqJYTatCp/E7z430Bqi5fg
 9xtAJs/hqVFwPwGzLE8N6BSfL+3A7LXuB0jY5INWrCoM2MzxKKP19rgdygg/wB1/lhE3
 XvRPmKXnWRbMUhb7tWGo5dkKIY2QECsiQQaUid4jt+R0EnTwO6GgBhURqPuKsld13GNb
 dk3Y+uUL4AAWQ9SiwbCpiRJqmhjoeeUTW95DJI5a6+E4hwgrGVwozDOmQfWVsfh6W4hC
 nRrqzz8ETdQdlKhHbHKf5zRcQ6aCCm3z+Ft77idJJ88hFhi8tgbZbCdYx8zLPTavCUsN RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36yeqn2wvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 11:09:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123B56kh155985;
        Wed, 3 Mar 2021 11:09:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3700015euy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 11:09:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 123B8uBn018759;
        Wed, 3 Mar 2021 11:08:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Mar 2021 03:08:55 -0800
Date:   Wed, 3 Mar 2021 14:08:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild@lists.01.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/mtd/parsers/qcomsmempart.c:109 parse_qcomsmem_part()
 warn: passing zero to 'PTR_ERR'
Message-ID: <20210303110847.GA2222@kadam>
References: <20210303054918.GX2087@kadam>
 <20210303094840.0e30392c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303094840.0e30392c@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=979
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030086
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=928 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:48:40AM +0100, Miquel Raynal wrote:
> 
> @Manni, I thought you would be added in Cc automatically as you're the
> author of the fixed commit, but I was wrong, sorry for the mistake.

That's very weird...  get_maintainer.pl does look up the fixes tag and
adds the commit signers.  I tested your patch and it added
<mani@kernel.org> for me.

regards,
dan carpenter

