Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125DA39A13C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFCMlI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Jun 2021 08:41:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3139 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFCMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:41:08 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwlWd6zhSz6M4b5;
        Thu,  3 Jun 2021 20:26:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 14:39:21 +0200
Received: from localhost (10.52.124.195) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 13:39:20 +0100
Date:   Thu, 3 Jun 2021 13:39:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "tiantao (H)" <tiantao6@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <song.bao.hua@hisilicon.com>, Randy Dunlap <rdunlap@infradead.org>,
        "Stefano Brivio" <sbrivio@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 1/3] lib: bitmap: introduce bitmap_print_to_buf
Message-ID: <20210603133919.00004603@Huawei.com>
In-Reply-To: <YLi41Iz5fJ4cUErt@smile.fi.intel.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
        <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
        <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
        <95f5e01d-79c1-28f3-f27b-bee4398308de@huawei.com>
        <YLi41Iz5fJ4cUErt@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.195]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 14:11:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Jun 03, 2021 at 06:33:25PM +0800, tiantao (H) wrote:
> > 在 2021/6/3 17:50, Andy Shevchenko 写道:  
> > > On Thu, Jun 03, 2021 at 05:22:40PM +0800, Tian Tao wrote:  
> > > > New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> > > > exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> > > > of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> > > > bitmap_print_to_buf().  
> 
> ...
> 
> > > > + * @count: the maximum number of bytes to print  
> 
> > > > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);  
> > > Are you sure you have put parameters in the correct order?  
> > 
> > yes, I already test it.
> > 
> > ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
> >                                 const void *from, size_t available)  
> 
> Have you read the meaning of count and available?
> Please, double check that they are filled with correct values.

Ok, I don't get this one either so can you give us more of a hint?

/**
 * memory_read_from_buffer - copy data from the buffer
 * @to: the kernel space buffer to read to
 * @count: the maximum number of bytes to read
 * @ppos: the current position in the buffer
 * @from: the buffer to read from
 * @available: the size of the buffer
 *
 * The memory_read_from_buffer() function reads up to @count bytes from the
 * buffer @from at offset @ppos into the kernel space address starting at @to.
 *
 * On success, the number of bytes read is returned and the offset @ppos is
 * advanced by this number, or negative value is returned on error.
 **/

These docs do end up rather confusing by using the term buffer for multiple things
but taking what is passed in.

Count is the maximum in the sense of how many bytes we are requesting are read
which indeed should be count here as that reflects what userspace asked for.

Avail is the size of the buffer we are reading from.  Now that's slightly
ambiguous in the docs in the sense of 'buffer' could mean the to buffer or
the from buffer.  However, I'd assume count is definitely <= size of the space
after address to in the to buffer, so I would assume that means available
is the size of the from buffer.  Here that is strlen() + 1, so looks fine.

This interpretation also lines up with the implementation.

So what are we missing?

Jonathan

> 
> > > I guess you have to provide the test case(s).  
> 

