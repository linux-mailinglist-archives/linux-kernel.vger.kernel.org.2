Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2E346F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhCXCes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:34:48 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:4608
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232118AbhCXCeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:34:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkG7W1YBb6qJFpn+dspDlUs6offeI0mQayDXuGdKxDPiFOIvOyBfYz43Cea34rWCKMQ84gc7TpfJiawYeIjR1N2xCZBaE1yVRvdMRg56oJXdDmGcCNZ8wYeCxZVNpv4ycpfovP+LyDFhyfrkiP2FeEcaZQTptrxFgB582233k28lD2FoY4wDgxgOfWK+xYhQPpmzopee+YrfEn7dObXRJEQrdF8sSSTE6GI2d76ijglDViiceUGeiANH996JgUQwbGaLmUIt2QNRcQhX2IuFwkXANOCKncBy8YQ14eJ1ozRAwAzVTQUfOp7z5GYpEK/UkIWjn4JUClecvzg8KpgVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFWCDNwcGjfgl0J1q20Rd+rxOeD7MN8x2EH2NJ5x6WI=;
 b=d1RlTmXjuxy98jn9HFCe5gcdsWoBtbaONjyB/NdElHH3tjPAP9ThLM3ZwRvwdILilZbG83ZIjFVIL4+xdXshr/JUfREfmLvJZfNoQ4kni52Pb6pFfRr4pT7lnRvXwo1ozxZ3CaqUvZc1rb9mSJTYrd1bB4jeq0PkUNSsALnjXD0AmNvX+81CDxQCL/1P1qmaJaVJ8swKDOncvLMO3XZa9BkTTCDltx7O1B6HkuYlMNPvamtXFQqaMqekISg+oeNt4AknRGTYqb0vQxW4pZWEIyxu3IaFcD8Q8pbvFCugdXuUzQ92wbh9cB/D8TaQ710oxsOAYcNk2A3MZ7GgCozPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFWCDNwcGjfgl0J1q20Rd+rxOeD7MN8x2EH2NJ5x6WI=;
 b=X/FdtjgeyIMsYcMu0Q/Ta7TgdMgxhdlakCO0O83aUMFrLk9nzSYCVzZLWtzDbSxJ0ru3/q0r5+AnpDZtP/utCfkpn2qCrNOm0KpnwHfbRo1LajdYKDZFXdBKtdW0ODf2V4+P57zutnkvxYZ+kIbxNi5xoccNNuo5QTGstmNj1ubZglOz8zJR31B8GYZ++9vjATb+gQMC4SqxzLs7SWpUro2IGQjJDZ2QXIQkbKcH8/n1QZTsvZo7+PMFQTiW6rNQFve7vcrjlN+usxx/ASSetNxivdYaRtlOG+rBp3L4WjdfpOZrp9Fh8h4BLDSFboxvc73DO318ivw0Z5vInniWJA==
