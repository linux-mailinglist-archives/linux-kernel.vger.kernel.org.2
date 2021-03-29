Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35B234D0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhC2NCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:02:48 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:37984
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231435AbhC2NCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdhFxCXl8f/CXEUfLHVpz6C11zheXd8R3+9secXASqgmY/MGN9g0SN/mjBXLiSMSd43qfqLukISNeNQHP0d4PRaoj6ffBQCw4sTmlOsP1rg1IOHU40wVUQj1x5WAKYD0WqEna26L4ooUFY5CHkfiLN8J8V95lfAtXs2Qv0IL+vYoC9bxrFSaaAlT/EPRjQdxSMqTAbZa0D0Gs2gmWXRNqyg9+lQ0UWZ61W5ZwTfLvjzjJbvIoYGux1Ut68ArjxjvbKq5INDz3ZWv+ngxIATjE3ifB4fAOzYnxOoldhz4Q888bkLONg3Y/wcGIiCY2Je9iiTdgHH5YzMz6rHe7UlxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmiVr/TiwPh/SehqUZt93KZRdRqVLUzqInnQltQiJzQ=;
 b=RTQmRFmWXrTghTMZ5/Y/YsRmGg2CKTkTrDf7DiAFjj+F1CbXkjtSjE6YZt4pniBT+zpFbXnb6GdUoxJrIdm+m0Rk0NjZb7aH110M9dIzc1NbGnAzp3KrX8dh46QnEhrxuUYeryPLFgECfmEgib2E1VmzAyfTITrAQiYntG/bJdJDOnLw9noIjgga3G/MlTEPbqTHo+da3gHJllMR7BgiHpnSPcg9TmPmRoVOe0KmJR09hD4Kw7S7GebApv3t6B8vOKPIs9qED7OGAxLEm1jr4kaCRchel+uyXjGnFa6ufPfNX4Cv5CbBeCagieHvpiItRThAMmyHFvGrEdvciDVI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmiVr/TiwPh/SehqUZt93KZRdRqVLUzqInnQltQiJzQ=;
 b=AvtGQeUKxpSrY+3EYXYoGJ3ZQW/PJYfD3GOV5yreqmxa1pdRNSBCIEyb1kWMddS1r9+vZXhP6GjcfuBFBYfrOhUuUeUfWtrti36Gzg6NHf++wxzZ+fFYoxhiG+CKRk2O9lHIugltS+F4nvBG73Ev5JS6sEEeqw+0C1rD7aXkELMj3HBBesISqTWJn1zqO4rsryhqWeM1q5rAvWpj1mtFhnT7lEJpLHC1AAorpLGz1Nvlqf8hfSsKJGlt718xgRHlpYA1rQxo04zEklf7ldIRgW/u5jZN0EljgqcmqbxGT/ikxGfbeLZAoH1sm/EV2AO+FAWKdMtH2UcZnr5RyP1rEg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 13:02:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:02:22 +0000
