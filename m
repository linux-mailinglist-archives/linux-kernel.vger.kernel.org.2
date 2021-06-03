Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A5399E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhFCJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:52:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:7576 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhFCJwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:52:45 -0400
IronPort-SDR: jcHeadFD4jmcVkjxTAhoJF/rRfGGL7VBd8pz9xBQlOCeH8U0wxqV/re5Oz9Pxyas5gzelFfzWe
 G5C/tXGBg4Uw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="289637732"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="289637732"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 02:50:48 -0700
IronPort-SDR: egrW79uVlQVySoOBpQjcExImZeWGgQciy1ymwqfJNC0je8AQlvRDGBB5mWJGsR5mM1hxLbqETO
 bhmZXxDnoNQA==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="467905605"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 02:50:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lojzt-00GuV7-Hf; Thu, 03 Jun 2021 12:50:41 +0300
Date:   Thu, 3 Jun 2021 12:50:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, song.bao.hua@hisilicon.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 1/3] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 05:22:40PM +0800, Tian Tao wrote:
> New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> bitmap_print_to_buf().

...

>  /**
> + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
> + * @list: indicates whether the bitmap must be list
> + * @buf: the kernel space buffer to read to
> + * @maskp: pointer to bitmap to convert
> + * @nmaskbits: size of bitmap, in bits
> + * @off: offset in data buffer below
> + * @count: the maximum number of bytes to print
> + *
> + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
> + * the same, the difference is that buf of bitmap_print_to_buf()
> + * can be more than one pagesize.
> + */
> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> +			int nmaskbits, loff_t off, size_t count)
> +{
> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +	ssize_t size;
> +	void *data;
> +
> +	if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
> +		return scnprintf(buf, count, fmt, nmaskbits, maskp);
> +
> +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);

Are you sure you have put parameters in the correct order?

> +	kfree(data);
> +
> +	return size;
> +}

I guess you have to provide the test case(s).

-- 
With Best Regards,
Andy Shevchenko


