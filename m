Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F3428991
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhJKJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:22:28 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:20452
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235430AbhJKJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dM2b1vKhqqliMzuafjJ6Ig2ixZNMalyBuwMaYHlsrw=;
 b=9lG9e8p61BOJLjqUsiDjoO87peDwC+yBePdWe2Kz3FJTZi7CJoQFnpJWvcfWQsU70yUDQ0VdqHQANbMDLmVTNKOkqN5ZVk9fNSk5W1FDZf2DioDISKmHIFd6eXE8lZst8tjcVhaWILZhcDuVTbraxsnD6rldZX6kBlQP2NBEq9U=
Received: from DB6PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:6:2c::33) by
 VI1PR0802MB2463.eurprd08.prod.outlook.com (2603:10a6:800:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 09:20:25 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::83) by DB6PR07CA0119.outlook.office365.com
 (2603:10a6:6:2c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Mon, 11 Oct 2021 09:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 09:20:24 +0000
Received: ("Tessian outbound f1898412aff1:v103"); Mon, 11 Oct 2021 09:20:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8f5ca6b1d7703397
X-CR-MTA-TID: 64aa7808
Received: from c63a62784eec.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 31869678-364E-4BB0-A954-0E82F5BD10F3.1;
        Mon, 11 Oct 2021 09:20:18 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c63a62784eec.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Oct 2021 09:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV8h0NKcfQe7tYhrkOnABNcNVgZXCmwy7SVOJD1pgmzUmZtDd7c6PTtnXTy+smdtaOSNmOqYjt+Vtc7fsBDu466edAiYweGRuN/A2YA9IfLtuREbzQAj4IvY3f4T6gnFgHt0OIDbm3DCBcjtclYtEbEOysxuXgxAui2hCj0wubjalJpTrTwZ24jG97reswiSDxYIUgx4ZuGX407UcEZq+8ycmHbImk2BzBJO2I/FLWm3LbJsvw2vXOu21sLorV3RusA1xkdnljJSaRBtM6OHXEcneFgy9jlOWhreCnfz/n7ryQAY0ag2huGe5QPBXLbfq9E2yO4l+n2VcCkS4gqf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dM2b1vKhqqliMzuafjJ6Ig2ixZNMalyBuwMaYHlsrw=;
 b=Uuh9UhwLXf0QTl3fKt4gt+1geEGw/464Y+lRsOrK10qMV8hO9K4+KDf+AwoCSPvsmXYSr02NpQR2ofkf97ZsKPieWi1Ajd8BgRTXY+tXQCDSB2Jqop7N1vK1Q0skTGGiWAW1WpuO+yNqKCV/E0aHLMhDcog++KH4wVKzyAi6He09BVNSVKRMRMy3vc9adRc+JbmlTzaqmwBKAVXRAGu9TCDPXDk9rPGkaSIipDWJ5oXCcy1tX8emHtjstACElwCHoDvt9JxPWaZxOEnkanxPcZ3RwZsAimCoHAgAzxQIX24YvLsUJTjWmlz+G/zRu+g7qf1BPC9mgUXEiuYxtwPiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dM2b1vKhqqliMzuafjJ6Ig2ixZNMalyBuwMaYHlsrw=;
 b=9lG9e8p61BOJLjqUsiDjoO87peDwC+yBePdWe2Kz3FJTZi7CJoQFnpJWvcfWQsU70yUDQ0VdqHQANbMDLmVTNKOkqN5ZVk9fNSk5W1FDZf2DioDISKmHIFd6eXE8lZst8tjcVhaWILZhcDuVTbraxsnD6rldZX6kBlQP2NBEq9U=
Authentication-Results-Original: lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB8PR08MB5097.eurprd08.prod.outlook.com (2603:10a6:10:38::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Mon, 11 Oct 2021 09:20:15 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2d42:f89a:25b8:8bc1]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2d42:f89a:25b8:8bc1%5]) with mapi id 15.20.4566.026; Mon, 11 Oct 2021
 09:20:15 +0000
Subject: Re: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>, mst@redhat.com,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-4-vivek.gautam@arm.com> <YUoCTV6WYxxE10qj@myrica>
 <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
 <YWQA8JLXfmQ4DMXv@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <cdc4a52f-948c-0cbd-b45e-7231ef78b3e4@arm.com>
