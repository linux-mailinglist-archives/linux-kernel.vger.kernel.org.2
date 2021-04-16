Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EA3628B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbhDPTgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:36:04 -0400
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:18050
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235029AbhDPTgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQvmObWUvyWkHZ8yRacdOR9UNoeuhWIS8gIdLfRZg+gRcLPUYHwAcM9iXjcplvT/AyUcLDeS1kYuQaQmVzgMWOB1ka5ORpPdv6PglZixbRQKKf189xP0yrkVFsG7it6iYVRpdhN2/x2sL2l5FMNUX3swd+SeeSF06RLnWsuN4Q9+uWmO7gt5kIVry7+9NRLoEqR+ZRDHKFqKOfnJFjDXzZGhdj07sZJf5leGysvuWRcMQkNOwxL1stLV97vvwvNaQeT51Ezhh7Z0C5mvWaiMwzW+tX8DrSH/1iRxwmQZwTqcWacgLyT6mvAdTfMZ1tZMtV2KCnToDefnCGeqOea0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuTZ7gDVDAj73oyxLhQo6Iyr7ZqIB4LSvsBtII7iXrY=;
 b=DhJec2rzNBz99lxj1j66vR6b/kDeT3zbLDsoxo6DHqf8WAktNS/sPTGtqW5W8sG2LJk0Z83HMXWXe0vZXM4ibpW41wUfqWMz3wrvbQswiqOQ8UyspDslLvadWTH91dS3T0w5xjVqlPIpUUx95cx5V1Et+528Etxc0NDLLzFwCaAUQDUmaoEzJ2dJgR+zCBj2B80pZuHhnkWHDNUxoLqADr397ffGkjMufdPeWkoWBnMsbkC2fnROs7KRYxZlJQqpWwL8vndLZsdHHlMO3oXSyualwKcYOEsoUd4jsISM6qbLspl1ZIeONfOUMLdI/qoLrDIxdbSigTLDoylNCahcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuTZ7gDVDAj73oyxLhQo6Iyr7ZqIB4LSvsBtII7iXrY=;
 b=dYKFHGT4zTtclE9op24K0B8DGCOWrH4HK1NM46wJL7WvjjSzTbYBIpcey0FFPx1bQHLZZN4n7fAjsgx2/LPhUxUcFKcnFtUDgvZZt0zgQgj6UGQAu1xz9BlEK5gSrDZKkHPqv7zcIMqAAPkfCXsCVVZnBe/sGSrFWuB/WzNZBa62OZzx1XGvyDO0COilBP4eEzIrB+FgdvEdSzRNqHeDlW513R8iICWASWLM1ePsCbG6C6lvQ89RQufVsvN5fCfyCeRinZDgnOx6diCpf83occyDmIPKxwdlb2/8mwQtE4me0xzhdE9HdcRHq4S8vl0S8wrxW2n3JFpNyaOclxVdug==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 19:35:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Fri, 16 Apr 2021
 19:35:36 +0000
