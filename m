Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FF234D2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhC2Oyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:54:40 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:22400
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230402AbhC2OyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5w0WSJVNR/+no7jn5AomdJpsHph5RJD/NWFmZNWzXdUsB4BKeuAC8XpRFwY+a95ZwuMyf7fM8KrgCdjsnmvvqVDv4HQfhjOXLyQsj4qBtex2DfHIfDWDCvTfDbUH0WO5Pb8DvvQcsNPmepiDdR5VrTqrWjx+J74gBc6hQvmCpnaP+40DgjwJ6VAgCSkOga5oJQiwfyaWLtjnHY412a5azZ+uz0Q5K3JRBPnxOrv3fdaS5pA35CWB2RtPSuRgyjHbIY8fQ+9N/laYFLYonODzqszBbbEBmTZMyZarIWtj0j6PXEHFqNfOthB5c4YulVf5hWWNWgaAyG8R+AyDEpR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxjjSXplRwON+BLljQJlmZ41Vl4SNTDKrHU7FDF1ysw=;
 b=CUM2noj9Bdo+n/fWL5x8mbHGRGJncZ6EtBsVlvclkMy3AxOtuiqSe5ayapLjDOM/zDquqaxK0NTFXETY/P4J3zTSYGb8uW0HFQzJQHsVM1p9QZ3cwCuzTd+06gftr6fekkPaJ9eqUw4gI0Gfnim4bH4AJibrL7SJxuGygUYQzriAWK9i/IdS7nVarR/U0SV+XVTAHhcXIMXPx8/6Nejtg1+HsfoaUEydhH117/fRAUn5ki6JLRn43jvUrD2/nkd42SVOtVWx73WMZ6cr0HXj0OIav8BqGySahGEPlkUPIdTVex/R7xyv+6MWIz31IJvNIJR/Ph5hgbwXnbqaKwGtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxjjSXplRwON+BLljQJlmZ41Vl4SNTDKrHU7FDF1ysw=;
 b=DYgNdyYHiotkqURM7mUzbYlwjwRHtlnk+SnFuqHTf0RCG9NwYEBxouj4jF2qtOAil9ZWw0+EhT74UKsiFkijG+aHd3VOPb3xIOqdCy4KEMGA9SOo1qpXYhYV/Pf+mEp1/y5pTA3UUtXdqajZmG8UE01dJIvlA5yBAOykmhrz8LlSMAfiHqpD6obmPMYBkp/VUU4bGkMwkK0hA/hT9S8hBeaZAODKySjV+jlr/nrgLc2AFQ1o5f1o0aNjjpYPLlrqjtCKG95P+7DLpBYKCqLkcJvkje0HejxXN8VOCApJYXS5kHEq+7zqnC8GlTLT56cAbqUcLzY3EfEUjS+yg7fNZQ==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 14:54:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 14:54:06 +0000
