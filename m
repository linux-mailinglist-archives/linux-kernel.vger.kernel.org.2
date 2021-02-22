Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA82321085
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBVFoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:44:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33216 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhBVFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:44:13 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M5cwLE010037;
        Mon, 22 Feb 2021 05:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BGCMXtBu9a+0Ly6I6nTFxZbpghNrYOcmwKGRXQhYz1M=;
 b=FGklHZPf54cvhbO2AfPZ+HNTPySjCp4bYQR3TNHW2MSJ4d/WYMC4oJ1CvXPLqNZ/3wRC
 Es6Yke7Q2IKuN7ERoOBOuRjKZpeX1xdxmxW5G637+E/fMtdpStsVxY4nvvTJ/ySl8P6F
 TGRq4l0P4LpK0OswCqszTklLkj2HBv2ulRVl+98uARJy7sspkZ9dp5Rf/CHKBuXKsGCG
 JYuv7vlK3ktUzB9R+5a1F5cGOUxJFOFxDDHKCE2snCuaLLhpFt18nPMUYxSMbchD14oK
 5tnHzlZ+Ta4B9HJAIMHrb5+5ikWIRpY/5vwBF730cs/K0EiH/Gjd4Y6fQ893Sk4+Ho0T 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36tqxbafnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 05:43:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M5e1bn138061;
        Mon, 22 Feb 2021 05:43:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36uc6pw2gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 05:43:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11M5hOqu001392;
        Mon, 22 Feb 2021 05:43:25 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Feb 2021 21:43:24 -0800
Date:   Mon, 22 Feb 2021 08:43:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthik alapati <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shivang upadhyay <oroz3x@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax/i2400m: fix byte-order issue
Message-ID: <20210222054316.GG2087@kadam>
References: <YDEAB/QatfBX9vQN@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDEAB/QatfBX9vQN@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:56:47PM +0530, karthik alapati wrote:
> fix sparse byte-order warnings by converting host byte-order
> types to le32 types
> 
> Signed-off-by: karthik alapati <mail@karthek.com>

This is a v2 patch...

regards,
dan carpenter