Date:   Fri, 16 Apr 2021 16:35:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] node: fix device cleanups in error handling code
Message-ID: <20210416193535.GO1370958@nvidia.com>
References: <YHA0JUra+F64+NpB@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHA0JUra+F64+NpB@mwanda>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0379.namprd13.prod.outlook.com (2603:10b6:208:2c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Fri, 16 Apr 2021 19:35:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lXUFb-007Poz-7S; Fri, 16 Apr 2021 16:35:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e1bfb1-c16a-427b-847c-08d9010ecf17
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12434B14C1CC6313BEC45B7FC24C9@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+wtOTj8COcFLugjSnehPaqvqtw25VSN8m3q4AD30c86FJb3zOLJLDJpbK/Ueh6IGMZA6+9dMDBLIE0Yb+YLlSjhmSubhwlpPyj7X9SaLTKa+SF3auZ0ma/dKpf0Akqy7lK8KMdwdXMv1QMDwjEgJolfPg/S6xE20lQ4zfLQgWoOIYoh3fgXCkJIwRb0HuaSHw63lUv5P5pWyqIG9P2DJuyVQnFsH13pP9bvosQbpgBjTXxAvEStMDR7Ns8fjQiwPPuvzWEcnz+7fS5Zo7C3Ovck+UN4Mz6WWmbJHX4lJla11JHZ3i3sG4l8zySamz2fEVXONCJlnqnYmbDGN2U9DKQIKsdFfQb+GJU6nOqln9F8fLVA3pTf9Sz+FLWZSl7omzhIzfhvrgNUAKTJ4ng7bYRn+k71Qe7xuvnQaC60t1SheXM/M4ele5AY4euS5GL8wTXc+s0oteawv+TGAWcq+tnGmx21E+EcFbs653sLtr06vnOGxqHg3VeU4yJth76xRm5p/RMbjUTO4lEOq8dGWvapF5K596bP9XC/c1+FX+f7uHVptDm98OddWghq1ahYurqXOGtMoSu9IpdReaYlU2Us67BjmzZVWA4SXwp30so=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(36756003)(5660300002)(9786002)(9746002)(8936002)(66476007)(86362001)(8676002)(186003)(66556008)(6916009)(38100700002)(66946007)(316002)(33656002)(426003)(26005)(83380400001)(1076003)(2906002)(478600001)(54906003)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T/+4Q6R3Bl+Hk0UwVo0V9qvK9TEPo85q+4RkLyb2534Zbq3dk3nFdOEGmzbB?=
 =?us-ascii?Q?IRloDHFWvaDDfVjqQJ/JvvqIFhYlLbK/YbDw0OLm2xFMkVhl7Pe/mvqaMiQR?=
 =?us-ascii?Q?dfBnHIu4UKqAqDt+bBYvkSRIh5YDlp7sNVLKOLXtNI0UwgMxDgtRIhlb4pui?=
 =?us-ascii?Q?6jGJ19nkpNeJudjrdsWlqvd7zVvT2SzB+Qn3dokqvoOQADBae4e0g1rs/lHh?=
 =?us-ascii?Q?WxARbUkMdWt1f3oTy8sLb8T8b2gnwyRgIc7A7NOTAfE+/aag48X8TwrbQCed?=
 =?us-ascii?Q?pWJvNCZhdpCoG/NL3cWjc8v6r5XAeA0/ZJGvwDrIes97oOUdArSp/hnNaHsw?=
 =?us-ascii?Q?0/RIwCqF9Kn7rq/M26OFRn+E1NGP8dDz/A7oDPIexYVWdEam50tNO8AKcVMr?=
 =?us-ascii?Q?tLgUth/ZOohwwQC4oRiDasojrZNf1NFPadeT3vqlfsoZtmEj+PdCOM5SO2/V?=
 =?us-ascii?Q?ijxAuKZV3hdD8yZYdvcexPhTiqXbopOa0LQoDCXtg8g1LhfXtGKw6fsKaqzZ?=
 =?us-ascii?Q?xsIoRxRPoIF9eVXXsjrCTTwiQtm/ug7h0SfBqEqPsI0o2Yx0N1GQMAQ6RRjO?=
 =?us-ascii?Q?BXdMflp8os2lw4P237rehwI7zKYUyLOA4BfT+/bRDcxwB8zVAdDC7+iCg4D1?=
 =?us-ascii?Q?4bbje87a16nnluRJ+Sr0efeAA6zQsyy7r4vKXj55npd9z9GIqEgDakBuuao/?=
 =?us-ascii?Q?IfidpRLkUqRpcm2brFEthyYlbKlGABRX6FgIHDD0Aox+uGcspWzfpgj2nL48?=
 =?us-ascii?Q?ML++Xu6a5PGly6uSoLW9Q1PGcMClYNjIkEylUwjA3ngMDL47FNrLvLOaJjPJ?=
 =?us-ascii?Q?uxtEalxdmNu9V7bRoxihIjRRU/Zlzy5C1zpeKIIh0XATBU3fzfNxQWnH/2l9?=
 =?us-ascii?Q?PCfrlXBYKLs7NH1AxD3Sjd6m8425JSERvpEX1uOjhRCgonfrStWc6NnkUSeo?=
 =?us-ascii?Q?jptNk6NEG18PmxsHmfAxVQIghxUs2VZ62j6y52YmSqFFraOQ8NHWHexWa5V9?=
 =?us-ascii?Q?3L8mH+5PFcAdfdCFQzgc3dzGd+xJ/EcgTOJKE5FNQXZyi0va9qhI1OGBsGSX?=
 =?us-ascii?Q?vWNj6lGFk/Zfr7gZqMHD6jgClToPq3AbiD+D/zl52qPf8jew2rYrVPcp499h?=
 =?us-ascii?Q?pLGTMFG6sDU/6LcjamsRHZBl3Fiol3uZCjBqPwkpenp81VYhTo2EgjImJX1U?=
 =?us-ascii?Q?uC2XsI/nvl7hy0ssNtgv418ICcF6A87bCCN9bfH4NjPmklfPApFh9lzhAgON?=
 =?us-ascii?Q?MUxpf1nAHQwiz737EZR20r/gKY31JmgASNn6xMaB4fLtrCN1LSk0COMvjVkJ?=
 =?us-ascii?Q?CGfynAJSPhnMoa9ixq6aZiQIqr4TWfZEPFZ0jOmvKHnLjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e1bfb1-c16a-427b-847c-08d9010ecf17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 19:35:36.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18oCPZG0fIfWdIr+YlzWlVsnNAtRLCH61k00tfBktn4f/P35lOBMs9gwo1IMdB5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:01:57PM +0300, Dan Carpenter wrote:
> We can't use kfree() to free device managed resources so the kfree(dev)
> is against the rules.
> 
> It's easier to write this code if we open code the device_register() as
> a device_initialize() and device_add().  That way if dev_set_name() set
> name fails we can call put_device() and it will clean up correctly.
> 
> Fixes: acc02a109b04 ("node: Add memory-side caching attributes")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/base/node.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Wow, yikes, that "kfree_const(dev->kobj.name);" is really creative

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though I dislike ignoring the error code from dev_set_name(), I think
Greg would prefer this:

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb2c74666..80079e440add12 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -140,20 +140,16 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	dev->parent = &node->dev;
 	dev->release = node_access_release;
 	dev->groups = node_access_node_groups;
-	if (dev_set_name(dev, "access%u", access))
-		goto free;
 
-	if (device_register(dev))
-		goto free_name;
+	dev_set_name(dev, "access%u", access);
+	if (device_register(dev)) {
+		put_device(dev);
+		return NULL;
+	}
 
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
-free_name:
-	kfree_const(dev->kobj.name);
-free:
-	kfree(access_node);
-	return NULL;
 }
 

(arguably a device_register_name() would be even better, if you are
handy with coccinelle there could quickly be alot of users)

Jason
