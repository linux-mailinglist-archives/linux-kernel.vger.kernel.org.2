Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEF540C116
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhIOIBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:01:37 -0400
Received: from mail-eopbgr00114.outbound.protection.outlook.com ([40.107.0.114]:59790
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231611AbhIOIBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMhbAVoaY1aBt+T4/umzUJipmfAxz/GLgq21gRRrmHW0tpcK+l3/7o8RLDasHeKkd1wfQInPh2M0unjV2yNTyTBjoPsQV92YsQTUI4uwb9SqtnpopKFGfEJ1RBS+fU3Zu+WWNcXDlteV6E+HPoeYaGMxMLIDYmgtWwAQGHB3gnqgGcAHJLKekq3wBXrjoogqWtMQO1v9dYwl5DcMNivK+5szahy2pRzkK8PrfdypIXRnDgfxI8TJL+euzliH/TmLGmunE3Y/BvLXFedEdC6mt0Y1uhbcGm2W3DQjVGK/W7WkbWrK7D2sRCBydJy8V6S8qkFGm3vmF8ipS+JhMzoEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A9SX4yAVMeWRfeSkQXPdhH0gDLfyyDV7zy21lB7noL4=;
 b=QvUNcwggjAlEXLdntzXC0MMJiaIPossywLtNFw7bMR1It2wWWy5eWfWsxZ3rMW12k8Onrjwd8nf37YYheAPWK9du+naNX9oYhrMCjMEzYgjVA4FvM6DHjy9j+9RiEL8BJAL0KZzn6XwblCzVA6MfyeyKvMgFBcA+XswaA0HUkezO8H4ammu6u2gB8Ej+lvNU7qsyMz8HHM6VGuj+18MiV0xXmaF75Q/kyXPhihssZEl6gLv4wjmUgbK9cIm8urjVnKPXIxNF1yhg29ZXJm1pYFZRybMuCwd14pGfLSFdyyaUEqyxXuG2+xYp3Firga4VTGfAVXdEWFlER6/7m4XqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9SX4yAVMeWRfeSkQXPdhH0gDLfyyDV7zy21lB7noL4=;
 b=PK0leLBSJXIex/mkWTfbpxYaYZsDBADEqmWi8LS1UaceAquWGnTN1BHHXqg+E0DLglYxRlGdNJMj+XabuzRC738Hv2DvgvJmdh6Y62nFy7aZ9C/mkf7EeuweXDfpMvKVWdZq/zz/5JNsun4UO7F2wheikSomFF1H0xzZ98KnCLw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3404.eurprd02.prod.outlook.com (2603:10a6:8:9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 08:00:14 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 08:00:14 +0000
Subject: Re: [PATCH v2 19/29] ABI: sysfs-class-mux: use wildcards on What
 definitions
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
 <2949241c7c5ad171cf6f4d115e4da7bd7915b024.1631629496.git.mchehab+huawei@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <30537702-71db-27a1-ed4e-ff3ad91f8436@axentia.se>
Date:   Wed, 15 Sep 2021 10:00:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2949241c7c5ad171cf6f4d115e4da7bd7915b024.1631629496.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0113.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by AM6P193CA0113.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 15 Sep 2021 08:00:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d31477-909b-4983-48ad-08d9781ed965
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3404:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB340425C8F8E5E61CADCF8F39BCDB9@DB3PR0202MB3404.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2NDEVE4FHcalWI4NaGvOHaBwI7PPVKMz4GNkQKoIpYc/hk2uGzJUVXTogE8Las/T1t5mx70Og4I/rZfBysBuY+zp0IgoThetuyAbffqEpKtv2SHcLTF+QZgnHCpW8aJg/oMTaL6TbRJ5rTyGIe7C+CIdxArpeLP83M1bMmrCfYnffM4QuPHOJ4tM+/LhWzosp8J/ollQOOxxGxp1rP4CcyHxhqpyGQl9WNV1Vpo4n/Q8mHLmWSoIwaxpuLoSkzAhIg5JgBROT2zeVQ1AzK+h3Vy61rebm85A2LDHO0sOb3jwZV2T0RubLP544IVDj/CQe9i8WubWEstoyQBzcIIHD+0d+pOO/0wdk/apxwZGtlYQv++CCZbN2jOlbKdiHqvLZKq68mFl94vs/N/Sg90nFBbBSp5boLH66pUyljy0snxzaHBkmU8N6j7+UTu0ZOiLKDaslnVmC0CmahtBGjeaM02WEf7v5/EHhKTPop/mcLLJvgrpPtOy74d1BrqF1G6e7h4U44mTsx/9WmIXxCcqxQrmM55cKYWIvnu9PYpbi8OAsjVn04s5AHlSxeDz0i+r6+urEcm1tfVs8yP5ToqB0l0pBzO2vuRrsFh7nWNYx6ladE+twV8U5peyYfNRxfYXILQO2XiUfy6PEi84gIu5H5SRcp+I7lOObKAZ8w0WQwMniVzS76CdD26FmChYnjNj84ideTlfEo3UKUpp4PfZopuoiTvwkQKgIEzdV7AnAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(136003)(346002)(366004)(376002)(8676002)(6486002)(38100700002)(478600001)(36916002)(110136005)(16576012)(316002)(2616005)(86362001)(31696002)(83380400001)(956004)(8936002)(36756003)(4326008)(66946007)(66476007)(66556008)(186003)(5660300002)(26005)(31686004)(4744005)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9IdHh1THUzQ0NCdDBFWkNMSWE5ck5NZnQvSWkvblA5ZWlvMEo0aXFhTFZy?=
 =?utf-8?B?MjVoUHNvMlRuYlBzQjlpY3dQWk9UeDRNeVhDU2RNK0dJZTFOdElyNC9uTngx?=
 =?utf-8?B?MUZyUXdyRmRwanNCWG9jYU5yRDlvMkRoYm1mbUFvUEc5UVB6VzBrZ3ZnYnZt?=
 =?utf-8?B?Z0dlOTVpczVzZU9hdjdNaWV5UW1aT01ZWVNNak9jNzk4TU8zbnBZUXl1dGJO?=
 =?utf-8?B?bWxML3V0Y09XQTRxK0k3eld0MVFSb3RDQ3F5a0FtVHBrdmsrNElzTytUMEh6?=
 =?utf-8?B?VzV1VkRabjllTDEvRjk5alY1QWFYaXNRUjl3aXl1andVaVZQRU1jWEJjeDND?=
 =?utf-8?B?R2YxSkloR3pNV25pcThTdFpVamQzd2tXWkRWMnU5S1VRSG5jcDhGQVUwSXpE?=
 =?utf-8?B?czYya3psTjRHeVZJQ3RzN2U4LzlSb2gxaWpva0o2LzFVM3R1YUNTR3Z2dnhp?=
 =?utf-8?B?U0pBOFhVUzdvckplMkw0WWgvYnhGTGtiSTh5Y21hdTEzWGpsd1pqOHpZWmdQ?=
 =?utf-8?B?ZEQvUi9aTnJnSHM1YjVYcDFJbXI3MEtCR3d6VGd6WlBFT1hyMFowWC9ZNDBT?=
 =?utf-8?B?ZkQyWlhPYWN1NW94R1dsZ1htT2NVZFc1WmM3UUE3R0dTejBMemhPSER0RUtC?=
 =?utf-8?B?aGs1SUVnVkJWV3lMODBWYnAyV05Zem5USVhBcDFiTU5STU9CZVFpRTB6czdJ?=
 =?utf-8?B?bmNyZW9FSmszQVl2UHZ6SGk2eEpDNGVRUEhzdldmSDBieGN3RXpQWDRjRmJK?=
 =?utf-8?B?bWRSUklyYjB1aFo1RnFIQ2NGK01LY3J3ZmVUNkZnaTZ5cGx1K2J1cW0rdFRC?=
 =?utf-8?B?aDNBdDBqUW02TGkrZkxwQytyZFV6ZkovMW1sYnpDc3g0UHpIUlB1ZzhnOXRa?=
 =?utf-8?B?WEtUV0VqeDZGYmd0bDQxU3M3Rm1RbUhGanFXY2F4NDJNZ0hNemU1U3hnQ3Fx?=
 =?utf-8?B?ZUNoLzZDZlJzVzRmajJwazJHS0grNzNIMlVMOTNMbFNBQ25vWXBmN0pKRjlW?=
 =?utf-8?B?WlBjY1dYQzR6ZnVIdk5NY3N2TFNzcHBkbXFHMmFZRmhYZ1pWb05IajJOODhk?=
 =?utf-8?B?WGk0dHZLSXoyaTE4a21iSTRoMis3b3pIRUVnKytaWnFMYUxUTzFtMlNZNits?=
 =?utf-8?B?U2UzQmx3YUxkaFVzT3BEalRVdDdMZXlBRWpnRnBPWFM5aFBwMU5vaGIxTmdi?=
 =?utf-8?B?d2NNNm5aL1kvZmx1NlVNTjdzZWVZSFBTQnUwcnZ2ZXh0TkdkYWJGMTBQYjhY?=
 =?utf-8?B?dmh6dDZjT2ptSkhhR0JGOHp4ZnBZWi9qWTlaemxNTGVWcGQ2WkFPSksrUmlh?=
 =?utf-8?B?cmNXekl0cnRPaEJhZW1NYTJmdmk1UlFSeXdvSjIrY0VGYXdVUWluZk0vMkRz?=
 =?utf-8?B?UGUySmErQ00rNXZXV3VZTFk1N2crbGt3WGR1bm1FTTBadjJKcVlBQ0FNQmdH?=
 =?utf-8?B?UDVlMmwzN1p4Zk9oSDJPQjdGNzduSXY0YmVudVkrdDBWSjc0WHpObmhpcXBl?=
 =?utf-8?B?a091NWE0MjRpU25SVW1JS3c3TU1SR3VGbmhrUTBzQjBkSU9JU0g1OTRHVE1s?=
 =?utf-8?B?dnpjSDk3UXBKdW5mY2tTWUJLQ01rM0laQmI5RkZjdlpEc3VROS84OVB6WXN0?=
 =?utf-8?B?V0hibGZwQnNSQ2RIbE02bjJ3VWJWYkxjS0J1ZXZnVW92ZHQ4L0YraDBiMFVz?=
 =?utf-8?B?MG5yQkFicUp4dVFRVTVLSHZIc2picS9DT1JvcU9PRkM5VElJTHROWWNiZHFk?=
 =?utf-8?Q?xPZ9shY8R1QiuAwCKRjUelarMNLujis9xF3zctZ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d31477-909b-4983-48ad-08d9781ed965
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 08:00:14.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj2zKN8x7Fx3hZC7Lc6rYNT7lACxYZvxAqv1iQxC7i6vVP3dTClTGOfj0CfEsSMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3404
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-14 16:32, Mauro Carvalho Chehab wrote:
> An "N" upper letter is not a wildcard, nor can easily be identified
> by script, specially since the USB sysfs define things like.
> bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> to convert it into a Regex.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[To others as well. Mauro, sorry for the dup]

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