Date:   Mon, 29 Mar 2021 10:02:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Fix a leak in tb_retimer_add()
Message-ID: <20210329130220.GY2356281@nvidia.com>
References: <YGFulvAa5Kz6HTsd@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGFulvAa5Kz6HTsd@mwanda>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:208:134::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:208:134::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Mon, 29 Mar 2021 13:02:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lQrXA-004tWe-PS; Mon, 29 Mar 2021 10:02:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a16098a-6531-46e0-ee8e-08d8f2b2e442
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1884F69648BDEE7361F4356EC27E9@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaaMke58Z8hN3UZ+QPACImS0Av9j95txNbhTQ0aPBhLlz+E61/T4xgq5nQ6o0hGWS+zQto+eU2ToZMG63SLFHH07LhwE11BY4EyDi7qK5+xunoT0858nv08tafSxlJCida1YjziL/yb62oT0YFbcQtybPFlxSvOx6n4tXoqfn07yWJYa2Ls7O6Whj0nEMw6ApqcY4tcrObaWRc7XcgghmAxntNmm6j4l3PA7Q8u0Tw9PdU+OTXcZ9M7QnubxBmHyuEUCtaI+FbsoL3lUYTTZk5Zi8nWnpL7qt82dzzchHsRFhYBU/A+D/uVSe/yXYT2tM2RzRNudFBnYrlcnyEIEt0kLEZXX1qbaiSfbSVakvfPyvwmdGV4621AX5F9E/08INVPlbQdmM7NMjT2rHfiu5BcQwuJSRpwps1rmTlO+MnjWv693U0NSYwAhjvYDKTnmtWDBRtzRcSEqIKFz/DugxvxE236ErJnHACQP2DHzxkH/Iy4IfU2JMPakEd/Mp2dFxxbPY0tKXdanrA3Fi7F4tA77GrV24T+PLdMpdIXOKl51W8XMGqIEHsmAr0B3+v67pVCcBLU/yaMIH+j8TksqaHbyc8JrYd0SGNjOHWbl/aO+VORXrk44cphALeS4XilDcr+CZ/P+vo0R45Yz4//EzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(1076003)(66946007)(66476007)(66556008)(478600001)(426003)(2906002)(2616005)(8936002)(316002)(54906003)(4326008)(83380400001)(9786002)(9746002)(86362001)(36756003)(38100700001)(33656002)(186003)(6916009)(26005)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?52D9AJPobd82eTAdp2QiO3gRoAvJs6tQGmgPbzpnY05lZ5xm3mr6IHw8bLDE?=
 =?us-ascii?Q?6VZTk9my0P4WYi5712x869rfcX/VpuZSztCUNHxC4TSyuekUhYfTth6iEMm9?=
 =?us-ascii?Q?4jDATDhXpymVvAddYHRlB3nMfVfm8YTz4pyaGfzVHmp0GrF1RJRtgqo44YNI?=
 =?us-ascii?Q?sZ+sgvAQGmrvMpE5oDfBiu3q+p/5zm46T4i/wpgT3QjaRux3hQUWkzisPVaY?=
 =?us-ascii?Q?cjwtyR3xyixQeCvpJHVG5aOrgtJAJRIphb7OsolVKQMJFkHA5wGkKg57HMMW?=
 =?us-ascii?Q?z6b9D6OYPTZO9bN9Ag8wb5pVycGl4M9ZHTDFM7aDV6llMleWOZF5b6RTO4+h?=
 =?us-ascii?Q?SGzz/IXyMl9IljpZ/IgUB2KrqP/AHb0+bIJ3wRzPsv4fVrXIjOBm+D44t+DR?=
 =?us-ascii?Q?WvJAMmibDOjsd9fjsuPOj9/7VbSgqtnw7vLUkZ4KWS6hAP7ZTTLy9sVUobBn?=
 =?us-ascii?Q?ZjgpGS6ODTVO7WgsRaGwxN0mwwWZolKqy/KHUnS97Tvoq/r8ecPW9pMWEtA1?=
 =?us-ascii?Q?tJqHtRw1+MJxe/4zmXahEuGNyfNtPMNe8lkkrWRV+FQxKJx7ReHnCfAHNK6o?=
 =?us-ascii?Q?v17OpM4pC24ibW+rw58BvKIZyaLKrsAt/xO+zmZaUZNCoptz+hKBK0WDqqau?=
 =?us-ascii?Q?ybsvdfLsaxAmF6lluDZPsdjWuUPVkWZmDfOe+yby3d9q3fCBU9QMoveiLIO3?=
 =?us-ascii?Q?wYA7+YShiK0RgRRjFaUK46RubTFlxgpkbXob524IINWjLMqF+CO4rWDcHdXf?=
 =?us-ascii?Q?QxdJKmoCngv8/8XWu9eDKTafwT40FWWWE/ZPeQAH326w9EskSqIlKLD/A5Cv?=
 =?us-ascii?Q?ny72Ugjw+BriH3GFz6faVvmh6y18EkrC4btS4qGM7ocNljDU5nDObyY0t8WR?=
 =?us-ascii?Q?S/uM1QQDczoEhCykIdxHh6wbmRxHrEnOEgj9qg0gsRT/mSFrU/Z/Qd+Q6g9y?=
 =?us-ascii?Q?UWgvNoeccqWKI4VNk6+WJHsywHvwxI49wenu2o8BsrGSzk63LvfJmJrBTRsx?=
 =?us-ascii?Q?9pez4Y/j3k7quawVpz8TbUyku4fWRmAN/3YZch3LPqZL41zGJaPR/LwIWPcu?=
 =?us-ascii?Q?h+eBBVZuirPi4U6C7c/B5vj8PWnsTFSRhBRr9KwgbpglizJOnOy9czYvHTRE?=
 =?us-ascii?Q?HfC44R4XMNj/GJg8+4KV1oaZw+0cTlVa4O8e2csEU6aevyQuOgto8p1QVLns?=
 =?us-ascii?Q?1u8syBoSM8T5hI03klMrByJbQEBIU7X0yz2crvVwkusH4Jrn5bRqYvuUTbEF?=
 =?us-ascii?Q?0ztyg8VBHYyo7LUg0YefpXG7BU9OTaPatiH5hwv77OP72gwE4aa61aHmMnco?=
 =?us-ascii?Q?0eR8b8BJ8HlXT23tgNoEuCBL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a16098a-6531-46e0-ee8e-08d8f2b2e442
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:02:22.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOf1iyeZ1OSsH62LwdYLPvu+A8L8XdfVxy6AGQG3u6PUqUGezDcLXDqDd12cqSyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 09:07:18AM +0300, Dan Carpenter wrote:
> After the device_register() succeeds, then the correct way to clean up
> is to call device_unregister().  The unregister calls both device_del()
> and device_put().  Since this code was only device_del() it results in
> a memory leak.
> 
> Fixes: dacb12877d92 ("thunderbolt: Add support for on-board retimers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is from a new static checker warning.  Not tested.  With new
> warnings it's also possible that I have misunderstood something
> fundamental so review carefully etc.

It looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This also highlights the code has an ordering issue too, it calls
device_register() then goes to do tb_retimer_nvm_add() however
device_register() makes sysfs attributes visible before the rt->nvm is
initialized and this:

static ssize_t nvm_authenticate_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t count)
{
	if (!rt->nvm) {

Isn't strong enough to close the potential racing. The nvm should be
setup before device_register and all the above tests in the sysfs
deleted so we can rely on the CPU barriers built into
device_register() for correctness.

[which is a general tip, be very suspicious if device_register() is
being error unwound]

Jason
