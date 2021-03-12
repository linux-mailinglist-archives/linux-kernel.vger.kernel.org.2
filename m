Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97DD338E52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhCLNJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:09:33 -0500
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:5954
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229667AbhCLNJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q+5edGybpnNXtza2ON2f7EqcQDeUO9LiIPBh4vrMMY=;
 b=0pt1yjav10xJ5e4dAZGF1ZzkYLJ/q1kNFtK2LV0YMj1aOQkTAaiR76/rCordUoCi5THdHmbB7aAO+sNerIeKhc76H+38cJp2lc8xJryjscWW9APG3wC7tHrtFN3r4zIUJu4BtXk2F6eTfKAweVZC4vi8p7CgaLMMSjdkQDWVb8E=
Received: from MR2P264CA0076.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::16)
 by DB8PR08MB5386.eurprd08.prod.outlook.com (2603:10a6:10:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 13:09:22 +0000
Received: from VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:32:cafe::14) by MR2P264CA0076.outlook.office365.com
 (2603:10a6:500:32::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Fri, 12 Mar 2021 13:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT048.mail.protection.outlook.com (10.152.19.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 13:09:21 +0000
Received: ("Tessian outbound bbad306dbec1:v71"); Fri, 12 Mar 2021 13:09:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 88846883f414399b
X-CR-MTA-TID: 64aa7808
Received: from 4046d1cde74f.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 864141D3-4344-425C-A943-3D2F6FF01D96.1;
        Fri, 12 Mar 2021 13:09:16 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4046d1cde74f.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 12 Mar 2021 13:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy65RpJkHGNGbmDIWwkn4fAVIR+4ME9beQUEan5oLiti7/wyGvJxNbhV0RKe8z/TM7shsRWGTII+lh33lVUwuyyi0Tr6yffvo+wbcPHwEhBoemeGSWh/25VgfM9WMA5tTC2o0DRAaSwg37HtzAaOCPuikHn6r+jO0ArJzb2GtCgaYiqEokDQSZVqPfdgVb/qWSA+W1oubN6ueAibFior3fORprWo+a4zyRJ1un9LVMPL9QNxom8zeKxJh9ve6Sekf8PM81hNKL7W7m3mlcqf6VSo8o9lLYeOcuTsl6xgUSwak9C0XMmsZaAdWx2gnf7BKf6xJpGi++7Zad3BFI/irA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q+5edGybpnNXtza2ON2f7EqcQDeUO9LiIPBh4vrMMY=;
 b=R+u6KeP4bFND1/zENL45k+8Giujaz9fyR+DOXgs8R5cjJsMTpJgQBADJ2Qx8Sbgm3Z276BTiKBUgRzQJ/fAy4d1LPTWnY4zSq0nYPrYg0OLZ0IlEpBedCCzA1VtK9K5Xh8iZNod3Q+XdvxsayCgnu2qOR64Jx14vwCnMQxWMsaZ2OG0IdzkqIO9HkCxa7qqhFOW1eqbD0UdlH6cI+fyDmbeSqx4O3HRmnAtGQPF5UWcK63vwmxZlE802W4Kp6sc8Fl1HDEnpScA98jTYiEO7YmetL2wjCuQjzDFL247hKe6spNG7E1lMmueId7FpoLtv9MEv0RFJiojDjCLQ/dA4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q+5edGybpnNXtza2ON2f7EqcQDeUO9LiIPBh4vrMMY=;
 b=0pt1yjav10xJ5e4dAZGF1ZzkYLJ/q1kNFtK2LV0YMj1aOQkTAaiR76/rCordUoCi5THdHmbB7aAO+sNerIeKhc76H+38cJp2lc8xJryjscWW9APG3wC7tHrtFN3r4zIUJu4BtXk2F6eTfKAweVZC4vi8p7CgaLMMSjdkQDWVb8E=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM8PR08MB6484.eurprd08.prod.outlook.com (2603:10a6:20b:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 13:09:13 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 13:09:13 +0000
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
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
 <20210115121342.15093-16-vivek.gautam@arm.com> <YD/GjQIKkaJ5+UJM@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
Date:   Fri, 12 Mar 2021 18:39:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YD/GjQIKkaJ5+UJM@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::12) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by PN1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 13:09:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94bb5766-b6c6-4f45-4812-08d8e5580d8a
X-MS-TrafficTypeDiagnostic: AM8PR08MB6484:|DB8PR08MB5386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5386FA3514377CF2144158BD896F9@DB8PR08MB5386.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iq4p6A5BlK5D4RDfilJBIMgqzzgpDAP8mWgwNykn4g1Xoz7Plxtp8DJYMLVLSL121boAu7s99ISH+KTJ5kbfenZQFVmjV6L6QNaJu7Us5vxrUF4yIQAXFcZDot/9Gc4RMZn7I0986+2Sb5uN7NvwFUrrJVdLtOC1Eo/i2mKBkx0Ejf/Wn0TWqUwowLZkC8l0QGjpHB0ajB3r276XXNl2U2QFGpHH5ifVX+7Zb3LPNTGbfhNkSyZn4azvlD2af4VtfyPHb53DWDKfaXA5sotMiD6EpNpE3G2szwjTMz+Nt9x6reksCQuCME+/lkA2SBgfBhE8JiLUJ+tydFvSdMdazjwDlXXqc/nmLPDJp62SyM1hpz28N6ZyqubV7KbwilSttTofHaEcZ8CbrJXvDbjS87280Y474m9MsXaxrM2yYzsWN/VjtB3vLE008vhKPvpsSFcZvYpEzUFFrjKG2UKQmkSoiHnrFZJ6fsMZ/wU2Fh/TlFn34WZdMAfWXMaMFkacTwmTxl73e3kr4o78iZvb6mT3JG/mOFWeisuPL+mZ0p2e6JaN7IMp94k2da4BgdlGdY5f2wcH6IzM3blWxUuoDUp95GF3KlgNHyX/ipY+bqu/0nNzYLfT4ZO0IAQjsbWhj3sSSTX4NEjPWePaCoagaA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(36756003)(66946007)(66476007)(66556008)(83380400001)(31696002)(86362001)(31686004)(478600001)(6486002)(7416002)(6666004)(8676002)(6916009)(53546011)(2906002)(316002)(5660300002)(16576012)(8936002)(2616005)(956004)(26005)(16526019)(52116002)(186003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bElwdUdYaEhLOGxFM2k2MGlSQS9MbGc4Y0Uwa2lLTTcvcXJpMWFqVW9aSkpU?=
 =?utf-8?B?eFpwbUJRSVo4aW4xVnJQNkNzbVlBeHZsWUoxL3VrazZCVXJhR0RNaU9pTjIz?=
 =?utf-8?B?VkdnYWFMNlNmUEVsaTRoY25ScW9VZlR4VHhhQ0NqU1VkSWhsZlNwUHI5U0RI?=
 =?utf-8?B?OTZzUWV6d3c1dzFyZnhNTnp3SnR0Mnl3dFBJYUtYVXphbDZLYzZqdUdQT3BU?=
 =?utf-8?B?WkVjUVVRZTZObVNzd3kvZituVnVCSGZCeVg2TDV6RTN2ZGRaWVJhWVdLZENI?=
 =?utf-8?B?OVVvc0ZNRnJJVCtqRGVHb2RmOWVpTVlJZTZBQnlJRmZZckFWeWpuak5teEg4?=
 =?utf-8?B?SkZGNmhNL3Y3OFZJc0l2dHVUTHptTFJoazBhYXRlamJnbVhWUjZTN1JqVmU4?=
 =?utf-8?B?QjlFSTQrU1RKMkhRVVNHSHNZTHJJR2ZjVEhzK001MU94eVQ2UUVpdnVTREE2?=
 =?utf-8?B?S1pScGRDamZxcDhRYlBLeEJ3Ny91Y25aSWJyQjEvbG41NDB4Z0NZRXlYUllX?=
 =?utf-8?B?M2diTlQ5WUdjMXpubmFKRmpkOW9NbmxBeS80OHJGZHdJbGpyZzA0YVhPeU81?=
 =?utf-8?B?RlhlSWs2TVR6cm54M0xqcUM1L0plS3BxQjNDQk1jMHU2ajVkcnEvaGs1dUxr?=
 =?utf-8?B?UDIrbDgwREZXeWt4Q210K0ZoQnh1Uzk3NzZ6cXJjNTZWZnk4RmxKR2NjREhn?=
 =?utf-8?B?U2M2c0dTQThwbDRmR2xwN1puWjlJWVp2MTVRYjI5SXdyOHMyNk1lMWgyZi9z?=
 =?utf-8?B?TFpCTytubjliRHU0czJZYmpOcDg5UkVRRjEzcFNnUFFCRjdWNDVNT2g0d1lk?=
 =?utf-8?B?L0Z6K3U0RGF5M1VPUmtSZW10S2JSSnlsc3dZVkxJSzV0TkErdFpQT3IwQVhG?=
 =?utf-8?B?TFlBR3hXaTJsSHI1cC9Qd21GbkJyb2VEUW1BMnkxbnhPSmtDM0l4b3JnbjF2?=
 =?utf-8?B?UG4rWXpMTm9UREhJVkJPbGtjeXNoZnF4UUtobnNieEpoM0Nydk1xTUFRaTNy?=
 =?utf-8?B?VSthVlByWFFPOGFNYmlUdThCVTgraHRuU09iZjhadC9xT09mb0ljWGNCYita?=
 =?utf-8?B?V0Irak5uY2dscmZaUjB1Ulh0a1h2VTQ0dmhtajNDTlFQREh4dkxOMUxqRC82?=
 =?utf-8?B?UzE2NTNRTnlKckVxTWVxNTRWakJrVmRqbk9jUFFkUThHaVAvak1obDN5T0JU?=
 =?utf-8?B?Y3QyMWF4MktuOW5NWFJwNVJTTUFBMWxtU3ZyVy9UWXRmeEVadE4vREMxa1dr?=
 =?utf-8?B?eWFqTmN1L0QyWmRCV0RsdXlKbTNla0ZFVFpCakpabk14NTNBSnZweHJWdkFv?=
 =?utf-8?B?OTlKNld1YjR6Y0VrZHp2cGkybEJTREhEQzhvOXE0Y3kwM2pWUFBqWGQ0andq?=
 =?utf-8?B?QitobmMxSTNOeFFsOURYTTZqcG1RejJxK0dPdTFEWGVwOXRnellrZy9pd3Fa?=
 =?utf-8?B?TVY5QlB2ODErVEx4WE1vbEFCU3pCZld6RXgwRTdxVWFQOU1UUmY5N1MxZHc5?=
 =?utf-8?B?VlJMWGJOeTZTUzkxT21NSlFiSTNpSG5GWHJCWWZjZjZwL2dUc0NRN1AxcVgw?=
 =?utf-8?B?RTQ1UFIreVkwRXdQOHBJZWQ4QXF1cjdVNXMvSWZCTlhicFlzcUJrNnRtVUw5?=
 =?utf-8?B?dE4wYU9Od21HT3lyTWJ0dnc1ODNFQTBXb29aUTNjSUJGU29KbXRwWDY3WEs1?=
 =?utf-8?B?QzVPSUhUSUs5K0RhRVJDY0JQalc0UUwzZkJmWWZtU2lVZ3FnK2UzSFc1R1cx?=
 =?utf-8?Q?6DkN6weRRHwFFnkaeeT7IQgNwCVev+bYQiJQ2aL?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6484
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 23a5f8ad-91f2-46fb-0e40-08d8e5580829
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1k2jqdN/gTuz+4jdkVGUmlOCI155e9H/c/+4yvd7AuGkCHaKR8K68yyWXFgivWzy/bocrxHmhfUcybABdVUHwN3w9NSq4gMotS5SS9ooYPthPaV6fqZEpmymmrTHAsvBB+t3dIiFuKzcIRbReyEZWqkdnDbgvNaHyTaLx7lz7Qg/16JC6iuG+9+JWA6TUjbc/OOPwp6cwPd+bBvMKS9NxGUlyK5ABEP7eThPpKUfupmw0vw9ys5yRHwlE291+CFWL5o0cfuUvSLq+1jbkRbDecuO2/x/I9npv3yxvYdoaarVSyLyK/GbB9xaxv5oMu/KO820coDPqcEczEVmTPy+GVhVStWCsly93H63s4d1pU1B2uaEW8vqBGqv1VEIYhGeri0tlP9ywYIXcw4+78mvrM+4f4puhuFV9r341O3QNUPAXhVV919tWajaFTr7VmyiHZWHxTDbnswUOltOSXXZWBXFmBAmNlOK4LIcLgFvXUARlnryv9VZ6DsSttmrGUp3oh4UhscIoMDYzS8vVIXPJ/9jx/eI8Nn6nqQ2NFmHEKNvAah4bXsprNbtbx6y0c0o8xCH5ZNj6z7s6BjkSxX3IIRnB2f60LUNKWygasbWaJS8uZ5SIZgUK0mtvsYpRo6CDjL8UXKwYkfMg2qfMkovq4tTvrEwu/ZL0KhQQNb4K7VMnKCS5+HTaoV/IlrEL6IV
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(82310400003)(81166007)(36860700001)(31686004)(83380400001)(82740400003)(356005)(36756003)(70206006)(70586007)(31696002)(86362001)(47076005)(16526019)(316002)(478600001)(53546011)(16576012)(8676002)(107886003)(2906002)(5660300002)(6486002)(6666004)(956004)(2616005)(6862004)(4326008)(336012)(186003)(26005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 13:09:21.8245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb5766-b6c6-4f45-4812-08d8e5580d8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/21 10:55 PM, Jean-Philippe Brucker wrote:
> On Fri, Jan 15, 2021 at 05:43:42PM +0530, Vivek Gautam wrote:
>> Fault type information can tell about a page request fault or
>> an unreceoverable fault, and further additions to fault reasons
>> and the related PASID information can help in handling faults
>> efficiently.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
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
>>   drivers/iommu/virtio-iommu.c      | 27 +++++++++++++++++++++++++--
>>   include/uapi/linux/virtio_iommu.h | 13 ++++++++++++-
>>   2 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>> index 9cc3d35125e9..10ef9e98214a 100644
>> --- a/drivers/iommu/virtio-iommu.c
>> +++ b/drivers/iommu/virtio-iommu.c
>> @@ -652,9 +652,16 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>>   	char *reason_str;
>>   
>>   	u8 reason	= fault->reason;
>> +	u16 type	= fault->flt_type;
>>   	u32 flags	= le32_to_cpu(fault->flags);
>>   	u32 endpoint	= le32_to_cpu(fault->endpoint);
>>   	u64 address	= le64_to_cpu(fault->address);
>> +	u32 pasid	= le32_to_cpu(fault->pasid);
>> +
>> +	if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
>> +		dev_info(viommu->dev, "Page request fault - unhandled\n");
>> +		return 0;
>> +	}
>>   
>>   	switch (reason) {
>>   	case VIRTIO_IOMMU_FAULT_R_DOMAIN:
>> @@ -663,6 +670,21 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>>   	case VIRTIO_IOMMU_FAULT_R_MAPPING:
>>   		reason_str = "page";
>>   		break;
>> +	case VIRTIO_IOMMU_FAULT_R_WALK_EABT:
>> +		reason_str = "page walk external abort";
>> +		break;
>> +	case VIRTIO_IOMMU_FAULT_R_PTE_FETCH:
>> +		reason_str = "pte fetch";
>> +		break;
>> +	case VIRTIO_IOMMU_FAULT_R_PERMISSION:
>> +		reason_str = "permission";
>> +		break;
>> +	case VIRTIO_IOMMU_FAULT_R_ACCESS:
>> +		reason_str = "access";
>> +		break;
>> +	case VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS:
>> +		reason_str = "output address";
>> +		break;
>>   	case VIRTIO_IOMMU_FAULT_R_UNKNOWN:
>>   	default:
>>   		reason_str = "unknown";
>> @@ -671,8 +693,9 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>>   
>>   	/* TODO: find EP by ID and report_iommu_fault */
>>   	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
>> -		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
>> -				    reason_str, endpoint, address,
>> +		dev_err_ratelimited(viommu->dev,
>> +				    "%s fault from EP %u PASID %u at %#llx [%s%s%s]\n",
>> +				    reason_str, endpoint, pasid, address,
>>   				    flags & VIRTIO_IOMMU_FAULT_F_READ ? "R" : "",
>>   				    flags & VIRTIO_IOMMU_FAULT_F_WRITE ? "W" : "",
>>   				    flags & VIRTIO_IOMMU_FAULT_F_EXEC ? "X" : "");
>> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
>> index 608c8d642e1f..a537d82777f7 100644
>> --- a/include/uapi/linux/virtio_iommu.h
>> +++ b/include/uapi/linux/virtio_iommu.h
>> @@ -290,19 +290,30 @@ struct virtio_iommu_req_invalidate {
>>   #define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
>>   #define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
>>   #define VIRTIO_IOMMU_FAULT_R_MAPPING		2
>> +#define VIRTIO_IOMMU_FAULT_R_WALK_EABT		3
>> +#define VIRTIO_IOMMU_FAULT_R_PTE_FETCH		4
>> +#define VIRTIO_IOMMU_FAULT_R_PERMISSION		5
>> +#define VIRTIO_IOMMU_FAULT_R_ACCESS		6
>> +#define VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS	7
>>   
>>   #define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
>>   #define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
>>   #define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
>>   #define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
>>   
>> +#define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
>> +#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2
> 
> Currently all reported faults are unrecoverable, so to be consistent
> DMA_UNRECOV should be 0. But I'd prefer having just a new "page request"
> flag in the flags field, instead of the flt_type field.

Yea, looking at what I am currently trying as well - handle page-request 
and leave all other faults as unrecoverable - I will add the page 
request flag in the structure.

> 
> For page requests we'll also need a 16-bit fault ID field to store the PRI
> "page request group index" or the stall "stag". "last" and "privileged"
> flags as well, to match the PRI page request. And a new command to
> complete a page fault.

Right, will add the fields as suggested.
To complete the page request we would also need to send the response 
back to the host from virtio backend when handling page request. So the 
virtio command should also be accompanied with a vfio api to send the 
page request response back to the host. Isn't it?
This is where the host smmuv3 can send PRI_RESP command to the device to 
complete the page fault.

> 
>> +
>>   struct virtio_iommu_fault {
>>   	__u8					reason;
>> -	__u8					reserved[3];
>> +	__le16					flt_type;
>> +	__u8					reserved;
>>   	__le32					flags;
>>   	__le32					endpoint;
>>   	__u8					reserved2[4];
> 
> Why not replace reserved2 with the pasid?  It fits perfectly :)

Sure, will do it.

Thanks & regards
Vivek

> 
> Thanks,
> Jean
> 
>>   	__le64					address;
>> +	__le32					pasid;
>> +	__u8					reserved3[4];
>>   };
>>   
>>   #endif
>> -- 
>> 2.17.1
>>
