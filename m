Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8AF33EBB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhCQIlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:41:40 -0400
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:4581
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhCQIl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u62wW1g/M5zIua4uZ5xclTEL81fk4L68Gz6/PHxbTws=;
 b=dXqTzldIG8yCq5kk0nSZFG5dh0R3gGPQcKCXMrZviIxTcES3ZgrR4C3A2vl41S8gYok1m5Db7/kB6uZ26IgtdPxAyP2eEhmugQDa0azyzVjGRjdu07/osMTgdYLlgA73TxeVq7TZ2Csl/RPX6iwJcyK4x5HtmllUaK2gUwXsR8U=
Received: from MR2P264CA0048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::36) by
 AM8PR08MB6370.eurprd08.prod.outlook.com (2603:10a6:20b:361::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 08:41:24 +0000
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:0:cafe::d1) by MR2P264CA0048.outlook.office365.com
 (2603:10a6:500::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 08:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 08:41:23 +0000
Received: ("Tessian outbound 04b74cf98e3c:v87"); Wed, 17 Mar 2021 08:41:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 39162f545af93fd8
X-CR-MTA-TID: 64aa7808
Received: from cf69e5f50ca2.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D941247A-4891-459B-AFB5-0DD90536FB32.1;
        Wed, 17 Mar 2021 08:41:17 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cf69e5f50ca2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 17 Mar 2021 08:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUixXjLNv2OBdQnJOliKJXx1WNXkuEMfXpny3VuyG8YuP290EPNi0R0CR+Tu0tL7tRNUJWm10ji80XVP7ZraolmkFDB7lP88j/z66EiwZm2En17imT2hBt879nIkFahx33vKwwhkmMKSBUM2xHBqGLAKr6H7dvZ3h4eoHlNlojJ8D4fHgnKESssI3XdZb4TM+o+wYTYA3I3ECZ6s+fjJqJv7pPK2GEaRyc5kiVKM3MvpgcTUHudTwCQF3uJv9pVfbLMU+ZD9HvY9KYMMEmz7vlntsy3ncgZCT/A9DPwdyeNCNCLNMQrl2Z/yq7YCLGzwnQS5IlB6AsmxdeklvhWT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u62wW1g/M5zIua4uZ5xclTEL81fk4L68Gz6/PHxbTws=;
 b=T7NNOgBy4E9DlLkxVL6ZySG84ghmm3X/e+msUF+yaFrqwvo1s1v3eEMEd6i4FK+WI902zkmLpNYGX8LYFgYovux9616DG0IjxUr3/XLInNSuBP1BwqMru7kkgtCNuRAvq7w1qkmlTOuM0Adz88lcpsFNO2EVi1WmFBDr/QvJ9Vmx0Pdwz7ZBJdE8+vlrynbWAJBAmIgtMiSO2QFmrBWwxc+CNK6DpJXQXwT9mFAxmWFUQmJH2Iqe+8ZfqUPJh5w+SaPimd9Ti7Z/09unC8oABxZsNgl3qYfkeQukF52egx9KFrYHcMje/BZyrSLDoI1mcKCZmc/9ceze0KXuXQT1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u62wW1g/M5zIua4uZ5xclTEL81fk4L68Gz6/PHxbTws=;
 b=dXqTzldIG8yCq5kk0nSZFG5dh0R3gGPQcKCXMrZviIxTcES3ZgrR4C3A2vl41S8gYok1m5Db7/kB6uZ26IgtdPxAyP2eEhmugQDa0azyzVjGRjdu07/osMTgdYLlgA73TxeVq7TZ2Csl/RPX6iwJcyK4x5HtmllUaK2gUwXsR8U=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3568.eurprd08.prod.outlook.com (2603:10a6:803:7f::19)
 by VE1PR08MB5632.eurprd08.prod.outlook.com (2603:10a6:800:1b3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 08:41:14 +0000
Received: from VI1PR08MB3568.eurprd08.prod.outlook.com
 ([fe80::d032:5b3f:97cc:6c4f]) by VI1PR08MB3568.eurprd08.prod.outlook.com
 ([fe80::d032:5b3f:97cc:6c4f%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 08:41:14 +0000
Subject: Re: [PATCH v5 33/36] KVM: arm64: Wrap the host with a stage 2
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, nd@arm.com
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-34-qperret@google.com>
 <ec9df9a4-a419-089c-469f-1a1509597dd9@arm.com> <YFCqYT3Ib8kAN7/c@google.com>
 <YFDAyhjPEsnZ4N3P@google.com> <eb70a071-4d4a-885f-36a7-3b20358e5513@arm.com>
 <YFDvAqgimPvpgiwQ@google.com>
From:   Mate Toth-Pal <mate.toth-pal@arm.com>
Message-ID: <da9e7839-6d12-c69d-9f23-a091219e1da8@arm.com>
Date:   Wed, 17 Mar 2021 09:41:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YFDvAqgimPvpgiwQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [188.142.195.117]
X-ClientProxiedBy: LNXP265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::35) To VI1PR08MB3568.eurprd08.prod.outlook.com
 (2603:10a6:803:7f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.45] (188.142.195.117) by LNXP265CA0023.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 08:41:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1d7dd33-56e3-4bb9-55dd-08d8e9207247
X-MS-TrafficTypeDiagnostic: VE1PR08MB5632:|AM8PR08MB6370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB6370E423F266309B9B3DDF70AF6A9@AM8PR08MB6370.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hDRb++svfTqFB+NIaitVb2FiIQov3R0KFzS71SN0oRyir08o5r/kIYLbUEbjfb5S2zMHt/Sfpo4BpCibrF0KPkRLFlO/SdacSm1byxnhrbBX+g7StHxibdwXQFTALyeeMF4I2kNgNUZesgIMiNpqw7aHrSix7sbjvZZLpx60ID5WjZOlPh+eOhwTaMs8NfF18Ax9UP7ptAijIzXA1i5NgHxrtOSCz+B3RmLrCDx0Q4y0OrHojLd9Q7t3AFwSNe68obEjtXANFPxjjt99jNWW9WFgTpBGjmtTUtUXKFaHfL2IBDFVdaJaGOFjGlg8NiUAtHEu3w8PY/CviEhHvJaPmiH/yQ5WNbCpDEBPkdMgentPLxjrhwiRy+llY0P2CmQ7zW8Ik6o/EHbYzBQqIofkjU06Xb/p5erYk4a+cz1DFQLSi5I5scIUWBfouq4xibP/FDdT+yWQxaDdCbc4KSXfyxeUL2tMbtnZIPaWmaoKgay4PcoD+APDiB0xsTw2YjgDzlK3bnmHS+6s66A53Z8sHG0+QCe3XAI7xckcryEBcYuXf+rPPleg2zQUMgVWcaHTXeurYx2RsqCb9bVjjedRr4GMjzmsgpczj9H67LOtSTym0LtwawPieWSvIT7Z/HDshEacRIgIpPB4eRQbfTMyESAOhre/M6zAVMW77Hda1jhYC7PcdVM/n3q6cNkrXUNnXpWac17yUq6f3aF3IOtNyW4MA+gzolMd5AiKjRqodA4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3568.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(966005)(7416002)(26005)(36756003)(53546011)(6666004)(8936002)(55236004)(8676002)(5660300002)(4326008)(66946007)(6916009)(186003)(66556008)(66476007)(16526019)(31696002)(478600001)(316002)(6486002)(16576012)(86362001)(2616005)(956004)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aCt2VjUwbnRCNVhvYnZkRHBZZEJBOEp2VTU0Y3ovRXU5UWFGTGY1RjZIUW9R?=
 =?utf-8?B?NWhURnAvS1pweFIwd2VnYVNUTGEzTHVyUmFQdFlNVEVFTVlEejV3c2tEQmR0?=
 =?utf-8?B?Q0xaUjVFdlBaR0YwOStZbTNaZGx0Rm1BRFRIVVlkazI5Y3IvUTJoSmVVNi9m?=
 =?utf-8?B?b0JlU094cSs4NThOSEhLSHBpNlhxZ3lqNHEyR0VpVEhIamZxVDIwaUU4RXZE?=
 =?utf-8?B?bUJUQmpQbm9yWm15dlc3dGhDVFl0ZzN3dzlaTXRCRENQeVByemNsOEVjZWdF?=
 =?utf-8?B?d2V1WWltMHlWTi9zTDFvb0tQTlZtWkxRbjZKU0wyYXJ4UGRHaXFENFlVaHN5?=
 =?utf-8?B?eVFCaC9DRzg5c0Z5YUtQcXpSdTMyZmhrS2FsdUExWkIyTzIvWXd3UzlGTGg2?=
 =?utf-8?B?bk1FRmZKVkhyb3ppelBLV0h0UElPZHQ3QmxKNU5CazV2UDF6TnhhYzkvbzEz?=
 =?utf-8?B?VVM4KysxOE9kUDE0dzdmMitlZHN0bFdTK1dDNElNU21aa1U3YTA3MjRxTWhK?=
 =?utf-8?B?Mkx6VFF2QnB2L3IxUUxNaklZY3c2ZDhvT3NQMWxZa3ZISGhVRmpIVm9aVjBN?=
 =?utf-8?B?Y0p4cVJYcmhIcmhvVVBBaENCZVhDQkd2WDk4Zk8wQlZRNTEwY212RjB5WHNu?=
 =?utf-8?B?T0pPNjhybUNudG5IWUE5cDFDYXNkblk2QVEvTkg4MUo4R25idmNHTUNpWjRR?=
 =?utf-8?B?Ulh0eVlId3AxWFlBcm1UcEFmQkZmYzdXVHFKaFhMMlpFQXNkL1FhZEdJQTNP?=
 =?utf-8?B?U1RITmxwK3RGQ1FMMU5idE16ZkcweXNRZ3BROTJnVXFkWmZmUlZab25xTG1k?=
 =?utf-8?B?NzQwQXdTQlZaeUlGeGp3ME9keGVMT1RnWEpmWFU3MVR5bnBoMmNDTytoMk9Y?=
 =?utf-8?B?akJKM3FUWHhsZWJGMkJianhhLy8yTmFTSXdicWU2UDBMTmhqYnl3bzRSdUo2?=
 =?utf-8?B?Yi96WGpKbkN5NHZScFpiUVZ6b0xmcDQ1bi9RMElqSHA1RU12OGtMS3cwQzNL?=
 =?utf-8?B?U0JQeWxTYjdra2hYSnk4NFdJQmRTbC9HQkdBYTB6TFUrb0NEQmxUVkRoc1V6?=
 =?utf-8?B?Q0tUaWFwV1NPUDAvSmNiMkJ2a1NQeStXVFVpdnhrNXBpWXp3aGlVcjl3ZVFY?=
 =?utf-8?B?UkNtbU0zVXBqTUFCYlRxYnJCNjAwTG5uRVRjd0VUdU5VUnU3bnJwYVBtM0dP?=
 =?utf-8?B?Y3FaOGRIcHFxNkZQMmNaeTBOUXZtbVFHbUpUbDdZOFdGdUVzQnNFRkV6RzF3?=
 =?utf-8?B?ZTFWazAwMUh1TlBXai83aDkrWllSdHZldWpVNUUwTXdCb0VFSmFkOWJwMVNI?=
 =?utf-8?B?a0M4OTBtTks2UjUvUzdSVkZZbTRzV1dHMzN4ZnpkbFlHSlIvNFV4bGwyclNN?=
 =?utf-8?B?L1N0MFYvL0Iwdk14dnNtUGNVS0xvYWlWM1A5R056Y3M1eEJwTkFZTk9LVUhm?=
 =?utf-8?B?TUpSN2t5UHYzajQwU2thUmFtTlN4T09qMkxDQW9QeDlZZUtRRkx4V3VoUzg5?=
 =?utf-8?B?eE45V3ZsaExYMExEbkVhaVVEd0ZTZmNoVERsNSt4cXNEbHJ3b0dUcUZ0SkZC?=
 =?utf-8?B?VDVhVWVtUURHZ2Z2eEhLazhGcTdmSkt1ODFDZFc1cjZZcFRWbEhtRUpiUzVm?=
 =?utf-8?B?TzVCOEtwMkc2eDdjOFRxUnVEaEFBZXZGVUR2VkdGUThXMnE2QUtlK1EzNmEy?=
 =?utf-8?B?aUxER2ZkUEp3WjdENkZPWVNhY3RLa3F0M2ZWZGpLQVlwWWxvUEQrMWRNTjhw?=
 =?utf-8?Q?zc4OlSjpJuh3nPXj3UxCo/Rmx68wJMrByacuZeh?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5632
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1ebb8b08-fab3-4b01-ecc1-08d8e9206c31
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNG6VJod5zZUMskcsJCwB8K5vDPTxgDNVh+wYpRvKZar/GHeoaS5PGHdUmKddP2/xVtgO2tvEJTxFdqGCsjTty6SbA75wp9PLEANylq6A+smSvj2CqTZPKXiu/6F7Pp8ixeIMA2UI+sdOHF0UEyL8gPHZNGXXCFVF/+c1/hUpqYAhDMgDeP3fFdi0dMn5qxBDNd+ZeRh2k+Up5oEiWgknPCgryvGnDEybsQohOx45fLsZ1HHPzyRVlaIeTk9zhIglN0rqEO4KlCRRDb6HlJUGf58rw38DM91LK4OE+Luy2xzUnZaYukK9wDSTTQJoOPRBeOYDND79oSr8cHHnftjU/wNGrHO7XI3s9X9cXwUB+cNA93KRTjlLW9gwcFDEk4R2NYwlpzDBy/RCoFD1luLtIxTWBQybjzI1lAKYdVIvS88+mWIwxV56Z0vP7ZRGHkgeKC5B5Hb6wRK5Yxoth9RCdeZQG0itdj1B67qYjn0wvmnWK6FJVBPbm/5vZWAPXYJMUje+WvZ7xIOWEmNLg94Atlqt/UdxNV5iFQHkxquDWW0Hwrnw3FGcd3Rzeoa+RaYMrYKzLmpwp6NMKOpdv19rDOrP78tASX8bHdClv2vtQt9Fjvu7G0lKST7NNsWsNR6yD/6eCz2ABpbELofPBmuIuzueyc000+Wxq8RGPhLR7T7h8RipnYLV2GS7c8R9Y1ZOYWpFdAs1gCSCBtUu1lvw23VmyPgawwW/A3FJiGM4tz+E85jYyhhGYyTumBGNuwqFsv39pQZ0XRSNrmoKhlvzw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(316002)(6862004)(4326008)(8676002)(5660300002)(478600001)(36860700001)(16526019)(31686004)(70206006)(966005)(47076005)(2906002)(70586007)(82310400003)(356005)(16576012)(186003)(26005)(81166007)(2616005)(6666004)(36756003)(956004)(6486002)(31696002)(336012)(82740400003)(53546011)(55236004)(8936002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 08:41:23.6736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d7dd33-56e3-4bb9-55dd-08d8e9207247
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6370
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-16 18:46, Quentin Perret wrote:
> On Tuesday 16 Mar 2021 at 16:16:18 (+0100), Mate Toth-Pal wrote:
>> On 2021-03-16 15:29, Quentin Perret wrote:
>>> On Tuesday 16 Mar 2021 at 12:53:53 (+0000), Quentin Perret wrote:
>>>> On Tuesday 16 Mar 2021 at 13:28:42 (+0100), Mate Toth-Pal wrote:
>>>>> Changing the value of MT_S2_FWB_NORMAL to 7 would change this behavior, and
>>>>> the resulting memory type would be device.
>>>>
>>>> Sounds like the correct fix here -- see below.
>>>
>>> Just to clarify this, I meant this should be the configuration for the
>>> host stage-2. We'll want to keep the existing behaviour for guests I
>>> believe.
>>
>> I Agree.
> 
> OK, so the below seems to boot on my non-FWB-capable hardware and should
> fix the issue. Could you by any chance give it a spin?
> 

Sure, I can give it a go. I was trying to apply the patch on top of 
https://android-kvm.googlesource.com/linux/+/refs/heads/qperret/host-stage2-v5 
but it seems that your base is significantly different. Can you give 
some hints what should I use as base?