Date:   Mon, 29 Mar 2021 11:54:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Fix a leak in tb_retimer_add()
Message-ID: <20210329145405.GD2356281@nvidia.com>
References: <YGFulvAa5Kz6HTsd@mwanda>
 <20210329130220.GY2356281@nvidia.com>
 <20210329144323.GI2542@lahna.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329144323.GI2542@lahna.fi.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 14:54:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lQtHJ-0055XG-3x; Mon, 29 Mar 2021 11:54:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08aeba1a-60cc-4ee4-5fc3-08d8f2c28051
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108DCCD418E80C8D84855CDC27E9@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DxYdXKyhX1d7H2u4R3VXEcYbvmR6SpEEp0YrMPDzdkBHVuIGYjWqFVV7A5Rk0zfOjwsdlGxKp6g4XoczgZ7ExXNEQ7YB6kEk2BdxKgHeTQ3S3fpTqxhV8k/GtmZMSgKaa8ky/w4oa02U4b17Tx7QIuGyJzAi4UTuai3HEyO4EQiJNiSN55azDpnCoecgs/FZ9y7+tQn+qWZQGwXYOx9LeHhWIqrfaL9lRRIOLy9mpCijT3+0pGi+pdLbTGrKrEDNOTCc3hReurl/gYxbgK1otyZIVrou8RS6dnx+G2R1bgPXIalOZ0prxNZrnVeDrb8xuJWApaL6y4P8PamCNHKDh1QyLUNchN1gfH017XU+O2vqu5sG6IpjULxAJmno12Gyxr1HjiKXcog6/KUW0i7SyOdhJTtzFrKV7gO0Y/NDRZ1TPKR3HWV4+KMRpXQ4UfhRbq7P5jIHLg/mEtc/fj8/ujQ89aja/LLQIUMob23Rp1UByCQQrTbweshA+33qlde/DUXDPn0Ryk8wBkCBJmLdI3QrQriyuPtQHUjLW2OH6RFpsCP5RZMUxyyqj9uyKiFmnhuQ2qlc9HK+mJwhvToRF/gATI6wISbuSfwTYe9ddU/K35u2xOlUu7aGPLYPkml1j3wupc3wcqMYQk0XSuwojjQmZKcujr1vqdnkqpqQ2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(26005)(9786002)(186003)(478600001)(9746002)(38100700001)(86362001)(8936002)(1076003)(4744005)(2906002)(8676002)(426003)(316002)(54906003)(4326008)(6916009)(83380400001)(2616005)(66946007)(66556008)(66476007)(36756003)(5660300002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xb+sJj8TQ46MToPHtmscWAfBb6pxn/YIggdLIawnnpmxQKELApM2OPeeM6KN?=
 =?us-ascii?Q?hLlCiEbGiaUuk963OQDQbblljVZuZ7E7JwgxlqApu+3zdL0ol2b9Yc+F47Up?=
 =?us-ascii?Q?HLUEoJsnQgkP2trSHziNC+RbOrgEt7YGFYHbiV+kksJ4wHZliMDxYXUeDHPc?=
 =?us-ascii?Q?yjPOozjPqw5ZIQol4v3AqwngVda72stfhbIK/g4mwluDXP8EPx8GsCPTuibB?=
 =?us-ascii?Q?sVmZvOtMhY5AyYsc80yUmRh+xwnqcQre3NSUkbNWMzPjE0DTFQweV9VQs/NE?=
 =?us-ascii?Q?x+Rckz3EoJq7d091JBw3FORbeqjc4uuljZn0W1jlQ3lpDcfi6POsYRnX2WlV?=
 =?us-ascii?Q?i1X/yKp7Sd/UEg7Kwv+1eUedPY0tngz0AG5idgg3g46y6Qljmqkmr825wQY1?=
 =?us-ascii?Q?erTilGWR1PAATPewOoHlhxhlle5SJrDvMXFe7GV0cKYnkUZ6oC+dp0fdzEiv?=
 =?us-ascii?Q?+xrk4OTF31Keog7C0y64Kby4vQ3f/r8uHQXMaeKjxwpFJEZPEIQ9dKN79D/d?=
 =?us-ascii?Q?CW0/cwB5Pluj4lvtlFhrG3iotD6NmDHULBcserGP6ps9eKX0OcPz044bva5K?=
 =?us-ascii?Q?xet/bbBtqjPib5BnVqU08TTRUoYScHsXTPZYcE+HOO1hwK+1f79M+pphcMoc?=
 =?us-ascii?Q?QSQHsKFhPe/ByP4TQJPx0Woy99rCA80QGIM9maD1xgFYwiI7zAiLmFw2YSF4?=
 =?us-ascii?Q?Q2dJIRvrdKFpdWTUzItW7L/Df5ADfkHoC1w3yV7wHb0lDayCy2/dz0jIAf17?=
 =?us-ascii?Q?cAC30b6huGUpUC+oLQckWX6og590vzUrvFK14qqsG49kwJ4/PbYnW+EfPKil?=
 =?us-ascii?Q?+dHdOqNQlNDZ0zelcahx7b9QpYezQXRWRkGQqZ/FeXDBKUUoAdNH4DlQ/VEI?=
 =?us-ascii?Q?2hI2txemlGrTVFt5kzwaNX4uErvXIjDN8yma8C5OD+RYvSFb+YhyvwxSjTgN?=
 =?us-ascii?Q?VHC1ul8EpNDf8xnfnjydzGmFOJdMFI7qa4ahkJZIxWAqDjafceWWs3pid4FH?=
 =?us-ascii?Q?yfM3Dj4HE4WsGyDaz5On9qwuJYGiEtigZsinNbAyZZVuvXjw1pfVz7BdOtJf?=
 =?us-ascii?Q?wY4cvkMogOu+dLjs0QarcT4Qo601kJtDOSf1PUZzXMLxyEKjuO2xa4nvDBvL?=
 =?us-ascii?Q?jvJj8MdyfK09QWvUYZVmRsD2vITDlnRn2kjYhm9nqXAxvMW903kZdpe4ww6j?=
 =?us-ascii?Q?Yu7UaUIJzHuEtfGxH4wlf0YaLqq2ySp0cfGid92R1AOk33DcmlXig5cFsS2D?=
 =?us-ascii?Q?rS2PZucLlrTLsVFRU2or8z2wxdl2wjO7aogqM/+h4yqvM5fwyJkZNFqgbE7z?=
 =?us-ascii?Q?d5zrH8DWt/fv7KhkzpAIYGe5VEZXNkyIzY8wkNy/Lz3Vtw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aeba1a-60cc-4ee4-5fc3-08d8f2c28051
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 14:54:06.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TGykYXGSWU2GyhbBpYSbPWgAdM8AJGUaviXBvcKxEVCEu0Wd9susH4tWIGkcV3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:43:23PM +0300, Mika Westerberg wrote:

> The nvm is a separate (physical Linux) device that gets added under this
> one. It cannot be added before AFAICT.

Hum, yes, but then it is odd that a parent is holding sysfs attributes
that refer to a child.

> The code you refer actually looks like this:
> 
> static ssize_t nvm_authenticate_store(struct device *dev,
>  	struct device_attribute *attr, const char *buf, size_t count)
> {
> 	...
>         if (!mutex_trylock(&rt->tb->lock)) {
>                 ret = restart_syscall();
>                 goto exit_rpm;
>         }

Is that lock held during tb_retimer_nvm_add() I looked for a bit and
didn't find something. So someplace more than 4 call site above
mandatory locking is being held?

static void tb_retimer_remove(struct tb_retimer *rt)
{
	dev_info(&rt->dev, "retimer disconnected\n");
	tb_nvm_free(rt->nvm);
	device_unregister(&rt->dev);
}

Here too?

And this is why it is all trylock because it deadlocks with unregister
otherwise?

Jason
