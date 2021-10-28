Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1898043E517
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJ1P3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:29:33 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:26885
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229946AbhJ1P3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:29:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtsKPvpnjDTAoBGtVFXcJ7xZ/qCYb9ZDWwEWZEe6tCA6dzWtae4bTcByj4VqAz0bSFmjPjU3KxlbSKUImFlZoUQDKJMYXSMfL8UGHVGYoX3EbMrb1Qfb0HKnoQ1Zv5SEQsIEeXsALSdcDkDGMGeKsYfZJCOhGqU1qZO9NO1q+p/FjyeIzMft0/I1kkf+IXSrPBanQnIHaVjKuyFzF+vR2rZ5WmIahUhV4cuLe8Skh4Y4gKEezL1Ca3YTGH1wcCni0jGw736mmu9FO9y9stIgMDEC5ZS7JHFiwtYbEVhqf6/tIvvzCDBMsdF+A06mOYaX3mcWmZKZ64srSRCo3O9CvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjob44z6SipbQO3PR2RKRJxaDNPbR2dI17smRXv1zf8=;
 b=JuXGN9BbJz/1Y7Xatd/UZzkvCsaTt2Znb2+aeFerRcOFrK7MTHATX7I9gdfSNikzvyboueka92v8SxPS/Bed6nTJO21EUv26Qg402yzoUWd9ZY84OexA4J8qJOtZiKgqQjCQsOcMi9tuJn2L0xQ1I57pIsCmsJfGruCqpNYA0m0MpoVBlBRJstSDsILyF5ywSOPq/6rkUXyzj+8gdx1qPVh2FQiujXufENHZ5Uo69C9Y3i7NR50RgJMylEVWYhu1EwvZuJqR8XiM8/FPOs9g2mW05/P3w1u/IPAE6mebL6odaAv2+o80WArJeQWh6mvqgZogjd3S8hOZsvVGOI+6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjob44z6SipbQO3PR2RKRJxaDNPbR2dI17smRXv1zf8=;
 b=x+rU+yBYmw2f4CjrsJFgWADm/nnm3avlbEbf5ygYfzRi9l7kwjCtzx4YgvcJpPGpPmm7XvehW+01/Bvvnx2otN2z+CUUn7orwXxVO0tIZVUJWtDgZX0XsVdhPEI6QQkxw60j9QvUbaRZxW6mzycs7FOEr8kvpBzT8OfF4GB7ORs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5365.eurprd03.prod.outlook.com (2603:10a6:10:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 28 Oct
 2021 15:27:02 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 15:27:02 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add generic GPIO reset binding
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211018234923.1769028-1-sean.anderson@seco.com>
 <YXi5CUCEi7YmNxXM@robh.at.kernel.org>
 <47d4c3d3-d6ab-3888-1cde-937551537e3f@seco.com>
Message-ID: <9a9693a6-922d-dac8-a340-1268b96826a8@seco.com>
Date:   Thu, 28 Oct 2021 11:26:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <47d4c3d3-d6ab-3888-1cde-937551537e3f@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Thu, 28 Oct 2021 15:27:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88547ac5-7838-46e1-1340-08d99a2763e7
X-MS-TrafficTypeDiagnostic: DBBPR03MB5365:
X-Microsoft-Antispam-PRVS: <DBBPR03MB5365FADC6755718DC3E79C6A96869@DBBPR03MB5365.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZiazxbXApsBGvSgRUks2+OeLY2uAyaB1+E7HKDGyjaduIiBnN2SWdoCqOI/Xp6faequPODjMhYd39cpS4vSOFzisr4Pu/5TobRiNqv0+1ZpgisW7cZRCD1X/4YebRJV0ZpPjzbDO3JKRfWgK2d8lWwR881GUj7AnQ5tS/J6gJs79+y21XwYkReD4Mla3g6IdPy/fY6a7kFEkD5e/+5FmgxLPO0GQ+nSenIhUdckVi65rTsYduVM58Fg0p473bqrupZhgf8clYz1DQDoleQjop3wbBW8U4XwJHtjiETr1Xs0XnkQf34iaQssrmfqW3W0lvaQvu/TFVVLgTCuc+LaWMm9I3bX/7JnDAeRVe09E3gmoflGl3r0tDXvwqHaIePL5/LvCIjj1Rs7kKHaAQLdoW0IAI6ewknGR389PgNmiARVRyKUyPUvk/n6g5Dmeoca6+ncjrN6w/XdbWy/0INcW7OW800B8GH0IQD/MbiPloa6rcVq87Km3WYgfjh9+WeJE/Xoyw4kJXLDmCnxMWrpKevGoKuchW/bbDcvK3AalDZd9U3LAExxc1oVMcX+3uuWgHjUsI6pJ053YPd8DljIxyF0HNNE7jXB8xy8MrutzMdHpk1l7XiVcLa4axewQqQWQ8rJ3uCw4ubXqAP4jDVyelphFdsonBeEzCIvEDYU5a9CWk79P2QzDb9gUpBbmkCSSsOPTaBIK/dLKR75AqVgApfsFUgKACwgSLiqJVYCE49El7EWyDXYpCbFm36b3dRjSv7JviKTAdzPlXb677Bo8FEvM+3aNW5AINznczJ9iNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6666004)(6486002)(8936002)(66476007)(8676002)(2616005)(44832011)(26005)(38100700002)(66556008)(36756003)(66946007)(38350700002)(956004)(5660300002)(52116002)(31686004)(6916009)(16576012)(508600001)(83380400001)(316002)(2906002)(4326008)(86362001)(53546011)(31696002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25JS3d2YUMxQ0hzWkZGZGh0WU1HR0VNRnFLOHZibnV2UkVJbFJFcGN3OFZP?=
 =?utf-8?B?QnVsZ1RFVHFFOGxtb2R2aFRST2ZWRlp0MVN2dWYzdXdwOE9QSlhKSStNYnVt?=
 =?utf-8?B?V0ZSd3ptMmpRMUVSd0ZML3grYUd4Q3Y3K0FJSzVMbnRKaWhycG43eDJVUGZG?=
 =?utf-8?B?T20yQW1JaXptZWJwcUpZWGNkekt4aXFRZWIxRXFlRGlTZ1NsLys5TkJwdmYz?=
 =?utf-8?B?dndpV1ZPWFZsc0x3SzVnaEx0bGhxUEtEK1JIQ2NobTNwZldmdGNmdWw0VURR?=
 =?utf-8?B?bXovMWY3bDBES2wzWTg4bW53bVZMMS82bzZxeFlQZDgremQ3NmlOcjUrUU5h?=
 =?utf-8?B?eGxPRXhXQUVRR04yL0xiaUtxMGY3Y3pBK3ZIVHg5Z29EYUROVHE4c2lMSEQy?=
 =?utf-8?B?MFFCSXJrbEpBK0JmNUh4TnYydXRKZ2pmNDJrMnRXRzRXekJ1ejhMNEtCcUpx?=
 =?utf-8?B?aHpPdit0ZjlwUm5OaFJEamFmSEpXOFhmMjJMK0dTMGlsbDg5aFdGTWUwaEFN?=
 =?utf-8?B?UzZnQkowbVo0RFhFWW1BMmRKTVpqMVJudDkyc29WV1hweGxTM3hqVDY1MWZU?=
 =?utf-8?B?RkUwc1ZZUlZqZ0dSTTJ3MC9jRzh3eU9kN0xUM1FVbHNQRzhwQTl3WnV3dFNG?=
 =?utf-8?B?TmkwbXdOQ1JmdnBwUTR0VkRuVklaSVNaQTZ3enVuQm5vOFV6QmF5bWcyQ2hK?=
 =?utf-8?B?eDFqSWtlbmpFUThtc1hXUWQ2UGxtY0d4VDZSaDErcHdYQkxBMnJockRBMitU?=
 =?utf-8?B?MmFuU2J6ZzRkUzN0ZnMya3hMV25VeWlWRUNOdXVCSUJ0ZlBnMVJ4TTFlY2N6?=
 =?utf-8?B?UTNhZ3pUV3lOYzl4SHhqR2tlc2xyQ3Uzb3o1M2wzVWYyNXhnRmNRY1JYc0VH?=
 =?utf-8?B?R0dZSng5RHUxNkZxRjkxSEVWaXh0bjk5aEpDeXc4aElITkhaOFo1dnFiU2Ra?=
 =?utf-8?B?QWNjeUFyWWcxa3l2eWRFTHZSaEZpZ0hLSmthdFcyak5tV09uWkZSMWpHYi92?=
 =?utf-8?B?Z0hGWGpSYzlpMEJZcHZHWUVLY2VsaHd6MGJQR3R6OVBiOUFkVktSbWExcHh5?=
 =?utf-8?B?dGMvTUVWV25QWnVOMXdiMmZBekpkUkJnbmsyb1FuVjBzMkVUVTdVemNYZmt6?=
 =?utf-8?B?VWpjcXV3eEJPc29PQmp6WHYvZ3NOY0crdjN5TFNZbFhUOWNOaTRzU1hGcnhq?=
 =?utf-8?B?TlZmOG1VRDNjOWNZNWpWanRhMzY3b0pkc2w4YlhRWXFWbjRsNUlWdldvKzhq?=
 =?utf-8?B?VDVBL3V3c1ZWZnc1M0hJUWNFb1BNbkhQWStyS20xeXh4dzR0SmlxeEVQUXJN?=
 =?utf-8?B?MGZTanJ0MHhpWndhVm9TclhYQlAwNmdHVFhCZ3YzZHB6bU9CSTM3WlkrU0hk?=
 =?utf-8?B?aFhjcCs5STJReDQycGJIY3h6cmhMc1pDdWlGS0crZkRFVEpudU4vTmUzbWRr?=
 =?utf-8?B?NFdSVmp6Z292N0lFbndKQUJiMGFCTDhndTNCNTFCZndCQXJUUHAyY2Nub0VH?=
 =?utf-8?B?YU0rb3hha0JVLzBja2s0Qkx4VmZhbDJMT3FrcUZyMTAwR1o2TlloM3VZUHJV?=
 =?utf-8?B?Y1Jhc3ZmN1p3RVRrRE9oVkI3S3phb1Fpc1p5N04vQ0ZvcC9mKzd1ckNEVjRx?=
 =?utf-8?B?aFFqcHhIVTZqR0FQdGFGMTZxWlk1cXp3T3pwMWd3YXAwbFh1am9GWkxLaHRK?=
 =?utf-8?B?eVVCcTA5Y3lBZk5TWGtkSEJNS1Y2Ulk0ZzhhMldnZVRkRCswb3hUbktPanND?=
 =?utf-8?B?elNiTittUW5WNURQRXkwRGpnNk84akdvdk8zT2drc1E5aC9FWWxPSmdIcDFF?=
 =?utf-8?B?dW52MG9tamUrOTNkbGNUWUpEUWNWYTRnT1pTUllOWVhkclNiZ3M4YVdmVDhz?=
 =?utf-8?B?and1UWN6ZHI5cGE3SEZ4dWs0QklhS3FMVHNSUEw2bHl4Y0NoeC96UEJRZEtL?=
 =?utf-8?B?ckxmc1Rsa3lZWTU1T2tUWXNxbWNSNGZZbEp5L0Nma3F4VFlMbERONlRKN1N2?=
 =?utf-8?B?aWh5NmJ5aFpvd0dZUngzTzhWbGtJTTliRDlVb2FsY1FxRWJocEVCdG1MTzZO?=
 =?utf-8?B?NEtOeDlRYkNwWUNUMzJDTFpMNVpUS0ZVQ2F6cDd3b1dwMTB0Q0dCamd1QUNm?=
 =?utf-8?B?eit0U0pVREE5NitTZmd6cnVWZStDQkZ5UVJnYXpXWktLd1htSFo4eWpOeGFa?=
 =?utf-8?Q?3P+I88eHZyHaRCYmh2jAAPw=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88547ac5-7838-46e1-1340-08d99a2763e7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:27:02.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZfeb28PenPIYHudUTpz0a9xj01FIoZCeXFFNRCaw+fQYj7UbMnfTWuv6/ICtzMgnpXBE67BW5WQJ+aUbLn3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I forgot to finish my thought)

