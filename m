Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81D5347DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhCXQdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:33:35 -0400
Received: from mail-eopbgr20112.outbound.protection.outlook.com ([40.107.2.112]:37095
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235878AbhCXQdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:33:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl7f9g2boS8DwKJ66qnQ5j5GOmpWM8AoeMril9wdeE97/G4uM8UTVIQ1FjDfkXDFqgvisFNv2elu8f77rU/pC4J2INMGdPceEDCW7NGpNJ9iE5n4jlBYQDqAms/pVrg+RlsRVMtbe4Zsk/2Rq8GoNr6guJraWP+cbc+GoPPytW5GvRwqiuc+ta/b+NE1C9EmIRwpgwpk0y8/Z9ADrwn+MNC/85GETIbnxPaAzjY3OAmYMlOLtVCEG6iiju+b8tN473MgIr8he9OEwbSxaiwLD9TtDUOzGs4cbl8lqyklT1yfpfc1Gst1z2D4gwyqbP8x2cwHsCGNYrcbbtc4DheEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK97x5dmlBw6hQUC5yltqvTgQVd1eFj3sCE4zeh2GtI=;
 b=GIj0fDMQPEwlbi12PDRYy2E830gme+Bg5i0MKvzDb7aG+KsBZSQhQjZ9gZgH+30DdY3PxnabGfa83VqXe5k2v0+IP3K7GVJn3v+I0+9SzQsHhaWcgkyfjiFWLQMEsTbSMVuiiYPYIX0BARiT4kGr19gkl8BEJ6/wRUwRnNvNucUSpc7wyEdIWc+08ViJEqwK9AM1BQrd1bLXd7LHGNAYHXSnR/e0sfwequAFSJFRXrfIKZXHOq99iCkDlmDGOyml0mmgqSIINWoyF+Z0JKQK2z6qQr2VGpIiSCKd9Xo/zg6do7RIFfi4na5mPJXnvQEQdH72Q9/SdXvBWxJUtYF3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK97x5dmlBw6hQUC5yltqvTgQVd1eFj3sCE4zeh2GtI=;
 b=UZNy1Xn4utUNFIhUv3nGp2ITZZou6LKlhAB4ohQG6kR5nGwKZQCiKvDFaecUgLgeYy+Tr3BmZU9AnPgrGU13IqLzu8a2K+dpaBDhh3YzFYmF8uwGVCIJInCOJLZDhwhi1XsebqzXcRM8H1AsTJES4JCiWN7xM2LBCtptKBwnzd4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM4PR0701MB2162.eurprd07.prod.outlook.com (2603:10a6:200:49::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10; Wed, 24 Mar
 2021 16:33:16 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3977.024; Wed, 24 Mar 2021
 16:33:16 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
 <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
 <20210323222230.2d63hdcxq6strbug@e107158-lin>
 <25056e99-dfd1-645b-39fc-14f47085a7fe@nokia.com>
 <20210324155700.ktcgpeabk2fuamti@e107158-lin>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <169a0b1e-beee-bae6-8625-9b9ceb8bb0ea@nokia.com>
Date:   Wed, 24 Mar 2021 17:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210324155700.ktcgpeabk2fuamti@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.32.169]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.169) by FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.14 via Frontend Transport; Wed, 24 Mar 2021 16:33:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c0260380-61f4-46a5-c39c-08d8eee28691
X-MS-TrafficTypeDiagnostic: AM4PR0701MB2162:
X-Microsoft-Antispam-PRVS: <AM4PR0701MB21621147BA24477B547D103688639@AM4PR0701MB2162.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUeMKO599y49FeyZPs7z0t4s7GNlLe14MBorkQMwykljKxCg54I81dPYxgUI05U0GX9ZVJrc08Qp2JaZ6sV/2HaxswRfOono+VuZXMlx3wh5SayrQ3K10honvZNNqzyLp2YKxRzA44EyCE9Io2Gykpsa0WQgWhQNkmI2EGOH2FbgJUdQPw/VY4rFl1BZ93tjfL27hGy/Rgxy66S8kcwIM1grl3yx+11jRZqIjDPTTfvvVEA2MviCleD60DnGj7Bwq5GRHd6AvNYfL55rcZ7WILAojKcJ6mJqzzYYOaK22zd4Te0enfW4mep5+XRcCcBbLFdLew0jvwwEu2vtM6UbtyhxzoYEP/C6ltWt4+Ph1x/D+zxtaemJQFuHhiYr0HwpgAPoLCkh0lZey8zUEY030uWwM35dhMcf6btUio4RXU9f3nklKQ8cNHKa/jWwXDCPhlklU3HezgisHofc5euAFkvXoye/HsyXwOf2zDJgk2D5/ghxO4X9FOeT7iTwokqu6xev3gwlZrNs4OF5E4VvLgHZz7BnHai0/1rJtu0OplGR8BJIJrYK2KpcLJtJImZFrk1wdquXZuZaXfqTL6QzXeh7X6URMd/7l87AeuFSRWTCEl4g+L/PPGIL3+5R39AGndV9m6y9RCpW+he3Zelnl3tWqTz5sXFBnCxB4BeyBHZiI9E1Pe4QJWvi6/Hny39wO/3Ujw4h7VjFYhrcZCRciA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66556008)(66476007)(66946007)(5660300002)(6512007)(8676002)(83380400001)(26005)(478600001)(16526019)(186003)(6486002)(38100700001)(6916009)(53546011)(52116002)(6506007)(956004)(44832011)(2616005)(6666004)(54906003)(31686004)(31696002)(86362001)(316002)(4326008)(36756003)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajY2ejZGN3Z3enZnV0YyMW9EbjZ5anJ6cXA3ZnBuRnpXcEFYVHo5Y3YreHdM?=
 =?utf-8?B?aU1SOFlKR0kwYXRvWk51R09jcmZWbXdyblRJSExxSHdIVFNyRWU3ZkxHNXc0?=
 =?utf-8?B?MmpBUGwrdmtIdWVYUEs1TldIRGRaNUhETXVXMC9XVnZTK2NZdDc1VnQvU09t?=
 =?utf-8?B?S3VyWTNRbjhBSlRqeTV1WXhPN0RRSlA0SFRRZlgyYmMxQlNMN091SDVjZGly?=
 =?utf-8?B?bTdmODlWMk1PckhWSHA0Q2pwZkI5QzVWTUNCMVJ3S2tQQ29TK3NmV1VmMG11?=
 =?utf-8?B?NkNkZ0ZlY0FKSW9kYkZPa1FYS0dQVTdTeU4wMjBPMkZicG5OYkVwS0RCTXFO?=
 =?utf-8?B?Zk9UNlZRTGtETHhNd2hzd0xiSTdTQ0JwR00zaGZmeWNuSm9vL2szakVoTDZC?=
 =?utf-8?B?UnNIekViWEVRRFV6eFlWZ0ZHZFFHcExzMDNsbFVwTXhpWWJIZmQwZDNLWWV4?=
 =?utf-8?B?R1MrV0ZnZzN1THBwZkxvbFZOQ29zbjlNZEdJditIVlljR0kvaEJzN0cxR0RV?=
 =?utf-8?B?SDhDYWEyKzRmVE5xano4endRcm9ORk1jRWhhbXlOTUx3NkpnR0RNQWx3L0xs?=
 =?utf-8?B?dGpSWmhmSTVmSFN4OVlYSWp6cEhUVmlNdVJFNzB3NytUMlBiS2hPVFpxbmFz?=
 =?utf-8?B?MWpPQUhrd29FcjVtREk3a2pIVU5LZFlVVVFRUnhaSkhPL2RVckl2elpJOWZl?=
 =?utf-8?B?aUYzNnFvQ2dWYTZBZmFvZHpYVFl5aFdxdzh2UGhmM0taR05Cb2FXV21EMzAz?=
 =?utf-8?B?WkdLUVc4MTcwVVI5ZmJEM2VsZll2TkIzb2RNbjBzQ3htWWNpVGtvZ3pYcGVN?=
 =?utf-8?B?QWYzVjkxMlYyZlkwVDhBVlVha0ZzdGlpNDNMNHRsdkhJMTZwNTNBZEpMNnJD?=
 =?utf-8?B?ekM1Z0FwR0lFaERtZEdkZmQ5UlFtcWlsYVBneDY3cmF3OTZ0eWw1TytOVHJt?=
 =?utf-8?B?MGlyOWdRazBYb2Y2NitBOVp3Nko3TFZQRTVrYTlHRlJ4cEppSWMzTUxPVG9m?=
 =?utf-8?B?WkR2MEJqOXlKMzVTdzJZUWZCZUtFYnRUajRzVWR6MHArSGpJQTlKS2M2TXlu?=
 =?utf-8?B?ckFMWkFDN1VSMXNNNFk5dElMbUpnQmFVVkwwSDhVeFA0WXJMd0dJZmpvaElY?=
 =?utf-8?B?azF5amk0R1ZSOVhadlNuQ01DUllDU3RIT3Z6UVlISjcwMWNUTFVBbzVnLys2?=
 =?utf-8?B?bktzM1pCN3NHWjlnRDlyazVzS05MaFNudy9rVStDUmo3c3EvNHIxMjQ2aXhT?=
 =?utf-8?B?VDNXdk56WnJxSytxaHVna29xV3VsRGx6SFdLcFZwamRsK2hSVzVGUmdyRGUz?=
 =?utf-8?B?QTk4cVFYanowMmI5ZWpQNW83d01uWWZiZE44RDJUbG43RG5mRUQ5OTg2dGlF?=
 =?utf-8?B?eng5UytFZmRBUFZpd2h0QmNsYVRROWVPMEVKY0txZWMyUm9OVnJ3UzBRSzNJ?=
 =?utf-8?B?bGVFbkNLSGw3N3U1UndkZlMvRWIvUVA2dlJ2MldxWnZYUHQvMkpsWmtnODN6?=
 =?utf-8?B?ejRBVmx6bTdDalFvMmVSM0F4cE5NdW82OHdTQU1zRVVJL2t4SDVhc1Jad0V5?=
 =?utf-8?B?YTdQQS9nOUtHNXdGdE1VRlN5UzdEV2I5Q3dJSFgrTy9RUi9XVmtya0tjTloy?=
 =?utf-8?B?WGZMUFl1aDkwSlZ6VkxRSjd5YzRQRUV2eU0xeS9meFN1bUdBYUJvcm13bU52?=
 =?utf-8?B?SmxkU0RQT25MSGtnQXVSRUFaaVErSEdwWHp3aXlWSlJGNVQwUFJaeWJCdmtY?=
 =?utf-8?Q?FAO3ZElyi2CvyEbdFyl2qLkoTCw6o8J2r9XBwob?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0260380-61f4-46a5-c39c-08d8eee28691
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:33:16.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HU7mkAzZnGv5U8+BmDujaVbkE6ih/Pj/EL+z9MPvE9ibsQtd1E1byup5cOBmhNIPDSXIRNefAWKv7wtikSQVJej4YRkU9wTj4HziLb9JjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Qais,

On 24/03/2021 16:57, Qais Yousef wrote:
>>> FWIW my main concern is about duplicating the range check in
>>> ftrace_call_replace() and using magic values that already exist in
>>> __arm_gen_branch_{arm, thumb2}() and better remain encapsulated there.
>> could you please check the negative limits? I have an opinion, my limits are
>> correct. I could add extra parameter to arm_gen_branch_link(), but for this
>> I first need to fix its negative limits, which, I believe, well... Approximate :)
> Can you elaborate please?
> 
> If you look at Arm ARM [1] the ranges are defined in page 347
> 
> 	Encoding T1 Even numbers in the range –16777216 to 16777214.
> 	Encoding T2 Multiples of 4 in the range –16777216 to 16777212.
> 	Encoding A1 Multiples of 4 in the range –33554432 to 33554428.
> 	Encoding A2 Even numbers in the range –33554432 to 33554430.
> 
> which matches what's in the code (T1 for thumb2 and A1 for arm).
> 
> Why do you think it's wrong?

thanks for checking this! I'll re-send v8 with your proposal.

-- 
Best regards,
Alexander Sverdlin.
