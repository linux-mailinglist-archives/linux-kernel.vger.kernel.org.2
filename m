Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCF3331C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhCIWwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:52:12 -0500
Received: from mail-eopbgr150128.outbound.protection.outlook.com ([40.107.15.128]:58432
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhCIWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:52:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNkzCiv7WVeM+KqOl0cc7V8aK7VvYbZzbeHXhJ3lzw2lghWGr+C6Nc0NrjIzaicwv2yd8AdI9FMIRW7404elxFD0IE0zzff+v0pSRj/XadAK0I8OkFc9SPriSpJOT75rebbcA4mPQZySBsvHL5NoXVJ+STh5xOBEf4PVLbHgmihQAh6P3+p8e2Fn7OcKDGYugi6GaNPUvhQvINFiZTbcuOQwAZxfVQeOy+ddbGG719FlO09wMtx7n6++BI/chIp2PxZcssPgI+sYtK/IxnuFbeTT5fpzrCs7cg2vkd8ZFpTe3OnSmaIl+/tf/dj+4OXMy387c8Z2CssdPvyNZw+Xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq8ypw7Dq1JJ7QiLM6CmTh2ZUx+iFC8QVUChoT6+XXk=;
 b=ail3phU2+dK+Ut4k6Yb+3Y47bzoXx2IIxBmTN5F8uxdxLylGVT6e6pZgeXgboGYrpBc/wY0+TRsxZ2G9Jd5gw+wON8oHEVb2wMGGIEF3vWvZIS62GOaQ8vaV3+sdUwoQs2toNzPY2jpxIztgqQQmw47EQKijNWNTjD83sD+RX/vaW6+dBZjDCZt2lCDBjMIfID84Xv3/U4kjqKzwIl1CSgHPPd9cDdRqBWf5UoMgDblK0zKENz8a7sNm23WWuOh404075NUvAgeUMPNC1pQCsEwEI/e/x9CMRoENiLVCXrjKvBHDV1JkIgcvQSekBWC+VhBd0Kk8tr3SbQkZffy32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq8ypw7Dq1JJ7QiLM6CmTh2ZUx+iFC8QVUChoT6+XXk=;
 b=kDayy8Q0+YM/+BFPCUgtjJMhiq+jyK5YjogPj6I9QqjbRpnd8mInZc/WHzAoTJFtUWAeCQDEYpANvQrZZo4rLHM0CPJqNwtEco7X+KDXiAcoWnX7rfPnCiph5hmvscQT6JDQMUEJ37TM/JeNP86f59Ad84JuS/VWuqeWQFLW59g=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 22:51:58 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 22:51:58 +0000
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <d2a5e8a7-4093-4fcd-706a-430450014336@prevas.dk>
Date:   Tue, 9 Mar 2021 23:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.248]
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.248) by AM0PR02CA0024.eurprd02.prod.outlook.com (2603:10a6:208:3e::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 22:51:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc59e992-f756-413a-6865-08d8e34df1d9
X-MS-TrafficTypeDiagnostic: AM0PR10MB2625:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2625EBCFC61E17402BC8DD4993929@AM0PR10MB2625.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3N2e7n/GHLSH5Z+NcdoEf7+uXP3hlI7c4ElhFME16U4x7o73qlhTT2MyI24xRc+TUvcBFdQ2DksBijP4bHg7VyVutV6627fCgkjX+6YqmM/LmQgElZoFrWlbmSAUzGiraF8uHWU17PYH4JiDceAHoxSSnnDpozYWdzKT960KvsF9g+mNWv+9ok5bLe5tDb8spm7fuqidvplAFXhGrXnUfBfLz8hoNlITv8AwhXOo5o9N8s3XhDr5feaCqKxAaDAiganLc0gxfHAT4HBP/fBDtA8lbOpejDj2sdElm3MqkxjymmqlkUj2brmMume8SWTP++mv694egwNSMSBJR+2QMPEXIlza7AS8ZQT23qkbrTVt8CaV+tUz6a2IbLYZb9ld7dBXnQ6Nu90fFYpc/DpDHaXGepwkXTLkclB9zTtK6qMTUkSiruhiviQL2Exg8NgejylJu/Y/UvbCUDE4oeEtaFKzPTNTxPwpzwGgYHy4MqWbQR4TWCXaund89vvQ5QE/GS4bu65vCpxpkv5+VAQyo5RDn0GnjCCTFYBV+PW56Oz5JKs1Qi16ElabGuNgN0pMx0bCeLVlLe1Rvcgit5pW5hHTyBqkf4kWpY+8Yyj1Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(396003)(39840400004)(16526019)(2616005)(478600001)(8936002)(956004)(8976002)(186003)(44832011)(83380400001)(31696002)(66476007)(16576012)(316002)(66946007)(66556008)(5660300002)(86362001)(2906002)(54906003)(4326008)(110136005)(6486002)(8676002)(26005)(36756003)(31686004)(7416002)(53546011)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VlRwSjBnQ0ZpakYrbzRXa3MzRllpNVppa1k1R0x4QU5GQ05ITm5mUVZMVHF5?=
 =?utf-8?B?YW5LQnNSVlI0cW0zbUhzRi8zUEdpemZQSXRweUw0SElRc0pNVWx0ZkVnVmZM?=
 =?utf-8?B?aVhIMS9kVlhXV3ludEtFd21EbmJtRDVEUlJaa2sreU5Udml6L2lmOG1ROWdt?=
 =?utf-8?B?SzJFWVRBUmFKZkc0VFVPaUVpUFRPSHRYL1dycVdKK25Rd3lVTzNscnpGY3A4?=
 =?utf-8?B?MTdMR0VjazZ1WGxMakdZUnAvNkZ1bTR1eG51MGVTaStzSkNuR0J6NHBOa2d1?=
 =?utf-8?B?aWZDaGlWNUNyVFFiNXNGQ2lNNzJ0UVpRekVwYTU3YUtFS0lzVThRM2dSZmhk?=
 =?utf-8?B?dG9XcW9HSDltSTI5dWoxTTdZcE9TYU1oSFUzUlF1TEV5VUE0amVBb0J5V21n?=
 =?utf-8?B?N2pQcFFEdy9YaUFlMmZ5b2FySGc4RXpsVHZPdFNMaVNwemx1WGxHMit4TTkr?=
 =?utf-8?B?RXJVMVJxRzFBS09NQ3dwd05xeTkxS1BOQkRzcGVJaWNLaThubW5UdVgzSDI5?=
 =?utf-8?B?VmhmYU40dFBvVEdNR0xjVEI5Y0I5S2FlSTdEbHpRS0pMZ2ZDWVFJL2poYUdR?=
 =?utf-8?B?cnY4MmV2NTM1OTRQVlUyYnhSYzR5Y0lOSklzcm0zbFBSRG1WcXlMcTlXT01z?=
 =?utf-8?B?SG50QmtaN2RBZzh1RFBtR0tkTG5OdXFYQ2NmdTZuQ2xQLzNyQVRlOHdOSnFs?=
 =?utf-8?B?ZXo2L3A1dHJyRGVoSGo3WVFuY1cyVUdqazM3NjFIdEcwS1NPdm5RdUJJS0h6?=
 =?utf-8?B?RWNOSWZ4ZzljV2pUdXJxazlnenNOaEFRdUY4d2VZQ05lV1h1RFh4NUFDVnhL?=
 =?utf-8?B?dmZPOGdFNzZxUkFJWS9OSWNHNVI5ZHpmRGtVUDA3dzNjNSswYW1oOWw5NmtH?=
 =?utf-8?B?Zm0zOC8wc3RVQWpwc2JlQm9STG5mb1F3THN5SmVSZThwVHlYTlJWUGxTRkp6?=
 =?utf-8?B?TzgvTHdDR0RyQms3OWFZVndPUDZrc21xSmNJc3BpREJaMUorWm1sVTNIYno2?=
 =?utf-8?B?aTY1K0loSUxKT0I0bEV1OW1xekxWUW1OYzhCT2J0RWpjaGVxMjhLNkVsRW5X?=
 =?utf-8?B?TGlNWW9zRXE0TEgrb3ErVjNKSklMZ1QrYi9TcHlwNTlKT2ZLRUhkUlo0Wlo4?=
 =?utf-8?B?eTZySUpkcEpLaG9QMll6NXJ6WG5hMkcrN1BLT1R2akQraFZjUXpyckFEcWNv?=
 =?utf-8?B?cVZabE10VnZENEFGMFM5bThRdXNLSjc3Zy9JQkd4RDZuRm9raWp5U0x5ak9P?=
 =?utf-8?B?d2pnUGthczh5YzZUYTNuSnlpMmErQmhPcEZmbERwVnRwZnJTL0NaK0hHV2k4?=
 =?utf-8?B?OHI0azhibmVYOGhUNG1XT3JoLzBVVjNHZG1nWG5ZVGJaSWhQTW9zak42bkRE?=
 =?utf-8?B?NTc5THllVkQ4RlF0a2VGNFNyT0pIbVArKzFEUzEwcDJOWnczRUNya0VyeUNG?=
 =?utf-8?B?WXdCeXZsYlVRbDVJUm0xdWhIdy9Pblo3Y2c1akpVQlZzTUJWTE1CNTcvTlB3?=
 =?utf-8?B?NUZCYW5aUFdDbElHcW9vMjFUT1NpaHhoS1ZGeWlUV0xDWGE3M0pXa0haRXFk?=
 =?utf-8?B?UitnbVRYVFUrTk11UndXRDFic2RPeDNkbU1DellkbTBzdU1KTDZqVFpQU2xn?=
 =?utf-8?B?eUJ5WUdjNFdpSnNZTXhJVXpwRHYxQm1WVk03c3BzWXZaanozcVdJOFg5cWc1?=
 =?utf-8?B?a3dsay9OcFdqbEJHSzUvR1RUMys2VXBnRGp0VjlnYzBLN0ROeUZ5N3BPRitZ?=
 =?utf-8?Q?y4ifqF9OGTsruwaupVWaxUwIUuo6xxu67i48tEV?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cc59e992-f756-413a-6865-08d8e34df1d9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 22:51:58.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyxaVeM99aWJPlB7GQTmLNIk27QSJabWKL9jyecabpeCNDxDauicV51o9O99NN9VZeVCD+aZAXsDk2/X/AEjLQEFDiwdo6KEbFKLGD8uUbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2625
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 23.16, Linus Torvalds wrote:
> On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> So add an initramfs_async= kernel parameter, allowing the main init
>> process to proceed to handling device_initcall()s without waiting for
>> populate_rootfs() to finish.
> 
> Oh, and a completely unrelated second comment about this: some of the
> initramfs population code seems to be actively written to be slow.
> 
> For example, I'm not sure why that write_buffer() function uses an
> array of indirect function pointer actions. Even ignoring the whole
> "speculation protections make that really slow" issue that came later,
> it seems to always have been actively (a) slower and (b) more complex.
> 
[...]
> Is that likely to be a big part of the costs? No. I assume it's the
> decompression and the actual VFS operations. 

Yes, I have been doing some simple measurements, simply by decompressing
the blob in userspace and comparing to the time to that used by
populate_rootfs(). For both the 6M lz4-compressed blob on my ppc target
and the 26M xz-compressed blob on my laptop, the result is that the
decompression itself accounts for the vast majority of the time - and
for ppc in particular, I don't think there's any spectre slowdown.

So I haven't dared looking into changing the unpack implementation since
it doesn't seem it could buy that much.

Rasmus
