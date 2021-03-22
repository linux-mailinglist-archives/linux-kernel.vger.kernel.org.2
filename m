Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577D5344788
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCVOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:39:20 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:19825
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229946AbhCVOin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdW1PMoc8L8zENMm/subktaKJvQ5s+JcLArbTY9c4G8=;
 b=cde+WmwrlBDLe20BNIqt4+/kz42YcvX+0n7ZcSxA0pf6qkXPDWMX5CONFL79nRO4xvAN8zmMaNRuspcO/9wiIbNGcYGp6GtOsCxkx6hhn6RTLKPsmt82WW9m6Zz/fcdsU69xH6CZAPhikAM08v4JOBW+G9eLPuRJWAcEF3qrzuk=
Received: from AM5PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::27)
 by AM6PR08MB3942.eurprd08.prod.outlook.com (2603:10a6:20b:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 14:38:35 +0000
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:2:cafe::29) by AM5PR1001CA0014.outlook.office365.com
 (2603:10a6:206:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 14:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 14:38:34 +0000
Received: ("Tessian outbound 259fb7427a57:v87"); Mon, 22 Mar 2021 14:38:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0c13463b1473e963
X-CR-MTA-TID: 64aa7808
Received: from 896eee2f8ada.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F6E3CE22-D996-4C2E-AA05-EC104B7302D4.1;
        Mon, 22 Mar 2021 14:38:27 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 896eee2f8ada.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Mar 2021 14:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL2B4qzn+686QFwa7z4XwdLeSNfUCxnfQYuo9tl1cCb43oEWf3KY2QTNzFmC+uyiH6i0jWy/yDGXDfTIBYIfzvQ4Gwo2GIvbz4FK5hpxyiVZZTcP2yr4ExjftH8WdZMZjR7zdwJftD8IwWPqVl5bmrkiS805mdd5wNBHHpu4ZTbtvl4SV3UNMLgcwdAerCmb8SMj8r4LHqQ0ug+TTsBPyy9aJBWVNRZbHB+q5E/mwtsw4K7B3Cyj3NWs8EY2E1GZspCqibUJOrWsmUQWfvS9jI0fxXQJ6UKPRvD849pwvVzQMLpM/7qi0sqOza5VCQLFk7xT1UpjK94TEjxZE5mN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdW1PMoc8L8zENMm/subktaKJvQ5s+JcLArbTY9c4G8=;
 b=EJwrWeCl7/wgms/I9ipAvqYAmbp0IUozg9wY1BRhvYLUtdbNRTkyHl5N/bb2+LPKA0AL2STs8fygQUA3i+kMHBTd4gWy3q9lNeEUwjjO/JWJZg6rUDddIJkcRlBVJ+s22a4XSZ564Tw2eBlw+BQMEOJJwLg0DSjXRz6NESrhPJWfI0YFzvxDGlqkJ49ynFpyv3pAG8ovVocrcyY7xMNBKXF3Z5x6OjcaraaNcfz7klyPKoB43pXuEO4znbrraBgYsQW4pxhGhsn9fZNBzyT2cCimxKa0IxPBLYX+K6D9/ydFV6w6IZmheNTlaMuLnLkdmcH9x2mGMvybveCRq8/Heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdW1PMoc8L8zENMm/subktaKJvQ5s+JcLArbTY9c4G8=;
 b=cde+WmwrlBDLe20BNIqt4+/kz42YcvX+0n7ZcSxA0pf6qkXPDWMX5CONFL79nRO4xvAN8zmMaNRuspcO/9wiIbNGcYGp6GtOsCxkx6hhn6RTLKPsmt82WW9m6Zz/fcdsU69xH6CZAPhikAM08v4JOBW+G9eLPuRJWAcEF3qrzuk=
Authentication-Results-Original: openeuler.org; dkim=none (message not signed)
 header.d=none;openeuler.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3095.eurprd08.prod.outlook.com (2603:10a6:209:45::28)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Mon, 22 Mar
 2021 14:38:25 +0000
Received: from AM6PR08MB3095.eurprd08.prod.outlook.com
 ([fe80::99b8:b47f:6dd8:6f49]) by AM6PR08MB3095.eurprd08.prod.outlook.com
 ([fe80::99b8:b47f:6dd8:6f49%7]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 14:38:25 +0000
Subject: Re: [PATCH] coresight: core: Fix typo in coresight-core.c
To:     Qi Liu <liuqi115@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@openeuler.org
References: <1616418670-45882-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <914fbf5c-cb1a-47d0-00ec-e971f3e01ba1@arm.com>
Date:   Mon, 22 Mar 2021 14:38:23 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <1616418670-45882-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.5.128.15]
X-ClientProxiedBy: LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::12) To AM6PR08MB3095.eurprd08.prod.outlook.com
 (2603:10a6:209:45::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.27] (80.5.128.15) by LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:192::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 14:38:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4cf6459-16f1-4722-b59b-08d8ed402c59
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:|AM6PR08MB3942:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR08MB39427758E8D63D0CABF810B891659@AM6PR08MB3942.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: EUGunnoSywW+5GnnHka3uYE9fiqwZ0tcozYsb7xZYsqZXswHOpVJ6pc21QZDm/RWEpFuTaGWfE9SbkeQijyWYHIw4mXGiGRoIR/3PD8xBJRhwdXGG8B3CE06vduFbsolXxWOqMjQGBCJtzMfFJHEZV/nyRHWwhZ7P8dKsAFYsJuWpT/1Wv4/FuMDxPfh6L/TBJtDcJhTFbnbG2EV+Ld/Ubt9T6mzgswl8wpq2rnN8BPQB4w2bFn7vp4g17cWFaGL2JTJGWnQarOKk3SGPR4vRt9b0V3VOqmr211nneLoTOki6ngW7Q2gFhqsorsZv9N+mYPkuRcd0tRfDnQlHx2R6iaJV8I+rnfVgzpziFcKnR9DwAXD/fIO376SDpURW+1mHHxWjT01CNpgiXxFalWeGbsiQ+ww5M+oYAMS/KvbRzVlDwtzeGrvvWMRQIHZiaFIxDltjxplGcNmNNNhVtnHqsYQeFxKx4jPTLsP9z6M1U9zw4ah5UYNSp20RFiadxpZeYPKWasY26kAul2sUEkEikuP4JI3VFW2RWfwiaI2AHYUefEclRSp1+r/B51qfb4ROuvkp7kWX5dJsAmhakrPSQNH2BZ31UCJK9jNrIO5oR4UXJMg32CjgCR6QMZ6LG1glp6VA6t2gBf4xJPR9rfIkCrDa97Wu2CfWS5gx8onpE2zU1KsjFdIVAXMzhwqVhySmYjP5+KmV13yqWA3UX1+FA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3095.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(136003)(346002)(376002)(5660300002)(38100700001)(36756003)(53546011)(8676002)(31686004)(52116002)(956004)(478600001)(2616005)(6486002)(8936002)(16526019)(86362001)(558084003)(186003)(26005)(66946007)(31696002)(16576012)(66556008)(316002)(2906002)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QzVWL252TnpaZVl3bzhnTTZtTGxONzhmTmRrTnhtU2RGSzMwQTdTaDJlTXdI?=
 =?utf-8?B?Qkg2VkhweFMvM2J5Z1FFazdDNlQvc1JXYkJMaXZVbFFld3NsZ1BNTzhSQVh5?=
 =?utf-8?B?Um1CNU9vOWpNcDEycHA2MzBKY00wL1pYSDZybWdQOFRnZzJWQ2tXVkdvSmhB?=
 =?utf-8?B?RHdzSTVWM1dBdWR4NDd2SjU2ZGNHVW9qdTVkWEsxTndxdERYeXM5czB4Y1Ri?=
 =?utf-8?B?Y1Y2VllLbUErZExES2pFT0NCMi9QdFpCM2dReUgxSFhqWkU4cVl0STVKTyt4?=
 =?utf-8?B?aFdMT3RIQjk1R2diWVUwOElaZnZZZGwvOXlIdnBpb2R6ck5BSElYc1JuMkIx?=
 =?utf-8?B?K0U4b01iZjRiNEZXenVpM3ZZRU8xZHRjcmFRcFhlTW0zeWJGa3F1TU5waHgz?=
 =?utf-8?B?dFNTa3lTaGkzejRxbjJvSHlOZ1F2OUlpYXZERG5zR2tMcHg5YWdoRkluQlFV?=
 =?utf-8?B?NFc2RGE4aGROR3drZnVydHgvTGUvTHZxRjFwRlgvdlNVeklEK01FV1RjMFJs?=
 =?utf-8?B?VjBNMVM0MEYxMDJWWEpuY2ozTnoyQWVXZUFhMUFDYTdlS0EvNHFuWkZNOCsv?=
 =?utf-8?B?bnVNYzBIOXdwK2F6cHdRMnJGWi9qYlZDdXoramcxYVNsZGVHajgzYTJGVjN4?=
 =?utf-8?B?V2VjTVpyNG1aR2llY1ZnSjh2Z0pGUGpCTTRocDhNNjlKSFlVdnF4dXk0ZmZC?=
 =?utf-8?B?cTNBSjRpUENwN1htMXBmN0lFUlhOMUZ1Y1h5YVZUNkRod2grdWJyQVU1L1Fi?=
 =?utf-8?B?bHFldENOdEh2WDNwQStkQVFzMWp3Y3FEellicEpMdVo4b3BxSGZHd0FITzFU?=
 =?utf-8?B?eHBSRDA1T1c1bDZuODg5djNMdGtCRWwxb3NQb3V5a0ZtV0VrNVlMdTVlZGpx?=
 =?utf-8?B?WXYvODJLYk1KSFdtK1pzNFlYODI3b3FJblIwdk55bGlKU2RTVjZ6enowd0J6?=
 =?utf-8?B?L29hOFZqSVB6QjYzM1o0ZkxWa3BweUlLdFM4UzNhMm8reG9lZXg5eTVoLzVJ?=
 =?utf-8?B?dmMzbVA4dWFhWEZtRmhTbUtOZklZeWl4N28zZUM2Q3I5YTZKZlcvcWY0cmdW?=
 =?utf-8?B?ZFFDT3ZkeEFTa09mV2NEWXhPQ0hsNGc4N3l3d1p4cFhMZ2x1MkRyMkFaSzVo?=
 =?utf-8?B?blQxcHh0K2hkS3JmbmQ4NkQyZnNTL1NZMTRCeUFjdWRCbzMrVFVZSHV0SS9G?=
 =?utf-8?B?WmQ2WjFMWVNZQnovdnRnRWJyY1RPazMzZnhOVkxhWmpaMWZkVVZSY2hLR28y?=
 =?utf-8?B?WWJ1dmVhUkdCa25BZXZaZThEYzY5TlpxeHg3UG1uTlF3OW9aV1FHbUlGb2Zr?=
 =?utf-8?B?VW0zbm9EeUNERnhSUXJJd1Y4eFlpOEt1cE1aQVRVSWxWUHZJb0I3b0Yxblo1?=
 =?utf-8?B?NThiUUFRWHkvbS9TY3N0K3g2M1JrOWRUejdodTU1alVRZi8rUVpGb0FUeVFy?=
 =?utf-8?B?djQyZUJEVmdtK3d4NWdVZTFpRUJSVk9qeGU1VmkzYXNoRzRZYS95akJtVjR2?=
 =?utf-8?B?VjcwSHRZOEdiRXUvWDY4TVBjalIvWUxNQk5hNE9vRnhOWUVUaHphcUk5eUpB?=
 =?utf-8?B?Wjd6VnpqaXhndllCYjNkUnFnbmg5M3dqdGc4emQ1bjQ2VXpRVVBUdHdoeWVk?=
 =?utf-8?B?YXF0UU54Y1VVYUgzQ3VuY3Fic0w4MG9pYmF2Z1dDTElzRmEvS3Q4S0NVNlF6?=
 =?utf-8?B?Y2NZaFNsL0E2Y2kwNGdWUm14dllOL21kajJ3SGE2NEVyUTRKYzlFRnl1bmkv?=
 =?utf-8?Q?/V+Lz07juYM48c5LPFFAz+kkrmsb6Ys1zkhnnhU?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Original-Authentication-Results: openeuler.org; dkim=none (message not signed)
 header.d=none;openeuler.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 11664f34-bad6-435c-59ff-08d8ed40267a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5Gr3X73nXoxEa2smKCtR+akip2+Q4th9pOCM7kEP9yGtS8ph6YctfvTbIZKz9KrStbMTVGrPdLRGQheFmGrLr7O5Qq6PL5TL/h6Fi6PupZFAscGV0aD1vBnkRs60i3C9PE27l3ICde9DN89cVYmQefrnksWqnsgmrmolAZsQv0laBcnMvSRMd9e4dgTz0cI/q33ltEyTD67Y3OKRx/8mw0SMn6ZgwfS5MaykANIwzqJUD3+tUfbk8xm+sR/S+cX4kGE9s3Kwpd/DymhVPto7gLW/kOKqTpOmVrmxKctvYffb3/h1lmAoYcf4SKUr9W9+bBKn1RBEaZZUBmr+oV0OWlDWcl2KR9diKwhyGw/5GqXZOojrVtHIvVeo4AXNE16XCQdagL5J8b4CEmvxg89v3V/Gchgan46PE4wWAWrnmTwv8gv+0ZsnWRqSHCj8Q6b6JdNB52phpda8YCltNQ48kC5LrVl5gctkPr1RH566hoF0322xKGKj9GYC19i7KWDvzSVI0Bbng3Iwh/puME2oDL06WqBfHbPQ7FcCjCENT8DrEv0SwuCPjJ9a75Tl4x7qhF+GXlo6gYckhXG86XjkUKbjsn3FJ3wNFZ1Baoy0HlT7/DoV4X4bVknx9UNo76cyo3o6Elx87B5JgYT7bbamLwbog4MhjMfjPnwxDVtdX0=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(46966006)(36840700001)(6486002)(36756003)(36860700001)(31686004)(8936002)(8676002)(47076005)(86362001)(316002)(2616005)(2906002)(5660300002)(186003)(16526019)(26005)(16576012)(107886003)(82310400003)(81166007)(70586007)(53546011)(336012)(82740400003)(31696002)(956004)(4326008)(356005)(478600001)(70206006)(558084003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 14:38:34.9432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cf6459-16f1-4722-b59b-08d8ed402c59
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2021 13:11, Qi Liu wrote:
> Fix up one typo: compoment->component.
> 
> Fixes: 8e264c52e1da  ("coresight: core: Allow the coresight core driver to be built as a module")
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

Thanks for the patch. I will queue this.
