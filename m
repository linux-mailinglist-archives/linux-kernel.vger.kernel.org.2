Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE841D620
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349301AbhI3JUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:20:21 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:4318
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349293AbhI3JUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbHdMatNyBsDyuk3SpOYd8aR1cIw6x96U2sANrsCPeg=;
 b=6SNf2Rcl1ytFc/pe30qBJ1/rOT+tvxTKOMGNHV5Sq2BTYFyLNG4Mp8WuPswyYuSdPUuySSwd2sd9u1BJjWwE4aTM5r1KdJN4DqXDJ0gLJo44SapO8jKNcFmMle+0CY4Hub542yPQ6LraOlznzaY24mKw4LBDhJV4JN2qySJ32lE=
Received: from AM5PR1001CA0009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::22)
 by VE1PR08MB4750.eurprd08.prod.outlook.com (2603:10a6:802:a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 30 Sep
 2021 09:18:31 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:2:cafe::23) by AM5PR1001CA0009.outlook.office365.com
 (2603:10a6:206:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Thu, 30 Sep 2021 09:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:18:31 +0000
Received: ("Tessian outbound a492f2284909:v103"); Thu, 30 Sep 2021 09:18:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3c90e2d815972e18
X-CR-MTA-TID: 64aa7808
Received: from 096e87c2e5d3.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1D0532EA-16E5-47D9-89F3-09BEC99DAF15.1;
        Thu, 30 Sep 2021 09:18:18 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 096e87c2e5d3.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 30 Sep 2021 09:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8GLfQEjLhQRWGIYCFaZlYxwQXOaIscYChM+NG9xrdNr0wQuzOF63qQ52Og+DkYbwxX3KwyPqVB3na624Eu7rYoJbfTNZys/WwyHf/Dss2O1C5PYbtMAu8ZNXoVW9J2JDiIA7l72AI4twZo87JC1MFdB9JH6FM6cOxH+WaffWw54xyh/L9hQRzFwTQHrX1CjcvshXO+ds5u26tcH2tasJ+LCnDFTcxuFcAIdsG6tyU53tgGZ1WZXAHzzPpSOmkgr9GXbt6jQumngCLJf2Om8cyfZGwSStvR9KTbfdepzTLav4LXf23cZ29W7j2IXfFPBtY9P4Kwnz/iCXXMW/zCbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jbHdMatNyBsDyuk3SpOYd8aR1cIw6x96U2sANrsCPeg=;
 b=QEsEq5CCvuPSBPyhfyLhcRBRGTrUuvCzqqG7z0fyzspmB99eVW7AshcXMSQCPYRGQ452Wqwja4uLUpU8sdNC9Ut1yIiHBSzkN2dooTwkz91s4XPUi/mTI9NdR7XB91waHzgtx+kZpczTvZ7ml5ZC4yg0vYw7s4Ccp6j+0yQseZQ/NpvnxfXj2b5nx5iWNzDs5O7hWBqYezmNYiU9cNyt1Zz+SqGGUFVRu1d6ywqLPioNmKKeBB3Cb+3qdM6FltYN1wVK3xh3lZeVgJFVvWlvY1aC/jLhim6Tg8Go7W8ocDRIQYECeZndHSc5JUJnPKl3rNtEVZnyre8p0ke+8LUnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbHdMatNyBsDyuk3SpOYd8aR1cIw6x96U2sANrsCPeg=;
 b=6SNf2Rcl1ytFc/pe30qBJ1/rOT+tvxTKOMGNHV5Sq2BTYFyLNG4Mp8WuPswyYuSdPUuySSwd2sd9u1BJjWwE4aTM5r1KdJN4DqXDJ0gLJo44SapO8jKNcFmMle+0CY4Hub542yPQ6LraOlznzaY24mKw4LBDhJV4JN2qySJ32lE=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB6PR08MB2774.eurprd08.prod.outlook.com (2603:10a6:6:23::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Thu, 30 Sep 2021 09:18:14 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 09:18:14 +0000
Subject: Re: [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints
 served by viommu_dev
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-3-vivek.gautam@arm.com> <YUoBW13+CvIljUgc@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <814df96d-8796-44f6-d5e5-09f36862c497@arm.com>
Date:   Thu, 30 Sep 2021 14:47:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YUoBW13+CvIljUgc@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::21) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by BMXPR01CA0035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:17:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 170be635-137a-4803-4f8d-08d983f345aa
X-MS-TrafficTypeDiagnostic: DB6PR08MB2774:|VE1PR08MB4750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB47502C214639C83F218C0D8589AA9@VE1PR08MB4750.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: auCmK2m67cDDwfoW+87RP3OBY7q73LGruh0YPR6/m2CTjeaISBNQF/U6aAYvgoL8gLIYSkid5Hq1Bd6e7MKp7dFyfZ04k6xpKpKzO/sTIN858NDq4nPIo42hlOzi/NUW0JsWiaTilmw0AvfHUJ87BR1PrxwMfaVNIEbayRY+cOCcP3zCOICsQYUNul0mMc90B4J0mhKUY6phV3vLKj8BT+K/fczfg4L7EZB1gA7pkUl5GIpH9goXe5oSxSSXyEceKZEuQZMH4xiqTXr2t+dqM/tot3q/AIR+nMKrp6QYOPGL+ior7pecJR/4jkXYsEcSnIHaCTYA/PmrL85pQnnA+ZPhGKPk3yGrT1V5f6F11J/XCnoDIvcWiqaAyx9tEUloT8+LXCZv38nUQQK6CF3CVt0pS3So9M5a7bky8jmQc9Cp8B4Ylxv8gorNtDCKzWS0WYjYxt3O9sJVbf0M7cYKNQZP4S0vk/jMgjeuzHoNsNFK5X87DDzX1+mG4Sb3YBG4lpe4/9nhD4a7ofa22WTUnD6/qD/VYNX/PCeBa7C+1ttrkdJkPsaujWiyZMc89llU8Bwt9UbxOchCxXIMq4Q+YB96plxkmAN10V9MhxH1Z2X7vu9mnIxdlIq8+i57k+qo+Vfhou1mAbn80irMdjOcIxrf2b5Sb9sxx4TLXs9DWWZDZFmdAyv3eJk5b57vWbz3vHwASSK0MijyZwJNZZe/5m+88Aa2SstDNh7bSvrZv9GHJsNugGKH+It5Cb3asfOc0AjeDcWMeaz0psZCyaRqmw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2645.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(66946007)(956004)(316002)(16576012)(53546011)(2616005)(86362001)(8936002)(8676002)(508600001)(38100700002)(38350700002)(2906002)(26005)(5660300002)(186003)(6486002)(4326008)(83380400001)(6666004)(6916009)(31686004)(36756003)(52116002)(31696002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2774
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c7fe981e-174b-471a-a77b-08d983f333ab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/VBgXCWQnghQj+smx0EmK/gAWgxqlmVTg20AbWDU6W8C8zCfWwTc/6PsrpWEEnDopu1gNxthOu3GLiEgFK/eP2r3Xn7ykS6KmBWJCsHhQ0ViBtgGPYP/WOFYB5SAy8oz+mAlnNuNQHay4M5QxCZgoqWXArMUd8+kL52PQ6kKyETxO4zcziTZpqHj09WCfCh/Cv8x6r+5aGIRAcU6Z7gEsfU5reSrWFJesYfg2JQz+EUIuim9N4t3mo0oT2wYW8DQjiA6c2ThOI8NIl8ySa2Ns1TYCHGoS6vjeo/kjuVVv+GPNom2kRzr20BZFD/NjDlB8x2PuOHzLb1gQ8QrsRbvSUDPy7v3fHbUwQnKUv7qwKucnejLBSALu1wD8QoxZAOnayzBuKb8xRpTW/PRiWsJgiMuap0gK+rPRYRg3MbyKsKluysePpgA1mPUwwLk5ZFBCmAU9br0jHPXIloIPW8RgWj8Vsz5Z4fHOLcKrD502mCCvnExZobSb0o5N1VzPG2IjTX1CP6nTNQBR8lhiRXkG/D/YupwI9RaVOIMpwVHPVwHXukuV8cfBTyynh/mYYRBEZ9Tq1GKN+boPMY7wHu3ok8EdNgXiznjlXusTN8llZx/XdmPkkdNm6zPSSNBRPVDu24hSdj33Y0HxuaLYMH+2DmvfhNBcI0BdoniryxJFJsbXKsYwNUhqvz+xj9GwYoPhDH/Lw1QDoUtsfOB9aLwOd4RoKSYO0R7ynVZLCGwRA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(956004)(336012)(8936002)(83380400001)(6666004)(2906002)(31686004)(107886003)(2616005)(47076005)(186003)(26005)(316002)(81166007)(70206006)(82310400003)(36860700001)(4326008)(8676002)(53546011)(31696002)(356005)(16576012)(86362001)(70586007)(508600001)(6486002)(36756003)(5660300002)(6862004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:18:31.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 170be635-137a-4803-4f8d-08d983f345aa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 9:29 PM, Jean-Philippe Brucker wrote:
> On Fri, Apr 23, 2021 at 03:21:38PM +0530, Vivek Gautam wrote:
>> Keeping a record of list of endpoints that are served by the virtio-iommu
>> device would help in redirecting the requests of page faults to the
>> correct endpoint device to handle such requests.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   drivers/iommu/virtio-iommu.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index 50039070e2aa..c970f386f031 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -48,6 +48,7 @@ struct viommu_dev {
>>   	spinlock_t			request_lock;
>>   	struct list_head		requests;
>>   	void				*evts;
>> +	struct list_head		endpoints;
> 
> As we're going to search by ID, an xarray or rb_tree would be more
> appropriate than a list

Sure, I will update this with a rb_tree.

> 
>>   
>>   	/* Device configuration */
>>   	struct iommu_domain_geometry	geometry;
>> @@ -115,6 +116,12 @@ struct viommu_endpoint {
>>   	void				*pgtf;
>>   };
>>   
>> +struct viommu_ep_entry {
>> +	u32				eid;
>> +	struct viommu_endpoint		*vdev;
>> +	struct list_head		list;
>> +};
> 
> No need for a separate struct, I think you can just add the list head and
> id into viommu_endpoint.

Yea right. I will update it.

> 
>> +
>>   struct viommu_request {
>>   	struct list_head		list;
>>   	void				*writeback;
>> @@ -573,6 +580,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>>   	size_t probe_len;
>>   	struct virtio_iommu_req_probe *probe;
>>   	struct virtio_iommu_probe_property *prop;
>> +	struct viommu_ep_entry *ep;
>>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>   	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>>   
>> @@ -640,6 +648,18 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>>   		prop = (void *)probe->properties + cur;
>>   		type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
>>   	}
>> +	if (ret)
>> +		goto out_free;
>> +
>> +	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
>> +	if (!ep) {
>> +		ret = -ENOMEM;
>> +		goto out_free;
>> +	}
>> +	ep->eid = probe->endpoint;
>> +	ep->vdev = vdev;
>> +
>> +	list_add(&ep->list, &viommu->endpoints);
> 
> This should be in viommu_probe_device() (viommu_probe_endpoint() is only
> called if F_PROBE is negotiated). I think we need a lock for this
> list/xarray

Sure, will fix this, and add the needed locking around.

Thanks & regards
Vivek

> 
> Thanks,
> Jean
> 
>>   
>>   out_free:
>>   	kfree(probe);
>> @@ -1649,6 +1669,7 @@ static int viommu_probe(struct virtio_device *vdev)
>>   	viommu->dev = dev;
>>   	viommu->vdev = vdev;
>>   	INIT_LIST_HEAD(&viommu->requests);
>> +	INIT_LIST_HEAD(&viommu->endpoints);
>>   
>>   	ret = viommu_init_vqs(viommu);
>>   	if (ret)
>> -- 
>> 2.17.1
>>
