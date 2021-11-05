Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B9C445CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 01:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhKEAEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 20:04:06 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:36736 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhKEAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636070485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7QY/XlVsT0vawCv/QFJhiRhRxopeU3pdgQVnH1T4G4=;
        b=FURgO39Pjp0Fi3511vwg3MSsFof4+LQwC592dF8ScSYJ2a15ydmZ9U9uyOAc7uaX9y8Z3y
        r8HHAHYrmEnmgTamUZHyQHpMWnwdzoBpqnFakrkqEWZx3ZaN8rQxYNJamBNLp+j7KW0X1t
        iA18oKN1DtmQfaLvDrJjjPOd892FACk=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-PTrKwevmOBqT65L9WbaqMw-1; Fri, 05 Nov 2021 01:01:24 +0100
X-MC-Unique: PTrKwevmOBqT65L9WbaqMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl8AxX+FO9k+xdMeZUbIISOKnTFQKiyycio6FUiTXYPYLXWgxX+tVUv/+Pi4D3XKfoTESm9acvZHjrbUx0bkXie6ENpKuXxvW8FX5CFrakGyI6eWxq7w4RG0jPPtFJpe1im0tTMDqCsmrUKsxYdd1mmLWJK1O0flZz6IOZwi5lEcyR3rzgnycPICqu75X+hhHa//QL+xhJTrCgL++1PRrlkU90mNDQYEbPY4iTuIctMRKLURJKYAst3V7X5mwl46inTYkATp3WdJA5S470SpDdO8bT7oMRWOOCl/fsWJnnPCYUMeoMG+Y1RAj9dBVbhWLFrWcjYp7Hej8q0OsxIX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7QY/XlVsT0vawCv/QFJhiRhRxopeU3pdgQVnH1T4G4=;
 b=GFh2w2XQQip2tPHyAZNaVJeTOBP+2n2k+yF/XQMb3M6kObI7FHJecXQPWrXz44SPP1IPm3GSbAx8oU85EX1l8jOJ1EbJm5LiqoSQCXrsJm/CGV97gY/53b7F/ZSGPQVaajj/YcUfKxysyWyPTYlEJvOziQFFzkYgDwIhLapr4nWl2lFkhbcJbiCOguP7A2Vloa0pIad5eGxT8SMsFiVtf89BjmKteTCUZUAyVyD+BYjQP1yMgw0Xi2NtgbGIZ5ljmogl2y9Mgq+Za3MC42KxOz/8Uzg56KiMehm5edAjGiQ9oeOo81Y0+XFX2bWkEdYrvpmWsQ1GslNCyJkqO/cYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3783.eurprd04.prod.outlook.com (2603:10a6:209:1b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 00:01:23 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%6]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 00:01:23 +0000
Message-ID: <f3d3dc5d-dcf8-76b7-f383-aed3c942ae49@suse.com>
Date:   Fri, 5 Nov 2021 08:01:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20211104115001.GU20319@twin.jikos.cz>
 <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
 <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
 <CAHk-=whGUxtcL8Z67y4A6_diSmtQdnOq1p_gyBAMzpKD9yk+gw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