Received: from MWHPR14CA0024.namprd14.prod.outlook.com (2603:10b6:300:ae::34)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 02:34:14 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::df) by MWHPR14CA0024.outlook.office365.com
 (2603:10b6:300:ae::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 24 Mar 2021 02:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 02:34:13 +0000
Received: from [10.2.88.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 02:34:13 +0000
Subject: Re: [PATCH v6] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>, <digetx@gmail.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
Date:   Tue, 23 Mar 2021 19:34:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324010547.4134370-1-minchan@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f00d70-b699-4a88-2701-08d8ee6d503f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4336:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43360FBE4C01E329FA86CFEDA8639@MN2PR12MB4336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 635gKlYbfg9NJpyypumJJ0cuaf/KhRC1TmEPysrcgLCx0AsVbfIn0pgPbhjyPNjv8iC+pi5YZidQlc0zQIQvqd6uaMljJ2aySvcLbKOsTwaJonJttwNF33BoRuRXVLJdgtw3ts7AGB7D3VB32BaoB40UG1zd6w1+Tm1VD9J+jF7WPxiI9KSPH/LRFOv2WEvNl2C0nZvWNxXl2coI3FXmAIWlLEqmOUnFrmOXjdtn7SwS7/XgCrplTICLzeVWUzyau8rCpMDaylNYYanb+LGJkgSdea3KZbkkXI6mCrYhRyeKIIN20kuAzsQNDDgYG8DHKmQEyNb9OiCE04MKCwCbBikaGv7TMKiRlyaY4JzTS8OP1GOrIv3X2D4QtBIH50t9mMy2nS3n7qn0oNnOuWSZ2FYShfftT6VEndp+3Mg/vS2YTIjhj81YSXU3Ufs8U3onDeGAoJ2mbhln4Ksq0Hlrd/kRjq9ZbCtFfpzNEw20qlD2t1HBxa30o9wtt8FXrjqidTiL4wfNUwyqTZC9FwhWArpS8G3NAjcn9+thC9v590YoKkt9oQymyeOd621mw/SzGFGkLiZwMHjWT1c3RtPMvZMzouO5yznXQ5dolapV006zN/lI5Gsddz1Da7D5Me+Ap1tLSZ2MuSCO1e7gjnbHM2NPrEYfSEZQO48GdYqdF67r8TAQXJr/XICWjMNp5xve
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(2616005)(83380400001)(16526019)(5660300002)(82310400003)(82740400003)(53546011)(70206006)(8676002)(31686004)(8936002)(70586007)(478600001)(2906002)(36756003)(7636003)(36860700001)(16576012)(356005)(336012)(47076005)(426003)(316002)(86362001)(54906003)(31696002)(110136005)(36906005)(26005)(4326008)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 02:34:13.6997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f00d70-b699-4a88-2701-08d8ee6d503f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 6:05 PM, Minchan Kim wrote:
...> diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
> new file mode 100644
> index 000000000000..c3791a032dc5
> --- /dev/null
> +++ b/mm/cma_sysfs.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CMA SysFS Interface
> + *
> + * Copyright (c) 2021 Minchan Kim <minchan@kernel.org>
> + */
> +
> +#include <linux/cma.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include "cma.h"
> +
> +void cma_sysfs_account_success_pages(struct cma *cma, size_t count)
> +{
> +	atomic64_add(count, &cma->nr_pages_succeeded);
> +}
> +
> +void cma_sysfs_account_fail_pages(struct cma *cma, size_t count)
> +{
> +	atomic64_add(count, &cma->nr_pages_failed);
> +}
> +
> +#define CMA_ATTR_RO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> +
> +#define to_cma_kobject(x) container_of(x, struct cma_kobject, kobj)

I really don't think that helps. container_of() is so widely used and
understood that it is not a good move make people read one more wrapper
for it. Instead, see below...

> +
> +static ssize_t alloc_pages_success_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
> +	struct cma *cma = cma_kobj->cma;

...if you're looking to get rid of the real code duplication, then you
could put *both* of those lines into a wrapper function, instead, like this:

static inline struct cma* cma_from_kobj(struct kobject *kobj)
{
	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
						    kobj);
	struct cma *cma = cma_kobj->cma;

	return cma;
}

static ssize_t alloc_pages_success_show(struct kobject *kobj,
					struct kobj_attribute *attr, char *buf)
{
	struct cma *cma = cma_from_kobj(kobj);

	return sysfs_emit(buf, "%llu\n",
			  atomic64_read(&cma->nr_pages_succeeded));
}
CMA_ATTR_RO(alloc_pages_success);

static ssize_t alloc_pages_fail_show(struct kobject *kobj,
				     struct kobj_attribute *attr, char *buf)
{
	struct cma *cma = cma_from_kobj(kobj);

	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
}
CMA_ATTR_RO(alloc_pages_fail);

static void cma_kobj_release(struct kobject *kobj)
{
	struct cma_kobject *cma_kobj = container_of(kobj, struct cma_kobject,
						    kobj);
	struct cma *cma = cma_kobj->cma;

	kfree(cma_kobj);
	cma->kobj = NULL;
}

...isn't that nicer? Saves a little code, gets rid of a macro.

> +
> +	return sysfs_emit(buf, "%llu\n",
> +			  atomic64_read(&cma->nr_pages_succeeded));
> +}
> +CMA_ATTR_RO(alloc_pages_success);
> +
> +static ssize_t alloc_pages_fail_show(struct kobject *kobj,
> +				     struct kobj_attribute *attr, char *buf)
> +{
> +	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
> +	struct cma *cma = cma_kobj->cma;
> +
> +	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_failed));
> +}
> +CMA_ATTR_RO(alloc_pages_fail);
> +
> +static void cma_kobj_release(struct kobject *kobj)
> +{
> +	struct cma_kobject *cma_kobj = to_cma_kobject(kobj);
> +	struct cma *cma = cma_kobj->cma;
> +
> +	kfree(cma_kobj);
> +	cma->kobj = NULL;
> +}
> +
> +static struct attribute *cma_attrs[] = {
> +	&alloc_pages_success_attr.attr,
> +	&alloc_pages_fail_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(cma);
> +
> +static struct kobject *cma_kobj_root;
> +
> +static struct kobj_type cma_ktype = {
> +	.release = cma_kobj_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = cma_groups
> +};
> +
> +static int __init cma_sysfs_init(void)
> +{
> +	unsigned int i;
> +
> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
> +	if (!cma_kobj_root)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cma_area_count; i++) {
> +		int err;
> +		struct cma *cma;
> +		struct cma_kobject *cma_kobj;
> +
> +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
> +		if (!cma_kobj) {
> +			kobject_put(cma_kobj_root);
> +			return -ENOMEM;

This leaks little cma_kobj's all over the floor. :)

What you might want here is a separate routine to clean up, because
it has to loop through and free whatever was allocated on previous
iterations of this loop here.

> +		}
> +
> +		cma = &cma_areas[i];
> +		cma->kobj = cma_kobj;
> +		cma_kobj->cma = cma;
> +		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
> +					   cma_kobj_root, "%s", cma->name);
> +		if (err) {
> +			kobject_put(&cma_kobj->kobj);
> +			kobject_put(cma_kobj_root);
> +			return err;

Hopefully this little bit of logic could also go into the cleanup
routine.

> +		}
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(cma_sysfs_init);
> 

thanks,
-- 
John Hubbard
NVIDIA
