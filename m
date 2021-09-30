Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F841D641
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbhI3J0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:26:15 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:40270
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349296AbhI3J0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU1md94yulkTb6YSXf2rBeH9qpKroKXOd2u4ABb8uXo=;
 b=UgRV64i+5cLqLV+i6BIwY8JXPw5AvFxmu1xpckllDJeRMmrA/QdZCaEp19SW4pwKUhjMJJNW6A6wNxmM7yTndCv9civEmD+oX0o1ih0WDu3eVPKX6cMcq0AWU41I8j7Vv9g78kvR3rdlLvJJtuomR9kZJcXhmIbULJwRGkudHUM=
Received: from AS9PR06CA0064.eurprd06.prod.outlook.com (2603:10a6:20b:464::34)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 30 Sep
 2021 09:24:29 +0000
Received: from AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::83) by AS9PR06CA0064.outlook.office365.com
 (2603:10a6:20b:464::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 09:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT038.mail.protection.outlook.com (10.152.17.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:24:29 +0000
Received: ("Tessian outbound 71ebfb754289:v103"); Thu, 30 Sep 2021 09:24:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 09b808f6f90c323a
X-CR-MTA-TID: 64aa7808
Received: from 788162a92486.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 95CF8B87-FB00-486E-A417-31FD87DED041.1;
        Thu, 30 Sep 2021 09:24:14 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 788162a92486.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 30 Sep 2021 09:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBlZzpBwYm3AbA2ZH1FA5bXiFTVQVEIcH3cAHPYYIlZi/TUTiKzZWdDTu/XX+MDZR3ruEgqB2sZ1N6fv6XhZoY28RZaV7NqucJlfYWaE1NI+BqGGZwEMvyZPgNP+OkCBjUbsNzPVB6k3Cym5a3cbZeJ8pYSqBnVzh7iDqEocVKcek7cYw9/XlKH1DHI8PSavz04msB/sRb+KETewdIS8LfotdpFPUGHxQseXouVOc+Iq64tnVGZBIhSan277s0q3og+6e/rJKfzEXX71gcJ9MLBvVdtFKTQfWCY5yhj/L4Py/jkbtm2Pbt07eHz4jZgI8zeVRQjpDJFWJEbYIJ5ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EU1md94yulkTb6YSXf2rBeH9qpKroKXOd2u4ABb8uXo=;
 b=Em6cG1MGhoxpd+CMqSeKPjxf5Bz7j+UNvmtWqt6/Kx5VwYGn+m2ovvwqDtJVPdr0PqdJ/OUpmIwbP4nbFW0QunpjugYwJzLLai9S83QJIwWcuzXSpiVihcvmu+uJTsFzmjthpKZBreggsh+1rCh9xO6PbniaJnFXAPIb3AjwwLxIIpVMXvCUkJ8twCLbOt8C0LcXKa818zFD5jsvwTh4eLJx0pClAyeTvRLsHd6rsU8b2ZNmhzaYZf6+go3RsOYkQCbsGbGId1M1ngthSyWqUJQBlOfEefRy49izL/3gzInvcxrpdv9qquzpLYoI2LXHP50Z4mj9Xz/zQ02UIrB5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU1md94yulkTb6YSXf2rBeH9qpKroKXOd2u4ABb8uXo=;
 b=UgRV64i+5cLqLV+i6BIwY8JXPw5AvFxmu1xpckllDJeRMmrA/QdZCaEp19SW4pwKUhjMJJNW6A6wNxmM7yTndCv9civEmD+oX0o1ih0WDu3eVPKX6cMcq0AWU41I8j7Vv9g78kvR3rdlLvJJtuomR9kZJcXhmIbULJwRGkudHUM=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB6PR0801MB1960.eurprd08.prod.outlook.com (2603:10a6:4:76::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 30 Sep 2021 09:24:12 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 09:24:12 +0000
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type to
 send page response
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com> <YUoFSrAK2gi3GWp/@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
Date:   Thu, 30 Sep 2021 14:54:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YUoFSrAK2gi3GWp/@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Thu, 30 Sep 2021 09:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2cbefc8-83d0-41c3-a632-08d983f41a9a
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1960:|AM8PR08MB6322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB632233FA19C9DCAAF531566889AA9@AM8PR08MB6322.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: X5KDNntZ5iY2DpB+Y19vnCTJ8BKGwPq/8mWOhNKERLaCR2971NFfrQL6HKfppOlH7xQr9he5pj7foyiolmSc/dLK0iCFwWi4M1UrQrHAhdLIMevpbwmo+LP1YUFDeTGoAZq3rXiuTHMx2qjVYJ6EOhMHFmLjLDojqgllUhIb/Qdedb5mdDUriKjOEH5qpxJzEOauF0JyCJDhX/Em8vU7HsEwXjm1yvfFMJzvCHzoGw5emJ7Y0CgwJMXjy6awqmTbY4Cz9HWED+DE/uOeAEDNiTuHemR6ie43x2WnhOibnpyvkZLd+lWszIJenQefniEYeKoV+0uw74ePTgL5zQbqRyUm1oTbNvuVpLTML4YYMtC/VGTIDCEEAfujkNNRJo1V+DPufFPAxt0+hRCfbWv0LColYYXwNojEWwcmgUe2KtgvjTd1l4DSvADsprbLuIsJBCtnRhpcBf0mpkXpu8trPTHiJVNEnNveTdz7xMB/1Pv/4AzwchKd+GVPW/F3SU4G34atm85ONKL5p1mFldBc8+V6ONdY8W5gn1TDPmRguTdbppHIFiGlkel2dbrDYaeZrXvuUGqfWh8htwBbowlasa0O9pmX6UpOofuMGIeLMgsnoqaAxVFeabtFT+ZxjDXmPMU3ri8/Vy+37Hz1aI83zwvwaa2LvDkm/fcK/c7Gak+OqaQhbzjodr7hjhAVroNVh5jdY6is6hxq8HzplkLmasfFyDxN42buwiBDz7Eb368KG7h/72x2GH4oWpLjLlhnWreMq18VQSBS81R17POudg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2645.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(4326008)(38350700002)(8936002)(36756003)(16576012)(316002)(31696002)(508600001)(6486002)(83380400001)(8676002)(86362001)(38100700002)(52116002)(2906002)(5660300002)(31686004)(66946007)(956004)(66476007)(66556008)(6666004)(6916009)(26005)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1960
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa945b30-56d6-4120-007f-08d983f4104b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roaUJ9lCi2nOiyn6aSIybwsE9EwHHeGaS/rvaPkeXfaxcZGHUm3Es4BCpfNmPAX98BXO58/8YVEsA+NpvoUvm2xgaGfxHTdpW5odrIRpuucTSwplNV9UblAVL4vB1C5YgBHsz7vPRFmaVS1T8/CovZ9uoH/vV1vODRGdT0eeq/xlgPgRWoA58YU7j7c5cSgbDY8i+YPlhFZYHA+QpXIwq12zuvAI6bVo2Ic73KjRZsApM2JGnxh47oNHTljnDOjTybPsjDixzFV/TITVEGPlekMBbi5uwIlLPfQM0DgRm9yQ7FU8tpTUMqVwR+U+4Pmmp/YoJfj81i5zb7SLQYXvoYHmznRZBs0erbB80wogImLYMdA2hijU4emzDEpUOiepvzYBviaJaViehOMwWm+fGDlOx3WFfA4EkU0oJHHNTPzlD0Tf+gss+6nzzG464lBVHNmP7fyjNbcujGxb3TUt50XIJCBM01JXBLdWO9euSce84uJK0yU7S5+PwFw3IBsx9zz8b+uHSv/SFloSy58GMtNSYxNlR+lFZdVrkGjCOmcWDFlqE/P82pIcgyBpRYcNaw6cDDwnutSokfISRsOScww2JeQdnGL9SUAUV96x7anq5YqdSqzvhxl1z+c42M/Lx5eUpV5cdZgiD/jAP+lgexwnfwP3ybAzCTl2RfmatzjkQ/ErRGNfc3DU+7v8FrOWTevyx8n6uOs4pDqfJ8zCDNXNU5Poyg9tjeQZaPYDcww=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(356005)(83380400001)(47076005)(4326008)(81166007)(2906002)(107886003)(70206006)(70586007)(6862004)(6486002)(82310400003)(508600001)(336012)(8936002)(36860700001)(36756003)(316002)(31686004)(956004)(2616005)(5660300002)(8676002)(26005)(53546011)(6666004)(16576012)(186003)(86362001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:24:29.0607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cbefc8-83d0-41c3-a632-08d983f41a9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,


On 9/21/21 9:46 PM, Jean-Philippe Brucker wrote:
> On Fri, Apr 23, 2021 at 03:21:46PM +0530, Vivek Gautam wrote:
>> Once the page faults are handled, the response has to be sent to
>> virtio-iommu backend, from where it can be sent to the host to
>> prepare the response to a generated io page fault by the device.
>> Add a new virt-queue request type to handle this.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   include/uapi/linux/virtio_iommu.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index c12d9b6a7243..1b174b98663a 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
>> @@ -48,6 +48,7 @@ struct virtio_iommu_config {
>>   #define VIRTIO_IOMMU_T_PROBE			0x05
>>   #define VIRTIO_IOMMU_T_ATTACH_TABLE		0x06
>>   #define VIRTIO_IOMMU_T_INVALIDATE		0x07
>> +#define VIRTIO_IOMMU_T_PAGE_RESP		0x08
>>   
>>   /* Status types */
>>   #define VIRTIO_IOMMU_S_OK			0x00
>> @@ -70,6 +71,23 @@ struct virtio_iommu_req_tail {
>>   	__u8					reserved[3];
>>   };
>>   
>> +struct virtio_iommu_req_page_resp {
>> +	struct virtio_iommu_req_head		head;
>> +	__le32					domain;
> 
> I don't think we need this field, since the fault report doesn't come with
> a domain.

But here we are sending the response which would be consumed by the vfio 
ultimately. In kvmtool, I am consuming this "virtio_iommu_req_page_resp" 
request in the virtio/iommu driver, extracting the domain from it, and 
using that to call the respective "page_response" ops from 
"vfio_iommu_ops" in the vfio/core driver.

Is this incorrect way of passing on the page-response back to the host 
kernel?

But I think this will have to be worked out with the /dev/iommu framework.

> 
>> +	__le32					endpoint;
>> +#define VIRTIO_IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
> 
> To be consistent with the rest of the document this would be
> VIRTIO_IOMMU_PAGE_RESP_F_PASID_VALID

Sure, will update this.

> 
>> +	__le32					flags;
>> +	__le32					pasid;
>> +	__le32					grpid;
>> +#define VIRTIO_IOMMU_PAGE_RESP_SUCCESS		(0x0)
>> +#define VIRTIO_IOMMU_PAGE_RESP_INVALID		(0x1)
>> +#define VIRTIO_IOMMU_PAGE_RESP_FAILURE		(0x2)
>> +	__le16					resp_code;
>> +	__u8					pasid_valid;
> 
> This field isn't needed since there already is
> VIRTIO_IOMMU_PAGE_RESP_PASID_VALID

Yes, sure will remove this field.

> 
>> +	__u8					reserved[9];
>> +	struct virtio_iommu_req_tail		tail;
>> +};
> 
> I'd align the size of the struct to 16 bytes, but I don't think that's
> strictly necessary.

Will fix this. Thanks a lot for reviewing.

Best regards
Vivek

> 
> Thanks,
> Jean
> 
>> +
>>   struct virtio_iommu_req_attach {
>>   	struct virtio_iommu_req_head		head;
>>   	__le32					domain;
>> -- 
>> 2.17.1
>>
