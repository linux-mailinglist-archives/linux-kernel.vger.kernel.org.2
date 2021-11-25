Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB71F45D574
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhKYHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:32:22 -0500
Received: from mail-db8eur05on2090.outbound.protection.outlook.com ([40.107.20.90]:13165
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhKYHaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:30:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnZCTc+KGqevigploLs/zyZJ1r2DNvr5uc8ECoX2vFzbvQDRISXZmLyqGFAAkVG9n5WuxLmi4EDPBk51M1w7DYh+PtgCr9WoChpA8hoj77KoEhyqr3RNg7viG6iZCfbP7ADEB41A+xLRxru4XVBNRIw0FjRFbnMN+Ax+JsloOJKVdlvO+a3QzWa7W+PxPnNVXjtAU7a+fc0V39K4yN+pqTtJzAMwXcbmCU/uA8BrBXlV0gs6eOxJGRXNbF5lmIlx0UEAyjo0remOxv6VrQdsnnquxwjgHKfyzkPXQ2xFqkBvTaFl4seBBpfd4KiigamTUKgeBKeuv3c4V2cSdMApVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ9KWsP3NgOEpCSOApxSdyjeoDX05dPT+gZSBQgLRGQ=;
 b=YWJTHtM80pmKjhfqWarGRR+l+PQWi2RWWCeXrbsJDhAWRhmkYYibepENBPxDbNVB0mY+CYp1JG020zS+NH3VOkAMe62Rsit/l4Z1ygEgV9vMiEGFw6e3j1LqIptNY/ce5j0AZRVSiN5fiOPPdJ5Mz87F2QVhtBn4ONb0Q+kttlr+ntipoOs8Nes+lLc4pJUl7aHtI2yw1AKrbzougaI06YHM7VvQgUgo1bbly7CEeU1d98JGGNBmY3MfV9T7DEqJb9gcU6sI4vzVkiOsPN/l5h+JulHeRp+8g/I4R4wHG7J4Crb60XeSzk/vn1m4G5J1WETT0pq0m/GtLqro3Duvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ9KWsP3NgOEpCSOApxSdyjeoDX05dPT+gZSBQgLRGQ=;
 b=ngRosEKvOLZBHcYPDdDgkSWj0tQ4zmmWUQBtkLbyBaVq8tz/dxycATDUhDgl7YPAriX8U0+FLsw4gXDrPmMIddOeIPbIUVOnakrk406ySollINmp9rZBIW0MgxiAuOxTuNEJpz35UwqtUW8UNoQOpr3QDhJ4zwCMlq9MzooW4Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM4PR07MB3412.eurprd07.prod.outlook.com (2603:10a6:205:a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.17; Thu, 25 Nov
 2021 07:27:09 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f%7]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 07:27:09 +0000
Message-ID: <8742b6e8-c26e-47d7-0b77-67137d3de10f@nokia.com>
Date:   Thu, 25 Nov 2021 08:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <85251c3b-13c1-8b24-0ce2-6793ea55e39a@nokia.com>
 <20211123174206.bzh5yq2f7sgkqpmi@ti.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <20211123174206.bzh5yq2f7sgkqpmi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:610:b3::31) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (131.228.32.167) by CH0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:610:b3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 25 Nov 2021 07:27:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b7872c-e0e6-4d63-c9f2-08d9afe4fd47
