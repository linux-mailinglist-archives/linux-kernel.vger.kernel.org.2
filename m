Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6235041D6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbhI3Jwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:52:54 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:40770
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234475AbhI3Jwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd8Ojwayiqz5YwJz2k7GkWT/DMc0gqGK28RBq79ZC+0=;
 b=cv7YwsKhxwxilqLP7nBzHHFH4hgSyo01rrAIsQMCs9Pl4QmdirLLK97CvuhIxSuwgSHzWH84HnhEkCCJkrx9Ga3BbZY1aOiTG8IUXNkgw+HPiXLUSayAT3dUMtCUjfmZ8p/NQLJmd/v2fD6+oFgx9H+T+Aq33W3uPPz1ZeZfSSY=
Received: from AM6PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:20b:2e::32)
 by VI1PR08MB3615.eurprd08.prod.outlook.com (2603:10a6:803:79::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Thu, 30 Sep
 2021 09:51:05 +0000
Received: from AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::9e) by AM6PR05CA0019.outlook.office365.com
 (2603:10a6:20b:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Thu, 30 Sep 2021 09:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.33.187.114)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.33.187.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.33.187.114; helo=64aa7808-outbound-2.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-2.mta.getcheckrecipient.com (63.33.187.114)
 by AM5EUR03FT032.mail.protection.outlook.com (10.152.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:51:04 +0000
Received: ("Tessian outbound 173d710607ad:v103"); Thu, 30 Sep 2021 09:51:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d20d9d04b3432dae
X-CR-MTA-TID: 64aa7808
Received: from c4fb74305dda.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E087028A-0C39-4014-9DFF-0059C59E4772.1;
        Thu, 30 Sep 2021 09:50:49 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c4fb74305dda.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 30 Sep 2021 09:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp9Yx8nTtRaS33pooSZYyPCjc+YJhN4VkZQ9evNG3OerFxjRpfW6GxDVBtOUGgnZOIO5NmaY+un3B4txd6yHcM+O+D7+Es62ZofkhTzRSsMd03eVbuo+S2CSE95Ud1Jv+LtSnWjldmDP10XU0L8n/EPea4N1AGfAiSlSgR529+JvRS8/5QNv5spk0bJbCcDnD/7+qnG2Mzrn7miCHNqsykA06Hm10rnenEZ/IsQJXlx2Bz6SKG4VzkJKzcV9LreBGWD/+bC6VjUFR5zgavzKAjYj+S/7wCBjCvwPrIpPy22QNDk+VkJ+HTsY2NWRSRCFNrenGBW4hspstJzJTGuPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Vd8Ojwayiqz5YwJz2k7GkWT/DMc0gqGK28RBq79ZC+0=;
 b=oC7zaIA7uMg+2cYB/JpQXd9y+mi6hgU7pOcdO4ue4V5Nnf+LCl4FLBXJ+WO+y9VyrYqakFVOcdPtsD3W7X1hogs2xc+Vd7/c+1F65ESK7goA8H+5opjBdeHBVnl9wlI/4IQYZYBmpm+Uf36YnemcyVzU+NbK0/Lj0E32V3Rzm6h5jVQvXjyv+YG6Gw4wKfaLXNVsV4jcjXCPnO51KAt0tRIRKPAVuHv7NoRd6I7woRBzpovpyv3Aa91WImP/B5YrYl0wTwSzjQ5G9TbktEHCKJFfVtFU1rMDwHkmaPR5RBOorAJMH4BNXKJ+UVvQB8JZ3I911hYkuOkbOE3UVCkCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd8Ojwayiqz5YwJz2k7GkWT/DMc0gqGK28RBq79ZC+0=;
 b=cv7YwsKhxwxilqLP7nBzHHFH4hgSyo01rrAIsQMCs9Pl4QmdirLLK97CvuhIxSuwgSHzWH84HnhEkCCJkrx9Ga3BbZY1aOiTG8IUXNkgw+HPiXLUSayAT3dUMtCUjfmZ8p/NQLJmd/v2fD6+oFgx9H+T+Aq33W3uPPz1ZeZfSSY=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB9PR08MB6410.eurprd08.prod.outlook.com (2603:10a6:10:262::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Thu, 30 Sep 2021 09:50:46 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 09:50:46 +0000
Subject: Re: [PATCH RFC v1 08/11] iommu/arm-smmu-v3: Implement shared context
 alloc and free ops
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-9-vivek.gautam@arm.com> <YUoDTv0bhbfcu4MS@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <6f8b1656-5ca0-c106-db7d-366e536f5575@arm.com>
Date:   Thu, 30 Sep 2021 15:20:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YUoDTv0bhbfcu4MS@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::27) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by BMXPR01CA0017.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 09:50:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc5c149-8032-45d2-efee-08d983f7d19c
X-MS-TrafficTypeDiagnostic: DB9PR08MB6410:|VI1PR08MB3615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3615A19E94438F190B540E2089AA9@VI1PR08MB3615.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iin10Gs/ynEOUNTWCDkazHStSSb4G83BR9lbBXnDtrPzCDwiFkFogGSpkXuOFQuaxJPkPGDPIzEvHXw0HhOM+Lo1/HY039sLDEf7viLHYvPJ/Tz59N1NBm3rigKMlWqS5vrB5fC4cdZE6YPo2ETy/uZfERWu/akKp52c0SOlDVb/QobaTAanspB2pTMZasTcWJRiOcpC3A+6bqX8M6sqKuFVNguIUgrY/3qOfpzqmhdUZMAZ7+ebjNEa/xOPvFzY2eqzLvMnN5MArZRlajahCcI3ubuCoKs2qrqPDgFzuneUYD+5wSy7+0yMNN39djySIDEZIR6dPlLiLB/nET2/RBQ8tABOzbTJFn5GKBURBcSr2lpp8zmhJl8bqx5wrXkwnb3Hv07ma1UDMtisoV40nj4CIYighs5URdIDXA5t5umNxhJ00U/XlOaQJZU+PDfjdBiMVyxk8ZFWn8IWsXeGkXoYaNKNqIARu7+Mv/MIKY6Al2wFaYC5VyGMkmyxLDP9phV6OCro92ejDIp+Bu19JWoCjfFzXV/qB/413WKuAl0EiTvAvJQPD7VS0Rm0xrQ8MFqDFrFsl5qcbq78VJwFogkiEGfI7ZrKIbD4LoTa3bX/0M1l42EyVGCHirDiRcds81LHLAOOAEL69+43SnBZChYGChmeCSoddaxWSHVI2mvF/y+1N5dEJfXc8W9Sc0fEdQRKCMr5DQC+OkryYQQ1RVaKdn4wOZVQyFOa/IeBcKVnazHby3zxLbd8j5vtHHtGFUr52GBbeHyyI68cTjIWkA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2645.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(31696002)(316002)(6486002)(16576012)(956004)(2616005)(5660300002)(53546011)(30864003)(186003)(7416002)(66476007)(66556008)(2906002)(38350700002)(38100700002)(6666004)(6916009)(26005)(31686004)(86362001)(66946007)(52116002)(8936002)(36756003)(8676002)(83380400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6410
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: af59c037-c146-4d37-9e18-08d983f7c1bb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DRyo/91YdNJt4KuB6gXYDg2ixR8xjO4pkDPsRCCqMG65Fs7iEt49CaV2QuM2bVQY8v2w67byMD+v8YuOqLAfawgI+QXS+/d1BtIjVOLe4r7a4yYsr11U0n90/El6lG7HbInDxm/nDz3pO2Q04o/ESw7H+15XA3IPEefRvppWfwpGJ6RQV5+6AMW8gXlpIJe0DRpcuV1490412H853vhb11EiHQQFyHbTCeSMuF+PlbusU6MwrnavgNtNs7yEEew7Pz57fmp4KWh2P7AwfBQubInlV0WKKORsTkXzdvQR3qAaOMPRsHkM5ukAnDdV/3Vb4zv/HgyT9IEVIhnIWznlwPjLOoQmooBf8beh1EH7hdKjjJ3TAhI12XsKvMplc/crVZWQuhyfMpbxX55C7smtkzU+kDXIV649oGxDim7hr9i2wYMHGQEIQ2RxrDI7nYXJ+nIHFeoB0rG8pM43Bh2D4ip8UWjjHCBpsJXYNJG7w231an7ZAt9hgHzEaD/+5Aaz3BLUpRMY6snu/zbfozNwC/QpQkW8vy3FRuTpJnQue5Qv/P5Zvj18LLjsFgVhxDKjeAdTHLVhz6Nlv0ZAqgWaXBiWXY+n3HP6fFN5VDlt1d247/ycqiybT05wNBPld300ivabfoDl+UIMC7t4VXIKzt7I2wG6KJQL2K02p/lb7m3IAzR6F7PSJm1bITbFnFgI2/r/0NX4DSuiZyaT5NlAlwP9eCphXXxy/AO1DObo9I=
X-Forefront-Antispam-Report: CIP:63.33.187.114;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-2.mta.getcheckrecipient.com;PTR:ec2-63-33-187-114.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(30864003)(31686004)(2616005)(5660300002)(956004)(6862004)(86362001)(36756003)(31696002)(6486002)(6666004)(8936002)(36860700001)(8676002)(356005)(81166007)(107886003)(2906002)(336012)(83380400001)(316002)(26005)(508600001)(47076005)(70586007)(186003)(82310400003)(16576012)(53546011)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:51:04.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc5c149-8032-45d2-efee-08d983f7d19c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.33.187.114];Helo=[64aa7808-outbound-2.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,


On 9/21/21 9:37 PM, Jean-Philippe Brucker wrote:
> On Fri, Apr 23, 2021 at 03:21:44PM +0530, Vivek Gautam wrote:
>> Implementing the alloc_shared_cd and free_shared_cd in cd-lib, and
>> start using them for arm-smmu-v3-sva implementation.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 71 ++++++++--------
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 83 ++++++++-----------
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ----
>>   4 files changed, 73 insertions(+), 96 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> index 537b7c784d40..b87829796596 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
>> @@ -285,16 +285,14 @@ static bool arm_smmu_free_asid(struct xarray *xa, void *cookie_cd)
>>    * descriptor is using it, try to replace it.
>>    */
>>   static struct arm_smmu_ctx_desc *
>> -arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>> +arm_smmu_share_asid(struct iommu_pasid_table *tbl, struct mm_struct *mm,
>> +		    struct xarray *xa, u16 asid, u32 asid_bits)
> 
> xa and asid_bits could be stored in some arch-specific section of the
> iommu_pasid_table struct. Other table drivers wouldn't need those
> arguments.

Okay, will move them to a separate structure section.

> 
> More a comment for the parent series: it may be clearer to give a
> different prefix to functions in this file (arm_smmu_cd_, pst_arm_?).
> Reading this patch I'm a little confused by what belongs in the IOMMU
> driver and what is done by this library. (I also keep reading 'tbl' as
> 'tlb'. Maybe we could make it 'table' since that doesn't take a lot more
> space)

Yea, this may be confusing. I will fix these namings in my next version.

> 
>>   {
>>   	int ret;
>>   	u32 new_asid;
>>   	struct arm_smmu_ctx_desc *cd;
>> -	struct arm_smmu_device *smmu;
>> -	struct arm_smmu_domain *smmu_domain;
>> -	struct iommu_pasid_table *tbl;
>>   
>> -	cd = xa_load(&arm_smmu_asid_xa, asid);
>> +	cd = xa_load(xa, asid);
>>   	if (!cd)
>>   		return NULL;
>>   
>> @@ -306,12 +304,8 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>>   		return cd;
>>   	}
>>   
>> -	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
>> -	smmu = smmu_domain->smmu;
>> -	tbl = smmu_domain->tbl;
>> -
>> -	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
>> -		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
>> +	ret = xa_alloc(xa, &new_asid, cd, XA_LIMIT(1, (1 << asid_bits) - 1),
>> +		       GFP_KERNEL);
>>   	if (ret)
>>   		return ERR_PTR(-ENOSPC);
>>   	/*
>> @@ -325,48 +319,52 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>>   	 * be some overlap between use of both ASIDs, until we invalidate the
>>   	 * TLB.
>>   	 */
>> -	ret = iommu_psdtable_write(tbl, &tbl->cfg, 0, cd);
>> +	ret = arm_smmu_write_ctx_desc(&tbl->cfg, 0, cd);
>>   	if (ret)
>>   		return ERR_PTR(-ENOSYS);
>>   
>>   	/* Invalidate TLB entries previously associated with that context */
>> -	iommu_psdtable_flush_tlb(tbl, smmu_domain, asid);
>> +	iommu_psdtable_flush_tlb(tbl, tbl->cookie, asid);
>>   
>> -	xa_erase(&arm_smmu_asid_xa, asid);
>> +	xa_erase(xa, asid);
>>   	return NULL;
>>   }
>>   
>> -struct arm_smmu_ctx_desc *
>> -arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
>> +static struct iommu_psdtable_mmu_notifier *
>> +arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm,
>> +			 struct xarray *xa, u32 asid_bits)
>>   {
>>   	u16 asid;
>>   	int err = 0;
>>   	u64 tcr, par, reg;
>>   	struct arm_smmu_ctx_desc *cd;
>>   	struct arm_smmu_ctx_desc *ret = NULL;
>> +	struct iommu_psdtable_mmu_notifier *pst_mn;
>>   
>>   	asid = arm64_mm_context_get(mm);
>>   	if (!asid)
>>   		return ERR_PTR(-ESRCH);
>>   
>> +	pst_mn = kzalloc(sizeof(*pst_mn), GFP_KERNEL);
>> +	if (!pst_mn) {
>> +		err = -ENOMEM;
>> +		goto out_put_context;
>> +	}
>> +
>>   	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
>>   	if (!cd) {
>>   		err = -ENOMEM;
>> -		goto out_put_context;
>> +		goto out_free_mn;
>>   	}
>>   
>>   	refcount_set(&cd->refs, 1);
>>   
>> -	mutex_lock(&arm_smmu_asid_lock);
>> -	ret = arm_smmu_share_asid(mm, asid);
>> +	ret = arm_smmu_share_asid(tbl, mm, xa, asid, asid_bits);
>>   	if (ret) {
>> -		mutex_unlock(&arm_smmu_asid_lock);
>>   		goto out_free_cd;
>>   	}
>>   
>> -	err = xa_insert(&arm_smmu_asid_xa, asid, cd, GFP_KERNEL);
>> -	mutex_unlock(&arm_smmu_asid_lock);
>> -
>> +	err = xa_insert(xa, asid, cd, GFP_KERNEL);
>>   	if (err)
>>   		goto out_free_asid;
>>   
>> @@ -406,21 +404,26 @@ arm_smmu_alloc_shared_cd(struct iommu_pasid_table *tbl, struct mm_struct *mm)
>>   	cd->asid = asid;
>>   	cd->mm = mm;
>>   
>> -	return cd;
>> +	pst_mn->vendor.cd = cd;
>> +	return pst_mn;
>>   
>>   out_free_asid:
>> -	iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd);
>> +	arm_smmu_free_asid(xa, cd);
>>   out_free_cd:
>>   	kfree(cd);
>> +out_free_mn:
>> +	kfree(pst_mn);
>>   out_put_context:
>>   	arm64_mm_context_put(mm);
>>   	return err < 0 ? ERR_PTR(err) : ret;
>>   }
>>   
>> -void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
>> -			     struct arm_smmu_ctx_desc *cd)
>> +static void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
>> +				    struct xarray *xa, void *cookie)
> 
> Could we pass a struct iommu_psdtable_mmu_notifier, since that's what
> alloc_shared() returns?

