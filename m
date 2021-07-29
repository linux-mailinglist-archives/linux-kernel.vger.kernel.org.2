Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401CD3D9D71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhG2GEQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jul 2021 02:04:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12329 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbhG2GEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:04:15 -0400
Received: from dggeme716-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gb0Gj5y46z80H3;
        Thu, 29 Jul 2021 13:59:25 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme716-chm.china.huawei.com (10.1.199.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 29 Jul 2021 14:04:10 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 29 Jul 2021 14:04:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH] bitmap: extend comment to bitmap_print_to_buf
Thread-Topic: [PATCH] bitmap: extend comment to bitmap_print_to_buf
Thread-Index: AQHXg+KZwXR9e68Y4UCjnNkvs7pIuqtZca+A
Date:   Thu, 29 Jul 2021 06:04:09 +0000
Message-ID: <eec4210a5d724cccb2931a3f4403e5be@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210728185831.215079-1-yury.norov@gmail.com>
In-Reply-To: <20210728185831.215079-1-yury.norov@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.210]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yury Norov [mailto:yury.norov@gmail.com]
> Sent: Thursday, July 29, 2021 6:59 AM
> To: linux-kernel@vger.kernel.org; gregkh@linuxfoundation.org; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Yury Norov <yury.norov@gmail.com>; dave.hansen@intel.com;
> linux@rasmusvillemoes.dk; rafael@kernel.org; rdunlap@infradead.org;
> agordeev@linux.ibm.com; sbrivio@redhat.com; jianpeng.ma@intel.com;
> valentin.schneider@arm.com; peterz@infradead.org; bristot@redhat.com;
> guodong.xu@linaro.org; tangchengchang <tangchengchang@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; yangyicong <yangyicong@huawei.com>;
> tim.c.chen@linux.intel.com; Linuxarm <linuxarm@huawei.com>;
> akpm@linux-foundation.org; andriy.shevchenko@linux.intel.com
> Subject: [PATCH] bitmap: extend comment to bitmap_print_to_buf
> 
> Extend comment to new function to warn potential users about caveats.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---

Looks awesome. Thanks, Yury. I have integrated your patch into
the latest series v8.

>  lib/bitmap.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 56bcffe2fa8c..b9f557ca668c 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -545,6 +545,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>   * mainly serves bin_attribute which doesn't work with exact one page, and it
>   * can break the size limit of converted decimal list and hexadecimal bitmask.
>   *
> + * WARNING!
> + *
> + * This function is not a replacement for sprintf() or
> bitmap_print_to_pagebuf().
> + * It is intended to workaround sysfs limitations discussed above and should
> be
> + * used carefully in general case for the following reasons:
> + *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
> + *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
> + *  - @off and @count are NOT offset and number of bits to print.
> + *  - If printing part of bitmap as list, the resulting string is not a correct
> + *    list representation of bitmap. Particularly, some bits within or out of
> + *    related interval may be erroneously set or unset. The format of the string
> + *    may be broken, so bitmap_parselist-like parser may fail parsing it.
> + *  - If printing the whole bitmap as list by parts, user must ensure the order
> + *    of calls of the function such that the offset is incremented linearly.
> + *  - If printing the whole bitmap as list by parts, user must keep bitmap
> + *    unchanged between the very first and very last call. Otherwise concatenated
> + *    result may be incorrect, and format may be broken.
> + *
>   * Returns the number of characters actually printed to @buf
>   */
>  int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> --
> 2.30.2

Thanks
Barry