X-MS-TrafficTypeDiagnostic: AM4PR07MB3412:
X-Microsoft-Antispam-PRVS: <AM4PR07MB34129709C220422A4F9EA09E88629@AM4PR07MB3412.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnGh8XdLCM8uvzxPLvV+V2jOqgUtpVtHMy0TOmV5D++2hlPMvtiwoF/gOg+POppJn07QUpVoMPJo5rf4chtzyEya5ZhZrzcurh99a3iotAxeC/E7v3yKTL+pUBKyTWdDyOAXJyFC+9aKNvFRnJHc2gbel/rBRy0Q8UvLwejQPiTBaXVOehHg0yQdzm7AgTG7HAXNa8xY7ChPPH8wnfFVKUYZ7Fmx404/89l7Ky4BdD0uOSyiq4WmO+YpQoWt5ZoQhrlMIRrIlsAnDcYzvlxrav3tOR0gghvqeBleYNiDvQe+qAa+SdvqZH8g/NwjpL0tZ+UId/5qSk9Pzh/5pubylmxNTkDiaMs7epubrH2NUkj82UGmy1hOzwZwRSPgglqqr4ffbCDu+34/2q0dcD3TnmIrP2p1erK3gkjTeECtNVdCk7d3Kf71dh43z039p6/nKAIrymT6YKqMlBt1FmLO62ZEYVDm3VZK6F3XlZtODs8wP8z6g0C8UkPpHOudIl9qxN9ZDKgtRxbiTAKBM+JMRhzNK4uHgZZC/AT3ikxv4mUK5mSalsjtteSp49XWfT9OC48H/+iAwAqnk84ISNAL7VpRCTHhVACwgm9XIuhTanIou50AxZuTyD+3EfRICsofqad6FeWgoe8lhbNiYUEh78DKA7mMiJKyLiIwNIRuabyP/gFHRz+nhw11kn1cQpTIgBmv+X29kosOR9Vf3RVt8dj6iqxX2/lk+wKy2BF+nLuzbC+Qckr3dYMRi4AoBgYqVXOQoXqTxHGMggfkQgBK0m8qcIZhb1rXtysRG1KBQsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(53546011)(31696002)(6916009)(66946007)(508600001)(956004)(26005)(31686004)(44832011)(16576012)(8676002)(4326008)(6666004)(6486002)(66556008)(66476007)(54906003)(316002)(38100700002)(38350700002)(2906002)(186003)(86362001)(52116002)(36756003)(8936002)(82960400001)(6706004)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy9RQ2VGNTlZN2dnVDdLeG9wcFRiVjg2NCtudEJGUlBveGU5Vk5YNytSYlo5?=
 =?utf-8?B?ejV2eE0xWGRIVjdJWWgxOGNxVjFIRThPN1VqZTR5WXNIZlY4Y3ZsZGFZS0Vx?=
 =?utf-8?B?NzlhaEF5dXlMY3hDR2ZsOXpNOG45bTMzZVUvaUpmNU5DaEUvUitFRGNaMXhL?=
 =?utf-8?B?YkNaWENaOUVsSHFva3M5MVMwVmFiZUJkSmFDejFEVDh1aDBIS0JQNllSNWJ0?=
 =?utf-8?B?SGFoNVpHN3BPZ21CcVl2Q1BWRVpJSXJ1c1N1WTlrSXJIRGVOWHVWRU5IWEMy?=
 =?utf-8?B?d3dYOHM4eE5nNDlsbmlMNngxVjlMNGpJd2VuWGkwQXVDbjhTM24wNHk2NEVh?=
 =?utf-8?B?bzVZeUlGNUpPZ3hFM3Joa2wyNVNOTzhWeGprdmxpWGJlMVgrL0wydTlIb0po?=
 =?utf-8?B?NXlUVHBHdU1DaGFFbW95QmdPWWFCU0tiQjdWOVp1R3diNW1IL3RVeDNnUHMw?=
 =?utf-8?B?YjIwR1ZaS2wzVkxwVU9zK2dqRTJLdVNWTXdPRVpFeU1kV3pDZFc0eHhZZFI3?=
 =?utf-8?B?TXBEZEVxL3E2YldodmJoNkV6LzJLSHRLKzM1NndkSXJsT1NPU0dnNVM2Ullh?=
 =?utf-8?B?bnEveTVJSTdIOEE4aG1qUU53UjNZeTJJOVJkeU5hOGREUjYrNFlnQ2NkVk5p?=
 =?utf-8?B?Y2JMTmF4RG5Jd0tNY29XVmNLNWpubWljVXdLRjZSSDNQMmZ5QTlZZDk3NXhx?=
 =?utf-8?B?cmZ1UExqT05mMW1yM1hLNDU2NHREcjJUMWJEbEVYUkQrdC9XN1BuMmtzOUVy?=
 =?utf-8?B?NFF0SmxjdElQVjV3eUhxLzJ0YnFHMGtkSmJnUUVSMUVCYVRxS1BpRVE3U2Y5?=
 =?utf-8?B?blNRMDhrRG1BVGd1Z0NGaUppdkcxck1wamFMVkxFTzZqWE53Vnk3cHBVRFZ0?=
 =?utf-8?B?cnhxOTJmeFdtR2NYd3BHZkxjejJ1RlIzaU41L2U2OTQ2Qzdvd3ZtUDV3RVE1?=
 =?utf-8?B?cURuaGsxdG1oOEc3bG52cnBJZEtKNWlnVklRbHhtYXVTclo1RmZZZ0FRMWl5?=
 =?utf-8?B?TEFtVkVCYmdqdURlWHhnLzJOTFdmN2VWMjQ2Kzd4N2lMQVk1NjdodG9MeGlC?=
 =?utf-8?B?RVM0ajBtbUlaMHdLMHE0U1lTSzFpNDEwVU5aaTRwUTRQUmxCaHVGamorUHdp?=
 =?utf-8?B?NjJpMXlXZ091WE04OTJsV3RLWGlYMk5BYkZSRlB2MGNvTWp6L0JZTXFEN1hw?=
 =?utf-8?B?WUhxTG9oVkdRcEI0YW8zc0RPRWhXS2RrZmszY0lMaUdJNmwrcXpXYXMrL3Ix?=
 =?utf-8?B?WDIwSVRPb3VBUVQwSEY2VVNaSitzcVdvK1A4N3NaS1cyUi8zdWpDbmE1RWFo?=
 =?utf-8?B?djFiTmZqamxvOG1JNjZ1L2JTbW1zaUUwSWlFNDlQaVRLeEpQOWRxNEJWUDRV?=
 =?utf-8?B?ckFadmtzc2FzYml2Y1RZK0R3QWI2U21PZSt4SjFOWDQrOGZ4ZTRQdThoRXJp?=
 =?utf-8?B?MFdXTlVnM1l3ZEQ3dS9xNXFybDh0NVh1Q1c4OFNVNjhwQm5RU2R3RnJRS21j?=
 =?utf-8?B?dDJGZDJlM3BCNHhxWndjRzVid214UVhvWXdnc3F4WHEyYkgvZURId01OVUpL?=
 =?utf-8?B?bmNMWEtIdXVMdTc5aTVjWEk3Q3drVzk2bElqS2hsYlNCcTN6Z1BMV3YwdTMx?=
 =?utf-8?B?V3YwVlE2VldiSDQrZ2dJdmpaclpnYlZFZG16Y0pCMHRwKzFGa05PZEVSdWhN?=
 =?utf-8?B?eXJrVGFLaGFLWldLRW1YMitEVG14WCtWcU9WWHI3OVFpRjZQNkZHQzFiTTJi?=
 =?utf-8?B?N21vUnNGWUJKcTJ2ZmFLL3lwN1ZvMFFUK2Y2YnU1T1daSWFTUlJOOVB4SEJm?=
 =?utf-8?B?cEc4WGFxcUNkSXQrRWU1eGJ1L25PRGpQaEUvTmk4Z3VWVjg2ck56YTAwbTZR?=
 =?utf-8?B?Y3VYb0VwZDJEQ3N5aVVlcFBmeU1hcXNRcTNrTWxZWkw4UmUxYml0U1lOWDYv?=
 =?utf-8?B?UGxyMWpoZHZIaUN6aWh6OUQvalJMMFRob0xSMHVTRE5kcnpVR014Tkgra3Jl?=
 =?utf-8?B?dXgwZnhJUXNDRmszRXlJbEJUeXNqY1hyWlAwWHVZZlBqMW1BNGpZYWIrYlA5?=
 =?utf-8?B?NkJHNWg1YW1NM2kyaTRMTmZkNnhjVjhybThtRUt6VmFhL2xtdXd4d3lkcUIr?=
 =?utf-8?B?Q2RvTXhBbFhaTS83L0VNa0xMeFAzMmlJdVgzTlYrQTBYM1MydkYzMCt5K3FZ?=
 =?utf-8?B?eU1hSVlYVzlWUk55Z011bkF1Ym4reTVUVy9sSFlxbkEzdGxjL2hpS1QxTnBO?=
 =?utf-8?B?Z1JxcFN1OUtlbTJOUEJkSkRQUXNnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b7872c-e0e6-4d63-c9f2-08d9afe4fd47
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 07:27:08.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTiR4+ooiZ5tfzSlBpu7qTJ/su3WzIRdLd4XPYJJGellJi2e2RkPmMuSsLsYuHeJAQgpyJYMSl9NnRguUhTk/XJnVSvzB32YoQkfUk9QK84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3412
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