On 10/28/21 11:19 AM, Sean Anderson wrote:
> Hi Rob,
>
> On 10/26/21 10:27 PM, Rob Herring wrote:
>> On Mon, Oct 18, 2021 at 07:49:21PM -0400, Sean Anderson wrote:
>>> This adds a binding for a generic GPIO reset driver. This driver is
>>> designed to easily add a GPIO-based reset to a driver which expected a
>>> reset controller. It offers greater flexibility than a reset-gpios
>>> property, and allows for one code path to be shared for GPIO resets and
>>> MMIO-based resets.
>>
>> I would like to do this last part, but not requiring a binding change.
>> IOW, be able to register any 'reset-gpios' property as a reset provider
>> directly without this added level of indirection.
>
> That would be nice, but it seems like someone would have to go through
> every driver with a reset-gpios property and convert them. Since the
> reset GPIOs are
...effectively ad-hoc, I think it would be difficult to do a conversion
in a generic manner (especially since some devices will fail to probe if
they don't get control of the GPIOs). Maybe this could be done with a
single reset driver which has reset GPIOs added to it dynamically? E.g.
when a driver requests a reset named "some-name" and there is a
reset-gpios property, request the GPIOs and assign them to the reset
driver, then hand that reset back to the calling driver.

On the other hand, having a separate driver like this makes it easy to
incrementally convert existing drivers. Although it does require a
change in bindings.

--Sean
