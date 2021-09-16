Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340740ED8F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbhIPWzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Sep 2021 18:55:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16223 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhIPWzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:55:03 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H9XR95pHVz1DH1P;
        Fri, 17 Sep 2021 06:52:37 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 17 Sep 2021 06:53:40 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.008;
 Fri, 17 Sep 2021 06:53:39 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Tobias Klauser <tklauser@distanz.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpumask: Omit terminating null byte in
 cpumap_print_{list,bitmask}_to_buf
Thread-Topic: [PATCH] cpumask: Omit terminating null byte in
 cpumap_print_{list,bitmask}_to_buf
Thread-Index: AQHXq0oRxLFeYESCB0yrTStibF+ox6unQ3Ew
Date:   Thu, 16 Sep 2021 22:53:39 +0000
Message-ID: <aa4bc59c44b345ae814c61f6593a7178@hisilicon.com>
References: <20210916222705.13554-1-tklauser@distanz.ch>
In-Reply-To: <20210916222705.13554-1-tklauser@distanz.ch>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Tobias Klauser [mailto:tklauser@distanz.ch]
> Sent: Friday, September 17, 2021 10:27 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Song Bao
> Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Yury Norov <yury.norov@gmail.com>; Peter
> Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org
> Subject: [PATCH] cpumask: Omit terminating null byte in
> cpumap_print_{list,bitmask}_to_buf
> 
> The changes in the patch series [1] introduced a terminating null byte
> when reading from cpulist or cpumap sysfs files, for example:
> 
>   $ xxd /sys/devices/system/node/node0/cpulist
>   00000000: 302d 310a 00                             0-1..
> 
> Before this change, the output looked as follows:
> 
>   $ xxd /sys/devices/system/node/node0/cpulist
>   00000000: 302d 310a                                0-1.

If we don't use xxd, I don't see any actual harm of this NULL byte
by cat, lscpu, numactl etc. this doesn't break them at all.

if we only want to make sure the output is exactly same with before
for every single character, this patch is right.

> 
> Fix this regression by excluding the terminating null byte from the
> returned length in cpumap_print_list_to_buf and
> cpumap_print_bitmask_to_buf.
> 
> [1]
> https://lore.kernel.org/all/20210806110251.560-1-song.bao.hua@hisilicon.co
> m/
> 
> Fixes: 1fae562983ca ("cpumask: introduce cpumap_print_list/bitmask_to_buf to
> support large bitmask and list")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  include/linux/cpumask.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 5d4d07a9e1ed..1e7399fc69c0 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -996,14 +996,15 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct
> cpumask *mask)
>   * cpumask; Typically used by bin_attribute to export cpumask bitmask
>   * ABI.
>   *
> - * Returns the length of how many bytes have been copied.
> + * Returns the length of how many bytes have been copied, excluding
> + * terminating '\0'.
>   */
>  static inline ssize_t
>  cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
>  		loff_t off, size_t count)
>  {
>  	return bitmap_print_bitmask_to_buf(buf, cpumask_bits(mask),
> -				   nr_cpu_ids, off, count);
> +				   nr_cpu_ids, off, count) - 1;
>  }
> 
>  /**
> @@ -1018,7 +1019,7 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask
> *mask,
>  		loff_t off, size_t count)
>  {
>  	return bitmap_print_list_to_buf(buf, cpumask_bits(mask),
> -				   nr_cpu_ids, off, count);
> +				   nr_cpu_ids, off, count) - 1;
>  }
> 
>  #if NR_CPUS <= BITS_PER_LONG
> --
> 2.33.0

Thanks
Barry

