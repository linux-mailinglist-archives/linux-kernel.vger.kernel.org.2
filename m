Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49030F163
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhBDK7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:59:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhBDK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:59:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114At134051786;
        Thu, 4 Feb 2021 10:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5Dl5uO0wuQ9Io7YroGP2O/XkHkibc2tH4ARZF9oPjfc=;
 b=KGHsn6yGxfavfKSIId/0eta1s1zHRZMQHrFXULbjClqi0vGXssKTv0aIFOSLVsOfw+xF
 lBibWjQvIJsV3lvtbTMCmqNE17vZ0F7X+1u9XVBpwR1hSWqgTBn3NcTJB6BhdwZ3ZDM0
 ULwXfiK8PXYD6BPr3bVnsK9YPuX0S2eM+USmrTGHgqjPhg5zS6lQe+uNwueFFotQUCZb
 JN3OnR/iWn3/veoJw5NSxlOEWLAEIA+EaEBvMIP4lwFWRFcPsQgYeOtvH0EFLifX2ulA
 gLaNHsJszMTBbFyiaPgmxrIdcBQqBS3Qj6ddawxw/mlBuXrd7RMxQ6Gv+/TexaCBPKZL bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm4mgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 10:58:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114At6hC066890;
        Thu, 4 Feb 2021 10:58:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36dhc2hc71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 10:58:47 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 114AwjDY030437;
        Thu, 4 Feb 2021 10:58:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Feb 2021 02:58:45 -0800
Date:   Thu, 4 Feb 2021 13:58:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH RESEND] mfd: wm831x-auxadc: Prevent use after free in
 wm831x_auxadc_read_irq()
Message-ID: <20210204105837.GI20820@kadam>
References: <20210129143724.GX20820@kadam>
 <20210204103724.GC2789116@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204103724.GC2789116@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040068
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:37:24AM +0000, Lee Jones wrote:
> On Fri, 29 Jan 2021, Dan Carpenter wrote:
> 
> > The "req" struct is always added to the "wm831x->auxadc_pending" list,
> > but it's only removed from the list on the success path.  If a failure
> > occurs then the "req" struct is freed but it's still on the list,
> > leading to a use after free.
> > 
> > Fixes: 78bb3688ea18 ("mfd: Support multiple active WM831x AUXADC conversions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/mfd/wm831x-auxadc.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Patchwork still can't find this.
> 
> I've applied it manually, thanks.

Ah...  You know what it is?  I normally use Mutt instead of
git-send-email.  Some of the patchworks have been hacked a bit to only
accept patches from git-send-email as a spam filtering method.  What I
do is my patch scripts add a header:

	X-Mailer: git-send-email haha only kidding

But because this was a resend, I didn't use my normal patch scripts and
just resent it from Mutt so it didn't have the header.  Something for me
to remember for next time I guess.

regards,
dan carpenter

