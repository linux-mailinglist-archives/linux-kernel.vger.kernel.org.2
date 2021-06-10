Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8773A29DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhFJLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:07:49 -0400
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:25792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhFJLHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYoQbjyjo1M0flE+8+i707uaNDFwf8aChRNyLiPsP4s=;
 b=4qQO5Cajs6tRS85JIRJ+pSQOB/WvGg3Et/YLuFjRFVpW1glVHIrbDDkIXZFhDRuUe0aasA4yLR5aqgxjixsdMKTQb0tZhmnmb7yUIL3ocGXKzSv1Oa0c4yEZokv80jWKlynYWJyWCwbEw0coWltQPvVfbT734QfGP39q8n/vIgw=
Received: from AS8PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:310::29)
 by VI1PR08MB2893.eurprd08.prod.outlook.com (2603:10a6:802:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 11:05:33 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::94) by AS8PR04CA0024.outlook.office365.com
 (2603:10a6:20b:310::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 11:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 11:05:32 +0000
Received: ("Tessian outbound 5e4f56e125a9:v93"); Thu, 10 Jun 2021 11:05:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 68041148cacf6945
X-CR-MTA-TID: 64aa7808
Received: from 88f92cd33f93.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7AA5C476-C1FB-4747-B6F5-6199A05770A1.1;
        Thu, 10 Jun 2021 11:05:21 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 88f92cd33f93.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 10 Jun 2021 11:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VET50f8Qb7ntuQYBghDaUzUfZw5KFDdWAF2eQRGDTE8N8PYNqgK7SmdJb3Jo2K+8PAfxPCPBY2A/popPj8dBIPJx2dPceH+BOd6RYVXm0oQSjwN6w+qwIWoww5AVLVBhr+uTpGY39Ct4J39q8C2G5CCXbDI5Y3La5X2Vvb4k5pOOuW1qmm1TN/1qyNNDLqmYH5HF45ANQr4gOVH9T/1T/UVnL7n/+D2BIoj27xXWZebKkEi3y/XXsuYGuqti61xmX390LpD/erlSYpr0Z93QO41R844YfiFO0idXgGKVXJZ8Hp8Nhb8qaGZ/piH5G1l0vZoOigCmzT5skZCe2anPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYoQbjyjo1M0flE+8+i707uaNDFwf8aChRNyLiPsP4s=;
 b=fB9F14M6G6h4MaiplU22mn5SOLIEDjJP/sBAuiwWcLhDSF3U6tzIBCKcoY3WeAirWD3zPpU6vaC4PPgYJ8oJmgPrbiJFnGGOm4aJvTuGn6PkgXED4aopRgzigRI82F4xmnmxY0YUnv6MuVIAkCmonelDCrJOKWHWkF/s5PNhqhGAosLrYnlUiqpJiAGysAtCeAvgFkatZNFV7rAu0R7OMuW/kWkEOQxk7INAV1gFzM+FcSvvBRFmg+noKvytZlQGkQ031XwSxF29TBdr049BIgRsO7LDAt85qCfoKiuHaKYoVGXcSVrBB40XikT1RlmEG6NABzJ+Nv0vafB2uqoBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYoQbjyjo1M0flE+8+i707uaNDFwf8aChRNyLiPsP4s=;
 b=4qQO5Cajs6tRS85JIRJ+pSQOB/WvGg3Et/YLuFjRFVpW1glVHIrbDDkIXZFhDRuUe0aasA4yLR5aqgxjixsdMKTQb0tZhmnmb7yUIL3ocGXKzSv1Oa0c4yEZokv80jWKlynYWJyWCwbEw0coWltQPvVfbT734QfGP39q8n/vIgw=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com (2603:10a6:20b:29c::13)
 by AM6PR08MB5079.eurprd08.prod.outlook.com (2603:10a6:20b:e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 11:05:11 +0000
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::103a:d13f:1a60:e1d]) by AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::103a:d13f:1a60:e1d%5]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 11:05:11 +0000
Subject: Re: [PATCH v7 05/10] coresight: syscfg: Add API to activate and
 enable configurations
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nd@arm.com
References: <20210414191903.18349-1-mike.leach@linaro.org>
 <20210414191903.18349-6-mike.leach@linaro.org>
