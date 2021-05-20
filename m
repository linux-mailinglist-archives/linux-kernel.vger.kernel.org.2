Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542A4389D22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhETFeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:34:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhETFeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:34:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K5WekN007192;
        Thu, 20 May 2021 05:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bHmW7DjTNy6mnGJ19G1OFrjB4TVUbzTCIrZYyW2E40s=;
 b=m5SUiBSCTzhw5ALz3vfD/SbrtUtw/j+4AJ5GDgILRPCR12UeuRF5kbsOx8mZX4S7+gYl
 LeNBF1mFh1ggbIn7FZFATAiJLWx59CmPj15G2Y1I5MSnU9VISdIWgv7TX+CHHzWGiWVB
 B6VK8bfIfB8KNGl7bNu8SlIzqZcf8aHL5HcbyjGSAi/J9bjg3mxJ9z29gy4qF0oOMGNG
 NaVT1XW7XYphALxbS5h25MK+Ivq2h8BEyWMWCuwjiQx59V642CPUCOctVc1jYDHau2yV
 Ghdx9dhsLKzYZ9ZwfydRXeiDdCu8n9TVMoCyNEJs0gKiCAxsomKMwzRgnx5n3rTqwbmu KA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4u8r9ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 05:32:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14K5Wdr8045790;
        Thu, 20 May 2021 05:32:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38n491drns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 05:32:39 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14K5Wclm045772;
        Thu, 20 May 2021 05:32:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38n491drnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 05:32:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14K5WY3K029263;
        Thu, 20 May 2021 05:32:34 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 May 2021 22:32:34 -0700
Date:   Thu, 20 May 2021 08:32:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Pratik Shinde <pratikshinde320@gmail.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] erofs: fix error return code in
 erofs_read_superblock()
Message-ID: <20210520053226.GB1955@kadam>
References: <20210519141657.3062715-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519141657.3062715-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 71ktOTSC9iypQgxVtPdqoXOLQuYrozob
X-Proofpoint-ORIG-GUID: 71ktOTSC9iypQgxVtPdqoXOLQuYrozob
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:16:57PM +0000, Wei Yongjun wrote:
> 'ret' will be overwritten to 0 if erofs_sb_has_sb_chksum() return true,
> thus 0 will return in some error handling cases. Fix to return negative
> error code -EINVAL instead of 0.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

You need to add Fixes tags to bug fix patches and you need to ensure
that the authors of the Fixes commit are CC'd so they can review your
fix.  get_maintainer.pl will add the author automatically, but normally
I like to put them in the To header to make sure they see it.

Fixes: b858a4844cfb ("erofs: support superblock checksum")

regards,
dan carpenter

