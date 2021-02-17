Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB531DD54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhBQQ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:28:32 -0500
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:34375
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234072AbhBQQ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGXj2UHiqLgaM+AzohHWDrL/jxqFuNy0NOeRr+qfBB4=;
 b=WOyCpwFR+mMeb3o59tMtZKOm3sbaoskR4+qFwg9VXo3DqeNCAp2yr5rIqCOjK7OCKuGD0AHmcYJbHc3q/Vdgy4WADsSZyQ8mKsOn5rcUeqRziB3E3oDCVL0DkL2XLoqLbI152U39FTJzKeoG+P7XoWvpVsYgg/X9OXi1C4jXr70=
Received: from DU2PR04CA0291.eurprd04.prod.outlook.com (2603:10a6:10:28c::26)
 by PAXPR08MB6766.eurprd08.prod.outlook.com (2603:10a6:102:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 17 Feb
 2021 16:27:25 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::22) by DU2PR04CA0291.outlook.office365.com
 (2603:10a6:10:28c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Wed, 17 Feb 2021 16:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 16:27:25 +0000
Received: ("Tessian outbound c07266d0ef38:v71"); Wed, 17 Feb 2021 16:27:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb0c2897f460c740
X-CR-MTA-TID: 64aa7808
Received: from 431922f5d27a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B66FD966-BCDB-4F3A-B380-78F4B8205ECE.1;
        Wed, 17 Feb 2021 16:27:19 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 431922f5d27a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 17 Feb 2021 16:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GigsYGxgcHIwHcTOHINM5K3z794F6oj+WOPmJELVXIWKnr9aOAG4zbGo2EL6t/oFcQKji08LgZprgPkeHxwUCfIi1dVx3lrzzIylKrAUHvvpCzuPGDwkCVbMzteFJiCt6AcvA+85X5SIeQnu+zKfS/pjCzxtmjtsQub5LKvZGiBycabgVo+hTT9k1/VYLXhMfotTylmuXWO97MW52s0UqjEhj7sNppBevVD4WBQhquwJpWJZC6numsO9vAYXovVRlq0ZxxaFQRxOpBIP3Fsib0e0XX7cPzc3hT9O3M0iEiA0ged8yKT6ksBBczXUUrRYSwYQKuts94tMqFYKlQ3m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGXj2UHiqLgaM+AzohHWDrL/jxqFuNy0NOeRr+qfBB4=;
 b=Ih2NDpqxC4lSi+Jg6gFjjV9bl+rI3UXuDn4cPjzI5seGw8YH9zqD77dRCMX9HknlstMLWu2ezq1Oo3Y1UHrTQX3aEmPoJrtjXQgN5csJo8eRjMETM33lpiU+dWY35hk7rwxZOVtxguuQzif+0IxqyWNqZtl8efQKWe2m8H4RKkv69L9jiqraZj089FghDAzpsCzMAQ7VL8+y26tJ8JTOwitHuJe2Sql6FxagPFXb1AgqQVVizpxq8ocHwO1g/DgmagvXQmaiyyA6etb0nEUMF1UgyRVJxnXSR9Y0KqjfO5GRqTGuZ5StEKHLZmNrtBxWp1rDtv8mm653ukfIPO2qiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGXj2UHiqLgaM+AzohHWDrL/jxqFuNy0NOeRr+qfBB4=;
 b=WOyCpwFR+mMeb3o59tMtZKOm3sbaoskR4+qFwg9VXo3DqeNCAp2yr5rIqCOjK7OCKuGD0AHmcYJbHc3q/Vdgy4WADsSZyQ8mKsOn5rcUeqRziB3E3oDCVL0DkL2XLoqLbI152U39FTJzKeoG+P7XoWvpVsYgg/X9OXi1C4jXr70=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3568.eurprd08.prod.outlook.com (2603:10a6:803:7f::19)
 by VE1PR08MB4736.eurprd08.prod.outlook.com (2603:10a6:802:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 16:27:11 +0000
Received: from VI1PR08MB3568.eurprd08.prod.outlook.com
 ([fe80::c91c:227a:cba9:456e]) by VI1PR08MB3568.eurprd08.prod.outlook.com
 ([fe80::c91c:227a:cba9:456e%6]) with mapi id 15.20.3846.038; Wed, 17 Feb 2021
 16:27:10 +0000
From:   Mate Toth-Pal <mate.toth-pal@arm.com>
Subject: Re: [RFC PATCH v2 00/26] KVM/arm64: A stage 2 for the host
To:     Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>, nd@arm.com
References: <20210108121524.656872-1-qperret@google.com>
Message-ID: <18756e24-ca87-9c98-0e20-7c7a4c4d5433@arm.com>
Date:   Wed, 17 Feb 2021 17:27:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [188.142.195.117]
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To VI1PR08MB3568.eurprd08.prod.outlook.com
 (2603:10a6:803:7f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.45] (188.142.195.117) by LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38 via Frontend Transport; Wed, 17 Feb 2021 16:27:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e766c051-89c5-4e54-d572-08d8d360e903
X-MS-TrafficTypeDiagnostic: VE1PR08MB4736:|PAXPR08MB6766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR08MB6766EA67E8E11CDE7AE6D4B9AF869@PAXPR08MB6766.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GlU2MrG9Uwcq8qM2M1RFvPLBzBwAsMf+CeLvHOz8kH+VQIt6yhyA5fVrspYWU5reMyDBpwUI9/nyGZzmDpRB4WrlNzwcjFpIFPvFf3821DCoCLnCqw3bTlO3z97uurEb9oxkL8jV6bKnBJSzlADROR8Ljbr5i8P66zNjE7pW1NsbCKnQDq9fOxpemTAmVb5DbC3aihP1X7j3MYCN/YZPhZRwR6SAPP1K57TU9se+oSr3YSlb1AhqMcn4rNGVGPdxjiZOqpQoCWehHkuSuJI0MqAxuZMAq3SLmqGzh+bTF7WBqIPXltZ3+BU3AB6S0L8f4i/gFsE3ffNGWudMht00xUjd4PAgarwR+6hdJetBnnGDyYCMtLzStYmq0+YRKzpdxZZ5IIfjEcxKngr7tAeMRDV7695DLIyzI7VGHOeHvQ+8QKtBu4Ee9um7yrhGOOH4/zxj0t9BS6m2jJlLNMyBXu2Zx13XjJy6nW1Tqhu/97jqWpRu46U0CPgeAE+YC6ml1poJ5F8W/Qacz71XleC63ttSQkEeOHdWiyYGRg0NN7YYurRdBr8A6wWTPGz4uJmoHQ2wi5c8u9/FKzWdV75pfiluZ0tIB1UuG9d7AHjcHA1RHJhlBpueoQ7fJVi2galqXlYmC4LNP6Kyj5HHDaxARqHNRi+Y8dY+sjtrWbDBhvHegFOqk/Oc40vl+Fe4UteC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3568.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(26005)(31686004)(2616005)(6486002)(956004)(186003)(4326008)(55236004)(53546011)(16526019)(2906002)(8676002)(478600001)(966005)(66946007)(8936002)(5660300002)(31696002)(86362001)(7416002)(316002)(36756003)(66556008)(16576012)(110136005)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zmh3Y1RlcWsxYmp0WGFheTBUbDFkQk1HUjBQSS9uL3dKMk03Q1FQRklIdVZn?=
 =?utf-8?B?UHgwTTBYSTJ6d3pmK3pBVmRId1NJZXhPUnZvZUpvTHVycmdTZ1Jna0VHQjIr?=
 =?utf-8?B?ZGVRU3J4blZ1L0tuM1RPaEkvaFFrYTVmWnpnSmlkd1UzaSs3VzBxbGFZMC95?=
 =?utf-8?B?RExlS0ZIWlFzVmdxQnhzSW42U0VLVlhDT3diY09zQkQrOU9tdHppREJOZnBE?=
 =?utf-8?B?eGVQaWVyRUhwd0VrWXRHS3ZSOFhmZksxN0VJbXpUK2NDcVZlbVVzMlpRRWp4?=
 =?utf-8?B?SlJmeGlWR29YS0xod1NZd2pjR2U5ZnJrUXRKZjJ1amRPc2c5VkZYK1dDeGla?=
 =?utf-8?B?dG5LTzhYUUh5T0RsSWRxVkVVbWFocU1iNUVRSTZLZkhlem03djdoNWRQSGlS?=
 =?utf-8?B?V3kzT3dhMkpYNDlpNWdMdkt3ajBjUjVVeXhFeW41M1hzb3ZFTzZNcGpHc2Rr?=
 =?utf-8?B?WFEydmVIUC85enZJd3BVN3NHT2NESzU4UXhKQko2aGdQS29qQ2ZFTlVxTWph?=
 =?utf-8?B?Nm96RXFZS0h2T3BTOGh3Z2lQcHBwcFF0elIzL3plalBxaWQ3ZmowdEl0SXpn?=
 =?utf-8?B?OU1KNVVtR0J4S1MzSG1XMUNobE1LUmVkTHdCTmJsSlZxdlNWWjIrSzJ4cENW?=
 =?utf-8?B?ZzUwMWFjc2syTmVTdW1yS2p2UjhrODlIUGZXYkZXVml5eTZFRWFROElDd2dU?=
 =?utf-8?B?SkRpTjFjZmxJZ1djd1Qxd2JwWWpKSUdMQTJIMzdibGRuQWNjVXhFaVFXd3J5?=
 =?utf-8?B?WVdXaXl2N2s3OUFLSzcxb2tsQTROQk15cHJSek9qamZRTSt1RlNXQlhETWtE?=
 =?utf-8?B?YmlCK0NiS1F6dkE5cW0vMDRqQ1NQbWhleGtNanVDU3Erb2FLUVQvT3RNNWtB?=
 =?utf-8?B?YVIrVUxpR2tuUDhwMWg0Y2M1cnJwVDRVYzJ5dnV0VnhWWStLSXora0hQMldv?=
 =?utf-8?B?dHhheVhTSWtsa25sSEhyM0IwbjJKTUxkclJBVWxyZFcvTHpsUWQxSUphZ0dH?=
 =?utf-8?B?QVFCbGxTTnRONFhaTHFiZkFvQW5RdnRldzhpK2hHWFBSc1FGQ1VmNm9oSkFh?=
 =?utf-8?B?UzVFcmVjUGVDTHY5Y3E5WTVWeEJJK1ZyY1pYRDJaSzJYU2VaSHo1ZWRmTURs?=
 =?utf-8?B?NjVmQ2x6czl3RmZaSjFOWVpBeEQ2SnpqbEJrSFJDVUNtUjN6MWZ0WGRCRHRs?=
 =?utf-8?B?Sm5jVUdPYTFQcktlWlYvWkU1VFNlNzR5ajZtQ1JCc0t5cWpzUS9FbDJLRTBm?=
 =?utf-8?B?YnhveHZxUyt5VTMxdDFRRjVSa2p0dTJTNXI1SDhock1Kd3RqTE03dElhTEE1?=
 =?utf-8?B?U2x6bS9XbHVrV0dzN1Q0QXZZRGthZlFHamVPSDJOSlkxZ1dxTmYrOVZnRkd5?=
 =?utf-8?B?K1o1ZVA1K09MRnkyRWdsRWk3SHlFdDJ3dGFKaklHaVlkbjJkVWd5RmFuemlQ?=
 =?utf-8?B?REZmUlR4VkNlOWRoZldLeEVYSmNHL0R4ZlVlalh0LzZRazloVGVDUVJLa3d6?=
 =?utf-8?B?TkF0d2RHcWlEVjVQQ3RwSXRsU3hMc3BzVDVWVmVzVDFicU54SFFNNlQyTjZO?=
 =?utf-8?B?Tk5DSWx0dkVkTE9jV2lQVFFDQnBuN1hydXMwZS8wNVNtdVhLOTJWK2RzSlJG?=
 =?utf-8?B?eVhOTmNoWk5iVzFFSWhPUVRmZmVPa3RidXlQd2plTXM1R2ZrYkRkbllCT0w3?=
 =?utf-8?B?L0NHaWJEbGI0OUNaaXNkRzZqcndNSE00MVIvVXdTOHRzUkFaQkd4VjNwbmhP?=
 =?utf-8?Q?Y09jMpFgayyPMn2+yXotHLGSb40o7vhoWcV7cgO?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4736
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 51ecbf98-f2d5-4982-07d0-08d8d360e012
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hybnx+FYQIhncFmFMfO2k5zyu9CkYl7zaOenMBH96W00STPXFmjIudtGYt6zbF0JC0ElpnD8slPwV87cKFFMzogVHacH5ZibEzsiRd3YN23mjb/ukgT0dARmvw1ZdpVwJjEDhkIH1lnrXXC2n/qZUu1bdSicpJeXUPjmpZ/wJSV3ZzjNopHnZvOUcaVwhRKQ1l+cR+n3iTx8yCy5QQNHYrxfOw7agFSpHwMDtnCF1ssDTnveq3M0WjcWQRNvIpXETlOdqcXU7Kd2LPNc8fEwdmlkiJwoHz+bg+8GwdyV+1Cz2n+a4itjYRcjOd98LXeq2jnWeTIDJgCS0As0N7Q2s1xKONkTsrxzaww9r11ygZ4gO91axpzT1GJ1Ap5uELbC/S/8DOpZJXzAWlA33WthKRSOCDo5ZAboocpzTTO6LKOZbXb1/RFUmrsKv4dCJKmquLNeBE+JBtzFsgitKwUTAaMPgFQCKd3ICxdHm9xcZCfB8/tD4vUkF1LyK3rue+MuoibQTVRoYCVPPyAnztYku/tMkzp9cE1efm+8+r8YN/n9UUY8TeDzlVufOScJSOqvItM5zIppgSI9WlH3cFk+jHW4wwjAmKtsqbmpJpZI/ngWFYLeI0XHLD3znWEPswubl/QvET+1clWuKsNjitUh2Gsrbt9t+79ZYlV2gZORSddByVvJFuKylJrGhxCKIzmNOIMC96GOoYY8hFnPn+5/EBBdH7P2LdLGtL5pP4dEfij5KZO+dkAfru4MpskH+fA1g0c91eourryERZspwTVG7w==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(26005)(16526019)(956004)(2616005)(6486002)(31696002)(336012)(86362001)(356005)(36860700001)(81166007)(186003)(478600001)(8936002)(8676002)(5660300002)(966005)(450100002)(4326008)(82740400003)(53546011)(55236004)(2906002)(31686004)(36756003)(70586007)(70206006)(16576012)(82310400003)(110136005)(47076005)(54906003)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 16:27:25.2498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e766c051-89c5-4e54-d572-08d8d360e903
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6766
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,


On 2021-01-08 13:14, Quentin Perret wrote:
> Hi all,
>
> This is the v2 of the series previously posted here:
>
>    https://lore.kernel.org/kvmarm/20201117181607.1761516-1-qperret@google.com/
>
> This basically allows us to wrap the host with a stage 2 when running in
> nVHE, hence paving the way for protecting guest memory from the host in
> the future (among other use-cases). For more details about the
> motivation and the design angle taken here, I would recommend to have a
> look at the cover letter of v1, and/or to watch these presentations at
> LPC [1] and KVM forum 2020 [2].


We tested the pKVM changes pulled from here:


>      https://android-kvm.googlesource.com/linux qperret/host-stage2-v2


We were using a target with Arm architecture with FEAT_S2FWB, and found 
that there is a bug in the patch.


It turned out that the Kernel checks for the extension, and sets up the 
stage 2 translation so that it forces the host memory type to 
write-through. However it seems that the code doesn't turn on the 
feature in the HCR_EL2 register.


We were able to fix the issue by applying the following patch:


diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c 
b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 0cd3eb178f3b..e8521a072ea6 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -105,6 +105,8 @@ int kvm_host_prepare_stage2(void *mem_pgt_pool, void 
*dev_pgt_pool)
                 params->vttbr = kvm_get_vttbr(mmu);
                 params->vtcr = host_kvm.arch.vtcr;
                 params->hcr_el2 |= HCR_VM;
+               if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+                       params->hcr_el2 |= HCR_FWB;
                 __flush_dcache_area(params, sizeof(*params));
         }


Best regards,
Mate Toth-Pal