From:   Branislav Rankov <branislav.rankov@arm.com>
Message-ID: <dfbb1acf-b174-1990-33d3-39e2ab746959@arm.com>
Date:   Thu, 10 Jun 2021 12:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20210414191903.18349-6-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.99.251]
X-ClientProxiedBy: LO2P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::30) To AS8PR08MB6069.eurprd08.prod.outlook.com
 (2603:10a6:20b:29c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.47.24] (217.140.99.251) by LO2P265CA0090.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 11:05:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc8650a0-ec24-4a87-da8e-08d92bffaa78
X-MS-TrafficTypeDiagnostic: AM6PR08MB5079:|VI1PR08MB2893:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB289312A3F3EFF15FC0B47E3594359@VI1PR08MB2893.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4GT5clyhJnWL5Q3HMUy39rH8+7TzWFbb2Yo0E3HPR7qozW+HLju59mWcSyFLwxktfi2MvU6FUCHFRbt6TtqM7Il3UzTtqWOnFIb3G0Mj+APutGE31iY4KfcXCjC5TFd0eGRTU3Vktg9+j+4d9pM313ggNX1M97tcA9IxvfHejF4hgS1ophpGuolguSuxKpTnogkDOCJLv65z8LxgAXCRZy8PvaJnsT/tkT57qclG7cxBh09FacsiuUiOwHADFsWgBvjysVgwCZ/au6GW3SofRAQgsZAK4uRE/aHe7xn2wkkpEb+j9l/nWWVrKbW8f59Nxsv3/uYAX2bOUeDghJHUp+EH0am6W18zPDolXt2T374/xMCkO6xB8lNzA5JT/tOgdtL4Ztqfv7Qh7GWSYJEPavP/6tyGYnowW/KEhN7GCo0nb+qFTp++hULkogWfsIh8j9tsvR5VgAG6+wBjbWEBcfCoCRtHEtrXueYfDPBfYi7YH1XJLIjuD5epYUH3UZ1EzRi8u0A0crpicaJ2yODeYir6vSshVFKm+uvRl7ySu2uCKF3i/eaS0v/vjEYk3FmQ/kkujR1kMWdzDX9RdGA4ZArr0snO8DjZA8Gp2vxynPOJwekIcyX0Au2SIKnxgBM5jWTVPWFK9rtVy3cSpr24y79PCsPRh5v3zEvMMClEHfN8exas0jKxhgtzOXMZCFERn8i066KPv5IJf0n5VCyL5A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39850400004)(346002)(66946007)(8936002)(31696002)(16576012)(26005)(30864003)(316002)(16526019)(2616005)(36756003)(6636002)(44832011)(478600001)(52116002)(4326008)(53546011)(38350700002)(2906002)(8676002)(6486002)(86362001)(83380400001)(66476007)(38100700002)(5660300002)(7416002)(31686004)(186003)(956004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0RZSjZpMmlDbndtOFNqSWQxeEk4NjRnK0FBZ2JCSnM2d0pTeWhFZ0VDMXk1?=
 =?utf-8?B?dWxtU3FFNmtjMWQ4OWFxb0FhVEp5K1hqME5WQzFRWHVkSktKQmtxTklvVG14?=
 =?utf-8?B?a3JEYithdkM1VHZ3SnNSVkNhMVdCVlY4eWxrNXdFaGRjRUs3MjhaMjhLS3lt?=
 =?utf-8?B?RHRiUEtQc2xwR25rNGQ5MllxbU5GKzJsWDI0NkRkWWJYcU9GZjdFazFRbW11?=
 =?utf-8?B?YjdGcG9WbEFUSlRrUm5Jc1YraGJ6bk1SSWl0aXI4YzdDWk9JMGFtdUNyaWly?=
 =?utf-8?B?NERiZXRZMG5WaEV4dlM5L0FhN2ptck9KUDJGeEFWak4rSmJjVjRVRDBlM3dF?=
 =?utf-8?B?VzFLTEkvQ0ZzV08zZDNWMEQxSWcwRml4N3U2WWpFcUFCRXRzZTlsMklOOFJX?=
 =?utf-8?B?b01OSHV5UGZtczVKSFlxRGtTZ0xWei9KZkFMdGtsNG1nQXFGenplL3JRdFZS?=
 =?utf-8?B?LzZPTjVhZUI5UnNoazl1WlVwaHMyTi9Sb1MzdjBmVUIyRk1neWdHUW51K243?=
 =?utf-8?B?Y2lRMkwva1pXS0FLN3paM3NLb1Fhd1l3N0NzK1AwazV6czJ1TGE0bXlJWnJB?=
 =?utf-8?B?MEFEaGlvS1RaSXltalkrU1RFVHdKMTZyRE9OSUlyWHhwVVlKTmh1eG94aGxl?=
 =?utf-8?B?NW1MQmtZZ3VNNURtYWwzVUZkZXBUV29QLzdibm5JSjN4WmhjNnRSMUNxeDFB?=
 =?utf-8?B?YUE2VXNYeVZ0em5TUkdlQ0RGckp6aFUycExJMlR3bkZHbFkyM0NJUGpFWVQy?=
 =?utf-8?B?ZUh5UHV4QXIyZ2ZodGRFbWVNZzRuQy91dFNXdHFjcUNBZ25Qa0VCV2RiN1VB?=
 =?utf-8?B?TUxkc3o3dXVxVjJ0Tk45THRhTlNmRnovSEVvV2xCQU85NnNxZEc2aWU5VC96?=
 =?utf-8?B?a1NNYnJZZXJ2T2VmQjVzVmU2amQxSFVRWTZvMTJaT256YzZFdThjbXFXT2Z6?=
 =?utf-8?B?dnE3QVNWemFUTkRYS1c5MG9kbWRkaXB2OE5tT0l3MlNETm9JUnJLa1cvT2RF?=
 =?utf-8?B?RlBMZGVvMk9tOE0rMzJDTlhkcmpUTzZCYk5ER2k3VVZZUDBDM3VHZEUyU1Rh?=
 =?utf-8?B?cWpFMElhQ3R5SW1RcEdPc01TN3EyT082OVdYcUZwNE5xR0tCd3F0a3JvS2hs?=
 =?utf-8?B?c3kyaGE5Zi9ERXQ4NkFtYVBHUlFxY2V5dXVoV3JuMmVybDVpMzlZWm5PR1hx?=
 =?utf-8?B?ZTFZYkduWWNBZWtoZk1paXFtbjZpbENZL2NlSWJ1VUNsSFJqck53cVNCWDRr?=
 =?utf-8?B?NWFaSTFSRXJIbmhIcjZpM1RZTWh2L3NmRWJ3QjR5Mk42MjNSVGN2Y0dqMmRK?=
 =?utf-8?B?TlliWEhLMHgzN1JCaU9lMUNudEE5MW5LTkVNZVBLa1ZiaXRMbzdEMXZsbWw2?=
 =?utf-8?B?WFhVanlUbElkUTB2MUdleTh2UlZVMDFwZGhBKzJBMXBSYmY0TTV0ZCsrUHJ0?=
 =?utf-8?B?TTBHOXd5UkJESHhJNlBSRXRhZ3RRV21UcWlUWENTVU5aejFjeDJxSUprRGFs?=
 =?utf-8?B?SXJ2Y2crVURGNkZSY0hTa0VIL3lHRmYrNmFzTDZhVWpieWJaSEtEVktyemI5?=
 =?utf-8?B?cWpZUERGdUg0MUd3WHV4L0FWRFBiVHZvNDZQcmI5ZjJJb3J2NzhqTVFGNTEr?=
 =?utf-8?B?Ty81OUcwV243citWeGMyenZVZGFxdDZwMEQ4aktaYVdySURjdXhxVVhtUHhI?=
 =?utf-8?B?d3RScVFORTQxTzZXMlIrSXRuL29wVGUySjM3alIwcS9DVldZTklrbmExQkY1?=
 =?utf-8?Q?S8Ucf6jX8TF0GCmpeQAftIIJsTzQaAQdgo1jKY4?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5079
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e77d64b3-e2cb-47e4-94e8-08d92bff9d5a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPg5DqU21yB0tHmEG0EyRi8l6wuqq0Qz7a6FFxO7lOCfGvBMvXjPD9LmtUgvGrTxeHkAvz7UgVBmelPAFVK9YmizwbeP/AstCRK/SXCVU+0N4oji5TYqOBvTZrBlwN27je7swZRU0j0WNPsl1BRJkdpTgKpGbDGTqRc3F7+TVzZYrVBsw/tmyASVM6kXmWYJaLj1GPReVINULvAIngnfdQk9YlhpN0/NauRg34myS4PAdI506/udcs3/WOgE7DnYwi0lGzMnVnGtYNDwpjjjHkCapj7JeIz+VZe2lWFO+NpHeTk3ZhQVcMKBcrNF1pRiTQKQpRTupbcdHryaU5+PnQcyfbyQucy+thtE8ZefEVV8FH/KqfpmP61deIZXZV15s7fRFBHE0UM4LeJ4HDroXWSSQuv+cRMMGMhoxeGeuyK8VWOfMnNAxFl6YDqC9EE71CvzXU9Q0b3N3fRS+bCuDgNiFfFsrhqvf/r3ur1ci/ja0FOeq1Cf1TRgNDCpyQtYPwgfkR2OSq3bGiLpmi+TRXUI3QBR1AnSGwRZ0/26z6fqz0I6Qetn6SwYs1fc2Hp46/KSuao4SOoJ/fc5eJoH0whK4mhLYRC1Uxq//xKXWnfclOzSWPuM06YpAdSGlihBDbetZMhA++hf9FJ0TbCeWJ1onRttzB65j9Dajem8pGmN4wrynYUN71JxM6aYO1Ie
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(6636002)(36756003)(86362001)(82310400003)(5660300002)(82740400003)(81166007)(478600001)(8676002)(450100002)(956004)(16576012)(30864003)(83380400001)(44832011)(336012)(356005)(186003)(8936002)(2906002)(4326008)(70586007)(47076005)(31686004)(70206006)(16526019)(36860700001)(53546011)(26005)(6486002)(31696002)(316002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 11:05:32.5408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8650a0-ec24-4a87-da8e-08d92bffaa78
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2893
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/21 8:18 PM, Mike Leach wrote:
> Configurations are first activated, then when any coresight device is
> enabled, the active configurations are checked and any matching
> one is enabled.
> 
> This patch provides the activation / enable API.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-config.h    |   2 +
>   .../hwtracing/coresight/coresight-syscfg.c    | 172 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-syscfg.h    |   8 +
>   include/linux/coresight.h                     |   2 +
>   4 files changed, 184 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 0667581822c1..25eb6c632692 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -127,6 +127,7 @@ struct cscfg_feature_desc {
>    * @nr_total_params:	Sum of all parameters declared by used features
>    * @presets:		Array of preset values.
>    * @event_ea:		Extended attribute for perf event value
> + * @active_cnt:		ref count for activate on this configuration.
>    *
>    */
>   struct cscfg_config_desc {
> @@ -139,6 +140,7 @@ struct cscfg_config_desc {
>   	int nr_total_params;
>   	const u64 *presets; /* nr_presets * nr_total_params */
>   	struct dev_ext_attribute *event_ea;
> +	atomic_t active_cnt;
>   };
>   
>   /**
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index e35f8c0ac2f8..b234e45c153f 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -283,6 +283,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
>   		return err;
>   
>   	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
> +	atomic_set(&config_desc->active_cnt, 0);
>   	return 0;
>   }
>   
> @@ -468,6 +469,176 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
>   }
>   EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
>   
> +/**
> + * cscfg_csdev_reset_feats - reset features for a CoreSight device.
> + *
> + * Resets all parameters and register values for any features loaded
> + * into @csdev to their default values.
> + *
> + * @csdev: The CoreSight device.
> + */
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> +{
> +	struct cscfg_feature_csdev *feat_csdev;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	if (list_empty(&csdev->feature_csdev_list))
> +		goto unlock_exit;
> +
> +	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
> +		cscfg_reset_feat(feat_csdev);
> +
> +unlock_exit:
> +	mutex_unlock(&cscfg_csdev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> +
> +/**
> + * cscfg_activate_config -  Mark a configuration descriptor as active.
> + *
> + * This will be seen when csdev devices are enabled in the system.
> + * Only activated configurations can be enabled on individual devices.
> + * Activation protects the configuration from alteration or removal while
> + * active.
> + *
> + * Selection by hash value - generated from the configuration name when it
> + * was loaded and added to the cs_etm/configurations file system for selection
> + * by perf.
> + *
> + * Increments the configuration descriptor active count and the global active
> + * count.
> + *
> + * @cfg_hash: Hash value of the selected configuration name.
> + */
> +int cscfg_activate_config(unsigned long cfg_hash)
> +{
> +	struct cscfg_config_desc *config_desc;
> +	int err = -EINVAL;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> +		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> +			/*
> +			 * increment the global active count - control changes to
> +			 * active configurations
> +			 */
> +			atomic_inc(&cscfg_mgr->sys_active_cnt);
> +
> +			/*
> +			 * mark the descriptor as active so enable config on a
> +			 * device instance will use it
> +			 */
> +			atomic_inc(&config_desc->active_cnt);
> +
> +			err = 0;
> +			dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> +
> +/**
> + * cscfg_deactivate_config -  Mark a config descriptor as inactive.
> + *
> + * Decrement the configuration and global active counts.
> + *
> + * @cfg_hash: Hash value of the selected configuration name.
> + */
> +void cscfg_deactivate_config(unsigned long cfg_hash)
> +{
> +	struct cscfg_config_desc *config_desc;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> +		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> +			atomic_dec(&config_desc->active_cnt);
> +			atomic_dec(&cscfg_mgr->sys_active_cnt);
> +			dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
> +
> +/**
> + * cscfg_csdev_enable_active_config - Enable matching active configuration for device.
> + *
> + * Enables the configuration selected by @cfg_hash if the configuration is supported
> + * on the device and has been activated.
> + *
> + * If active and supported the CoreSight device @csdev will be programmed with the
> + * configuration, using @preset parameters.
> + *
> + * Should be called before driver hardware enable for the requested device, prior to
> + * programming and enabling the physical hardware.
> + *
> + * @csdev:	CoreSight device to program.
> + * @cfg_hash:	Selector for the configuration.
> + * @preset:	Preset parameter values to use, 0 for current / default values.
> + */
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long cfg_hash, int preset)
> +{
> +	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> +	const struct cscfg_config_desc *config_desc;
> +	int err = 0;
> +
> +	/* quickly check global count */
> +	if (!atomic_read(&cscfg_mgr->sys_active_cnt))
> +		return 0;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> +		config_desc = config_csdev_item->config_desc;
> +		if ((atomic_read(&config_desc->active_cnt)) &&
> +		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> +			config_csdev_active = config_csdev_item;
> +			break;
> +		}
> +	}
> +	if (config_csdev_active) {
> +		err = cscfg_csdev_enable_config(config_csdev_active, preset);
> +		if (!err)
> +			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
> +	}
> +	mutex_unlock(&cscfg_csdev_mutex);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> +
> +/**
> + * cscfg_csdev_disable_active_config - disable an active config on the device.
> + *
> + * Disables the active configuration on the CoreSight device @csdev.
> + * Disable will save the values of any registers marked in the configurations
> + * as save on disable.
> + *
> + * Should be called after driver hardware disable for the requested device,
> + * after disabling the physical hardware and reading back registers.
> + *
> + * @csdev: The CoreSight device.
> + */
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> +{
> +	struct cscfg_config_csdev *config_csdev;
> +
> +	mutex_lock(&cscfg_csdev_mutex);

This line seems to cause a bug report when the kernel is compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y

I have tested this by applying the series to 5.10 kernel on Dragonboard 845c.

It only happens when strobing is used.

The report is this:

[13431.885395] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
[13431.893919] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 3525, name: perf
[13431.901882] CPU: 0 PID: 3525 Comm: perf Tainted: G        W         5.10.0-rc5-17282-g923b456a55fb #124
[13431.911436] Hardware name: Thundercomm Dragonboard 845c (DT)
[13431.917450] Call trace:
[13431.919938]  dump_backtrace+0x0/0x1a0
[13431.923644]  show_stack+0x18/0x68
[13431.927008]  dump_stack+0xd0/0x12c
[13431.930444]  ___might_sleep+0xf0/0x130
[13431.934228]  __might_sleep+0x54/0x90
[13431.937945]  mutex_lock+0x28/0x80
[13431.941468]  cscfg_csdev_disable_active_config+0x24/0x50
[13431.946952]  etm4_disable+0xf0/0x100
[13431.950571]  etm_event_stop+0xb8/0x130
[13431.954380]  etm_event_del+0x14/0x20
[13431.958008]  event_sched_out.isra.0+0x84/0x1c8
[13431.962496]  group_sched_out.part.0+0x44/0xc8
[13431.967010]  __perf_event_disable+0xe4/0x198
[13431.971549]  event_function+0x8c/0xe8
[13431.975256]  remote_function+0x64/0x78
[13431.979161]  generic_exec_single+0xa0/0x100
[13431.983876]  smp_call_function_single+0x158/0x1d8
[13431.988629]  event_function_call+0x128/0x138
[13431.992942]  _perf_event_disable+0x48/0x70
[13431.997082]  perf_event_for_each_child+0x3c/0x90
[13432.001751]  _perf_ioctl+0x198/0x4a8
[13432.005359]  perf_ioctl+0x4c/0x78
[13432.008715]  __arm64_sys_ioctl+0xa8/0xf0
[13432.012835]  el0_svc_common.constprop.0+0x78/0x1a0
[13432.017767]  do_el0_svc+0x24/0x90
[13432.021616]  el0_sync_handler+0x160/0x168
[13432.025670]  el0_sync+0x174/0x180


> +	config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
> +	if (config_csdev) {
> +		cscfg_csdev_disable_config(config_csdev);
> +		csdev->active_cscfg_ctxt = NULL;
> +	}
> +	mutex_unlock(&cscfg_csdev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> +
>   /* Initialise system configuration management device. */
>   
>   struct device *cscfg_device(void)
> @@ -536,6 +707,7 @@ int __init cscfg_init(void)
>   	INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
>   	INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
>   	INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
> +	atomic_set(&cscfg_mgr->sys_active_cnt, 0);
>   
>   	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
>   	return 0;
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> index 5bcae3b374c6..a52775890670 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> @@ -24,12 +24,14 @@
>    * @csdev_desc_list:	List of coresight devices registered with the configuration manager.
>    * @feat_desc_list:	List of feature descriptors to load into registered devices.
>    * @config_desc_list:	List of system configuration descriptors to load into registered devices.
> + * @sys_active_cnt:	Total number of active config descriptor references.
>    */
>   struct cscfg_manager {
>   	struct device dev;
>   	struct list_head csdev_desc_list;
>   	struct list_head feat_desc_list;
>   	struct list_head config_desc_list;
> +	atomic_t sys_active_cnt;
>   };
>   
>   /* get reference to dev in cscfg_manager */
> @@ -61,5 +63,11 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>   int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
>   			 struct cscfg_csdev_feat_ops *ops);
>   void cscfg_unregister_csdev(struct coresight_device *csdev);
> +int cscfg_activate_config(unsigned long cfg_hash);
> +void cscfg_deactivate_config(unsigned long cfg_hash);
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long cfg_hash, int preset);
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
>   
>   #endif /* CORESIGHT_SYSCFG_H */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 6fb516e1b22e..a348049ee08b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -222,6 +222,7 @@ struct coresight_sysfs_link {
>    * @has_conns_grp: Have added a "connections" group for sysfs links.
>    * @feature_csdev_list: List of complex feature programming added to the device.
>    * @config_csdev_list:  List of system configurations added to the device.
> + * @active_cscfg_ctxt:  Context information for current active system configuration.
>    */
>   struct coresight_device {
>   	struct coresight_platform_data *pdata;
> @@ -246,6 +247,7 @@ struct coresight_device {
>   	/* system configuration and feature lists */
>   	struct list_head feature_csdev_list;
>   	struct list_head config_csdev_list;
> +	void *active_cscfg_ctxt;
>   };
>   
>   /*
> 
