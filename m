Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38D73B2B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhFXJZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:25:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17570 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231706AbhFXJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:25:46 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O9B8GQ025126;
        Thu, 24 Jun 2021 09:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lov8V+Vjyvr+RBF5ChSNyLQ4F+hq/X+Sd43RHJy/9Jk=;
 b=eovpwKumNuoFx1GVxg2ek1OW/DhA4FSrrusGak7cpBPA6TK/J9BaQOjv3VjBuesnJb/A
 PSCoKH2C3kh2hlHhbeUKhY8tnGhSiFwN8QtYhwLDJY0PN0Uni+S3Yx/d5R1yj0HIySlO
 26clQhXb2n8L2ki5YRBYVRW7B5QvnKwMFilNELIXJsx5rQgdYY82OKVaM3RaJrqOv6JN
 3Z2EmqjbUemCGW/qerUhLT6WUrNStCfBqqRa+c6o+x407Qa1JbCElsUPk3TylbJLZFWZ
 AlL10b3pWzjasv9eevHVYbaRAG7ne08+6R1m/ZwdaLg5Y7zB8aO7c5fQHyPVTwBMi9gd hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c2wnjfmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 09:23:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15O9FkGv010414;
        Thu, 24 Jun 2021 09:23:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3996mgambf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 09:23:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15O9NNE2030866;
        Thu, 24 Jun 2021 09:23:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3996mgamb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 09:23:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15O9NLa8005798;
        Thu, 24 Jun 2021 09:23:22 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jun 2021 02:23:20 -0700
Date:   Thu, 24 Jun 2021 12:23:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] net/e1000e: Fix spelling mistake "The" -> "This"
Message-ID: <20210624092313.GC2040@kadam>
References: <20210622221938.GA30762@oatmeal.darkphysics>
 <20210623191245.GA32122@oatmeal.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623191245.GA32122@oatmeal.darkphysics>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 5Yhm448BNh0VNS-B5EHCSDvT9HXAWRGt
X-Proofpoint-ORIG-GUID: 5Yhm448BNh0VNS-B5EHCSDvT9HXAWRGt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:12:46PM -0700, Tree Davies wrote:
> On Tue, Jun 22, 2021 at 03:19:40PM -0700, Tree Davies wrote:
> > There is a spelling mistake in the comment block.
> > 
> > Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index 88e9035b75cf..ff267cf75ef8 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -7674,7 +7674,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >   * @pdev: PCI device information struct
> >   *
> >   * e1000_remove is called by the PCI subsystem to alert the driver
> > - * that it should release a PCI device.  The could be caused by a
> > + * that it should release a PCI device.  This could be caused by a
> >   * Hot-Plug event, or because the driver is going to be removed from
> >   * memory.
> >   **/
> > -- 
> > 2.20.1
> >
> 
> Adding linux-kernel@  

That's the wrong list, and also the patch can't be applied because it
has "> " at the start of the lines.  You need to resend the patch, not
just reply to it.

Use ./scripts/get_maintainer.pl to find the correct CC lists.

regards,
dan carpenter
