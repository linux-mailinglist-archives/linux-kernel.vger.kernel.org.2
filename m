Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253B0393147
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhE0OrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:47:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34284 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhE0OrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:47:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14REdj7t028496;
        Thu, 27 May 2021 14:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/18rGlo89bBRkqWF7xirF/2+WnB22rnW41V2JQDgTlo=;
 b=ccfGkehcYESaobmG2ep9GqmjF1FY+NILYxPPOVNe+9VPxze8mEcRRlm1yN0n4q1iMUOT
 51aOjNhymtIgVQUPDs1NUKXjkBRdTV4UuTMfnhItQF1JUx2qgK+UjDhr18NgPUhTpKlh
 9gQwhfdcNz9C2SGlpAdVnm4HaKJ2EXAe9uGz4CNgweRzOQb7jZJ4sB3OZ90hCdXwylqc
 f6Ob/7OBy4t9KjTIl9OefR9zjU2xyl1axDyRXvdm1yegmaftwor+MfDY6/9jXgwVIeWV
 Ey1UsVHZV9Cvz9gYLee4Nx1rUJjRjeIyZtHHWY5PhtRnXhB9qx8qVZqD6PVP4/OpDEZs Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38rne47y3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 14:45:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14REeJwk112760;
        Thu, 27 May 2021 14:45:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38qbqud3t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 14:45:45 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14REjj3I126582;
        Thu, 27 May 2021 14:45:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 38qbqud3st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 14:45:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14REjirx018098;
        Thu, 27 May 2021 14:45:44 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 May 2021 07:45:43 -0700
Date:   Thu, 27 May 2021 17:45:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn:
 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.
Message-ID: <20210527144528.GM24442@kadam>
References: <202105271713.TLhpzN7N-lkp@intel.com>
 <CAJKOXPdkDe1iNpZa9X0eRyWO85WBWuhRk-t=ENqkRk3p0=-LuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPdkDe1iNpZa9X0eRyWO85WBWuhRk-t=ENqkRk3p0=-LuA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: tU20AmO6DfkZOaD2EODRvTtl7R6CnrRk
X-Proofpoint-GUID: tU20AmO6DfkZOaD2EODRvTtl7R6CnrRk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 10:36:42AM -0400, Krzysztof Kozlowski wrote:
> On Thu, 27 May 2021 at 05:31, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hi Krzysztof,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   d7c5303fbc8ac874ae3e597a5a0d3707dc0230b4
> > commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
> > config: s390-randconfig-m031-20210527 (attached as .config)
> > compiler: s390-linux-gcc (GCC) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > drivers/memory/fsl_ifc.c:298 fsl_ifc_ctrl_probe() warn: 'fsl_ifc_ctrl_dev->gregs' not released on lines: 298.
> 
> Thanks, I will fix it. I also see some more leaks there...

Oh, yeah?  Which ones?  I will add it to my table of alloc/free pairs.

https://github.com/error27/smatch/blob/master/check_unwind.c#L43

regards,
dan carpenter