thanks for the quick reply!

On 23/11/2021 18:42, Pratyush Yadav wrote:
>> In my opinion, as I look into Micron or Macronix datasheets, write_proto has little to
>> do with erase_proto. (there is currently no separate erase_proto)
> I think this just worked for most flashes since both writes and erases 
> generally use 1-bit mode. 4 or 8 bit modes are generally used for reads 
> only.
> 
>> Before I come up with a totally wrong patch, wanted to ask your opinion, how should
>> it be solved, what do you think?
>>
>> I do not see any erase-related tables for this in JESD216C.
>> I also cannot come up with an example of a chip with erase != 1-1-0.
> See Micron MT35XU512ABA or Cypress S28HS512T (in spansion.c). Both have 
> erase in 8D-8D-8D mode.
> 
>> Shall I hardcode 1-1-0 for erase?
>> Shall I introduce erase_proto? What would be the logic for its setting/discovery?
> I think introducing erase_proto would be the sensible thing. You would 
> have to see if we can discover erase protocol from SFDP. But my question 
> is: is that really worth it? Do you really need that little bit speed 
> boost you'd get by transmitting write data in 4 bit mode, since the 
> large portion of the time would be spent in the chip actually flashing 
> the data.

The problem I have is not speed, but totally not working erase. And I don't want
to downgrade write functionality for other chips.

-- 
Best regards,
Alexander Sverdlin.
