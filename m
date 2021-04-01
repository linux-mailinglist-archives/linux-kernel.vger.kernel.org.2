Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A52351DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhDASbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhDASJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:09:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF9C022599;
        Thu,  1 Apr 2021 08:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5iAQmFXtZdpNK/MY57y0SSIwAxhPj/kvGrXdQ3y9xHrKho2X+I7Yjg5PThYhKI6FOJCQD5sKKMEfIPboAmFGxmrKvt6OhFFqQrHh5N2RuCwxAa3MkXesBDQwFSDRwE/dcw3vhLyhPOkTx1l5E7/3aXeWHaxNVDfjzK5oCEDmX7bzxgCDzYbkkgb0ZLvZHUL7gxCQao1J7287ji42pwruzB58jcB3q+17csf8iffKbNrm64zFyc4PFQDjYI6rafzf8/RMzsTn2qwigHkabD4NFOoAZ1K5+upzsGSlSiEnIPLX+Qa+rKmO0FQFX+6LG4OP2tn6zS0NzOuuMz88uqE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u1G5ndHcH7pOfsRsdS2SETCDEdXlvXN1Xsgi0sR/jE=;
 b=FZMDlG5p3vkCtUtAWnJ2Yz87SW1qj/MCMPRLMPHrDCJS4trBCQxPVW4DDCrBWpsvdyiBeqvmZQHdaMImAwcoZB479YqzYZtizyWyAC9v8sMy2LwbP4WX8mV8qTKVMjJGH77Uv39aVDjP3JQ8uhYVdjuB9YU5gC5sYtkA2FPE0fgcWutrAvRx6OZoisBykYIKrA9Elu2z5DaFspA7Be8pvDNNpWWAadEJoguBzVMW562Msznd02TPU99UUIf4c+IwwCpOJLBGtZtrOECPy0sNzAAJ/m3kcAZl1n07esEWyCvOoDyiRr+RRx+aoX805oyFVBWqEqZ/o8mf5DFz21hf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u1G5ndHcH7pOfsRsdS2SETCDEdXlvXN1Xsgi0sR/jE=;
 b=FoKBWr6QEZ+fW5KDdn5tzUa0XgI91oaxFTkDgl07W+i6AMI3A7O3Ney86Y3729X5InuFIC3eu4xYc8Ahtq4EqrTRkbc2VRHxjF90ImtgB3rVmnoSQI9TZFO2aTTB1iC1LVp63PxrQvNj9zGtmXUFe705BhTEMuELe4a8MRVJV20RtLMUbRo2Kyu8/7nZT+vnu3VXHusoTfGNvsftG+MMQnfJxF073L1aAVulugG02oMsi59z4I8KKDOosPvp6TIySchNzUC98DufEMIy4pwVrg+SRAOcrtjRF+bGch37qpR/mzHMY6ulIfBOFmt6hCwIPGPKenHtd+sqo9O/zDQBaA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Thu, 1 Apr
 2021 15:22:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 15:22:15 +0000
