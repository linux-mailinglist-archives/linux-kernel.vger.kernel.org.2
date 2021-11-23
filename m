Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605B045A24B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhKWMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:16:25 -0500
Received: from mail-vi1eur05on2105.outbound.protection.outlook.com ([40.107.21.105]:15841
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233037AbhKWMQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:16:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpaUkMJXlYT/gqePMekTJFoQn6w67pzu5TqZtkMdXRlKwuRWZ2y9hSlOC3lKwVKHwLZ6Mmtslj8kLcc9lAASajLpqSrfJB+YrmUI5Lj9/UfkHHixRSoYHwS8NH/SRycK1HnPN2X7iras0SkgpP3yq5j8S9DqyEg+2aR8tIrOumESY/Bp2hD53lRTHYOLW5j0JupllBGcAzKQK+EhUOL//tASmSRcNSYLV4GCFis1eWzn4h40+itNuw6QmZnc1SnIRSCxXxHCIFo2n94BPBfBYF0QrkE4XiKcUpzRUZkOFVWMx8rS320oDKLmhUZ6Tt3CS98IgeJKG63RTFTfcOu3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=916TYf1M6UsrteEr8l/8X3OXTy9raiDYshkN+SQLBFs=;
 b=INyEUcZulHpS3tvZ6T4cHX5oLGOdllKXC5+i/LEGAOrcaiUDVZUugmhI3Jn7B7TbFy6FE+IIbAHj5zZizjzZd3zGzL/IfdXhT09+9vOntZZPoG6l0qYu0FtTjHqU7wHGiCMpz+e0Bd10EtdwGCyC+OdAgRu6qg8ri0E9AyzNxnk31CTuM9PyzLbS4WmFeSOl7wS0UiP1VqngN8yGciiP6ezcYiXwW45NIsvNVnKMUjLVmpcy7+gRK5tB43bZnIfK/DSoE5ziL5PS9QEDYXav3pv+TSV0mgUc+JuhBTRSU/Qo7LOxpx7rmBYK2Qnkd95Va7x6E5mCZRRj6C7JIztQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=916TYf1M6UsrteEr8l/8X3OXTy9raiDYshkN+SQLBFs=;
 b=K7Xn/qh8oG0Vl5ltvyeciJeKdrSHbEW8wC4PDPbPWmmu/2bggJcL/3mlwW5lb6JWweyhdns/ve0cfHiFa0Ufj90+PhVdj44+nCC3/EQErRCG7GFPncduW7s4nf3lGmmvszHHoniNMi6MNXUC3a4sKmqlQLZF3dS/sfRzDqbrVes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR0702MB3826.eurprd07.prod.outlook.com (2603:10a6:208:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.9; Tue, 23 Nov
 2021 12:13:12 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f%7]) with mapi id 15.20.4734.019; Tue, 23 Nov 2021
 12:13:12 +0000