Sure, will update this.

> 
>>   {
>> -	if (iommu_psdtable_free_asid(tbl, &arm_smmu_asid_xa, cd)) {
>> +	struct arm_smmu_ctx_desc *cd = cookie;
>> +
>> +	if (iommu_psdtable_free_asid(tbl, xa, cd)) {
>>   		/* Unpin ASID */
>>   		arm64_mm_context_put(cd->mm);
>>   		kfree(cd);
>> @@ -428,11 +431,13 @@ void arm_smmu_free_shared_cd(struct iommu_pasid_table *tbl,
>>   }
>>   
>>   struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
>> -	.alloc	 = arm_smmu_alloc_cd_tables,
>> -	.free	 = arm_smmu_free_cd_tables,
>> -	.prepare = arm_smmu_prepare_cd,
>> -	.write	 = arm_smmu_write_ctx_desc,
>> -	.free_asid = arm_smmu_free_asid,
>> +	.alloc		= arm_smmu_alloc_cd_tables,
>> +	.free		= arm_smmu_free_cd_tables,
>> +	.prepare	= arm_smmu_prepare_cd,
>> +	.write		= arm_smmu_write_ctx_desc,
>> +	.free_asid	= arm_smmu_free_asid,
>> +	.alloc_shared	= arm_smmu_alloc_shared_cd,
>> +	.free_shared	= arm_smmu_free_shared_cd,
>>   };
>>   
>>   struct iommu_pasid_table *
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index da35d4cc0c1e..ef28d0c409da 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -13,23 +13,12 @@
>>   #include "../../io-pgtable-arm.h"
>>   #include "../../iommu-pasid-table.h"
>>   
>> -struct arm_smmu_mmu_notifier {
>> -	struct mmu_notifier		mn;
>> -	struct arm_smmu_ctx_desc	*cd;
>> -	bool				cleared;
>> -	refcount_t			refs;
>> -	struct list_head		list;
>> -	struct arm_smmu_domain		*domain;
>> -};
>> -
>> -#define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
>> -
>>   struct arm_smmu_bond {
>> -	struct iommu_sva		sva;
>> -	struct mm_struct		*mm;
>> -	struct arm_smmu_mmu_notifier	*smmu_mn;
>> -	struct list_head		list;
>> -	refcount_t			refs;
>> +	struct iommu_sva			sva;
>> +	struct mm_struct			*mm;
>> +	struct iommu_psdtable_mmu_notifier	*smmu_mn;
>> +	struct list_head			list;
>> +	refcount_t				refs;
>>   };
>>   
>>   #define sva_to_bond(handle) \
>> @@ -41,20 +30,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>>   					 struct mm_struct *mm,
>>   					 unsigned long start, unsigned long end)
>>   {
>> -	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>> -	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
>> +	struct iommu_psdtable_mmu_notifier *smmu_mn = mn_to_pstiommu(mn);
>> +	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
>> +	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
>>   	size_t size = end - start + 1;
>>   
>>   	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
>> -		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
>> +		arm_smmu_tlb_inv_range_asid(start, size, cd->asid,
>>   					    PAGE_SIZE, false, smmu_domain);
>>   	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
>>   }
>>   
>>   static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>>   {
>> -	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>> -	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
>> +	struct iommu_psdtable_mmu_notifier *smmu_mn = mn_to_pstiommu(mn);
>> +	struct arm_smmu_domain *smmu_domain = smmu_mn->cookie;
>> +	struct arm_smmu_ctx_desc *cd = smmu_mn->vendor.cd;
>>   	struct iommu_pasid_table *tbl = smmu_domain->tbl;
>>   
>>   	mutex_lock(&sva_lock);
>> @@ -69,7 +60,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>>   	 */
>>   	iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, &quiet_cd);
> 
> Another comment for the parent series: I'd prefer making this a
> "iommu_psdtable_quiesce()" call, instead of passing "quiet_cd" between
> driver and library. Because that won't work if the SMMU driver is a module
> or disabled - build of virtio-iommu will probably fail since quiet_cd will
> be undefined. We could make the library built-in and move quiet_cd there,
> but an explicit library call seems cleaner.

Right, having a separte library method would look cleaner. I will update 
this and the below flush_tlb() call.

> 
>>   
>> -	iommu_psdtable_flush_tlb(tbl, smmu_domain, smmu_mn->cd->asid);
>> +	iommu_psdtable_flush_tlb(tbl, smmu_domain, cd->asid);
> 
> We can directly call arm_smmu_tlb_inv* here. iommu_psdtable_flush_tlb()
> should only be called from the library. But with the previous comment,
> this invalidation would move to the library.
> 
>>   	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
>>   
>>   	smmu_mn->cleared = true;
>> @@ -78,7 +69,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>>   
>>   static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
>>   {
>> -	kfree(mn_to_smmu(mn));
>> +	kfree(mn_to_pstiommu(mn));
>>   }
>>   
>>   static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
>> @@ -88,63 +79,59 @@ static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
>>   };
>>   
>>   /* Allocate or get existing MMU notifier for this {domain, mm} pair */
>> -static struct arm_smmu_mmu_notifier *
>> +static struct iommu_psdtable_mmu_notifier *
>>   arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
>>   			  struct mm_struct *mm)
>>   {
>>   	int ret;
>> -	struct arm_smmu_ctx_desc *cd;
>> -	struct arm_smmu_mmu_notifier *smmu_mn;
>> +	struct iommu_psdtable_mmu_notifier *smmu_mn;
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>>   	struct iommu_pasid_table *tbl = smmu_domain->tbl;
>>   
>> -	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
>> +	list_for_each_entry(smmu_mn, &tbl->mmu_notifiers, list) {
>>   		if (smmu_mn->mn.mm == mm) {
>>   			refcount_inc(&smmu_mn->refs);
>>   			return smmu_mn;
>>   		}
>>   	}
>>   
>> -	cd = arm_smmu_alloc_shared_cd(tbl, mm);
>> -	if (IS_ERR(cd))
>> -		return ERR_CAST(cd);
>> -
>> -	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
>> -	if (!smmu_mn) {
>> -		ret = -ENOMEM;
>> -		goto err_free_cd;
>> -	}
>> +	mutex_lock(&arm_smmu_asid_lock);
>> +	smmu_mn = iommu_psdtable_alloc_shared(tbl, mm, &arm_smmu_asid_xa,
>> +					      smmu->asid_bits);
>> +	mutex_unlock(&arm_smmu_asid_lock);
>> +	if (IS_ERR(smmu_mn))
>> +		return ERR_CAST(smmu_mn);
>>   
>>   	refcount_set(&smmu_mn->refs, 1);
>> -	smmu_mn->cd = cd;
>> -	smmu_mn->domain = smmu_domain;
>> +	smmu_mn->cookie = smmu_domain;
>>   	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
>>   
>>   	ret = mmu_notifier_register(&smmu_mn->mn, mm);
>> -	if (ret) {
>> -		kfree(smmu_mn);
>> +	if (ret)
>>   		goto err_free_cd;
>> -	}
>>   
>> -	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid, cd);
>> +	ret = iommu_psdtable_write(tbl, &tbl->cfg, mm->pasid,
>> +				   smmu_mn->vendor.cd);
> 
> Pass smmu_mn here, and let the library code get the cd (to allow for other
> pasid table implementations)

Okay.

> 
>>   	if (ret)
>>   		goto err_put_notifier;
>>   
>> -	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
>> +	list_add(&smmu_mn->list, &tbl->mmu_notifiers);
> 
> I'd keep the mmu_notifiers list in domain if the library doesn't use it
> for anything.
> 
> That made me wonder whether the whole of arm_smmu_mmu_notifer_get/put()
> could move to the library, since the virtio-iommu version seems to be the
> same. They probably belong in iommu-sva-lib but we can revisit that when
> there are more users.

Yea, I will move these notifier calls to the library. This makes it 
easier for virtio-iommu too.

Best regards
Vivek

> 
> Thanks,
> Jean
> 

[snip]

>> -- 
>> 2.17.1
>>
