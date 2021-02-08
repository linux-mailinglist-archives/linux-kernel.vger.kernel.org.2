Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B63133A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhBHNsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:48:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48294 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhBHNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:46:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118Dfcw5117645;
        Mon, 8 Feb 2021 13:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=S/CuYIjuHjzFLD6mnTlI2mltUXg/4xRtQhW7gxXZHxA=;
 b=Ztm64LaUuV5sFQSFz/fKCMdhsz9sOHlWQlFks7hyBmYtnLgj2eyhgw+LjApKeADdoofC
 51XSQC/2eCzG/OpCb1bP2NP+09DcEEHnomdi4MN+oRiQE0XnWMGRjq/mv1G40d8+JpsA
 tTnuE4ZPaiJAMPVoImYCl4y0hBtMv/U5N9yeYI/SOqFWKAU0eTvj+x+fHZQJL8TVgpFv
 2FPywRRFzExtVODTReQITiPVOtnXuTB3ZQ/SggYcRPqxFkdV1/UHz6xCLw4daXFMfmL8
 vHh7bSzBnAgEByGLXsa1Y1K7iUqRIRYfrv7VDkOxSq95vt7aU/KCRpo0Gw53kcqNh8+/ 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmac18x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 13:45:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118DfJ1T007946;
        Mon, 8 Feb 2021 13:45:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 36j50ytayr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 13:45:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 118DjQ4E013402;
        Mon, 8 Feb 2021 13:45:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Feb 2021 05:45:26 -0800
Date:   Mon, 8 Feb 2021 16:45:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: fix ignoring return value warning
Message-ID: <20210208134517.GG2696@kadam>
References: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 05:23:28PM +0800, Youling Tang wrote:
> Fix the below ignoring return value warning for device_reset.
> 
> drivers/staging/mt7621-dma/mtk-hsdma.c:685:2: warning: ignoring return value
> of function declared with 'warn_unused_result' attribute [-Wunused-result]
>         device_reset(&pdev->dev);
>         ^~~~~~~~~~~~ ~~~~~~~~~~
> drivers/staging/ralink-gdma/ralink-gdma.c:836:2: warning: ignoring return value
> of function declared with 'warn_unused_result' attribute [-Wunused-result]
>         device_reset(&pdev->dev);
>         ^~~~~~~~~~~~ ~~~~~~~~~~
> 

We can't really do this sort of fix without the hardware to test it.
This could be the correct fix or perhaps switching to device_reset_optional()
is the correct fix.  We can't know unless we have the hardware to test.

People think silencing warnings is good, but it's actually bad.  The
warning is there to show us a potential bug.  If we silence the warning
without fixing the bug, then we it's like when your mom tells you to
clean up the room and you instead just switch off the light.  It doesn't
fix the problem, it only makes it harder to find.

regards,
dan carpenter

