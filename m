Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6E338D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhCLMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:49:22 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:10305
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231233AbhCLMss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ve8LwidzuNHflImW4Ob7/D73ECZm6wL/mu3xMJHl/U=;
 b=N1YjMml5EpLHT+NDEe2NI6DQ4G+0uqQc+ZK9Sm/+rPDPNed3SxJ+TAlUmBWlop9AkcG/giWdAsxoRPxa831jZHllb8bmAAELcZND3bf/iHQcAVNVhDO/z30CfxTGKWvi8tLqECsbHQCTHCLN2TBQNMYqn5RmmYaYIcts3NXfcGw=
Received: from AM6P192CA0075.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::16)
 by VI1PR08MB5391.eurprd08.prod.outlook.com (2603:10a6:803:138::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 12:48:43 +0000
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::3b) by AM6P192CA0075.outlook.office365.com
 (2603:10a6:209:8d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 12:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 12:48:42 +0000
Received: ("Tessian outbound 24a7072fdae6:v71"); Fri, 12 Mar 2021 12:48:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 33d1cd0e5edbae17
X-CR-MTA-TID: 64aa7808
Received: from 43937b922af5.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8EED2A73-6CCC-4D16-A0E0-8780E19D447F.1;
        Fri, 12 Mar 2021 12:48:08 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 43937b922af5.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 12 Mar 2021 12:48:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHO0roPIcOXzqozQChLJOWDmWehUJML3rYjPp5Rmjq04ZTLK8ncbgoysV5ijOmekvMtS996FT/JHTl4eYr5sqPjN+gSYHxVApzORokhHm9Aoq3wxWpSK7KdMcjCOPxkT576utOv9pGtK2m9pFK3cJKonvJR1BIihFNMWYzlDq/ewQsJ1X3Ikehe5G/d1LnHI7v+mFNH9xmHud/JS0UF3awl1tY9t1qxp9pgjHphdZWdC6KELvIOCvrsqG3gsZ3Lv3MOL3dyyLN+Gibwfgtf2oEtzvuElSwQ1txNlTPikrc1SDmdEYtMYK+6YAL6rHpr7anCHRhv+J8VqJaEGpSvDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ve8LwidzuNHflImW4Ob7/D73ECZm6wL/mu3xMJHl/U=;
 b=nmN71KhJ0ZBFm3tLMrTqmxT3Ur6l4G82evYRB+LxltIIE8gZo8Db24a+N13sO/xQe1NIXVHBG8u5hS7DXfmPvfWU1Dn1KVNxAzjkB4/5550senRYxLjWgt5m9YK9CgOmVoBJw+p/zG7cvRUFbaaT66vfqwtK+dLj6loHoI2g8d0LatTHbjv0FLXDPbbZVTN5k2fXNG0Qdu7+ASlcsyg973mGvWM+6zx3MZc/a3gAcr4IYguSl3+rLLFfxJVwv8viPuPpEj2MkRkiYdsCR5y1fjZsnhplggzq67Oq5nBHpHl9uLUwX0MHqEeR3X/DFAIiAO97xI3Ow/ACNi1svJW9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ve8LwidzuNHflImW4Ob7/D73ECZm6wL/mu3xMJHl/U=;
 b=N1YjMml5EpLHT+NDEe2NI6DQ4G+0uqQc+ZK9Sm/+rPDPNed3SxJ+TAlUmBWlop9AkcG/giWdAsxoRPxa831jZHllb8bmAAELcZND3bf/iHQcAVNVhDO/z30CfxTGKWvi8tLqECsbHQCTHCLN2TBQNMYqn5RmmYaYIcts3NXfcGw=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM9PR08MB6226.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 12:48:04 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 12:48:04 +0000
Subject: Re: [PATCH RFC v1 02/15] iommu: Add a simple PASID table library
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-3-vivek.gautam@arm.com> <YD/DU8XNYHlTzTay@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <cd030006-2701-206d-5fca-e0e7afff316a@arm.com>
Date:   Fri, 12 Mar 2021 18:17:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/DU8XNYHlTzTay@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::27)
 To AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by PN1PR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 12:47:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70d74d1a-0291-49ce-61e5-08d8e5552b1b
