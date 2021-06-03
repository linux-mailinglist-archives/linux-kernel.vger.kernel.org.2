Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB30739A1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFCNCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:02:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:56639 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhFCNCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:02:22 -0400
IronPort-SDR: JrmE5VTCkgQVTB4ZXRI6J7ErXwcxZSyDNL35QJ+BYmdtOYyMr1OEjd6dLi5Bfmu7L5i+i7hHbw
 Y7CPTzIscs0w==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="265207505"
X-IronPort-AV: E=Sophos;i="5.83,245,1616482800"; 
   d="scan'208";a="265207505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:00:37 -0700
IronPort-SDR: jqTIsbYOI2IHqHLU8ljWa7EWe1NPu4TIHX/CH/Fp51RU1MqxfrU8D6Mla2beTWHQSeOWMYSOYQ
 AgLxW8nCUw0g==
X-IronPort-AV: E=Sophos;i="5.83,245,1616482800"; 
   d="scan'208";a="467951388"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 06:00:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lomxZ-00Gwlf-Iy; Thu, 03 Jun 2021 16:00:29 +0300
Date:   Thu, 3 Jun 2021 16:00:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, song.bao.hua@hisilicon.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 1/3] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <YLjSbSeFBygxl799@smile.fi.intel.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
 <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
 <95f5e01d-79c1-28f3-f27b-bee4398308de@huawei.com>
 <YLi41Iz5fJ4cUErt@smile.fi.intel.com>
 <20210603133919.00004603@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603133919.00004603@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 01:39:19PM +0100, Jonathan Cameron wrote:
> On Thu, 3 Jun 2021 14:11:16 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Jun 03, 2021 at 06:33:25PM +0800, tiantao (H) wrote:
> > > 在 2021/6/3 17:50, Andy Shevchenko 写道:  
> > > > On Thu, Jun 03, 2021 at 05:22:40PM +0800, Tian Tao wrote:  
> > > > > New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> > > > > exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> > > > > of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> > > > > bitmap_print_to_buf().  
> > 
> > ...
> > 
> > > > > + * @count: the maximum number of bytes to print  
> > 
> > > > > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);  
> > > > Are you sure you have put parameters in the correct order?  
> > > 
> > > yes, I already test it.
> > > 
> > > ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
> > >                                 const void *from, size_t available)  
> > 
> > Have you read the meaning of count and available?
> > Please, double check that they are filled with correct values.
> 
> Ok, I don't get this one either so can you give us more of a hint?

There is no hint, as you noticed the documentation of the function is a bit
confusing.

> /**
>  * memory_read_from_buffer - copy data from the buffer
>  * @to: the kernel space buffer to read to
>  * @count: the maximum number of bytes to read
>  * @ppos: the current position in the buffer
>  * @from: the buffer to read from
>  * @available: the size of the buffer
>  *
>  * The memory_read_from_buffer() function reads up to @count bytes from the
>  * buffer @from at offset @ppos into the kernel space address starting at @to.
>  *
>  * On success, the number of bytes read is returned and the offset @ppos is
>  * advanced by this number, or negative value is returned on error.
>  **/
> 
> These docs do end up rather confusing by using the term buffer for multiple things
> but taking what is passed in.
> 
> Count is the maximum in the sense of how many bytes we are requesting are read
> which indeed should be count here as that reflects what userspace asked for.
> 
> Avail is the size of the buffer we are reading from.  Now that's slightly
> ambiguous in the docs in the sense of 'buffer' could mean the to buffer or
> the from buffer.  However, I'd assume count is definitely <= size of the space
> after address to in the to buffer, so I would assume that means available
> is the size of the from buffer.  Here that is strlen() + 1, so looks fine.
> 
> This interpretation also lines up with the implementation.
> 
> So what are we missing?

Thanks for double checking and explaining.

> > > > I guess you have to provide the test case(s).

Just test cases is what we are missing. Then we can play around with different
input to see if it's all correct.

-- 
With Best Regards,
Andy Shevchenko


