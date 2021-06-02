Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6198398F39
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFBPuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:50:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:22361 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232143AbhFBPuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:50:07 -0400
IronPort-SDR: SDMSRLklSO1j6akGRQWdo4pWitya20itBR4HYjO32wwuNTKvcshQ/0dBeKeYbQHqOeDvkgpHn8
 byu8K9QjJm/w==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="184187138"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="184187138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:47:33 -0700
IronPort-SDR: DbzsOULsi6zea7J8HpmDoYlaiiYgMPSZ3UyaXePMwK6kXJ/BQumGWmKOp/H5POh+E3pCS+R6pY
 G1NqnWBRgMKw==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="550192050"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:47:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1loT5b-00Gk5b-Fw; Wed, 02 Jun 2021 18:47:27 +0300
Date:   Wed, 2 Jun 2021 18:47:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <YLeoDzObZpJwDswB@smile.fi.intel.com>
References: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
 <1622641734-22538-2-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622641734-22538-2-git-send-email-tiantao6@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:48:52PM +0800, Tian Tao wrote:
> New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> bitmap_print_to_buf().

...

> + * The role of cpumap_print_to_buf and cpumap_print_to_pagebuf is

 * The role of cpumap_print_to_buf() and cpumap_print_to_pagebuf() is

...

> + * The role of bitmap_print_to_buf and bitmap_print_to_pagebuf() is

 * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is

...

> +	int size;

Strictly speaking it should be ssize_t.

> +	void *data;
> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";

Can you use reversed xmas tree order?

...

> +	return bitmap_print_to_buf(list, buf, maskp, nmaskbits,
> +				   LLONG_MAX, len);

It fits one line.

-- 
With Best Regards,
Andy Shevchenko


