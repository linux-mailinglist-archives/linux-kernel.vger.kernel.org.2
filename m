Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2B35189B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhDARqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhDARii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:38:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854ACC05BD30;
        Thu,  1 Apr 2021 06:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDa6tAxlEibaaxxkyQAVVtxfdOEz2uvZdSKhQIUwj8AXTp1LhXZmvBIgpqDTMdtPHhFJQTiyWvbPGgdwbvhPjj4mUhyvJAWLjyMuhqJU/Nt9oF7UM2dkcuyUqu1zHNse4ISFBiZjk0LAegzE7033y+gBsTz1l94SzeD4vbAEaa+ZB1myF6vLG0iNlOZN6ryXrmA7gX1/jQ1WwWE9OUZ0dINbHQMBZQaqiR2jnTlEFLyvr+0CisFNwd+lPTkJsIMlM7OHYfJY9X3TRTBfdaByO+oqLgwl1JUi6V83i6FfkSgnXjEXq6Yr3NM9OR+N58O+0HOYlszUL0+53pGi9xolnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+Ualula6cZURnqRGKcb4Xa3gs6XcXPqiGJQSNghHZQ=;
 b=SAjLjHyMYtqcJd2GrCzQt6gjF0QZbMaIbRo0xxxksiy6PbmI1wV03weyPimKk/dMc3Ku7qTKWYxPvQFNJcZK3qj8EynuhyrI9pwwt4Mi77kXh65AKOYxD3BxueUGE7NstEX8F81XUodgjspUwM2ldvq9NbBCMnxSROjEyu0OnJyxNq73vdHvCkq3VWK/riVpzUfhM2kWFzj0VW55unFdjtUhLhb5BbAgd8orX7fuLfgqHIHKICPSk/ifJZatY6D1ozO644wvN3YTTxYvPVmtq3YskKoJM6AdODYodrF2RygEdjoEn0aFX+WrZRO2tSXAjx6y68TMfM2BIRFb14fhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+Ualula6cZURnqRGKcb4Xa3gs6XcXPqiGJQSNghHZQ=;
 b=lObAt72rzTBvfjv0qO5xJLY092lRGdCXEvcVE2nDeY879E6yt0l/XLkyhOPj9wluwghE9gog7Wko5UmUzIVBfCCaR+r8wGNY/f6b7RsCZSwqTOxrexv/tl4s3MRW3tmxuYuqz7nRqBGZWh1vqyIiI3HkmTPTrwomoOXq/JN64KuGbenUwJ5pGKS5ZNCela9tcZjZNggo4IoHR1fpBKJUW6H0TOaVoz2oS+mn09gVUpVZUXTQd1TQAzX078q7QtVN1wRnJqX4RwdhCrWFbjtMa271yIWgppENzR1QvBDnWLgKz8gqd1RDM6L7I/07q5HbsFMy04CVA+n6aSWMhwse4w==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 11:25:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 11:25:13 +0000
