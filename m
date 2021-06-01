Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757573971BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhFAKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:45:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56778 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhFAKpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:45:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151Ag0uY029859;
        Tue, 1 Jun 2021 10:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Gx79InivmVewarDJyyMOVuflbWM4unS5ErB5h13b2Lw=;
 b=gB+WLL32hgD4VzXFy1XC5N3VAJUPyY2GBN9nXi8S5ZZozIwng/PV/N7iipnoRHupUwiV
 gsxJ+5FZCfCnHYsnfh2h4Aos8UtQq7xVY83znarvvFf6Bhi1T7HdmeFik4ceTdLBkPIz
 w0EvYCpC1lbFNCoHJ3dYCNo1eT5n6fM7mGhpqgpd9cgXfScdXPCZQbKbMSC2RV12NgzO
 zJ23bzCAquQslCy6ONKWuw3hkOAnmieS8T3i/wQTM8FXWARfQ38FzPny/Z/mKF7FIe7f
 2Gms6P/aMqcWuVn5faE2SS30+WquZyIwySlx6sIKDNSt2pNKxFLHuO7t3ejfUTkdPi1N GA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38vjar0js1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 10:43:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 151AhmAG003720;
        Tue, 1 Jun 2021 10:43:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38ubnd3n98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 10:43:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 151AhmgW003708;
        Tue, 1 Jun 2021 10:43:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38ubnd3n92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 10:43:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 151AhkJL013285;
        Tue, 1 Jun 2021 10:43:46 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Jun 2021 03:43:46 -0700
Date:   Tue, 1 Jun 2021 13:43:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm: thp: fix a double unlock bug
Message-ID: <20210601104337.GX1955@kadam>
References: <YLX8uYN01JmfLnlK@mwanda>
 <20210601100849.GQ3672@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601100849.GQ3672@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Qpm2tEc2qMH89MRHSfhoULSDgCa0t8Yn
X-Proofpoint-GUID: Qpm2tEc2qMH89MRHSfhoULSDgCa0t8Yn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:08:49AM +0100, Mel Gorman wrote:
> On Tue, Jun 01, 2021 at 12:24:09PM +0300, Dan Carpenter wrote:
> > We're supposed to be holding the "vmf->ptl" spin_lock when we goto
> > out_map.  The lock is dropped after if finishes cleaning up.
> > 
> > Fixes: 9aff7b33c74a ("mm: thp: refactor NUMA fault handling")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Ouch.
> 
> Acked-by: Mel Gorman <mgorman@suse.de>
> 
> However, that git commit is not stable. Instead of Fixes: I would
> suggest renaming the patch to "mm: thp: refactor NUMA fault handling
> -fix" and replacing Fixes with "This patch is a fix to the mmotm patch
> mm-thp-refactor-numa-fault-handling.patch". Andrew usually slots that
> into the correct place in his quilt series and collapses the fixes before
> sending to Linus which works better with bisection.

I know that these normally get folded in, but I assumed that Andrew
would want the Fixes tag so that he could fold them in automatically
using a mutt alias. #OneClickShopping

regards,
dan carpenter
