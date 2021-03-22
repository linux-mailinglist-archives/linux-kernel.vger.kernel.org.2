Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078F34411B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCVMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:30:54 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:22439
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230468AbhCVMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g4bJ857K71h2UOwyidKcPuGQZdbCyEFx2sf1/Yunp8=;
 b=qcHXfkMmT68fBuuevTP82eFoa8qIpFFya8TRD5Q8sKFWatq45iqoa3wEaD0hD+W76lGKDIqcGtljV+OidWzOlWoVEdDg+n5Lo7PvWx3exL28bvRasQgGl3IwBd6Mdu/6nKDyuz5jiNuUGWDdJKeOWW49jh73RSFJNY41E1cgB3I=
Received: from AM5PR0201CA0003.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::13) by DB8PR08MB5290.eurprd08.prod.outlook.com
 (2603:10a6:10:a5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:30:07 +0000
Received: from AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::3b) by AM5PR0201CA0003.outlook.office365.com
 (2603:10a6:203:3d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 12:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT013.mail.protection.outlook.com (10.152.16.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 12:30:07 +0000
Received: ("Tessian outbound db863403a82e:v87"); Mon, 22 Mar 2021 12:30:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bed603994e652e37
X-CR-MTA-TID: 64aa7808
Received: from b09f1767ef2c.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 53B58223-C5D4-4289-9F45-DB67965106A5.1;
        Mon, 22 Mar 2021 12:30:00 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b09f1767ef2c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Mar 2021 12:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR+QW8uxeVUgsJF5IlA/hufS62EAbJlRW+1FjCWipLFgZ7ymJEkWlQzYpLxrPGGY/D5E7NmT6hQ7yIYZGOmqRY2C358eHZhUpkDaeFbt9hA4m85GY2UM+70kyUnoImGAc8xjLtSE24CTYKcn0VHsIdbZVMb59huspqmaiczaANHybTD+yJaNgzmcBCWfCN3PH5TW1hlrETYXr9HDaNM+lbMH8HhCXxWMX4diLSN68ikFRx2Lim0yRUolAXzi6VVNuqrqQ/TSlPwiprDjQt9K4mfnDTfjQQyFDy8jdStasHaVfwuIw70XrM8j7cFrF2PqYRLNGhrtM0BWFAkOrr2vDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g4bJ857K71h2UOwyidKcPuGQZdbCyEFx2sf1/Yunp8=;
 b=K3BUUQk0CnsFsyZHQYqQnBkdFXvKWmLxzAdvzHcEDj+mb89ipoW4hNEM4lxaLj+ZcHOvFBYbsMq/wzaW7S6zy99240ya1qDA6tvVWybtg6n46w9hAbOK9NwOKvZ5IZ5dtd3kYkQroo0MLwtadsL6nWTC0yErqu7MHQiPQFdiZLnZuJa4mN4B4ZITrXnh4Csjr+jJbC4THUpQMkhQuLTlAehUMvJLqrE3J2GlQ292csSzdpoaNMEBqpgIRq7YwQ5uCX6IKUx1nH+wOkkqGgHIGTcgGOmHA2I+Mmbr+CxFbKSO6PLwmfm+MRs38fIm50lOqPf/IxBlhGrDLr7wXbnkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g4bJ857K71h2UOwyidKcPuGQZdbCyEFx2sf1/Yunp8=;
 b=qcHXfkMmT68fBuuevTP82eFoa8qIpFFya8TRD5Q8sKFWatq45iqoa3wEaD0hD+W76lGKDIqcGtljV+OidWzOlWoVEdDg+n5Lo7PvWx3exL28bvRasQgGl3IwBd6Mdu/6nKDyuz5jiNuUGWDdJKeOWW49jh73RSFJNY41E1cgB3I=
Authentication-Results-Original: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3095.eurprd08.prod.outlook.com (2603:10a6:209:45::28)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 12:29:59 +0000
Received: from AM6PR08MB3095.eurprd08.prod.outlook.com
 ([fe80::99b8:b47f:6dd8:6f49]) by AM6PR08MB3095.eurprd08.prod.outlook.com
 ([fe80::99b8:b47f:6dd8:6f49%7]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 12:29:59 +0000
Subject: Re: [PATCH v4 02/19] perf: aux: Add CoreSight PMU buffer formats
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Peter Zijlstra <peterz@infradead.org>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-3-suzuki.poulose@arm.com>
 <20210316170420.GA1387186@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f41a9702-b7b3-c4e8-cc6c-c66bb0fdbb27@arm.com>
Date:   Mon, 22 Mar 2021 12:29:57 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <20210316170420.GA1387186@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.5.128.15]
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To AM6PR08MB3095.eurprd08.prod.outlook.com
 (2603:10a6:209:45::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.27] (80.5.128.15) by LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 12:29:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dd65ee0-ca59-4168-f002-08d8ed2e3a45
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:|DB8PR08MB5290:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB52906308AF008984734DE09691659@DB8PR08MB5290.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qs8bC9E1ZccjdM/9G++8pv9Mr+V+YVUvo47NLuE+aHm4AN9UAxe2j70O+EKs8nM0B6eiz2yWroLkG24WVVUEMB2SJnDewmbCCxtJQhJSjNtVtN8IlPMmDR8RNrc60sK3HdvB5IOlarKTd8FaVaNNY8HLdsd+4v5nxm2QVp5Rhb5SD3DdUMSBcnCxio6zpZQ//1CDnYHClHsg67kfQZNgCPMS7IOKWreWMbXDRDpBsmubscNArJLph27lUWaIyZtDiO9Ig0aa3uZrIA3aBdbHqRp0Fe3Tk3IL2cRwnkMuFDkzwStfYZjrlwHooPgcPnjCLoHHw4ydi0I2XepqsChwlU0Ej4u0jKz154pobQvl8LX1GCoLYiOmic+wGtvBgnrwGWEvnN6l11XOim9m8e7qZ37JqdrW3sdxKGm3LLsy/LeUBLtn99psPPbswdOgNKMJxCX1laUyrO3mc4uSibQ5afkq9yMjHjC00Y0HpSZC2YmSfa/JSMPWjzJyNQTCbbJezgkRWNc6G6v1DGgth0VPc3jMWgzIv/AY1PqE40i6xsqasVT6Kgasqeg8g1hoCgcMJhsZu/paS8jcRsK/hh7DD5eH21T7BcNXKbdeuQ/pqrk77x5yRMAzeBCEV8tNZSAIu+5cPd0NojQ38gKVgAB/ia1KG/RTWPrWfNL9bvzmY7upVcs5GU3MK2r2PDsUbMaLziIWe21kBG4aas2eow1RBrvPlkKfmwChoToyorgcuHM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3095.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(2616005)(186003)(36756003)(6916009)(16526019)(52116002)(956004)(66476007)(5660300002)(478600001)(16576012)(316002)(38100700001)(86362001)(8676002)(66556008)(8936002)(53546011)(66946007)(6486002)(31686004)(26005)(2906002)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WlJvOHhuL3plcm54VWZKVGdDUVl1cFF5TGcxb1N3R01adEYwVFFNNDNGdjl1?=
 =?utf-8?B?WFYzaUQ1OVU5c1pqZGFRV09FYUxvUGlOdGk5STFLYmJUQUdyQU1hTFhaaUg4?=
 =?utf-8?B?L05HRlVtWUs5UzNvN25GeDhxQm05N1pKbjUydlFoSENmTjFFY0hKcmhoQXFV?=
 =?utf-8?B?cnh1cTlxT3JVcnJFbHhzRCtyZVJtR3RRSmRtMEo5UmkxZ200RmJsVmFORnZW?=
 =?utf-8?B?RnJtR1cwT2hwdG16SXNodHhsMDBkaFdqM3YxcjdSdEZEYUJMMEtiUGNKWXVD?=
 =?utf-8?B?cEJPL1ZtVFBHelVRRlJhTFZ6QTRQcGJqYlk1UHYwdzBJODJKaHVlcHJQRUxl?=
 =?utf-8?B?cWEzWno4NDIwQmZEOXQxaU9QTjhGeDk5dlF3N2ZUc2JXcTFXRnRZTzcwYTRG?=
 =?utf-8?B?R0VRb0oyaVJEU2V2OFNrVjNGTlhmNmN5dnVFTDVMTzVKcStTMTZJeExTbU1W?=
 =?utf-8?B?Z2JxS2JxYVowc1ZJRUhsbktMUS8vR2xTdGYyUWVxQ3RKSk1mY2RHcWRZMlAz?=
 =?utf-8?B?YncwbW9QdXZ5c1RtQy9mcklQTGhsNlYxeE45YW9PVG5TTHJCai9ibEJDL2hF?=
 =?utf-8?B?cXdiU2JNRzdrVnZ0a1RnUWVLbVFUbU1uYzB4WDBETG5uYXJSUXFwZnNJMXZ4?=
 =?utf-8?B?TUpZa0h0OWxIb2FneTNKZHcrSFV4U0NXMkRIYzVUdGFRSXBHSlc3TzNpa3gv?=
 =?utf-8?B?cGQ4ZzJ6ejM4VWlnQlZSdklOMnlEWmhEcnN2c3kvZzRvZEhnUWxpTFFjTE93?=
 =?utf-8?B?K3phbU8wVzJQbzFvRDlRZ1YwNWlGUzdYdVc3SjhVaVJOUXBpajNNbFRsQkFq?=
 =?utf-8?B?U2ZhL0R5clkxN3BvTjI4Vkpvd1BnRFVYcllVSlJpWjNXOGozbm1RanJxa3lq?=
 =?utf-8?B?RnVENUZibW91SWlVc28zeVowNkVCMjZpbWx0UzdUcnhLRUk4MGFEVUI5YXpw?=
 =?utf-8?B?NDVsdTNsZ0NjY1V4MERVbnJiMkx1c0FGc1RuTUcrUmdNR2JkTXZpbWcvVzFo?=
 =?utf-8?B?T3VrUVRLRnB0a0NMZnFNeEhmTzEzQUxRVVJuMmJVdUMxV2hXWWw5b1R3eHFV?=
 =?utf-8?B?a1JFL0E1Z0I3TFRLV1phK3czdjNtaUhwaWdjNkdQOWoyS0tPLy9Dc1E4SWR1?=
 =?utf-8?B?Vnd3d1JxY0RrbFlSN1RoV0l5Q3g5MGNaR013aS95YXFNZmFlWDZITzhyaURn?=
 =?utf-8?B?NmJ4VGdTMFZ5RkFrbFF2SjFwd25JZkhFajdKdWRWUkYvbFNIYmJZQnhvMXNk?=
 =?utf-8?B?QTE2SHgxTVAvT2U3ck80NGhIOHIwYlZGZG42aWlUYXpacU5GVXVsU0xnVHV0?=
 =?utf-8?B?d0JpUEtudDRWMHVLM1ZVZHJHV0IwVHRrY05sQTRJNElSdDQ4akxrSUo0bkRv?=
 =?utf-8?B?Y0JQR01wMUcxcTl3MkkveHZLNTlMVDhJOVdoQXFvK3NJcExtUDdoWWxHVU5U?=
 =?utf-8?B?RFpPZU5hckV5OW1xNUNFTENhenlhdFlyVEc2V3d4dkNKNXJCZlNKWU1kcTY0?=
 =?utf-8?B?OXR1UW5UcW1WK0J1ZVdrVnhzNFEvS2JRQitmMmR1TnNtbnI5Qjlka0FmSnRx?=
 =?utf-8?B?OERTLzdoV2hpcGUySS9DOWV6S2JjYlVlYUdZQktRb005WlRkbldwcjZwWmFz?=
 =?utf-8?B?QldtY1JCYzB5RlRnaWhNZXlpeWYxVDljUnltYitteUlvOEpLb2pNcDRReU55?=
 =?utf-8?B?WFhFaDlwUGZ2cjlCUWFvckhJTlVqbTZBOTlxcDRxTTZuRkorYmJBM3BPN0l1?=
 =?utf-8?Q?T7tgF4t3XXhQAtDmPMGvVJqtE5YkxrzjAEhSMKK?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Original-Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: bf35356c-f9ec-42d8-ac4a-08d8ed2e3530
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2Uc/vwJM0kPwiYWwEb0UCvFwLoH/KJIuKdfdVAKq/0ALat7XfACQNJWJ+lCpqaFhrSQy7LqzgL4anxOPNVUltOyZOrKEuFjBgGghD75qEtDX0TVXCs/L+v9m+sCjvrcSHnBC6sDjGWuznBd67u2PMLNVVkVGMTf8Rj2tpqUrdUvyTh0xfZdd/U4PLLihu80p4RTGvi4YQmIwsdtIvPrg4CvnGSFfjXOPvrnFdxO9Ei1k0qsB+f9ZbAPZE8SSIRQFwIkxYvirc/oGfbu2My7OwJr+zzQM40RdOvBPdjWmicvAnR6YVkoiJQaHAXl1oUhJUSwJwSJPQ9R0FGZ5hKN3luyvWCKK9Y5YHupZPteRH8J1wOgl4piVnrMFt5MWXOyH1qP+CqoSjTY9/sbWcoo8s2R/xt/JErXuSW1Jp7GzjCkjrHzz8cnE8jCRnvW5qRFKsTLd+PDiPrYaPBpNszf2ILr63RYzdv26mcUnYUITYcx8JpMXlP8o08Tf8thW/AAG6dqB4/1HDRSWm1hit0e5bxalI+4cMseLCAQYWGGhsTrBC15RSTZYxy6NUCzpif0baWuATPOowdwnocDmthPc1scfRrHg4Lf1ziDdGfLsAihwc1jUZUGUQSC3wnOMqzUcny6pQD3zidwBVka+FIK+cB4Fohci9oluUd0pDogUiezJb8ZgNSOmC1/FIdH2bAL
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(86362001)(8936002)(6862004)(16576012)(8676002)(6486002)(47076005)(336012)(956004)(107886003)(4326008)(316002)(2616005)(31686004)(82740400003)(186003)(16526019)(81166007)(356005)(70206006)(26005)(82310400003)(2906002)(31696002)(36756003)(5660300002)(478600001)(36860700001)(70586007)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:30:07.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd65ee0-ca59-4168-f002-08d8ed2e3a45
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5290
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 17:04, Mathieu Poirier wrote:
> On Thu, Feb 25, 2021 at 07:35:26PM +0000, Suzuki K Poulose wrote:
>> CoreSight PMU supports aux-buffer for the ETM tracing. The trace
>> generated by the ETM (associated with individual CPUs, like Intel PT)
>> is captured by a separate IP (CoreSight TMC-ETR/ETF until now).
>>
>> The TMC-ETR applies formatting of the raw ETM trace data, as it
>> can collect traces from multiple ETMs, with the TraceID to indicate
>> the source of a given trace packet.
>>
>> Arm Trace Buffer Extension is new "sink" IP, attached to individual
>> CPUs and thus do not provide additional formatting, like TMC-ETR.
>>
>> Additionally, a system could have both TRBE *and* TMC-ETR for
>> the trace collection. e.g, TMC-ETR could be used as a single
>> trace buffer to collect data from multiple ETMs to correlate
>> the traces from different CPUs. It is possible to have a
>> perf session where some events end up collecting the trace
>> in TMC-ETR while the others in TRBE. Thus we need a way
>> to identify the type of the trace for each AUX record.
>>
> 
> The gist of this patch is to introduce formatted and raw trace format.  To me
> the above paragraph brings confusion to the changelog, especially since we don't
> allow events belonging to the same session to use different types of sinks.  I
> would simply remove it.

This is not entirely correct. We could still have different formatted
trace in a *session* but not for an *event* in the session. i.e,
imagine a system wide/task bound (not per-thread) session, where there
are events created per-CPU and bound to the CPU. Each of these CPUs
could have different types of preferred sink and thus, we could have
a single session with an AUX record per CPU event, with different
formats. However any AUX record is guaranteed to be of the same type.
And this is why the flag bit is important, so that the perf tool
could create a decoder for an AUX record stream looking at the type.

>   
>> Define the trace formats exported by the CoreSight PMU.
>> We don't define the flags following the "ETM" as this
>> information is available to the user when issuing
>> the session. What is missing is the additional
>> formatting applied by the "sink" which is decided
>> at the runtime and the user may not have a control on.
>>
>> So we define :
>>   - CORESIGHT format (indicates the Frame format)
>>   - RAW format (indicates the format of the source)
>>
>> The default value is CORESIGHT format for all the records
>> (i,e == 0). Add the RAW format for others that use
>> raw format.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Reviewed-by: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes from previous:
>>   - Split from the coresight driver specific code
>>     for ease of merging
>> ---
>>   include/uapi/linux/perf_event.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index f006eeab6f0e..63971eaef127 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -1162,6 +1162,10 @@ enum perf_callchain_context {
>>   #define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
>>   #define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
>>   
>> +/* CoreSight PMU AUX buffer formats */
>> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000 /* Default for backward compatibility */
>> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW		0x0100 /* Raw format of the source */
>> +
> 
> Is "CORESIGHT" really a format?  We are playing with words and the end result is
> the same but I think PERF_AUX_FLAG_CORESIGHT_FORMAT_FORMATTED would be best, or
> event:

It is really CoreSight FRAME Format. So unless we specify the "actual" 
format, which is CoreSight Frame format, simply FORMATTED doesn't
distinguish it from a new format that could be applied in the future.

I would prefer to retain the above names to indicate the definitions
apply to CORESIGH pmu FORMAT flags.

> 
> #define PERF_AUX_FLAG_CORESIGHT_TRACE_FORMATTED         0x0000 /* Default for backward compatibility */
> #define PERF_AUX_FLAG_CORESIGHT_TRACE_RAW               0x0100 /* Raw format of the source */
> 
> Regardless, for patches 01 and 02: >
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks
Suzuki

> 
>>   #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
>>   #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
>>   #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
>> -- 
>> 2.24.1
>>

