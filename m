Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9773B39EE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFHGMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:12:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:12:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15865ILv046020;
        Tue, 8 Jun 2021 06:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VoWhBhCzotbyXNC47dREQCZMawQAjdOiikROgwHHh2U=;
 b=gcgvYo4LGQeyA22gJep9M64lKK+RQeGoU8Da3HL+CIJ402CBtHhBgDSKOYGJUl6AWSlX
 s9B2MYFKQBjzEUdX1Jkl4RioGwg1EruRU/4i0ciVveCSKhwqI1BrxHXOOja1dy8c4qO3
 oW04rEvGQLfLaVqhTSFlp+7uQ8BevMBBlbn6kcSKI2J9Yv6Nm457Lg/k6LmETg1ZWtqL
 IVdsqc267uC0oG1VwSLXTti+Tu/0EZRd3KJy7jt7jHQDNf0PsKAGtMssB5POstuXD/Xk
 g0DsJd5WhnklRHOzjhlajmITFvEXkyCRkRMs1BF3qiVJp0G2GxNshad+AxWgEzCOWsiY zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3914qukdg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 06:10:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15864pDp093786;
        Tue, 8 Jun 2021 06:10:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38yyaamgax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 06:10:31 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15866Hlq097531;
        Tue, 8 Jun 2021 06:10:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 38yyaamgar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 06:10:30 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1586AQEo017539;
        Tue, 8 Jun 2021 06:10:28 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 23:10:25 -0700
Date:   Tue, 8 Jun 2021 09:10:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: ensure return variable is initialized
Message-ID: <20210608061018.GY1955@kadam>
References: <20210527145048.795954-1-colin.king@canonical.com>
 <20210527170309.4d99bc31@xps13>
 <20210601121401.GY1955@kadam>
 <20210607085711.65c64c58@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607085711.65c64c58@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: _rJQgIOyb3G8Q7kF3RSqPX5T5W3Mu3q7
X-Proofpoint-GUID: _rJQgIOyb3G8Q7kF3RSqPX5T5W3Mu3q7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=904 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 08:57:11AM +0200, Miquel Raynal wrote:
> 
> In the ONFI specification, the sdr_timing_mode field is defined as
> follow:
> 
> SDR timing mode support
> BIT  VALUE MEANING
> 6-15 N/A   Reserved (0)
> 5    1     supports timing mode 5
> 4    1     supports timing mode 4
> 3    1     supports timing mode 3
> 2    1     supports timing mode 2
> 1    1     supports timing mode 1
> 0    1     supports timing mode 0, shall be 1
> 
> IOW sdr_timing_modes *cannot* be 0, or it is a truly deep and crazily
> impacting hardware bug (so far I am not aware of any chip not returning
> the right timing mode 0 value). Hence my proposal to turn best_mode as
> unsigned. I honestly don't know what is the best option here and am
> fully open to other suggestions to silence the robot.

If the hardware is broken we should just return -EINVAL.

regards,
dan carpenter

