Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52585399F94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFCLNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:13:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:26576 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCLNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:13:08 -0400
IronPort-SDR: vNg28/ip/G43+6kh6UYUFXJKdJTDNNPcPcSFzN9bAT73JiUSTgsoDJcVBS1wN442HBPTp56PzP
 xPE35raec03w==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="204047633"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="204047633"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:11:23 -0700
IronPort-SDR: PqLkvmgHoSQZTIMomFXawdAh4ehjRskKlmP28f9WI53WczWHVKVx8rIiQ/b1LkhhomsAXyyrN5
 zvKaERFaAINw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="400397127"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:11:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lolFs-00GvSf-QM; Thu, 03 Jun 2021 14:11:16 +0300
Date:   Thu, 3 Jun 2021 14:11:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, Randy Dunlap <rdunlap@infradead.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 1/3] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <YLi41Iz5fJ4cUErt@smile.fi.intel.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
 <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
 <95f5e01d-79c1-28f3-f27b-bee4398308de@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95f5e01d-79c1-28f3-f27b-bee4398308de@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 06:33:25PM +0800, tiantao (H) wrote:
> 在 2021/6/3 17:50, Andy Shevchenko 写道:
> > On Thu, Jun 03, 2021 at 05:22:40PM +0800, Tian Tao wrote:
> > > New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> > > exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> > > of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> > > bitmap_print_to_buf().

...

> > > + * @count: the maximum number of bytes to print

> > > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> > Are you sure you have put parameters in the correct order?
> 
> yes, I already test it.
> 
> ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
>                                 const void *from, size_t available)

Have you read the meaning of count and available?
Please, double check that they are filled with correct values.

> > I guess you have to provide the test case(s).

-- 
With Best Regards,
Andy Shevchenko