X-MS-TrafficTypeDiagnostic: AM9PR08MB6226:|VI1PR08MB5391:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB539170DBABDAF5C21B75E0FC896F9@VI1PR08MB5391.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nbkCIgf1QopwOeIj92Kuygg+LiYN3Ma4ORMRwdqT0n9gKOXWUYWfpY44xvuKMbea1UZgD2B3OBmPtOEZt+PfkP0FXzGdluZy6FCA2hmr2D1pSvSxvcOsdtKpnHK5VuLNhAt2MHB+PYaYxS51wFW6EsKW7Z1fknevkxg8vA7Ot7WCvi0WXSEDvc7TdBWe1kMBpk/fUU4ydrH06H6lpUTzLYvZf0XAeU0x8/4ymnpHNHw4Q3hnGupjWXrRrQsu9zGsQbAOfBYjcEsBE5ZkrbKg2ndsyMX8QsSzHjroQ9YMxNmAqYlCnSGQ2z1oPAKemotb0nanTltEddn2YaWf8LtldSKZmcJaUAuwxT028o2cH8O0CUhXMmHEsKoCTqp93lLuT2S7mtXkWRs0MBddVXBDUa4+Qeu80iotu2dKyeyduJfpjXHmu2oyTaxDdB6U4W9wTYgG3PIdJDo6ihc+qz34TUDW57Qt4ggC+9vb7JcDqUcKMutXM/8qLEFhfOkQMLbL1499jNXoi0vM1NacHVwVzZdV/HHBU4PxzWCo0+rpYMLkmU+lGzc4WW9BhZx2DwkYSvnv2DeLytfhRD9/WETydPIeu08xjNqjDSSAAvTPBmd2uE//g05zjdtxtmLc1wZ6IYRynU0mh9S+i7/KbVdqtg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(16576012)(8936002)(26005)(8676002)(7416002)(31696002)(6486002)(16526019)(5660300002)(316002)(4326008)(2906002)(52116002)(6666004)(186003)(956004)(2616005)(31686004)(66946007)(6916009)(478600001)(66556008)(66476007)(86362001)(53546011)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d1N5K2JmVUJVS0hYdGhxVEFTMkMvdmU5Y1QwN3JXWmwxWGtCenhQR1UxWVdZ?=
 =?utf-8?B?d0dUQ250Z3MwRmtWUks5NTVPWWpQN1Izc25qaTlTbEcrOWc5NitBaTFoQVJN?=
 =?utf-8?B?dlVlUWpMcjFjajI2amFteHAyN2RsdnQvSGJDaXpVaVgwYm9XMGZOOUNDZlZv?=
 =?utf-8?B?ZklkYStTdWxoOERZUE1tZmRvN1kva2tIVTdzMDd3ZVp5aklaMDJoVkVnVnU0?=
 =?utf-8?B?SWtKRTR1c0xLUDJRaUxNanpXb0hKRFg4Y0ZscDF6M0hoZEp2TEs4S2E5Z25S?=
 =?utf-8?B?ZmNrb0xLS3ZYRWhESW9UbExZSjQ4NHpSNXQwMi9LV1o3QWNYMnlhTk1HeUVm?=
 =?utf-8?B?MVZWWDkyUGJScnIyaUx2WCtxTVFMc1VXZ0dDSnNoMTY5VHh4SkhnMDgxdFdv?=
 =?utf-8?B?Z1VhY1BaeWtWUTZ6dCsxUWFKYUtjai9tOVV1NlpRZkN5UFlKZWhQZVdQeER2?=
 =?utf-8?B?clJBT21vNDFBYXdOTkoydGxWWkJLL1lQNkVvbk1vVGZLTkQyemMvQUxVQ0FC?=
 =?utf-8?B?RWM2Y2NSanlyWGR0bnVJQ0x2QStRaGtlampYazd1SzdVZWlFV3NTSTJTQUpZ?=
 =?utf-8?B?Z1J2dVNLd2w0ekhId2FEd3Y2engvcW9LRURnK0VCSGtWb0FGb2tpc0RUa2ky?=
 =?utf-8?B?Ym9vM3lONGlqU2pUSEdQWmtyczZ6YWJOSkczY2lUQVpYU3ZTN1ZLem9sQ1Vv?=
 =?utf-8?B?RzlsVHFZVm56c3dzeFZwSFJqWTYzTnZ6UG5qTnFQQmpVSFZPdFBzL0VVd3lo?=
 =?utf-8?B?NWU4S2xPWU0rTzRFU2dqRGtFNlNkQUxpMlE1T0hTR1M0QWthTDZsTnRYdXdp?=
 =?utf-8?B?b0NGSDF5Z0VCS1c2TWlGaGlsVG9CTTZZazVvR3NCQVlvRXNtYXN6WHk4R292?=
 =?utf-8?B?V3k1N2xHcWZoL3ZLU1hnN3RNR0VkNCtQdGRERExaV2did0YxT0kxT2JXN09H?=
 =?utf-8?B?TTBYRExMZ3BXRnlYN3dRNlkrQjJHclBITkowU0ViZmZnTXRoMG15S2IwQTZO?=
 =?utf-8?B?QUpTN3IydzEva0N1QUYrbk5NV2JiT0NGck53NmFMNVhEc2hLWUFGcU1wbSta?=
 =?utf-8?B?NGo3K2E3aXUzVFRhNi9qeHVZY1BEMW1CajB4TU14Mm9iUWl4R2YwTWJQOUZt?=
 =?utf-8?B?dzZyUEVQWGp2NlVhVWk3eEROemxEOEl5YXJ0ZUdBQmZXcEQxOXZVVnRWcE1I?=
 =?utf-8?B?QUxncWNGVWJiaU0xOUozTGtrb1poUk5uMkRya2RSZnV0N01nVm16Ym9DaUJv?=
 =?utf-8?B?NXlGZjZmWlFQeUYydEIxR2dDbi9QSkR3VHhhWDhLdXp0UWoweW5OcjlnczZx?=
 =?utf-8?B?ajV4U2xQTmk5ZUxjdFRZbkRndENCR2w4aUlpVHFIdFJOV2dOc1ZuclZ5Unk1?=
 =?utf-8?B?L01JUStNTU9KZHhmNVRiWDl4V1NSdVVVcGJoVGpiN3JkYnRRMnh5Y0gwUk5M?=
 =?utf-8?B?YU1zckpYL2M2aFZzSWowZlFBSjFtbE44SDJmNHZuMFoxT2lxVWZPRXp1UUg5?=
 =?utf-8?B?OC9zVnpDanY5c3ZGNDlSR1U1eDd2S0FUaFlOQnpOeWdCZ3pZWU41dzYvcHJl?=
 =?utf-8?B?M0hsa0hON1JSWFNNTnZ1bW5lZHRobWM3eDNjdlB5VUhFVE1FZlhYV1pseEUw?=
 =?utf-8?B?REpRL0RrSGh5MFQvZUhqZDQrdlVJWHhoNHZPRzZFWWtsVGVjRGtPcXdiM0U3?=
 =?utf-8?B?RDM3eitGVFdYRWN5SStTc3paSEdHTmtOVXFDYW0rcXVWQm1KS0drY0R0RHJV?=
 =?utf-8?Q?NzY7fc6XcJyywYUMnaP2Nzn3sfsls/FuLtp2Lw/?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6226
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01109572-4903-47e8-8f84-08d8e55512fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 184yi7WPkY3DD3fRd82iMkhJ4FqyfG5iByNYdIyCYLgS7D/h4ZaoEGyxK8c05OKBm11z+Ahz5hzx9RSD19mP4JR9WHfG4+fWwy43hs1KtQTWCDCu3ZcYvm9g8czyPZxVcaWOYuVTDnRztcPOAQ6kQhddflNrn5vp/APgCb0hLovNmokPqhYUretGZ3mWaVkAI/TzpNBBPl9mzVgddpVJElIcaXpZeOQD/w3iIhuWQopFhzL6AT4q4bNDnYdEBztKgNRnQcDtPZK/OZPI5EbnDXiPZB26Rm+9YU828NLC5lGKJLiTAvV8+KONsa2Ol2v66MGUULwP6e1AixKXggehmcg0qfx3LKOV13fQViR4fX6Jc2mk6CRyXah050iFsD3sa5+K0+fAq5jJLdlJc444bSPudQ1eNkQS3G/4IzIgyGiNfShgPp+uvDnALggeqdcHZKVLGQD379AmStp8VJ+mkyg49JHydrx7SyA8AmucBkgjXfeoFzjEtZX8hsiLNCvlYH9Jf8ug3SLiW/nhCnWPnmdEls3cIqNmh+oYUjEZe9loqF0GxZFCKzaXrvgZStlm72ZG7t/Lh7mjfxEjTiCGnIkubA1EXx1F2ZAqzLVXWg2bJ3LwMNPBpaCykx2wpMWtmjYeO8Od+6uA+SvUBwZWfoSr4mGa9ku3PMwIaRWVp2A87BFWbpKi3rTz7OEyT+Jo
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(956004)(2616005)(26005)(186003)(16526019)(478600001)(336012)(47076005)(4326008)(316002)(6862004)(107886003)(16576012)(82740400003)(70586007)(81166007)(86362001)(31696002)(36860700001)(70206006)(5660300002)(53546011)(356005)(36756003)(6666004)(82310400003)(31686004)(83380400001)(2906002)(8676002)(6486002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 12:48:42.9331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d74d1a-0291-49ce-61e5-08d8e5552b1b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,


On 3/3/21 10:41 PM, Jean-Philippe Brucker wrote:
> Hi Vivek,
> 
> Thanks again for working on this. I have a few comments but it looks
> sensible overall.

Thanks a lot for reviewing the patch-series. Please find my responses 
inline below.

> 
> Regarding the overall design, I was initially assigning page directories
> instead of whole PASID tables, which would simplify the driver and host
> implementation. A major complication, however, is SMMUv3 accesses PASID
> tables using a guest-physical address, so there is a messy negotiation
> needed between host and guest when the host needs to allocate PASID
> tables. Plus vSMMU needs PASID table assignment, so that's what the host
> driver will implement.

By assigning the page directories, you mean setting up just the stage-1 
page table ops, and passing that information to the host using ATTACH_TABLE?
Right now when using kvmtool, the struct iommu_pasid_table_config is 
populated with the correct information, and this whole memory is mapped 
between host and guest by creating a mem bank using 
kvm__for_each_mem_bank().
Did I get you or did I fail terribly in understanding the point you are 
making here?
If it helps, I will publish my kvmtool branch.

> 
> On Fri, Jan 15, 2021 at 05:43:29PM +0530, Vivek Gautam wrote:
>> Add a small API in iommu subsystem to handle PASID table allocation
>> requests from different consumer drivers, such as a paravirtualized
>> iommu driver. The API provides ops for allocating and freeing PASID
>> table, writing to it and managing the table caches.
>>
>> This library also provides for registering a vendor API that attaches
>> to these ops. The vendor APIs would eventually perform arch level
>> implementations for these PASID tables.
> 
> Although Arm might be the only vendor to ever use this, I think the
> abstraction makes sense and isn't too invasive. Even if we called directly
> into the SMMU driver from the virtio one, we'd still need patch 3 and
> separate TLB invalidations ops.

Right, the idea was to make users of iommu-pasid-table - virtio-iommu or 
the arm-smmu-v3 - consistent. I also noticed that the whole process of 
allocating the pasid tables (or cd tables) and populating them with 
stage-1 page tables in viommu is also in-line with how things are in 
arm-smmu-v3 or atleast that's how the design can be in general - 
allocate pasid_table, and program stage-1 information into it, and then 
pass it across to host.

> 
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   drivers/iommu/iommu-pasid-table.h | 134 ++++++++++++++++++++++++++++++
>>   1 file changed, 134 insertions(+)
>>   create mode 100644 drivers/iommu/iommu-pasid-table.h
>>
>> diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
>> new file mode 100644
>> index 000000000000..bd4f57656f67
>> --- /dev/null
>> +++ b/drivers/iommu/iommu-pasid-table.h
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PASID table management for the IOMMU
>> + *
>> + * Copyright (C) 2021 Arm Ltd.
>> + */
>> +#ifndef __IOMMU_PASID_TABLE_H
>> +#define __IOMMU_PASID_TABLE_H
>> +
>> +#include <linux/io-pgtable.h>
>> +
>> +#include "arm/arm-smmu-v3/arm-smmu-v3.h"
>> +
>> +enum pasid_table_fmt {
>> +	PASID_TABLE_ARM_SMMU_V3,
>> +	PASID_TABLE_NUM_FMTS,
>> +};
>> +
>> +/**
>> + * struct arm_smmu_cfg_info - arm-smmu-v3 specific configuration data
>> + *
>> + * @s1_cfg: arm-smmu-v3 stage1 config data
>> + * @feat_flag: features supported by arm-smmu-v3 implementation
>> + */
>> +struct arm_smmu_cfg_info {
>> +	struct arm_smmu_s1_cfg	*s1_cfg;
>> +	u32			feat_flag;
>> +};
>> +
>> +/**
>> + * struct iommu_vendor_psdtable_cfg - Configuration data for PASID tables
>> + *
>> + * @iommu_dev: device performing the DMA table walks
>> + * @fmt: The PASID table format
>> + * @base: DMA address of the allocated table, set by the vendor driver
>> + * @cfg: arm-smmu-v3 specific config data
>> + */
>> +struct iommu_vendor_psdtable_cfg {
>> +	struct device		*iommu_dev;
>> +	enum pasid_table_fmt	fmt;
>> +	dma_addr_t		base;
>> +	union {
>> +		struct arm_smmu_cfg_info	cfg;
> 
> For the union to be extensible, that field should be called "arm" or
> something like that.

Sure. Will amend this.

Thanks,
Vivek

> 
> Thanks,
> Jean
> 
>> +	} vendor;
>> +};
>> +
>> +struct iommu_vendor_psdtable_ops;
>> +
>> +/**
>> + * struct iommu_pasid_table - describes a set of PASID tables
>> + *
>> + * @cookie: An opaque token provided by the IOMMU driver and passed back to any
>> + * callback routine.
>> + * @cfg: A copy of the PASID table configuration
>> + * @ops: The PASID table operations in use for this set of page tables
>> + */
>> +struct iommu_pasid_table {
>> +	void					*cookie;
>> +	struct iommu_vendor_psdtable_cfg	cfg;
>> +	struct iommu_vendor_psdtable_ops	*ops;
>> +};
>> +
>> +#define pasid_table_cfg_to_table(pst_cfg) \
>> +	container_of((pst_cfg), struct iommu_pasid_table, cfg)
>> +
>> +struct iommu_vendor_psdtable_ops {
>> +	int (*alloc)(struct iommu_vendor_psdtable_cfg *cfg);
>> +	void (*free)(struct iommu_vendor_psdtable_cfg *cfg);
>> +	void (*prepare)(struct iommu_vendor_psdtable_cfg *cfg,
>> +			struct io_pgtable_cfg *pgtbl_cfg, u32 asid);
>> +	int (*write)(struct iommu_vendor_psdtable_cfg *cfg, int ssid,
>> +		     void *cookie);
>> +	void (*sync)(void *cookie, int ssid, bool leaf);
>> +};
>> +
>> +static inline int iommu_psdtable_alloc(struct iommu_pasid_table *tbl,
>> +				       struct iommu_vendor_psdtable_cfg *cfg)
>> +{
>> +	if (!tbl->ops->alloc)
>> +		return -ENOSYS;
>> +
>> +	return tbl->ops->alloc(cfg);
>> +}
>> +
>> +static inline void iommu_psdtable_free(struct iommu_pasid_table *tbl,
>> +				       struct iommu_vendor_psdtable_cfg *cfg)
>> +{
>> +	if (!tbl->ops->free)
>> +		return;
>> +
>> +	tbl->ops->free(cfg);
>> +}
>> +
>> +static inline int iommu_psdtable_prepare(struct iommu_pasid_table *tbl,
>> +					 struct iommu_vendor_psdtable_cfg *cfg,
>> +					 struct io_pgtable_cfg *pgtbl_cfg,
>> +					 u32 asid)
>> +{
>> +	if (!tbl->ops->prepare)
>> +		return -ENOSYS;
>> +
>> +	tbl->ops->prepare(cfg, pgtbl_cfg, asid);
>> +	return 0;
>> +}
>> +
>> +static inline int iommu_psdtable_write(struct iommu_pasid_table *tbl,
>> +				       struct iommu_vendor_psdtable_cfg *cfg,
>> +				       int ssid, void *cookie)
>> +{
>> +	if (!tbl->ops->write)
>> +		return -ENOSYS;
>> +
>> +	return tbl->ops->write(cfg, ssid, cookie);
>> +}
>> +
>> +static inline int iommu_psdtable_sync(struct iommu_pasid_table *tbl,
>> +				      void *cookie, int ssid, bool leaf)
>> +{
>> +	if (!tbl->ops->sync)
>> +		return -ENOSYS;
>> +
>> +	tbl->ops->sync(cookie, ssid, leaf);
>> +	return 0;
>> +}
>> +
>> +/* A placeholder to register vendor specific pasid layer */
>> +static inline struct iommu_pasid_table *
>> +iommu_register_pasid_table(enum pasid_table_fmt fmt,
>> +			   struct device *dev, void *cookie)
>> +{
>> +	return NULL;
>> +}
>> +
>> +#endif /* __IOMMU_PASID_TABLE_H */
>> -- 
>> 2.17.1
>>