Message-ID: <85251c3b-13c1-8b24-0ce2-6793ea55e39a@nokia.com>
Date:   Tue, 23 Nov 2021 13:13:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <e9589af968d7b9dafbce17325dbf8472@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0701CA0057.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::25) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (131.228.32.166) by HE1PR0701CA0057.eurprd07.prod.outlook.com (2603:10a6:3:9e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.17 via Frontend Transport; Tue, 23 Nov 2021 12:13:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa413025-2778-42f3-c180-08d9ae7a9efe
X-MS-TrafficTypeDiagnostic: AM0PR0702MB3826:
X-Microsoft-Antispam-PRVS: <AM0PR0702MB382650F3BAEA945BD171393588609@AM0PR0702MB3826.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MA+MIur6cg1G7iDYRZiscbSWKNj+bh1MJjB5l/R00vUU08L5FYYY8epNS4tSqVy3evjIyvd6rT4yZahE8x8PCNG8xob0EKE9dAuNKAvgY0NzCGdqPF0yyvtrZ7L8V7vGpPoMTNcw/68OaD0CRr/GeOx9NpH5wGeY4316q7OshSjnBtzjjmSROTMKf2Y0EqwbKdWFyWB4LH74v02HzWPmAqCCPAZuRPZRcaHYGAthNSzDTIya4pVEFXlnIAhVvKMCWytm0s901dnUily2pA9cKWQa9tM9VZldbhHe9qek8Q1NJTgkNhiWhJ+FekSN7WfL3A8sK0DEYNQi2TUkB2uVYeB8Ix5RapiRVE7PbIKEcY8oUtVVwk360TLhvWnkvfYlCSOoMD+mqPg5VD7lkO0kAjMhzX/+yPv4g44KAPUevXmYpPTI+hprP4Bnz45QCKffVJCNFKV8w7fHzxcRqng50VM8IM2eqeMT/Avh453dafKP6S9UbY/Cus7Padw9Y1zmcjXVjrhLLB1N5jA7qAPrGN2UtumDPBTpzeU7TK0p+/qii8HYiaJNVQ+Y/5i1t5o0XaMFzD/kwDaIEXwsWeQTN5PW4bGXB1lfRJJdtUrXyNyl/UsA0M7i84rv8krlsxi/3R5USdrVW1/cBXM2pzcIQZjpN+Ab8kuEq2NsM1gin6sMHREJ2YlJmfxXll1to9nGZwLugZKG8WeYKHDiu92Q1ubcwp9tZEvlplLlrxdd+M2gIHR5Q9p2+0mY8p6MwdZIoPgsritCpvqKAkg1AgfY/9WpRpNsQryWAJp4Wt0D+sQ+/iVDll2FzOR9FNSVdPAHwerEHKCPuG7uXmhOPxrtaoi2fGDg1cbwIMYyUrytiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(53546011)(38100700002)(6666004)(38350700002)(82960400001)(44832011)(83380400001)(31696002)(36756003)(2906002)(5660300002)(6486002)(26005)(2616005)(186003)(52116002)(316002)(6916009)(31686004)(956004)(66556008)(8676002)(6706004)(66476007)(16576012)(8936002)(86362001)(66946007)(508600001)(4326008)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElRb2xQTHU4ei9aMWo2d0pQM2lXTDFpSmgyendQVXB4MUJHZlRBUllUenlS?=
 =?utf-8?B?QTl6UG9sNmRIUS9xUnRENWRDeE9FVDkxcmNMQXU4bzVrRFUxU3ZnZlJQaXdW?=
 =?utf-8?B?aW5VbGhhUDBVcnNBTU9mVDFYZmNSZHkyZ1ZoaDFoQTVrNzczTk45dWJKVzdp?=
 =?utf-8?B?RFVRMC9nWUVCdWpTS3pLc1BPM04wUWZQdkYvQm9uTURaeTBvcXlWUkxRdVNI?=
 =?utf-8?B?Uk10SW80bDk0cVFLdU44eXk0K2VxZGNUMjhiSnF4akRTTWpDSVltaUJoZVNI?=
 =?utf-8?B?VVk3eGF5bHhCV0lvOUJNQTJCRERhaUt3aG4wVHRzb010aEpKTWlkcSt6anhX?=
 =?utf-8?B?ZndvUnphQ0RWa3VrWXpub3pNbWI1VDdYdUU1cGh3SW0wc2dCU2tXWlQ4WUFm?=
 =?utf-8?B?aEdlK0hLcEFBTTV2aXc3bDJBeGpuN0lUOTBabnZEU2xvKzRrb1lKVjgxMjlh?=
 =?utf-8?B?SVBpOFo0MEFlUXVUV2VTcUJmYlJSbTJGQTBRTncwNlB2ZHhMVzNiZUkvZ1Iz?=
 =?utf-8?B?cnlqY0E5SnhjdkRGdHpSbHIwOXJxZXpySk9nWCtNRHlOMWE5eVMwNGM3RGs5?=
 =?utf-8?B?dFNlM21wenBGZUMzYXduRU94TmhlYTU3RXYxd1ZoMmY4eU1FaEFiZnJmUlRn?=
 =?utf-8?B?V0pFQW9MSWJsTlVvZEJZMXFUK0g5ejFtRHpJMXFPUGNZQlh3QVYvODdQem9l?=
 =?utf-8?B?ZnF5N096TXJHa01VcktBQ0lhTURlcmF2SlR5UFNGV1ZGdndtZ0x4WlQwTmw3?=
 =?utf-8?B?NkptNUhuVjVFOTRRUWRmM2hhdHprV1BBNWJRWHJsRENjOFVFOU82WGNLa21v?=
 =?utf-8?B?dzJyRUIvNnEvODMvbDNzQXdpRFJKMHRxS2lTZ3NTV2xuNUdITXNsL3NaR2FI?=
 =?utf-8?B?WFhhQkl5bTl6L28yK0lnazhERXpBV2dsME1SSFg1bkxNWlZMR1Z5VkJoOEpl?=
 =?utf-8?B?dDlkTEZIQTNwMWJYeS9FZ1VZM1RRRG1iNUxlRGVDNEs0WnNua01WeW9ZYmxw?=
 =?utf-8?B?bEhxczhDUWxqRDZHYXppL1FxenpjNVdZR2N6OTM0UzZPV2FSZTVDeUJWUU9x?=
 =?utf-8?B?VkgyRXlWK2dmRWhnYWlMWkUyWVFEUGtiS3p5NlJPUGRTZ05GVlRVVTZzRHVk?=
 =?utf-8?B?bFVIdmdXazl4YmlpaDhRZ0hFMDRBUE5CNWcwU2ExSE9oR3h4enlEMFBTbjlk?=
 =?utf-8?B?dTVNb2o3WUdIUGh4NE53UFNyS2NNYlczNm1hSEVNWGtrT3R3ajR1WitHd0I4?=
 =?utf-8?B?bVU5WDZyVzI2NVNtU3JWQzhvRDNRMmc4Mm5BSUR1UkJzRGdaNFBiWW9zU1Zy?=
 =?utf-8?B?eGJ0cFJQYkcwL0JUYkJuMk9xUExtdnYyMjdaWjJRQUVmZjBFd0pwQXZ6bDNa?=
 =?utf-8?B?VUJyRU1YcnJBdUhsNks3NTFYNVYxL0dJd0x5Mk5iV1hzWk9ud0FSYlJzbUtZ?=
 =?utf-8?B?ZGoyV3V4UUh3U005dUhEQnMwUHQrV3dLOU9EK2MwbEZCNjloL1RNcHBxTEZ1?=
 =?utf-8?B?QWVYT0NXc0ZPMEVabEh5MXRhdENmTC9TSkJhcXJJNTNJc0JQLzNVdlIwdjQ3?=
 =?utf-8?B?b1gxT0kxa1FLV1hGeEJJZ0pyV3Vjc004bXpKSzNMdEZnQXg0VGhlTjR6cVpv?=
 =?utf-8?B?UEtmRDgzcFc5V2gyR0xqRjh4Q0puelFGaFdBVGVHdFNPdmp6RGxTNHNVMzl5?=
 =?utf-8?B?OFd6d25OeFNuMTVheXJqUVVjYWhzelBpSDlKWUhGR2FoVkdGOW1FQSs1QWl4?=
 =?utf-8?B?U1ZQQW1UY3BLdkdIUzAwUkhNVHpTQVVVS3BvSTR5Snl4KzNyL21jdytGNlpu?=
 =?utf-8?B?d2lpeHlZOVVqdHpTWkdxODYycjYzOE1UMWtubzh1QVBJV21CRFBVNm5oM0Z4?=
 =?utf-8?B?VzRLZnl6bzY0RXNvRkJmd1ZrS0hCRDdjOVlTUlZNaWhHSWRjd3dLSlQ1Yktr?=
 =?utf-8?B?bFJEZmVZOGttT3NOTzNwdkk5cVBsUHRMRVhzZWlhVnFCUENLcnZIcTlXTWww?=
 =?utf-8?B?STVrVkxPREdYRy9JbUtwMmMxOXdzQ01pY3dxMzdrL0o0N3pPbmwyaFZOMUZZ?=
 =?utf-8?B?anpJenNReFhrbGlZcTcyUnV6NDMyZ1oyZ2FqZDY3SFkyamduQlVNeXVhL2lx?=
 =?utf-8?B?Z09rOUlFc3d0WlFIanJZRU9HRzA4OVBYdlE2cldzd0laYlJrd2RpWENaaElo?=
 =?utf-8?B?MmJVNGlvb1NqSm1sVkxweFUydTUwMUxjRXgrbGFLeFVERkxxbzlLTWtpZUtR?=
 =?utf-8?Q?gV8Lwg34NWZtZE0u9DRno0ihXXTnfNLg5hBZcg8ZZ4=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa413025-2778-42f3-c180-08d9ae7a9efe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:13:12.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWlTIlXSBKWvnthNEcDlWm2qaZh+uFadeF6SP3X9OrxZ0tIYG0VoyFXEfiZLXut6Y+oWqZ2Auw/5YnVPnP/uhyBbEFNZlGkXxlb1pfo6JQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0702MB3826
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers!

On 22/11/2021 16:05, Michael Walle wrote:
> Thanks, so that's the SFDP data for the mt25qu256aba8e12-1sit part. and the
> jedec id is 20bb19104473, correct?

While we are at this part, I've encountered another issue:

The chip supports 1-1-1, 1-1-4 and 1-4-4 write OPs in extended SPI mode,
while only 1-1-0 erase. (as well as 4-4-4/4-4-0, but that's not the issue here,
I think).

Now the erase code (chip/sector) uses spi_nor_spimem_setup_op(nor, &op, nor->write_proto)
in both functions.

In my opinion, as I look into Micron or Macronix datasheets, write_proto has little to
do with erase_proto. (there is currently no separate erase_proto)

Before I come up with a totally wrong patch, wanted to ask your opinion, how should
it be solved, what do you think?

I do not see any erase-related tables for this in JESD216C.
I also cannot come up with an example of a chip with erase != 1-1-0.

Shall I hardcode 1-1-0 for erase?
Shall I introduce erase_proto? What would be the logic for its setting/discovery?

-- 
Best regards,
Alexander Sverdlin.
