Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB50418FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhI0H2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:28:35 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:46694 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233185AbhI0H2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632727614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xjuVATs6D3wjKZlrb9lrWmJ+kcuNY9mgUVnAPrK/gA=;
        b=AWpv1BESMjaLcnvn81vXLye/gG234lrhHUFnGttiBPoyboVA3XZ1guDUxhBVd3lC/M25pR
        UFg8aVPP1G+IdceLegBsjRMNGG2BWow2Zs2fSIKn7JRY/aGz+F5IWEegnxjYXe09PdhrFh
        qcX352bLeDnJKrLOlhzwfD5ZX49tWto=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-8-ugGp8uFDPgK88etsL4MnpA-1; Mon, 27 Sep 2021 09:26:53 +0200
X-MC-Unique: ugGp8uFDPgK88etsL4MnpA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdjgnNbZQtCYaQTtccvOF8N0+j1Aq3ojlJ/xes+QISBe8I8t2piGgjtDVC+46JzIjrspbeQg6Uxkv6aAW1+3H5+fhGXsc1GssuJKu++PnTJbkyV5Fug9joOZYcZtaXAnapI9n7CekSqcu4kvCC7EKcYvP5vRmk3ahoBglfoKnoMZuua+ahKScujHVZ2EJ5Ib0yIHJkbdtLqOhJDhpRwWRVBFI6Km9Su6+M9GZj/ZGuqO/V9J8GI9Ix1YwPNAdWUpXqZVnB9IWk5bEJKfw4930AB7KSZUFhyuSt0KjCrb6oKgzFKh3xabZu3C0luvc/1ic5tOCL/Q+ERm7T+qOBb/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6xjuVATs6D3wjKZlrb9lrWmJ+kcuNY9mgUVnAPrK/gA=;
 b=nD5tmP/yiIAROEkm+oqa6X4rMSKvpdNXzCtI+tvyjtBpfllavj630D3D/stXQR57bsTwEuLE3Qnoy7FMbpZAQKudosDr1/Bli0mk3NnWf2+mGOQ1+xzPisktbQ4E1E9AjLrWTlLBOnYmlUW8qrL2SwFa/rQ23caoTYJLtnY4Woplx+AHb0nvZiDF2PsIh+YsfJcbrFVZXoVVaMLD3CfNMo8Ky1G1qWFRMK2JMqvCOwGcgs2DPkBi+Pzr/WMnmuKIOGzM2Muxbz8uRtI1cGdTzkmeDAA6HDN9u1hlBh0fp4ocfNLpmnbrkHB+unfi+3/uzICghB6hrE4eVqgbeMfbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB5328.eurprd04.prod.outlook.com (2603:10a6:803:59::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 07:26:52 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 07:26:51 +0000
Subject: Re: [PATCH v4 1/2] xen-pciback: prepare for the split for stub and PV
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, julien@xen.org,
        sstabellini@kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20210927065822.350973-1-andr2000@gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <e472468a-625e-6c4d-a9c2-85594e2ff908@suse.com>
Date:   Mon, 27 Sep 2021 09:26:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210927065822.350973-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
Received: from [10.156.60.236] (37.24.206.209) by PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 07:26:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9038d1b7-e2e0-4cad-e8c4-08d981882cbb
X-MS-TrafficTypeDiagnostic: VI1PR04MB5328:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5328D591A10AD0F8C815F2B6B3A79@VI1PR04MB5328.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vMYmP6i3vrL3r+WCsbUkwTo23NUZz0tMMKJOMG1lcOzFEZvOKRMa2/VI25NGN4TB6hyujfutFl4Z+oJqFbLSEr4gu5BaijlJRnowJ4IXQmMOqSMLFUAEYnJJsUOclGG6K90bwu4xqkJVSxvhDm2/K8T726FvkkvThtnoRjmA00Qdw86H3kMZEKMP9XuMCAiANqfOQ5l7a+0Dav5PmQ6y4+Ou9C2E6rSiVMVdpvBP+SMDCfFHgTlYfFOrT2eXVPBHcxW9BOajTEtbKxy8Gpddvj8lCKqD8WrC0lx8oqqOopvGd/RA149jDxHLitMHXD+lshrU7KyYjn5NujgMsj7M65z6le4ExnXzhrdJAi+1nT15egT0/7s/ZqOooQz77hrlVQ8tOf4OvXsm4LuSB75z7bIGtJf6783I6Dr2IUe0cKTioWGcRIU4r8zxj0ZZX3oqI3FBgvzoHx9h5Xydz+Hvfyu7bSdVZlf4fvH+sunHvp1/p/I6u51IY3jt0kdyiWWPKZwxkjhOgS5aNmo3s/6N8bJWUfjbQijUraEouhgAyfUTetyHEcjsmztuKAfgBhjmtGULUW9unK2fL9XG6XlKxQI/op6s/8dcrBdd1ixEDrZh2cGlF6N3GG6ArAeSX+uwBIUnbULv0JzhZZaNQyQnc4TdLABm4RZbYGYaP1RV2z6LnHKlNHHdeCfNV8SY3eBKiLyn/jHSUdK7OUO+wFbRi8A6dn225lf8JpZWsAZ+so=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(66946007)(53546011)(316002)(16576012)(8936002)(2906002)(4326008)(36756003)(66476007)(26005)(186003)(31696002)(2616005)(956004)(66556008)(86362001)(38100700002)(5660300002)(508600001)(6916009)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJUTzBDb2VMNTBBMk1QcG04THR4T2d1TmRHTHVRbVhZSk9CSDUxOUpRVVNT?=
 =?utf-8?B?c2t2MnlnV20yVXdleW9QV3A1TFNKNmhYejRmbEUvaThGaWJxTzk0RUErblJT?=
 =?utf-8?B?ZHl6VjdycGFIWjFuVThGZm1SR1V2L1VqZmZCcVIvTFV1Tkw5UUZrcnFibUlp?=
 =?utf-8?B?elZDTlQycytaeGhpT29GTTVyM3NYcXhSU2Rka0hTUGYvb2lLZ2d5aFdHemNQ?=
 =?utf-8?B?N1lDUEtqbTIrVEFITzdpS0hMbUg3SWx2ZGI3bHlRb2l5LzIrenF4RE45UG0r?=
 =?utf-8?B?NDdFdlovMU00Mi9TUWJXRXMxakNnWHNNdWxQVmphMlB1RkZTbkJHVkltMCtF?=
 =?utf-8?B?QWtFRmhPcWsrRWdWSERocHlTSGVZTzlFNCsrZkR2MjloRHVjWG5wRmtPWWlk?=
 =?utf-8?B?YnFYSzdMZ3A1NGZXbFdHK3RvR0E4bmhxN0VOdnlqS1h5ckxLbk0xSUhDcldq?=
 =?utf-8?B?RUZYUElLaUhCc2lSUEpqdWxWcm1TQUIyUXk5cjF3OHVjdk1nVm5kNGtWQjVO?=
 =?utf-8?B?Qk54aXlsNXkrbWdVbzZXeE9Ec3NLaTJvbERWc2JBdk5rZStlSEZwTGlWT1Bm?=
 =?utf-8?B?WnVtbFVuYTRRYUdZOEt4SVNkUElpa0tlZXZqQ2hqMG92SXg0dE1ZOWNNN1Yy?=
 =?utf-8?B?QzhDVWZNMzhyWHNMR1QwVzF0eFlnVVJQTElEUk9KQmpyL250QURIbTdXZGd0?=
 =?utf-8?B?MmN1SGdzRHF1VWlRRWQ3R2dzeVVUYTI0NGhmdmpzUWIvVlBieHR4T0VtRC9o?=
 =?utf-8?B?U2tkNk8yMTUwZGJnQkNRcXN2NUgxM1JDdVoyWmF3eFhjWmpKdEdxWlF2Ly9l?=
 =?utf-8?B?Sk82MEdiZ2lFS3lneTV6OUlpV1hoUmk5ZHgvTXQrb2lLVDgybHNxTFZjbzha?=
 =?utf-8?B?STFOaHlacERINWI3NHBNY0V5eVliQzRWQjNtZjR4TnhtV2h0MkNJOHorV2o2?=
 =?utf-8?B?UVc3eWg2RWFwaEZGM3BVNktHUHpUNHRHOGJnN3VRM0t0L0wvemllY1crZ05T?=
 =?utf-8?B?dC9RQ3NmN213OE5MVmtMdnp3eFpTSVZ5VzZFVGd4d0VTellDTDMxQnpPNnhI?=
 =?utf-8?B?UjhsZXJUNzJ5enI0NWZMOWFHQjA5ZDBCNE5tKzRBcTFGQ0Rrc2lUTFFIVjly?=
 =?utf-8?B?V3NPL2hpYlVMNXNRK2pKdkJsN0lJQTV1MGRaOWw4VVZ1bjM0TUxMMkNCY28v?=
 =?utf-8?B?d1Vwd3pmbnhIOU9XSGtTTkdCTnBYMG45QkJJdk4zRFl0ckxIVU5jVHQwTkky?=
 =?utf-8?B?SXp4Q3dKKzFDSndGYUVzWG1udjhLcTZlUUVUdU5KaFYrVi9Xb3UvcXVwbE9Z?=
 =?utf-8?B?ODhlYmo0aWs0dDlBNkpQdWRha2NmWm52amxyMHNQYTFHTm9GYjRDTjNnSndQ?=
 =?utf-8?B?ZVJTS1RxYm1RZVFKRCtBc2VhREI1enpHRUMrNHlRRjNwVU1tZEFSWUhkNk05?=
 =?utf-8?B?Mk42amwyQnJTdUJBYjh5TWpveitTeWVPa0ZIZFo1VW5zWkw2RnVEbll0ZkFz?=
 =?utf-8?B?ZlpkSGNqbVlEU0FzYUthMjFiUjlwVE5EUWxvT1RRMDlGRHVKd0hTcFA5VGpt?=
 =?utf-8?B?RWtOUk0rVkRqaVdOZ1pvMlFncXRCQXdPMHRsK0hHQXh4Q3lYVm1DQ1FNa1B1?=
 =?utf-8?B?MGgzUFpQeWJ3MnN0dkZlRWk4UkkxdUlOOGJaV1hoZkRXNkh5WHJQUDNSVlli?=
 =?utf-8?B?b09YcFptNUg4SjQ1eS9TaHJWcGpGQkZVUVBvdDdZUEJKU3hCNXdNVmRRQkpi?=
 =?utf-8?Q?R7BU/Sq9mqBjaEw1hFML0dnuw1emZ70JsDw/Iil?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9038d1b7-e2e0-4cad-e8c4-08d981882cbb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 07:26:51.6912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBZTzvjc4Q+LnMGsRbvKb8/ezmuBwke1OZQQkNhFgcL2bI02Swlu5f5F87EdalcHHT8vd11LfDVwp3KGiTT+mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.2021 08:58, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Currently PCI backend implements multiple functionalities at a time.
> To name a few:
> 1. It is used as a database for assignable PCI devices, e.g. xl
>    pci-assignable-{add|remove|list} manipulates that list. So, whenever
>    the toolstack needs to know which PCI devices can be passed through
>    it reads that from the relevant sysfs entries of the pciback.
> 2. It is used to hold the unbound PCI devices list, e.g. when passing
>    through a PCI device it needs to be unbound from the relevant device
>    driver and bound to pciback (strictly speaking it is not required
>    that the device is bound to pciback, but pciback is again used as a
>    database of the passed through PCI devices, so we can re-bind the
>    devices back to their original drivers when guest domain shuts down)
> 3. Device reset for the devices being passed through
> 4. Para-virtualised use-cases support
> 
> The para-virtualised part of the driver is not always needed as some
> architectures, e.g. Arm or x86 PVH Dom0, are not using backend-frontend
> model for PCI device passthrough. For such use-cases make the very
> first step in splitting the xen-pciback driver into two parts: Xen
> PCI stub and PCI PV backend drivers.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> ---
> Changes since v3:
> - Move CONFIG_XEN_PCIDEV_STUB to the second patch

I'm afraid this wasn't fully done:

> --- a/drivers/xen/xen-pciback/Makefile
> +++ b/drivers/xen/xen-pciback/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_XEN_PCIDEV_BACKEND) += xen-pciback.o
> +obj-$(CONFIG_XEN_PCIDEV_STUB) += xen-pciback.o

While benign when added here, this addition still doesn't seem to
belong here.

Jan

