Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9A3735FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhEEIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:03:32 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com ([40.107.20.117]:29696
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231963AbhEEIDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwZgNbwAUq2FD6PO8BTOjuBVYf+zC7pTP6hIp73/HtozNt8A1R88ju6TVR7xQIw2met43vDBMiABbb9U/JlZLjA6acAzFhx+Xg3nCMGxiRM2yfGssTQ2yUa21xu722nQU3h/7vT9rXII1GYB2L6+R11E0Vjg0kXfibk2rCb4UGyXcQJxxPyvyznCzUWzG04RX2G6/gjFLHhtH/jNRsQwwKSofon2KfVuYaDJHCwvk3Qw08yFRj6WrvJr84t6qywylJohx7353aWKoFU0s1+j/6T6OmrdSujwl7uaq8uh0/psHHxfeAIIfli6J2hQ/pvqIc+RkfC7/+Y9ojsX8cATLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnkvR0nQHYY68SlcI5Odh3rqkMSKE5NraSfE8befN8=;
 b=V3HyuJBJJt1evfc73NX6NPE7qP4E9LhoURmOxrjidibitVF20O9Brzyy2E1dWYnETA9NjzCbcF1rcH0TNrI5iZNCSKl/R2w3aqiOn6Of/2aJIZOXIP6DRqdYXARQak2VlpssLPjMeGJ3DY8uS/wR0iJnfwGpYWtOtemIwH7NJrKEjzE4zbZhi5SomNWxLlipLmNhPvSlPeVyVmgoWCVjG0PYK3VOCcUp8bJNiLTYnHNUoo+OA2BwtX2Q1IE+nK1KAcGl+6JtO5COOOwvqoXB59S3Txxs087UadDVL9Xfw/eKdGufPxrSjo8RE6iB440kTjfRjTgFP549rmUJO91cVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnkvR0nQHYY68SlcI5Odh3rqkMSKE5NraSfE8befN8=;
 b=rdWDdwF4J9x5jwOe7vmrZmWS0gOCi1vNcy1+l2tsOxogdJWbnNoAewPZXBM+UZD7wDOgvuRs+BE+68/JFp70w+EH3+j/o9dPM2ssIhYk4XTuff8ukkFQCSr+QJV2IF7judy/jt/wu7rvKCvklTVWrD5ONMBxcFL/gEI0rswNXKM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4177.eurprd07.prod.outlook.com (2603:10a6:208:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.20; Wed, 5 May
 2021 08:02:31 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::80f7:12a2:fbff:6a9d]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::80f7:12a2:fbff:6a9d%4]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 08:02:31 +0000
Subject: Re: [PATCH v8 0/3] ARM: Implement MODULE_PLT support in FTRACE
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210330114035.18575-1-alexander.sverdlin@nokia.com>
 <20210409153309.wbebto3eufui35qs@e107158-lin>
 <be48adb2-c838-1a9b-37bc-da783f3d5dd3@nokia.com>
 <20210412110810.t7pqkwawn5zmqbca@e107158-lin.cambridge.arm.com>
 <b26651f2-a5ca-ff5d-23e4-05b7eb7d9583@gmail.com>
 <20210419223448.vummlz37nyc3a64i@e107158-lin.cambridge.arm.com>
 <761c79cf-8709-6da6-cdb7-9e03e25f0272@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <bfed7c86-de49-424e-3b99-6697e93a9b50@nokia.com>
