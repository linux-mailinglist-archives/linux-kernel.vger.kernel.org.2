Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A83973B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhFANA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:00:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53452 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhFANAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:00:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151CtEl8022507;
        Tue, 1 Jun 2021 12:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=k9gZ/x/FrYyAyY2znziCK+W8/UgWcWWFHLXHMDMnlhc=;
 b=yM/Xl3isO4wuRiipwtzRApavPqo5FyoAXMUMFOCNnPRT7DLqG9q/5JC7PFxoHa7LXyHi
 1vXp+XRzNtxKvx3r5AoWelT7J11cmwev3yBzbW1mfaI1HYFfFfl5oQ5/NEh930RzZ/Fk
 3qVR1BjzWZhd1Z0u8b5Ejd3g4J9u401q5kVSw8d+UbUZuSh5ljnUNkPw8NHXYBMtLO1x
 8ntplJ1zXPBU8jPlQJUiTwqHmXvlTyneYQsDvv10Rqdw9lHyAjFnHYTBxf2DaVP/lRU/
 o0dzxE2R24QqHoMbyS2inypKJ18PzDJAE5Qpmus3F56OnsM+ZxGF0oDfL88vz6zI3Z+S 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38ub4cnehm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 12:58:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151CtDaA093932;
        Tue, 1 Jun 2021 12:58:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38ude8uen0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 12:58:35 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 151CwYsP119096;
        Tue, 1 Jun 2021 12:58:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38ude8uem0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 12:58:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 151CwVom016588;
        Tue, 1 Jun 2021 12:58:32 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 05:58:31 -0700
Date:   Tue, 1 Jun 2021 15:58:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: ensure return variable is initialized
Message-ID: <20210601125819.GZ1955@kadam>
References: <20210527145048.795954-1-colin.king@canonical.com>
 <20210527170309.4d99bc31@xps13>
 <20210601121401.GY1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601121401.GY1955@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: UiVjigSNNY-G05jAa1HIU_SZIbW0wDYm
X-Proofpoint-ORIG-GUID: UiVjigSNNY-G05jAa1HIU_SZIbW0wDYm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10001 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=991 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:14:02PM +0300, Dan Carpenter wrote:
> On Thu, May 27, 2021 at 05:03:09PM +0200, Miquel Raynal wrote:
> > Hi Colin,
> > 
> > Colin King <colin.king@canonical.com> wrote on Thu, 27 May 2021
> > 15:50:48 +0100:
> > 
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently there are corner cases where spec_times is NULL and
> > > chip->parameters.onfi or when best_mode is zero where ret is
> > 
> >                        ^
> > something is missing here, the sentence is not clear
> > 
> > > not assigned a value and an uninitialized return value can be
> > > returned. Fix this by ensuring ret is initialized to -EINVAL.
> > 
> > I don't see how this situation can happen.
> > 
> > In both cases, no matter the value of best_mode, the for loop will
> > always execute at least one time (mode 0) so ret will be populated.
> > 
> > Maybe the robot does not know that best_mode cannot be negative and
> > should be defined unsigned, but the current patch is invalid.
> >
> 
> People think list counter unsigned is a good idea, but it's a terrible
> idea and has caused hundreds of bugs for me to fix/report over the
> years.  *grumble*.

Imagine if best_mode were unsigned int (and the loop ended on > 0 so it
wasn't an endless loop).  Then instead of a no-op the loop would iterate
4 million times.  Each iteration would trigger the WARN_ON()
onfi_fill_sdr_interface_config().

I think people believe that the compiler will warn them something like:
"warning: Assigning a subtract operation to an unsigned!" but the
compiler is never going to do that.  Unsigned is just a declaration that
"I'm never going to be surprised so let's make this stuff more dangerous
and fun!"

There are times where it's appropriate, sure.  But it's mostly unsigned
long which is correct instead of unsigned int.  If you were to draw a
number line from 0-U64_MAX then the band between 2-4 million is quite
skinny and a long way from the zero.  There aren't that many thing which
fall into the band.  Most numbers are smaller, but once we start talking
about millions then 4 million is very limitting so we would want to use
a 64 bit type.

regards,
dan carpenter

