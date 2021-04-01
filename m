Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC821351162
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhDAJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:01:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43052 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDAJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:00:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1318wouB071849;
        Thu, 1 Apr 2021 09:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=CGkPXPPHpmlF1CktlWv/KooP+Kf2+sLKW+hJlQZ63QM=;
 b=uQWRsIQecYnbeUwf+EBYy4ejFKeyZTeLbpVEgV8ZCKSpg53yxi5xSNjokSwQGMmEuXa3
 nUq0JyGpklpqrRuDqNuU6pDTbHsa4JdHsyjwYm94QOq7KfuHHIHS6445XOvshB8sdiOJ
 L2r8jDL8tWmlFBPinrAhqlePD157yeKA667JdBtznjiO8MSDMEqv+C1ki7Dkmr/y1zZt
 CXqzepE8PUiaWQAB8FEIWoDxpMC5xRrawY3/g4cCIOrNHB5/8Dh8e1Jcg6121DjL9B6j
 bLHsHGWqwdzcnUdJtZuYsfoE3+y0XwPpzo9JdSDGfzWfmaD7OEFJJv/yzyyke8t4GoJr mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37n33ds1eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 09:00:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1318ti4b043749;
        Thu, 1 Apr 2021 09:00:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37n2aryxdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 09:00:49 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13190mNd027839;
        Thu, 1 Apr 2021 09:00:48 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 02:00:48 -0700
Date:   Thu, 1 Apr 2021 12:00:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbusch@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [bug report] node: Add memory-side caching attributes
Message-ID: <YGWLtzMLqSW4cxma@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010063
X-Proofpoint-GUID: vqzIBXprIwB4fcWmwErknLt8mEbyDy8v
X-Proofpoint-ORIG-GUID: vqzIBXprIwB4fcWmwErknLt8mEbyDy8v
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

I've been trying to figure out ways Smatch can check for device managed
resources.  Like adding rules that if we call dev_set_name(&foo->bar)
then it's device managaged and if there is a kfree(foo) without calling
device_put(&foo->bar) then that's a resource leak.

Of course one of the rules is that if you call device_register(dev) then
you can't kfree(dev), it has to released with device_put(dev) and that's
true even if the register fails.  But this code here feels very
intentional so maybe there is an exception to the rule?

The patch acc02a109b04: "node: Add memory-side caching attributes"
from Mar 11, 2019, leads to the following static checker warning:

	drivers/base/node.c:285 node_init_cache_dev()
	error: kfree after device_register(): 'dev'

drivers/base/node.c
   263  static void node_init_cache_dev(struct node *node)
   264  {
   265          struct device *dev;
   266  
   267          dev = kzalloc(sizeof(*dev), GFP_KERNEL);
   268          if (!dev)
   269                  return;
   270  
   271          dev->parent = &node->dev;
   272          dev->release = node_cache_release;
   273          if (dev_set_name(dev, "memory_side_cache"))
   274                  goto free_dev;
   275  
   276          if (device_register(dev))
                    ^^^^^^^^^^^^^^^^^^^
   277                  goto free_name;
   278  
   279          pm_runtime_no_callbacks(dev);
   280          node->cache_dev = dev;
   281          return;
   282  free_name:
   283          kfree_const(dev->kobj.name);
   284  free_dev:
   285          kfree(dev);
                ^^^^^^^^^^
   286  }

regards,
dan carpenter