Date:   Wed, 5 May 2021 10:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <761c79cf-8709-6da6-cdb7-9e03e25f0272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.11 via Frontend Transport; Wed, 5 May 2021 08:02:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0512917-7f65-430c-62c7-08d90f9c2244
X-MS-TrafficTypeDiagnostic: AM0PR07MB4177:
X-Microsoft-Antispam-PRVS: <AM0PR07MB41770124A0395C119E576DBF88599@AM0PR07MB4177.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C90mP8L0lFzUE/duOEz0l/IxYJ2MaXsCPE3jE9lAZPJVsWKyfAnjrfiy/VhzWT6NxmHeMY83Dsz7/h81Za3J7EGbB4bjDAN8nq2TEFX/+dqpKQkFci/BPYqtq9bo2cz+7bZwmHWwG0thJAYWvIEf6EZWOY9pFMYGtsjKHGdBgMp7uZF/kOFoWevPi/feyokRzgsu2AzqURsl4SGRFYn6g+2U70T5F6YcszAgfhaZ1EwjWTTqPS9sO3jd7MctESmw/CIviHFFavRBayW0aLnoISk5CXQU1JRiTj3rWKBdHtxiyKcKqvXFIqycds+LBzdB1qcJ5ovkRLeOrUUfwEmJnliXZKzbi7RReu7jEZqZArSN9tFMSP67hgZzUujUa6dkONJOsaNEUXy1EIIt+A/9zH3iOIUXIzPXKH3dT/SA0tKQmjek1okgh2bxl2SfiYxqb74gq0seIeoNfUCv7TkAKevIQTX8rJW7w60zgPGc/iggBdXNwo1F22yG5g9BsfzU0iv2WxFtg0q3DlGhhVPFYGYE4b+dVBDcNuVvWKfIOQo/nRFgb6Kt+hUnXQseSBxva2C2imqGChEiZiO+qzmPWP69i/GbcGAB4cg6vjmtsKP3b+lkUE93kGTyqAx8XrTNbJlN9ZTrMDDuJt/C6x0J0WK1HJtFD+cDimDJ4RdoNSTci+hjMiNNvVJvtYNu+tOWXupX+kAPCQRhPcdxtdHlzZ5/iG+kgbHWhiYkDeM8rqZ6jLU16xTAgdt5uQE6SN5kScSKrcDXpFW/K0Y3vYyqgU2gSrtKu+16nhL+qrYEgk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(4744005)(6666004)(2906002)(52116002)(6506007)(66476007)(66556008)(110136005)(36756003)(6486002)(31686004)(38350700002)(316002)(54906003)(8676002)(53546011)(44832011)(66946007)(38100700002)(86362001)(478600001)(186003)(6512007)(8936002)(4326008)(956004)(5660300002)(966005)(26005)(16526019)(2616005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cmc4Wkx6R3h0Y0NaMWhiKzdNM1RxS1pMeUdiVm4xeVY2UkRjZWRqQnlkdTg4?=
 =?utf-8?B?RjhzTmVIclM2TitrdmFHa29xUGhXdnR1NDFuRUhSUEs1TlhvMThMQ1JKWnQy?=
 =?utf-8?B?aTE3aU9vcHozVmhlT1RhOS83WEtnMWxaMXk2bk0zbk9SSHlUeWxldm8rMUZ1?=
 =?utf-8?B?N3pvOGNUNVlrZmJ4ZnV1Q3ZPeENZZ1pDMmw5TWFoYUNPTEdySERnRmtnUlNG?=
 =?utf-8?B?bmFtNXhkODhXajY3THJ1eURBN2lxaTRTMjZYZ3k0MzlSTzA0YzlqN2wzay9z?=
 =?utf-8?B?UmdGNkh5YkNtVG9FQmNXeUhzYU9UbUlLK3doRmV0N2dPckJjWVhYc0pSTktw?=
 =?utf-8?B?UFFQL0JYNkRHbVRTbVdWWTE2dm85REhpaDhpbnZBYS9wQVhaTlNTMFA5L1RC?=
 =?utf-8?B?Tm9ycEZUaS9oeTVIZHl0SWNYMkJ6SDRPa21Ib1ROR09iU0FDbTV4Z2ZKUmd1?=
 =?utf-8?B?Z3FzSytGK09Pck5rOHJoc1dvMEJ3VG1oRDZUcUV5MHA3M2huTStucWc3M1Bo?=
 =?utf-8?B?SUlybVNOMGkyODJPb1FjNFdxV09IVUp6b3NrU200YlliZmIyd3h6NDVTSmNk?=
 =?utf-8?B?ZUpJSDFLTFNKbEt0UTBjMnBBYXB0ZTIwRHFLUUl3UnhsVVFTK2hueTVLM1Jh?=
 =?utf-8?B?TFIxZyt0Vmc4WHBvajI2WHc1NFpyNTgxVFUrcXg4V2JpUi9RRjRYTDF0WWpO?=
 =?utf-8?B?NjRRenMvdXNpZW5JQWU3WUJwTkxMVlJDb3dwLzBxVkdKMkIvQXIwTDRyQW5R?=
 =?utf-8?B?YUFZKzlQdjhvNkdtSStHUkxTb3ovT0hBbEpRWVoyMGRkMlRick1vYUtPalRy?=
 =?utf-8?B?TzNkQXBKdmxHVmdRV3FNTHV0bW9vanhuaklSMDVOYXo3SXZ6NFY4ZkNmVTAr?=
 =?utf-8?B?aW1hazBlelpQSEZrWDlZLzlpZ3JPendkcHdFNWlSbUNtSXZ2OUQvVGVmeGt0?=
 =?utf-8?B?MTNBRzlsY2Q2bVFha3krTkdyMUZqWnVWbnRCNkl4aWsvbjJST1VHY3kxK1Iz?=
 =?utf-8?B?ZE5yMDI1TEpQdTJtQlJBN09MZWZDc1ZKZnB5TjhQbUVsSXNRN2FNdXNRNkVy?=
 =?utf-8?B?MUlPN1B1N21RTktWS1dEa3luTzI2cEFZSE1qSmZCU2J2Zm5Sc0FuaU1YVXhU?=
 =?utf-8?B?ZC80ajU3L1hEMCtldjNyS3ZaT2QwZ01WSjZrRWYxYmN2eUJ3RTZTNzBMWG8y?=
 =?utf-8?B?ekJFODBJdlgveGFkZy9kRGVtcVJvTnA2OWR1OU1NMVB4TXBUb0ZmRTlwSlNH?=
 =?utf-8?B?Mk1WWSs3a1lyMEo5dVh3Y2Jab1BBWkRmYWhReWQxMjF3OTU0YWtBaHRTc2lY?=
 =?utf-8?B?K0ptaDJsVDNXd1BlMVBnR0I3ckhURkpYbnZHMWZnSitwZlc3ZWhwYXVLSUxI?=
 =?utf-8?B?ODhMNDlxWnZlQTQ1aGNCZGNtUTIwZEoxU1FNd1EvNXVsNGxpRmw0a1poelFE?=
 =?utf-8?B?TmVKemZHaFVZSjMrdVp4eElRWEoxa0gyN2tQMlRMb2RMZ3YyQTNEZ3FSZUh0?=
 =?utf-8?B?bXVRZzBUdjRzTjhaZDloekt2WEtnaXpYN0VtYWYvUURhclBDdStYNkdvaUxl?=
 =?utf-8?B?VUVpT2J2ZGwvaXQ0WkVxVW50YXdLclVtSkhjRFR6WnpCanVWT1QwUFozQkta?=
 =?utf-8?B?enE0WERkQWd2WFlxVkxXMlBZbjIwdkhnU2F1dm5SK2toYzB4cjZtTlkxc2hP?=
 =?utf-8?B?c2FsU1VrV2pZNTFmODVSTDJDbnlrTm02Z2t3QmlWMHRWM1pMendpQ05pTDlO?=
 =?utf-8?Q?pe3ecdxma3NCu066x0S3V8HZFKN3+7zG7ebM970?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0512917-7f65-430c-62c7-08d90f9c2244
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 08:02:31.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5cL81SaS0qZvLb/wNcBRH9nUxMx+Pls5kruyUxm+T2pEw5yaQNCYRYyEFXDSkk4WN7vJRAvhYJDUQGEozeWYbf6Qz0u3A5ATiypiqPnbj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian!

On 04/05/2021 21:11, Florian Fainelli wrote:
>>> What is the plan to move forward with this patch series, should v8 be
>>> submitted into RMK's patch tracker and improved upon from there, or do
>>> you feel like your suggestion needs to be addressed right away?
>> There's no objection from my side to submitting this and improve later.
> OK, thanks! Alexander, do you mind sending these patches to RMK's patch
> tracker: https://www.armlinux.org.uk/developer/patches/?

Done!

-- 
Best regards,
Alexander Sverdlin.