Date:   Thu, 1 Apr 2021 12:22:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     kbusch@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [bug report] node: Add memory-side caching attributes
Message-ID: <20210401152213.GI1463678@nvidia.com>
References: <YGWLtzMLqSW4cxma@mwanda>
 <20210401112511.GV1463678@nvidia.com>
 <20210401140652.GT2088@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401140652.GT2088@kadam>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0306.namprd13.prod.outlook.com (2603:10b6:208:2c1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 1 Apr 2021 15:22:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRz9B-006mWN-TV; Thu, 01 Apr 2021 12:22:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9128ad78-91b3-4f6b-b897-08d8f521ee39
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB260142F245250181FDC98758C27B9@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVPC5cFWopTZYRFl0aatxtcUEoZUvcgL4qIWIpGHCI1hABhHcYc08wpBG8FA2O2dRTCR8xUbAlYIEUDJvc+yPDQKKdAzBvbvYmn6nq1IrTq83p3SHhUDvALtQT3gPZYqtkiaua7o9Wv+/4tWNIUxibEONQq7pnYJEmt7rc1RsJzvUcQayFAmwmMRUIDrNt4xCBzqteQdFnLD04I+CxVLhnQ97LroNLs42JXggmM7cFGOJh1L25b+t2wecNUxg3yVoltlltZAY0PI2LjS+tS9w0nUuXhK7CpHaRUMUoUiIiE7c4CPoUYE1zPYTUAB7QWpm9K/7/vhwYOz0qLabkQfE1hrf0tq2qZOx6E7xzpbsTQqAmwH6pZjksK5nCrmyWLjkSBY1YXXDb1batkPiPqbICpycKOe4YQEUF05rHK8raEJkwqk24gMg5sinjPBYeZEv2/2Qh4wI0d+HXxVo23EjK+o9NSrofyteLr1ia62AFID4lznDhbrOk09ZVl3DK0Mv/+nQDumbk4jaL+dsHyVZZmMebe64jiKTZilBQyOjkErey2L+xd3PwxlGdCkUeytzTqcR8YSZwDDcWEpn2WTIlExNurpUbKDne0acXmzodvTFpNMIHgrBO4fjBSg1czE7myw2/BsZ9hr+QBdtnGViq8xbHm+OBt8b10wdmPpXYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(5660300002)(316002)(9786002)(66556008)(1076003)(66476007)(8936002)(110136005)(86362001)(8676002)(2616005)(186003)(478600001)(9746002)(426003)(66946007)(26005)(2906002)(83380400001)(4326008)(38100700001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S6SwvTPDREvlAyQbsmc6j2Ki4hwrRDjZ9rcpdPlGjl3UekHzHrvlG+ldG28v?=
 =?us-ascii?Q?TQvPNufQD6ourXkohfAgCcxQlGEXsctc6ms2T1zo0I7x+KM2yaYdRr/5JWp1?=
 =?us-ascii?Q?FW3hvsFfGoFPWUxfkKcUT+TIdlf4AMySdMolofIKwsAmoylhsarvFcvXQpE3?=
 =?us-ascii?Q?Tn+ODQVUwLlodr/mx0ytA4ljFE1Rn+9zkC0wVrgkpv1x/Zlc0V0lv/oWWane?=
 =?us-ascii?Q?eNS978HlVLsI3BZ3SRToVECR58EcPa23d5sZClGQPpuODb7vYVtGKD9vQYMF?=
 =?us-ascii?Q?JEI8/jYmk9Me4dF/t6PUwkUIZr0akBCVIkrdAkfVqicKLqTYdJzw2PgQfTUU?=
 =?us-ascii?Q?JdeJF+SiLjDPgu70BFU4mTh3QgaZOKSVhCoQY9mCeGuPnujyvi7AY8w00YE8?=
 =?us-ascii?Q?0AaRZxpAZyWUZnJgKZNKu741GKeSGkxqG4a1C7zLekL4hi8gCLlRM0zfNTOu?=
 =?us-ascii?Q?3b8znj4iyXfO6TNoMbKe8CXTuJIKj6VurKPNDdZP45D3ihKue/GKHUZ2AouT?=
 =?us-ascii?Q?OGbU0nooB96McjS7y1vXtxnidX7gLUFjVLj6LsPyi0SmsYhupvHA+NfAn23d?=
 =?us-ascii?Q?6013XFnqup/HlngviavLE5ss5SKA3TkjJ47WXfkipnlcP8Ez6JX86GxmcIIS?=
 =?us-ascii?Q?5eUgu5wB0Ep7Jx6GN3odyAMManXAF3Tu5AHvTgvmqMtxf1fQRt4XImPhUlyY?=
 =?us-ascii?Q?cPTI+L9DUINt4D+5N7fM2rXKWlfoBOU6ZhVq6C4Il19ezMMjQeufBMl4ND5p?=
 =?us-ascii?Q?idnnthJJnHAZYjs/lsgO5FzAzoAHSaGRAFa4jV8CtjdzAuytu21r47HM2aTP?=
 =?us-ascii?Q?IkuULRvHS3IiM2ix5JQOkN7oSfNq6ldU+OUtgqC1xQjmmhVYdTu6qYRtKyzw?=
 =?us-ascii?Q?96nETEXSO6sEqynO4zwwWJ8L+vU8LDoLzrj3Wdl+vB0cvndmegpAx0A+/SNp?=
 =?us-ascii?Q?yhAi9sFSvTA8zsVEsECNiO3YVro+EpDh5Es/kEeQhNmPZRUCCF6LgFzOIqs1?=
 =?us-ascii?Q?NHaIrOKcqUh8lJXFs97Op4kElFBna58hOGMbBKB/G9zkczfjyPpG8VgAeTNg?=
 =?us-ascii?Q?F7f1bD7YSdCoGpMVQoay7IKo3cCXTX9Ey1kv3k6h0bklc3BVuC6Q7IpfWngI?=
 =?us-ascii?Q?WRVN4tRGjNyuxLPyo5SAWJyKauW6eFHLsYVZdMtTGl5D3P3FDeYRtDGroxVT?=
 =?us-ascii?Q?OzEMKipEC2UTQ4t1bfZ6IA/6ZTOiuVQaNabSsV1/vT4zk2PrSSh31PXUA5OL?=
 =?us-ascii?Q?ztXEppGbCY7TmTDleWJoMp7uKHkznERkVd+NUIShGj9hhfjvHn4b7oVnnIiB?=
 =?us-ascii?Q?MiqS9/r5xQi1M3Wa9aP+Pk3Sly8injFVjUsCuit//Z1FfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9128ad78-91b3-4f6b-b897-08d8f521ee39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 15:22:15.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r9yBa1Zd2mjC3HsKcRgtEnSLg/MSyxxnmb4huWjwXratOhz+fVthj4/NqWfiCb4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:06:52PM +0300, Dan Carpenter wrote:

> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index f449dbb2c74666..89c28952863977 100644
> > +++ b/drivers/base/node.c
> > @@ -319,25 +319,24 @@ void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
> >  		return;
> >  
> >  	dev = &info->dev;
> > +	device_initialize(dev)
> >  	dev->parent = node->cache_dev;
> >  	dev->release = node_cacheinfo_release;
> >  	dev->groups = cache_groups;
> >  	if (dev_set_name(dev, "index%d", cache_attrs->level))
> 
> Is calling dev_set_name() without doing a device_initialize() a bug?  I
> could write a check for that.

IMHO, yes.

However, Greg may not agree as dev_set_name() with no error check
followed by device_register() is a very common pattern. If the user
omits the device_initialize() then dev_set_name() must be immediately
before only device_register() with no error unwind between them. It
must not error unwind dev_set_name() to kfree. (This is really
tricky)

Greg and I have argued on the merits of device_initialize() several
times before.

I argue the error control flow is simpler and easier to get right, he
argues the extra statement is unneeded complexity and people will get
the error unwind wrong.

Every time you find a bug like this is someone getting the complexity
around error handling and device_register() wrong, so my advices is to
stop using device_register (aka device_init_and_add) and make it
explicit so the goto unwind has logical pairing. put_device() pairs
with device_initialize().

The tricky bit is establishing the release function, as complex
release functions often have complex init sequences and you need the
setup done enough to go to release. When things become this complex I
advocate splitting alloc into a function:

/* Caller must use put_device(&foo->dev) */
struct foo *foo_allocate()
{ 
   foo = kzalloc
   allocate release freeing thing 1;
   allocate release freeing thing 2;
   allocate release freeing thing 3;
   device_initialize();
   return foo;

err:
   free thing 3;
err:
   free thing 2;
err:
   free thing 1;
err:
   kfree(foo)
   return rc;
}

Thus there is a clear logical seperation between the world of 'unwind
to kfree' and the world of 'unwind to put_device'. dev_set_name() can
not be inside an alloc function.

Simple cases, like here, should just do device_initialize()
immediately after kzalloc() and never have a kfree() error unwind.

I saw Christoph had a similar opinion on 'init and add' patterns being
bad, maybe he has additional colour to share.

Jason
