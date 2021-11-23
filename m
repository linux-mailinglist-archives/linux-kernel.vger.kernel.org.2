Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5253459D02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhKWHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:49:04 -0500
Received: from mail-eopbgr60132.outbound.protection.outlook.com ([40.107.6.132]:53429
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234136AbhKWHtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:49:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcwaRruPBVnlsyrmKr3u5c+RamwQ8ag4NdTUSHZ4nPKsOvEF1zDYRlNkwfZXp3oWYstybcZPjKMk2AB1u/4NFKlVUbuVfbf3fn/Oc0Whg4MqHZ1y9WNyo1pRlznS50imfgzQxwZ5vgHKaCgBqiQC6Mh1euxRNLfXuTEeoAVpYdTck1l4PtgabmdZKR8M2o65aHO3BRcjb/tfjLzSPlD5GpRBCvz67xnRL4KH1v5hrnR2798hRKQzjojXE04RDPf8mJeQUlPVnP1rOLdu8YgKuAUTsDUv+2MFm0yM5w8C5bIZTIMRjTRyd4yghQiJ6wOmKMJ1FvDxR2/nGwdRxHzdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hIJzt+o9/+eZp0It8gp8hTsCXGtedC4rnSIkMVlJi4=;
 b=NMBzvr0+1ectWdg8eGpqop0mMb1lUalgheZ6QjNvXY919+01RetLiQl7QZgQ/OdqBaLBQS7naGwKkbGCjiVX+RDZtApfNLFbnIPIbVBgE1sAZ0pgZ4dcCcDlR4Phjl4Y3JFcW/H8QWZtN8YEsPUAXO9FhDM+AtLw7J+pUXDjamCfTjeEVed/WESoISmSwoq2HOJNx4ryvOi0OwyNUbep0Abb/LG6dxoxbSFoSZx6XAIjHZ0vdoK62iroA2U0+WeMQJJPQY5hZfUme4IRgEttAihqarfSKvSzlVOIumQeN7tdBcJyrx/AaN5J/+q1cdeu8LTShtMvV1CvWZwPV+wJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hIJzt+o9/+eZp0It8gp8hTsCXGtedC4rnSIkMVlJi4=;
 b=roNrzhh8dXUW/uNpFGam78M+mE/wucHUNzXWtHNzmYqdOMc713+zikcRqEOuUWnpwjeSPXJSn0FmPCbi9KmSC1BmVYMlVmugRTW+4TBrDbN1iCfpdROZy/ZxrSNBcK94QmfaTHlOidGsDSRguMlKGznl1vBa9ufE6VWwZrVT/+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM4PR0701MB2212.eurprd07.prod.outlook.com (2603:10a6:200:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.16; Tue, 23 Nov
 2021 07:45:54 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f%7]) with mapi id 15.20.4734.019; Tue, 23 Nov 2021
 07:45:54 +0000
Message-ID: <2bf37a35-1ccf-f4fa-c999-42b9154a2914@nokia.com>
Date:   Tue, 23 Nov 2021 08:45:49 +0100
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::42)
 To AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (131.228.32.166) by HE1P189CA0029.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 07:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b310a148-a753-450d-bbde-08d9ae554703