Date:   Mon, 11 Oct 2021 14:50:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YWQA8JLXfmQ4DMXv@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend Transport; Mon, 11 Oct 2021 09:20:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1bc608a-c722-4c84-658f-08d98c985b8e
X-MS-TrafficTypeDiagnostic: DB8PR08MB5097:|VI1PR0802MB2463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2463A076D132574AAD33E6C389B59@VI1PR0802MB2463.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZpYWgQX16K60XiCwVHP9LGKLh0PCeADslXu/FspSCK1aVTMqhPugzaqK3UBt/NHt9gC3UsN0b0nGjUxOZD6F2fZiEf1H4Q2o+i0LCQmfv8uSKZeguNi60mvmrYHkIoMS50qwT1151TdnZV3jjLpA6W60Mtw1shRb7ZGbaNYRFRf+ccOe1JvmPMfOev8KWe9rLmDs4yinIS5bfTrY13eOToVtFVBjQJdfh+/mAgQEZoe9SL0qJYkrPf3scldOJw+5VproDThdW/ZbBN0okikS45cEMECuakrFa5Odt9SiY1+NMkyezErnbGD8x+hCkr/yS6Mis//9ZGzXkU8GxQBpp4KqplY3BPWLlQBhmEn7oo6UZ5ZwDZkPapAJdcnguxDZ/VTNyzzKa6TPvak5vMQeT/YCEuVXkXVPOSk+2Gs+FNvju3dDG73RhfSR7+riQTcR2IMORQvVsqCJXLZbBQBiEo4vqwFSM+EP+tG5ckeGN+rkojeDzXTtCFuuF4CltiY66G1OoaJ0x5qiyygw+40vhRvDfzzMh0OrcqBhdPm3M1c5EHbeZFtbR8ZJ8/MWdpDFZzEWc1H8Es/qK+0di79RbEaVgmz2O+viNKXmD7ggA5D5plFYH++vwjescprieNW3sdS+B4NBebXeusjTyvQq9edKYCfKl4IW3hLPip7WYQQdg+Ldrl9Za8dFT5HkOL+Q8nac4RvmTmLKW6meVLW5uEvHA75rHs0u1or/Ni4Qv32CCyVluV+afD4CxlpAwPXG5kDNSAitwndnK/SdYuZPMQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2645.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(8676002)(66556008)(2906002)(86362001)(4326008)(52116002)(53546011)(36756003)(6916009)(186003)(6666004)(6486002)(31696002)(8936002)(5660300002)(31686004)(508600001)(38100700002)(26005)(2616005)(38350700002)(316002)(16576012)(956004)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5097
Original-Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1d1fff4a-eb4c-4a6d-c4ab-08d98c98556b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mnB7LEkDLzSdhpAWieVznN7vnMVQ92l/qh8fvwnf8u7rTfs0sdpqxCTgbRTuNYerjfaBjrnxovvuEUaGdPFaw6wyS/zlRpfeV0UcPCAUQ2e8Ey/XBTWbe2E1zcqQhYBC30kYd8Yo25fAdvZY0UJ7uaTG+5bcEbWCfUPOI2ACGNZms+m93Zz1aG80Z3TUyBegHmFHCwYXRO19L93Tvk24kDqWOjoAJbFbgUfMkBTM7nkpkgQUSKJh2SMJkBStZxxapLQy+DtWY3mPmJ/uXEIhOJwpvpMwQhaxEIUf9A+t4Xr9eMZ1MnIwPDzAJ0DWMSl/QgrdGmRCScfBYQs3e6n1dB3sZwaHQrtN56R6TdnSEAo3f702njWvv/k09ouvmRAWotXCVdV/yXnS9DoE8NUCmzTl42KSJk3Aq0Y76FR1pmeNeK80N3bQ9qghXjQ4ZI3hPQFhrzXs+nxofXrmK38Gj0lOvxqd4IO4TyVZcMsZ5UvOzFZREKHqfSXnSrEx4WxOhzefwokpUz7GQCUCwCJMI49n3pzGsP76aMj+3rd0tHocW6+nNB/hThqGAzvqXlkCSY/cNyPniW+W1ng0vgJr22OPcnq+HUJzBo9+7HakK1BWh2KIjz86+JgG1vHR3JZHK0R4wIOszLL75B0JY6H5JfP12nej5GXkeBzDIUZ4fHSrbLawCd6yP6iipxwMM3ZR/vPyb2A6E9A599ATs+oqiHK05cvt64I2APWSblBIIs=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(186003)(5660300002)(6862004)(36756003)(107886003)(8676002)(54906003)(31686004)(508600001)(16576012)(316002)(4326008)(81166007)(356005)(26005)(8936002)(70586007)(6666004)(53546011)(82310400003)(47076005)(336012)(31696002)(2616005)(6486002)(70206006)(956004)(36860700001)(86362001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 09:20:24.8542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc608a-c722-4c84-658f-08d98c985b8e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,


On 10/11/21 2:46 PM, Jean-Philippe Brucker wrote:
> Hi Vivek,
> 
> On Mon, Oct 11, 2021 at 01:41:15PM +0530, Vivek Gautam wrote:
>>>> +     list_for_each_entry(ep, &viommu->endpoints, list) {
>>>> +             if (ep->eid == endpoint) {
>>>> +                     vdev = ep->vdev;
>>
>> I have a question here though -
>> Is endpoint-ID unique across all the endpoints available per 'viommu_dev' or
>> per 'viommu_domain'?
>> If it is per 'viommu_domain' then the above list is also incorrect.
>> As you pointed to in the patch [1] -
>> [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints served
>> by viommu_dev
>> I am planning to add endpoint ID into a static global xarray in
>> viommu_probe_device() as below:
>>
>>          vdev_for_each_id(i, eid, vdev) {
>>                  ret = xa_insert(&viommu_ep_ids, eid, vdev, GFP_KERNEL);
>>                  if (ret)
>>                          goto err_free_dev;
>>          }
>>
>> and replace the above list traversal as below:
>>
>>                  xa_lock_irqsave(&viommu_ep_ids, flags);
>>                  xa_for_each(&viommu_ep_ids, eid, vdev) {
>>                          if (eid == endpoint) {
>>                                  ret =
>> iommu_report_device_fault(vdev->dev, &fault_evt);
>>                                  if (ret)
>>                                          dev_err(vdev->dev, "Couldn't
>> handle page request\n");
>>                          }
>>                  }
>>                  xa_unlock_irqrestore(&viommu_ep_ids, flags);
>>
>> But using a global xarray would also be incorrect if the endpointsID are global
>> across 'viommu_domain'.
>>
>> I need to find the correct 'viommu_endpoint' to call iommu_report_device_fault()
>> with the correct device.
> 
> The endpoint IDs are only unique across viommu_dev, so a global xarray
> wouldn't work but one in viommu_dev would. In vdomain it doesn't work
> either because we can't get to the domain from the fault handler without
> first finding the endpoint

Thanks. That's easy then. Will have a xarray in viommu_dev and iterate 
over it from the fault handler.

Best regards
Vivek