In-Reply-To: <CAHk-=whGUxtcL8Z67y4A6_diSmtQdnOq1p_gyBAMzpKD9yk+gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.6 via Frontend Transport; Fri, 5 Nov 2021 00:01:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f7a913-2bad-45d3-c4a0-08d99fef6756
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3783:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB37835F94F1CD867728ABEC6AD68E9@AM6PR0402MB3783.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2HgyqW+IstNPw1GfLCVx6CFUX9/NJ5ukPaodVnYbadWxWOedCR5qVg2Gj5V/thGW5StK3w/68p4t0oVBw4XZDwxO7ORTqDDBezjpizfcPKgzYft7GhMh3mA1PYc10ucUpX8NOQ30KbU8aerixxFlXufNFooJeBEALABKn9rE98KdIx9HmtE4rt6ekJbYaqUOOr5irrraWRaU9db/PEwZPpLFd1/XVCWLv9KwpuaZ84peHIKmJDot4PvNfor/OvOLK2mC7xmhGamqyMVLDmymq4IeA/W2M4/GU/ih4p+xyFE6BIOHVkHTLjG9uV4YrnRg6DEd/7Ge4wZvbnwskkR4T2bdQjmWmJ+7gj235aH+bBtMUf40pcn6ZW7V10MUrdYM8QNiGiswM5aFLuKz5btb8xlTca391va8gnqr0zZzhV8lXkhbXRD4X3Evu3uB0n+sfq3WF1f5yvhs3ujUQzumyCFATU/IIT79zlGS6YmPR3693jOsisTptvOArekoxTSqF38SCIGQfUdyam+80vfqhuZ1DXp9ekMgRhsfMymOj5KrOXnhVOrAEaFhv5tZ4oczeHcQa1v/s2pTTw+GlVD4bzA5L/oTsWIHjEOzQQfKIvBy/5VwZ+M0GTPg5EPREpLPV5swuTgsBN/F/yIQv1g3NWQ1kuZItuuiaq7k9ewKpcL4F3eEYVENI07Lw4BQClD9qruTOrw/IQgaaWqFgIKrkdmtMV81cdCUT4YMPVMJSsxw+bow+hFQBcLruwduUGOP+deW1khHLZotXFxujd9ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(66476007)(66556008)(36756003)(66946007)(508600001)(31686004)(86362001)(83380400001)(26005)(186003)(6666004)(316002)(8676002)(2906002)(6486002)(53546011)(31696002)(8936002)(16576012)(110136005)(2616005)(956004)(6706004)(5660300002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlJMjdWQ2YrdWFlTTJaTnplWVVMeTUvUWlyRmliYkFWZzRiRG02QlE5WGQ1?=
 =?utf-8?B?T09Ma085NHJxNm1jYkJvMGxHZ0NBby9Eb0VpYVBYd3ZYSXMzdnBuNzFhNHQw?=
 =?utf-8?B?UlRzcGFmWCt1VmpxMXM1UTVZVjhYNEhsZ0g0bnkrV3NFYVh4VHlETHh2T0NW?=
 =?utf-8?B?OExPK0d5enU1SE9HU0tpRVhhekpRNFVBVldjV2RLZGNpTEFSMDFmUDl1UCsw?=
 =?utf-8?B?eUJHaExOT0lpelFRV2ZXcXBwTGx0enVsVVNkRmNtL0JPR0x3OXRBR2EvdUNk?=
 =?utf-8?B?SzBTL2JtcWhkcWtjclBzejNZV2x0V01tNHozc0sxa2d3RkZUbXQrWkRRRUVR?=
 =?utf-8?B?c3dmaWtqcTFOSXAvdVVSaGRoakVxd2QzVE5pUVBOR0d0dUF1U0NYSEZkQW54?=
 =?utf-8?B?M0dLdlpybUxzYmVyLy9tazg2b1BWaEJXQk9vTU03Ty95TUVGNUFmeE12S2xF?=
 =?utf-8?B?dVc0MC9ockhEQ1JKL3BXVGlUZTBqVmt6V3JlOGM5bkNydDYrNGY5OVM4aits?=
 =?utf-8?B?YnJubEdYUEZvaTZjdE1UVHlURTYwYUlkR0dzMXRZajl4aUdsVVV5SllNSnMy?=
 =?utf-8?B?RzhvL2tpV3ZvU0dnSEZvZWhIZm1kdkVaOTNiR05vaW5WY0o1U291b0Jra2g0?=
 =?utf-8?B?S2NwTWtYTVFJYzl5cVRPRE5rYyswR0NyN2x4UnZtRk5XaTdCVkdYcGR2ekQx?=
 =?utf-8?B?TWx1Qk4zVHludzFuLzZCWWFwbVFKdXFoYmFINmNhZ0NVTGRoWU41aXJDWmhI?=
 =?utf-8?B?UDg2eDFZVThaNlpOWVJFdnFzbkMwSVNrSzA5cnp3QTB3YjZVVnJxK3RzNmV2?=
 =?utf-8?B?YWZNMS8rd0VrcjZwR2dGMzNBNUozc3hoalIyd2Q3WkFDVzlZZ0ZybW95MVNC?=
 =?utf-8?B?K0QxM2VrNmYvZnBNSzJ2U0NSem9EWjhHc3RUT3RFRjIvWUJ5cHQyc09ZTWJ6?=
 =?utf-8?B?MWsyTzE2ZWZLWWtpS1llaFB4bjMxNi9GUjFiblZGaElVVGU0ZXJIS2xQOVk0?=
 =?utf-8?B?YWtsT2ZVaFArQmRUWXBrZkIyQ0Yvd3J0a3BORG1sVndFSjFreE50QlE2WFVT?=
 =?utf-8?B?VGpkbVhYT3FqbFd0Um1aTWd4TE9iSm1EaEd2SVlYejlVSjZZaW1ZcWp2cXhM?=
 =?utf-8?B?aUpmQ095VXI5Vm5GK05tU0RrN09tQWpwd0pDQzhWWEZQTk9BQ0FvTnNPQTRX?=
 =?utf-8?B?QVZ5dk00WDdNNFJrM3pteE1CWVlXK1Q5RFNyTWJUL2VCRTVSTEI1QUJyeG8z?=
 =?utf-8?B?VURWU0dSUlo1VEIzLzNVbU5VMDUyUy8yaWg0ZmErSFY2cUNlZzgwczgyVjlz?=
 =?utf-8?B?cmVQOGdaOE9YTzdzbTZvdHIyQk1tRzJvRHgwZHJhamZHSU1PK25ZeWVqOXJN?=
 =?utf-8?B?MGVlNXdQK3FKdE0wMUdlWm52d3ByVWN2N2RPd0tWNWY0SXJ1cHdPdkcrK2F1?=
 =?utf-8?B?aTRWMGNhZXlhWE4rMjJaZnF4a1RxaGZ5MlJVVHRKQTJ3U21xZ3QreW1CWE5o?=
 =?utf-8?B?UzVXQkFodTRLY0k5ZHB1K0F2RnlINHFRZmd2bEdhS29Zd0FWTWduVHZPa1NR?=
 =?utf-8?B?aXlBWlpjSVp4OTV1emw2T01OY3o4M2FERmZINDU0UVF0NlVZekpHbDhMS3pa?=
 =?utf-8?B?TndHbUJ5R2Rhd0ZhV2RvamtMR05GR3A3aHFKUERWUkQzMzR0OFRBSTBsd2Zv?=
 =?utf-8?B?a3VESWxNeFE2T250TkJLUWx3TWhxaUIyK3Z6OW4vcFExakp4Qlh1OFVHZ1JO?=
 =?utf-8?B?WG9oZDJtc2UvbWwrNzhqeVZIRE9VVW9YTXRkTGJvV0l6cTZxTFUybEVlOGUx?=
 =?utf-8?B?Sjd6engzKzhVZmZTS2ppa3JTNW9RVDJaeWM2T24wWFB4SVI2eXlUc2wzV3F4?=
 =?utf-8?B?YjRpZHdLckRsRDhmandCekFuZGNYNXNLMTZ5a1JDU0RleUJqR0lBLytiYm5M?=
 =?utf-8?B?UmtQOE8rN2tsejRkUXdaUkc0czg1RjFyMHVvU1lQcDE1Umt6R0RENktPQUFr?=
 =?utf-8?B?Ry96MmhxV1dncGl1S1FKcXVneklTMFQxbGhZQ0xJUXZYRDBMNm9MTW14NGl5?=
 =?utf-8?B?NHlNNEE5RzZCQmpRaVZFaGRjVDZVUmQ4bjJhdEplMGRUNEVOaGlVTGo5TWZM?=
 =?utf-8?Q?Or54=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f7a913-2bad-45d3-c4a0-08d99fef6756
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 00:01:23.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKLoGQtFm4WiEgIpYwsxdySEv4n/dodv+r1ur6/yFiR6iktXQZyHT6Kpxliy9FBK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/5 07:48, Linus Torvalds wrote:
> On Thu, Nov 4, 2021 at 4:37 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Having looked at it once more, it still looks "ObviouslyCorrect(tm)"
>> to me, but I suspect I'm just being blind to some obvious bug.
> 
> Oh, I was just looking at the pattern of kmap/kunmap, but there does
> seem to be a questionable pattern outside of that:
> 
> This pattern looks odd:
> 
>          kaddr = kmap(cur_page);
>          write_compress_length(kaddr + offset_in_page(*cur_out),
>                                compressed_size);
>          ...
> 
> (and then whether you kunmap immediately, or you leave it kmap'ed and
> use it again at the end is a different issue)

That part is paired with the the following code, to prevent we cross 
page boundary for the segment header:

	/*
	 * Check if we can fit the next segment header into the remaining space
	 * of the sector.
	 */
	sector_bytes_left = round_up(*cur_out, sectorsize) - *cur_out;
	if (sector_bytes_left >= LZO_LEN || sector_bytes_left == 0)
		goto out;

	/* The remaining size is not enough, pad it with zeros */
	memset(kaddr + offset_in_page(*cur_out), 0,
	       sector_bytes_left);
	*cur_out += sector_bytes_left;


So we always ensure that each segment header never crosses the page 
boundary.

This behavior is a little tricky but is part of the on-disk format for 
lzo compressed data.


BTW, I also thought that part can be suspicious, as it keeps the page 
mapped (unlike all other call sites), thus I tried the following diff, 
but no difference for the leakage:

diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 65cb0766e62d..0648acc48310 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -151,6 +151,7 @@ static int copy_compressed_data_to_page(char 
*compressed_data,
  	kaddr = kmap(cur_page);
  	write_compress_length(kaddr + offset_in_page(*cur_out),
  			      compressed_size);
+	kunmap(cur_page);
  	*cur_out += LZO_LEN;

  	orig_out = *cur_out;
@@ -160,7 +161,6 @@ static int copy_compressed_data_to_page(char 
*compressed_data,
  		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
  				     orig_out + compressed_size - *cur_out);

-		kunmap(cur_page);
  		cur_page = out_pages[*cur_out / PAGE_SIZE];
  		/* Allocate a new page */
  		if (!cur_page) {
@@ -173,6 +173,7 @@ static int copy_compressed_data_to_page(char 
*compressed_data,

  		memcpy(kaddr + offset_in_page(*cur_out),
  		       compressed_data + *cur_out - orig_out, copy_len);
+		kunmap(cur_page);

  		*cur_out += copy_len;
  	}
@@ -186,12 +187,15 @@ static int copy_compressed_data_to_page(char 
*compressed_data,
  		goto out;

  	/* The remaining size is not enough, pad it with zeros */
+	cur_page = out_pages[*cur_out / PAGE_SIZE];
+	ASSERT(cur_page);
+	kmap(cur_page);
  	memset(kaddr + offset_in_page(*cur_out), 0,
  	       sector_bytes_left);
+	kunmap(cur_page);
  	*cur_out += sector_bytes_left;

  out:
-	kunmap(cur_page);
  	return 0;
  }

Thanks,
Qu
> 
> In particular, what if "offset_in_page(*cur_out)" is very close to the
> end of the page?
> 
> That write_compress_length() always writes out a word-sized length (ie
> LZO_LEN bytes), and the above pattern seems to have no model to handle
> the "oh, this 4-byte write crosses a page boundary"
> 
> The other writes in that function seem to do it properly, and you have
> 
>          u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
>                               orig_out + compressed_size - *cur_out);
> 
> so doing the memcpy() of size 'copy_len' should never cross a page
> boundary as long as sectorsize is a power-of-2 smaller or equal to a
> page size. But those 4-byte length writes seem like they could be page
> crossers.
> 
> The same situation exists on the reading side, I think.
> 
> Maybe there's some reason why the read/write_compress_length() can
> never cross a page boundary, but it did strike me as odd.
> 
>               Linus
> 

