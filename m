Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F204133D9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhCPQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:44:12 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:58592
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236502AbhCPQne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT5b0hK4gYiAVwTuWm+/cJaYBoEHth/ouszA8Ie7cDTnN25yfUHE6/GMJvTi1RuvXRw9Cl4vTaWrDYZ/JtO78E8dt2m7wGzTpYsJYwydD6yvQqWWV1ywXViMisnSli+eVm23ng4fo9lyNh9IE/S4b/liqaXo3ayBFZcg4rQxyTFTl95S2g73lOvuJ0GXqzTOtJPObd+ZyhMS4YOMuRTV49vLy3ZXD7weEM9Ur3xqqc1YeMz3okS6+FmBkCtmoYMnihLonKq5aXc9cLcpqZGrbupY0E5CxVGdTbEcSaMGtm8iKvH650mwJo7s//eX+vuG6aibEjl7Xx8v7TdvYf3ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2kpCopuxGFCQ2cgT9H6faPk6qyV28HX1zBOqMGnYS4=;
 b=ldJwG35i1QzhFPwLUVuAlG7f8w2V/Dxi23FtLuKwN/torN+4KmAuQSRRadys5RvHpxzhcpW01pXZrcZNpMgnMd+iy1hfdCs9+1Kh6foi6qab2ht1kZPQTSuTcxVyMamKZxtbYSzwKnxaKTEQ6oFfwhIyeJWwHkxNLQTsnMr2i1se5RAfskF/4/MkicUWkG0jcsJqeBoqEiK5MpaR+vIHbjAPhW4m12WOGN6JMNklG4vcWNb1UVArGVFaT9EGzUt51u/gUa6rmioLE+qOvwf6KPEeyWH0z+GO5hMmU5baGJOYXeJRvMyoWBbsnGO8u4PVWbWCXJruGb+HODNoRT/jRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2kpCopuxGFCQ2cgT9H6faPk6qyV28HX1zBOqMGnYS4=;
 b=mzC5wvOm8JEUK1emkyax4NQMj895Pi3Ov19rxzq/Jzpofc4+SAAo6KDire5ND3cTdFkzxBd7YVji0RTmPqq/PHfx4XaTXt+JnzYxLH58TEe7Bo08bHBUSpuOhFXDTW1BOpkzY16+Vpnw4Mlbyb6qG+nOw7jDsxacy3phZVUAuK1cR3sY0RprLhHSVB+tii9Oq+jgnsxx8XEvhUhu/nEopPSHtpB+2gn7ndhBvpfm18zSTgSXEPQYtM1Esueh63DBalsHX2I+4WYjV9NY9b0jBmIfm9ra3ChnBceaol6bmms1c4yD3pXqlVQOexsR9k943dJXBvIhPk1iIz/N0yO/kg==
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by CY4PR12MB1205.namprd12.prod.outlook.com (2603:10b6:903:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 16:43:31 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::1) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 16:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 16:43:31 +0000
Received: from rcampbell-test.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 16:43:30 +0000
Subject: Re: [PATCH] lib/test_hmm.c: fix harmless shift wrapping bug
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <YFCZ1NNfMoixOjWP@mwanda>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <6f1a3909-c42e-be33-6cc2-0ecc32f59b1c@nvidia.com>
Date:   Tue, 16 Mar 2021 09:43:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFCZ1NNfMoixOjWP@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d42f74b-a290-4795-6ad3-08d8e89aa217
X-MS-TrafficTypeDiagnostic: CY4PR12MB1205:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1205E07E0EE52F1DDD8369C5C26B9@CY4PR12MB1205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYKxmci7SlTGWAvk4BOJ/rvdMpT4w6kqT1UVMBdKXMckSk5H5JnCwWrfOY8GVey22pxC+w2V1H84CvDqqDzSBUoejoAvXYhqsuDxamYPy6rJXF74QZ+C7cvFgCZZUFbjV7UbCfM/HUIAEWXATJ8Mf6+nM69/LVYjRi+7+A3hbWg8VFOKKkAtceJhfkY+BkIukOoK3/8vNIjT82oySknZHa/oeFhxbTyhb71s4Q1hzYZp0v//FMokU3xSrBLIXyT0tcqq68p9gvPlcEBYEK1P0q73pVYRED4l3V1mNK9wLEJd6FFiIv04oZU2q9Rjzmd/gl+oqzYiG+Tn3VYCxSikyCux4AdCuGeDyH7U8QeY9KythPQj6EBB5gNh4op/qE6KAjwzN59jH9X8BTntB1iJGX1mfKV3nOxcOKAFU5TQZYwFTkxQCXea34qIk5aB2wKb+9o2T3tjur5Hm2WJdl52g+m5tnoJs69vVybxR/h1DGH8SzCeWKMxzjOxFYN3DIROq1X2YdaNrsWDI3hZIerLKg+Lfo8tkzxvILY3TlOP2BaMEISt3QcVPaLWPOdjG4sMp/KzMmpXcYmeZfXA17NlF9ur4Xh98BVXeUTO7B9eYANr4ZxiCvEkb4TeV8bXHCHmFL/JgNCTzPhHz7YKC5BHGYCuxYfGxllMZIS8Yws/LS4e0SXlqEC52tsCZvJpxd5ommClgKKiIsF/yXUgNqyqhsSGZC3C0E2vsOfB06LgVBk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(31696002)(2616005)(86362001)(34020700004)(8676002)(8936002)(82310400003)(7636003)(426003)(36906005)(186003)(82740400003)(336012)(31686004)(7696005)(5660300002)(54906003)(478600001)(4326008)(2906002)(70586007)(83380400001)(36756003)(356005)(53546011)(70206006)(316002)(47076005)(16526019)(26005)(36860700001)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 16:43:31.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d42f74b-a290-4795-6ad3-08d8e89aa217
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/16/21 4:43 AM, Dan Carpenter wrote:
> The "cmd.npages" variable is a u64 that comes from the user.  I noticed
> during review that it could have a shift wrapping bug when it is used
> in the integer overflow test on the next line.
> 
> It turns out this is harmless.  The users all do:
> 
> 	unsigned long size = cmd->npages << PAGE_SHIFT;
> 
> and after that "size" is used consistently and "cmd->npages" is never
> used again.  So even when there is an integer overflow, everything works
> fine.
> 
> Even though this is harmless, I believe syzbot will complain and fixing
> it makes the code easier to read.
> 
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>   lib/test_hmm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 80a78877bd93..541466034a6b 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -930,6 +930,8 @@ static long dmirror_fops_unlocked_ioctl(struct file *filp,
>   
>   	if (cmd.addr & ~PAGE_MASK)
>   		return -EINVAL;
> +	if (cmd.npages > ULONG_MAX >> PAGE_SHIFT)
> +		return -EINVAL;
>   	if (cmd.addr >= (cmd.addr + (cmd.npages << PAGE_SHIFT)))
>   		return -EINVAL;

Looks good to me too. Thanks for sending this.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