Date:   Thu, 1 Apr 2021 08:25:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbusch@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [bug report] node: Add memory-side caching attributes
Message-ID: <20210401112511.GV1463678@nvidia.com>
References: <YGWLtzMLqSW4cxma@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGWLtzMLqSW4cxma@mwanda>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:207:3d::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:207:3d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 11:25:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRvRn-006ilV-NW; Thu, 01 Apr 2021 08:25:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10c02ae6-9e78-4661-3cc4-08d8f500d15f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3596F208CB9D6A26D2994685C27B9@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWpvs1dfIO2H9ZwCkCdccdOjO35fC1jOgvzPw6w3HN6BeBlPWQNe54uvBlMHAZuNE9zdgD1RsKiuQm964/ZAb8tVRWQwlxVBtiKkjUdhuLjaSv5RF/nmBGY7nUYwOWrFXxYRoKv7Q9ot+2i4+HPmQ5STeZbbgXz8u0o+2BIdIBlyWYAT3pRazDIPNsqoLPVtl3tE7iV2JuqgRXvKa4jZApP7ohRq5EOEcuhH84ynTAJ/w8P5GIvt3bXGCg2GiZJ4OrtWBZrZraDsJ/W4EMvGzUZmPZgyhexFrnAhhcQqN8XeiSRk++ktqv4NraTkw6BNGclBueSt75VdrS8dOdIu8c2Izg9iU2Ef1YVskBoEkHOh5/YREV49ggs8Xi8q2xjHY0EaCXQosO+/HedE0PJYN79FxTsnjT7JgGo/mybV/5bruGmyreDDlzyVWCu+3R4s9OL4wklIYb4H08pJANCjsCi4OjR/hJcvc8UJbnQUbwVkdZgP0WBPCPl5dF21O2QgTrT1M9045XzFV2Jr68/eGaam/jc0wYMVBFA2eWAUHzUHjDgEETfEOEYAyWM6EsVsyYIUYoEhHljUohiJL/ibACq+bPbDiFvkojyJQW7Cru3on8VtTl+KxxSqoaGwUmRFqCgtGUMPcr4EWS2YP8XKZVR2tL0Ka2qpuJ71D2hfPoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(2616005)(66946007)(9746002)(66556008)(66476007)(316002)(426003)(478600001)(6916009)(186003)(1076003)(83380400001)(9786002)(36756003)(2906002)(5660300002)(8936002)(4326008)(33656002)(26005)(86362001)(8676002)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+QotSRA3eWMUy9I/h2xuQ8ep1MI1ZYmN9zY9PxXseHQx9NyY/qHgxPfDcfEm?=
 =?us-ascii?Q?BEg4S+so6r5HVuwiGgtEMbKUYxAXil/+ihWXkGiN03/IMIPtcbX7ZciZc2DO?=
 =?us-ascii?Q?QRdGLEwHdYKImZQfJYMwoLHbnJ2n25hu//O5ET2phwK/5+28y7Nn5DpbTeUa?=
 =?us-ascii?Q?YCufCdmkkLELy1eFMxUgdspucnp2jH7s2tauYaYGA/q2R1UtfYZnp2Lezpez?=
 =?us-ascii?Q?kJHZ/Ze5TYIGgP9jfVzxGussy9eyghw60gSZS6/xU3dUu3V8bEEobe9i91EU?=
 =?us-ascii?Q?lgJIqSsST51oFpqw5WwEcZK9CbcWTYvFfXqAezlhycR3RcC616mQVsg32+mX?=
 =?us-ascii?Q?e/iEVMDfdeAufpmalQ3hPFh4Gfkhj+G0HcJ/J7v7WrCIjQ5kAulLegD3+iV+?=
 =?us-ascii?Q?OtABhlEpT5pX0IC22DGUKJiSyA+LHlLlqv3QfUxqfgT0GOmly1f1gEWitbLU?=
 =?us-ascii?Q?r3Num2tP84ApCaDCDZNIjRE2svj15r5lviM0Agm2WwVvcnBxKjdeLot+WjjX?=
 =?us-ascii?Q?dMGvHgzka8qbjY+LxP5QCl9lrdzZJyLEFbfwBUo//p4TwlWcRmkRpGVvk5kO?=
 =?us-ascii?Q?NdahM5cKdjeqGYBf4wctkwl0T0OiR+GOSVkahuIGdV3bUozfIoO31Y7Rdlgb?=
 =?us-ascii?Q?WrjTp2rVWlAliZFWKB5EzT0qeD2W8trcDMvp32+VNPThMGm3YbCgsEmBcvw+?=
 =?us-ascii?Q?uCKKHs1Yyk1bzbShPoLzrsPTFiWjIU8fxif3F6U6d0ZgN22K9p+nYDFs4Trr?=
 =?us-ascii?Q?wXPU/jNS41giBfp9Rvn/EEbzP3rxyhmGXBjXhXQieLoRs2nmgwFO2Zc4dYA9?=
 =?us-ascii?Q?G1wfqME05ATRxuXrWiSlH9KtkTqSA5oM9lyw12yd2vgoa8PwgKWPtooqt5n5?=
 =?us-ascii?Q?a56EcT54IQ94+leNPdqrSBZIrmKwv1p7KKfIl4izeTMCDMM5gVMS6vcFwbu+?=
 =?us-ascii?Q?jKohjyz3Mk8aH1uHVhiWHvMTQVgQg9IQfXEabBb1Odhzn+YAEX8mrRfbAfEF?=
 =?us-ascii?Q?BMmLhvSvqhQ6rdax89xL5mo0w2XWzTUhO72fUliavls46sTVQgqLR+E/sr67?=
 =?us-ascii?Q?3CxTwgC/JmZHMhnePYJiOSOIIgZoMPXIOPKIKWj/E1qokZ30R1P0MiGrpZc+?=
 =?us-ascii?Q?v7/PYUe9aQyn9xrPvto043eZhg8BZW3Ca8sHA8Pgz39RZC8TByhm/jSMHPPc?=
 =?us-ascii?Q?51tHeh7/rU2xFvSrLUsnEmbrFXrBnVaisZjdcxYoyOe0raYtpLm7lbNycIi+?=
 =?us-ascii?Q?00fdCt+VLS9Kr3jHhuKYHYPDrfu7LLzgtFn0wHtWtiUlDdgOT0al2T8FZUDq?=
 =?us-ascii?Q?EOJI0j1vYyPM5zEPOug5ALWQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c02ae6-9e78-4661-3cc4-08d8f500d15f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 11:25:13.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IWoTcxukYrqWKMkoUQalcfKJB3DFTM6kxht+hldOc2qNhTcE677Nz2XcAEK+4Ut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:00:39PM +0300, Dan Carpenter wrote:
> Hi Keith,
> 
> I've been trying to figure out ways Smatch can check for device managed
> resources.  Like adding rules that if we call dev_set_name(&foo->bar)
> then it's device managaged and if there is a kfree(foo) without calling
> device_put(&foo->bar) then that's a resource leak.

It seems to be working from what I can see

Also I wasn't able to convince myself that any locking around
node->cache_attrs exist..

> Of course one of the rules is that if you call device_register(dev) then
> you can't kfree(dev), it has to released with device_put(dev) and that's
> true even if the register fails.  But this code here feels very
> intentional so maybe there is an exception to the rule?

There is no exception. Open coding this:

>    282  free_name:
>    283          kfree_const(dev->kobj.name);

To avoid leaking memory from dev_set_name is a straight up layering
violation, WTF?

node_cacheinfo_release() is just kfree(), so there is no need.
Instead (please feel free to send this Dan):

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb2c74666..89c28952863977 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -319,25 +319,24 @@ void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
 		return;
 
 	dev = &info->dev;
+	device_initialize(dev)
 	dev->parent = node->cache_dev;
 	dev->release = node_cacheinfo_release;
 	dev->groups = cache_groups;
 	if (dev_set_name(dev, "index%d", cache_attrs->level))
-		goto free_cache;
+		goto put_device;
 
 	info->cache_attrs = *cache_attrs;
-	if (device_register(dev)) {
+	if (device_add(dev)) {
 		dev_warn(&node->dev, "failed to add cache level:%d\n",
 			 cache_attrs->level);
-		goto free_name;
+		goto put_device
 	}
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&info->node, &node->cache_attrs);
 	return;
-free_name:
-	kfree_const(dev->kobj.name);
-free_cache:
-	kfree(info);
+put_device:
+	put_device(dev);
 }
 
 static void node_remove_caches(struct node *node)