X-MS-TrafficTypeDiagnostic: AM4PR0701MB2212:
X-Microsoft-Antispam-PRVS: <AM4PR0701MB2212F5D6D8EF42EBFFDFC7EE88609@AM4PR0701MB2212.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1jRdEkbzA8AYk9Ia2Q5mY9wOUVG3ZvrRpkqse8/pqMHbMZ40KOv/uI0UxYL8NL3uYnytMH5SIuwS+AHheUt7HpUF3Roat0nGTNC4GPIewQuZt/SkbVcaPqQBICcNsIKjoSRSerJQCKYjjBTBlBaF7PGeMjGRAtjPz6pas4p/G77yLX1ePD63PuDfiXIvdGTRED8JQ74J33/CMzhf9T3RgC5xMu6FxOuZykOcBjeOhDJ7lOuDfEHYO4QtwBs9nGsflLcD8KjWOrj5TiyjtcaDJRH5BRaaUMLUZW+HnUTgyt2Mb8mUC/DipZ7ZsIm6FkN1B5fr/UUIoSBKOU1MqgZ4DKEyr028qqJYMwB4xLri1/7cWoqyr5M/WBh04RZJwd/j/6HBwVOv1NDVMAq+Fuqvwdf0yzU9RuhFe9whupFw9Q5NaOcf8HYjPf1qEmzCoObO3Z2rdmwr7AvXnpGQ1iFhK4MVRA1OG4zEqi26yiLITZ13nsTrzBs/F8bdpk0dOsJDfOqrKOwioHjKc3TTOyT1BEtlZ12ehmmrAMR4RyYDKX9ksaaEzH5NU7SD3EX/BapnBSEZlzVzAGzzcfWp1ualN3Mh8T53euhQfc2RsIfRiDEY30IwiBUW9KXIhEZYv+hCemqzKxNCvP7ebeeNENRmA8IZxs6ohQ9V79616xrwfVB6JskrXoS6/dbJnTKk4jrBQZBR8/W31gnUUth9se3Obd/c1k1cCCxPrIND8nkpd5WXf5Ze3R6upnxLMGM0yq+M8GOjCol+Gj2oJTnkeVNRXXRWEBYg+eNs1g5iZWhXi9l240lQX1Ku3qAFMmhHRlPY8qHVxIwBeTGKUdSta0gHXiTLQr/tIiyaDViKVCbTkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6706004)(52116002)(508600001)(186003)(31696002)(54906003)(36756003)(26005)(31686004)(5660300002)(2906002)(2616005)(6666004)(66946007)(83380400001)(4326008)(8936002)(8676002)(956004)(38350700002)(38100700002)(53546011)(66556008)(6486002)(66476007)(44832011)(86362001)(16576012)(82960400001)(316002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW93K2ZVbzZSMFc1VnhIclZOTVZPYzVLZ2VNVGZjbDcrYlZQbnQvSEJxUkRT?=
 =?utf-8?B?QVJ0aUk0TjUrK2NVTUVpTExPTiszNE00TFNjblJnbXpOK0QxdUhKKzZJS2Jn?=
 =?utf-8?B?MXd6RDVRVFNoZlA1UjRJWFNOeVNHWVNmcWZuTkwveXVyR0tMN0tJZEp4VjQv?=
 =?utf-8?B?clNpTEhmdjMzWjVMNlhRSFVhcElEdEV6UXBPaG93ZWpEOWdXVkZtN2xKVkJJ?=
 =?utf-8?B?ZmdrZkZTZFdEOS9TR2RGS1RSUlViMGFTdlVzTHErc1U2di9aVEU4ampINndj?=
 =?utf-8?B?ZGx3aHZsQllOUWpxWEJKV3ZZOSsyakpXNVRrTHFmb2pnNlNWejlXOU0zMmJq?=
 =?utf-8?B?TVNPU1FKd0xjRVN5UHlLNEhRV1d1QlVZZVpPeEZ6M0Z3YTA5VTh2TkJIV09v?=
 =?utf-8?B?endNUDdhN0VmTU5ML3ZpQ2k4Y3ZBT084d3YydmIrVkdKQ25WMWgvWHBnRFBK?=
 =?utf-8?B?anJGTlZYWVNZTFlvRDZtcWJxQk1DODdEMEZGR205MXpPZTNzcHo3a3ZvSjFz?=
 =?utf-8?B?QkVrTXZLRmhKQ1pxK1A4YTV5VDFIVTdEWWFqNkJ4bGVqRmR5YWtraStxU2JK?=
 =?utf-8?B?MmJiZjQvRWwrdkhEQVR5RnI2Y0pVTEJhRXRoZVRoUjc3aUlPL0tqTUhGWDFm?=
 =?utf-8?B?SkRtZFhmMk1lQ2gyWnBWQ1NaeDh4aFhKN1BnZmN6eEFESG9PQXg4Rk9mR0Js?=
 =?utf-8?B?T2dBYSt3Y2J6QmdGMHdDMGlTeno0cjg1aDh0NkhoTXBjTFpOV1BCN0psOGtN?=
 =?utf-8?B?dzhwK0pOZkNvNHFrZGpKR2MxRFZHQ3hRc21XeFFGMDVXcTNLZmtNMUhwd2M2?=
 =?utf-8?B?RjZtOTlZdDZOOGllSWhLZEl0aVIvTG5SaHdWOU1JcmRPdnFNNWV0Q2R3T2tV?=
 =?utf-8?B?a0o5YktoNkxObzd6Q0tiWEJ2a2Z3UzBDQ2N3WmI4SHZqajZJSzJSNnJTSWs4?=
 =?utf-8?B?MHZtSjdWRW9WNHpRM0ZSMXBXV1BWZzhXNTV3SnFhV0hSbjR4V0N3ZEVwbkh1?=
 =?utf-8?B?T1FXS0RnZnJIdm5iekJvTTVlYkNadExwMDBpY0dpZ0h3K0ZIMEhLTzg2ZFF1?=
 =?utf-8?B?MC9OUTlJcFhYejFmeFplTVR4KzhqbTNsekZZVzdQRytYMmtCK0x2dTExKzhS?=
 =?utf-8?B?WHRGVGNTSnNZRmNISW00K3dlSDdTZTg2VE9vbi93K2h4Y2g5SGJyZzBoaFZH?=
 =?utf-8?B?b0JBaEJ5Nmd2YUcrNjlwREpRNEEzQk4vN0Z1KzVEcjEvYUNtUUJwVVNFN1pC?=
 =?utf-8?B?WWZRSzdPUE1heWtodE0zSlhyMnozOFVYY1NNMHlzWm5EOGxLL3h4Z3dLTXds?=
 =?utf-8?B?U05QOTliNW1CM29ESVp5RVNDMjViR1lNNUc2NGZRaUFiRHRSeW9tcXpDMnVw?=
 =?utf-8?B?elJ6bVJ1VTVwZWVYYkR3dHczVFRKekY4Y0pwTStOaTZ2TW1jUWFnY0JGdTkx?=
 =?utf-8?B?QXl3V04xQUZCRGJHK2h5YlgyT1lVZHJvWERVU2JyUTA1dG8waXNhMmxVK1FL?=
 =?utf-8?B?Y3NlWG95aG0vMFMvNW5WaXkzQTlPOVdSbTdqU243cnFTS1VVY2ZlUTYwUmZE?=
 =?utf-8?B?YWVxazY2V2pXZmlpUjRpdENCY3B1TytxUy9qcmNCaGJwdFlDL1cwNFFlQ0l2?=
 =?utf-8?B?QlFwaW54Mk1uSUZVbklHR3Z3RUh4V2ZuREtnZG5sL0JIWG9SQ2l1cFZNUmpX?=
 =?utf-8?B?VG0zZkpBbnhnanVkZGVmdi9aQ1U1K25sN0x1QnltRXdWWUZMTDNUay9KeExD?=
 =?utf-8?B?bXpjc2RHbkhBWkRjQUFWcS9OUGN5OURIVjVFR1FvcmRxeFloTk9IUkhZWHdj?=
 =?utf-8?B?eTBacDhLWjhla0NrdkFWMXFTUDd4VkU5VC9xUHpuNGI2SjdxMHNMejZjUXVI?=
 =?utf-8?B?WmJnUWxtVUp0eWxLQTNLbnFFRytzbTJxcTBXaU9TM3NsbTlPdHRCM1dNNHdJ?=
 =?utf-8?B?QzY3dndzWUUramtiRmpNSzNxWGg3dklqZ1dNNmR1NUhEN3FhT2ZTY3BDdnNU?=
 =?utf-8?B?ZjUyckJ2ZVNSWGtqUzFyVVBnM0U0QjgydWprMVlFb0ZiNURnYWc3VEd3aVZp?=
 =?utf-8?B?UWFSSjRiYmFTMW1XdytsR1lmN3puVzdZQ0hLSmg1aGgraUdyeWpQQmp4MmZY?=
 =?utf-8?B?M1IrUEZldXVpNWVPeDlQZUtEaVR1dldVOVUzQUF0MEF1ZXVPQzJteS91L3p2?=
 =?utf-8?B?NkdieWExVXVLRnIwZlpteVpLSVJIYWhQWHlnZS9seksya1NNdFpSNTk4cGNW?=
 =?utf-8?Q?pFnNBvKDN9yy2KqGgr2aaDBBMEBfdbaz0uBm2xsdEo=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b310a148-a753-450d-bbde-08d9ae554703
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 07:45:53.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IuPv+jTZYcsnfUKt0Z6TEjZKJxM1FTwg3SBz2rsFJ75WJlfV6XG/0B0So35/R1wcyHd8GmC7EmVU5F40Z9NcgekYgTZvoKwQyHILmNBNRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 22/11/2021 16:05, Michael Walle wrote:
>>>> Ignore 6th ID byte, secure version of mt25qu256a has 0x73 as 6th byte.

...

> Thanks, so that's the SFDP data for the mt25qu256aba8e12-1sit part. and the
> jedec id is 20bb19104473, correct?

Yes!

> You don't have the non-security part by chance?

Unfortunately no. And this is exactly the trigger for this patch:
one can get "secure" parts from Micron even though these "features" are not
required.

> Mh, I'm undecided whether we should just duplicate the entry or if we
> should ignore the last byte ("Device configuration information", where 00h
> is standard). The commit which introduced the flash was 7f412111e276b.
> Vingesh?

Some people ask themselves why this table keeps growing if there is SFDP...
I see the point in fixups, but maybe at some point we will be able to support
some devices just out of the box?

> Can you elaborate on the 0x73? Is that a bitmask? If it was an enumeration,
> I'd assumed it would be 01h (or some smaller value).

This "security addendum" where one need NDA just says "73h = Secure".
There is no explanation for it and no other variants.

I'd really suggest to try to autodetect whatever features are going to be
supported from this chip and only duplicate the entry if this auto-detection
fails.

-- 
Best regards,
Alexander Sverdlin.
