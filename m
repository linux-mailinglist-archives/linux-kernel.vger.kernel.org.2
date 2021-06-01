Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CB39730C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhFAMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:16:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34658 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFAMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:16:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151C8wY8157385;
        Tue, 1 Jun 2021 12:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TY/l/e9NEFH9rioskKiN8eW/uAap6wHenLerhBZ8eeQ=;
 b=I2F0TiHqQwTnfOVMqOsbxFYnaKsT39+yZBMC9vNjJt0xHkOl48hBgetbPuqNqEH9/5Vd
 jIqTiGWNH3XSTzV1JlowUFmBaCZOIuW8ytwDL3xOSejejrtoz0X+kTiZ7HS+aJQ7PE4M
 SvfQnxi/1zXoLaYJghwYRr/dYBsP9kgwluE6OctZtQrqSooIAMwngf7gC8Vu3LazMfq+
 zw8Se3I83SlwWCh1M8jMN+/RCPp0Wh9bku76o4vFF6mI0X/nIf9JGZcrEU/OFOz5oQK8
 H96Dj1ZlApxGUP+au2bFi2Pps39j5FISabWdyY+aAsBUCYuZWycJmvZGJXt4gF+4AYJk fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38ub4cnb60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 12:14:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151CAbv3049882;
        Tue, 1 Jun 2021 12:14:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38uycr8b7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 12:14:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 151CEI8U065031;
        Tue, 1 Jun 2021 12:14:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 38uycr8b7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 12:14:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 151CECxS013783;
        Tue, 1 Jun 2021 12:14:13 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 05:14:12 -0700
Date:   Tue, 1 Jun 2021 15:14:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: ensure return variable is initialized
Message-ID: <20210601121401.GY1955@kadam>
References: <20210527145048.795954-1-colin.king@canonical.com>
 <20210527170309.4d99bc31@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527170309.4d99bc31@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: W5IuRZZzOTQyTDaouT9Db3Ml8C9ASZZ7
X-Proofpoint-ORIG-GUID: W5IuRZZzOTQyTDaouT9Db3Ml8C9ASZZ7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10001 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=854 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 05:03:09PM +0200, Miquel Raynal wrote:
> Hi Colin,
> 
> Colin King <colin.king@canonical.com> wrote on Thu, 27 May 2021
> 15:50:48 +0100:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently there are corner cases where spec_times is NULL and
> > chip->parameters.onfi or when best_mode is zero where ret is
> 
>                        ^
> something is missing here, the sentence is not clear
> 
> > not assigned a value and an uninitialized return value can be
> > returned. Fix this by ensuring ret is initialized to -EINVAL.
> 
> I don't see how this situation can happen.
> 
> In both cases, no matter the value of best_mode, the for loop will
> always execute at least one time (mode 0) so ret will be populated.
> 
> Maybe the robot does not know that best_mode cannot be negative and
> should be defined unsigned, but the current patch is invalid.
>

People think list counter unsigned is a good idea, but it's a terrible
idea and has caused hundreds of bugs for me to fix/report over the
years.  *grumble*.

Anyway, I was revisiting this code because it showed up as a Smatch
warning and the bug appears to be real.

	best_mode = fls(chip->parameters.onfi->sdr_timing_modes) - 1;

The "onfi->sdr_timing_modes" comes from the hardware in nand_onfi_detect()
and nothing checks that it is non-zero so "best_mode = fls(0) - 1;" is
negative and "ret" is uninitialized.

regards,
dan carpenter

