Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA49353359
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhDCKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:05:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33720 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhDCKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:04:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 133A4j0o070930;
        Sat, 3 Apr 2021 10:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DR3kMcIERBD5ZDWaTiYiYYL6h7b0SaMEVWUxDGaiv7E=;
 b=Ek8XPUZR0qeBlT3n2niXGvSrM6f1R6F5qWCTJjqlAvx3JVGXthfLDqqvVYjkTywV1x8j
 Ab17hpjJKJKm33Cah043qJHkBw6c87egNSLNQOnGOKqUxY7qzWbmQVJRNfNMuBfUi7G3
 yMhDCZzXCE8NR7MlFtc+plRnU69KdoXhdrLppQ0kP+CWW1nJiAgNbTKx+usKxdzIexKu
 kZMru9cb2feP2WseDffO0OStx29VUIzxs39Y0uLAVw3TpQlUOy7HEDtiYPhZ05JCREQu
 rlE7E/uEnvYP+ZhD2Z/v4akgCnGamvfWg5/WMXo5oiBBAF15xdY08uHNUmBOqsqFH4xb Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37pgam8atr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Apr 2021 10:04:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1339j3pl178658;
        Sat, 3 Apr 2021 10:04:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37pg616t0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Apr 2021 10:04:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 133A4gqb029456;
        Sat, 3 Apr 2021 10:04:42 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 03 Apr 2021 10:04:42 +0000
Date:   Sat, 3 Apr 2021 13:04:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/30] staging: rtl8723bs: tidy up some error handling
 in core/rtw_mlme.c
Message-ID: <20210403100434.GX2065@kadam>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
 <d8ad88bef77430107f8593091770b6a514b6f0e2.1617440834.git.fabioaiuto83@gmail.com>
 <20210403094247.GC1563@agape.jhs>
 <20210403095029.GD1563@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403095029.GD1563@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030064
X-Proofpoint-ORIG-GUID: 1Id9So8mZg97cBxcupyyoWHxWhPhNhFo
X-Proofpoint-GUID: 1Id9So8mZg97cBxcupyyoWHxWhPhNhFo
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104030065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 11:50:30AM +0200, Fabio Aiuto wrote:
> On Sat, Apr 03, 2021 at 11:42:47AM +0200, Fabio Aiuto wrote:
> > On Sat, Apr 03, 2021 at 11:13:38AM +0200, Fabio Aiuto wrote:
> > > the RT_TRACE() output is not useful so we want to delete it. In this case
> > > there is no cleanup for rtw_cleanbss_cmd() required or even possible. I've
> > > deleted the RT_TRACE() output and added a goto unlock to show
> > > that we can't continue if rtw_createbss_cmd() fails.
> > > 
> > > Suggested-by: David Carpenter <dan.carpenter@oracle.org>
> > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_mlme.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > Hi Dan,
> > 
> > I put a Suggested-by tag on one patch in v3 patchset. But reading the docs
> > on submitting patches I relaized later that maybe it requires your permission before.
> > 
> > It' written about Reviewed-by but not about Suggested-by, should I have asked you before, should I?
> > 
> > I'm sorry if I should have.
> 
> Found it, I'm really sorry
> 
> A Suggested-by: tag indicates that the patch idea is suggested by the person
> named and ensures credit to the person for the idea. Please note that this
> tag should not be added without the reporter's permission, especially if the
> idea was not posted in a public forum. That said, if we diligently credit our
> idea reporters, they will, hopefully, be inspired to help us again in the
> future.
> 
> I wonder if in the case of this patch was needed this tag..

Yeah, it's fine.  It's all on a public list so it's not a secret.

regards,
dan carpenter

