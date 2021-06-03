Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7088B399FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFCLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhFCLkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:40:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AED63613AC;
        Thu,  3 Jun 2021 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622720283;
        bh=XYkSTdSwKrmOV+bXH1aSs5Xi0fdya8CkNHPLXC3OmxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1urpEkwAZ7bfc2p7qpc/0yOaPN+wqVywQz30wgfYHIwSjUXFLOvBKHt+a/mukfeCn
         pWOf9zj3ja+judDLFY6djQNBJdM6l8LNO4JecwQHt9NSy5FDRyFmRkh0AKuC72W+FM
         oTPx7B6uEL7vP5Wcxkm73u6X2k+CAMRKRgB8N9HU=
Date:   Thu, 3 Jun 2021 13:38:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>, rafael@kernel.org,
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
Message-ID: <YLi/GJ1WDmxS71ab@kroah.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-2-git-send-email-tiantao6@hisilicon.com>
 <YLil8ZOpQSsAB5i0@smile.fi.intel.com>
 <95f5e01d-79c1-28f3-f27b-bee4398308de@huawei.com>
 <YLizweXUvRgB1l9I@kroah.com>
 <0a43ca2a-7563-0bd6-fd1f-3fef208d71ef@huawei.com>
 <YLi+5dOGIa6bkJoF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLi+5dOGIa6bkJoF@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 01:37:09PM +0200, Greg KH wrote:
> On Thu, Jun 03, 2021 at 07:21:30PM +0800, tiantao (H) wrote:
> > 
> > 在 2021/6/3 18:49, Greg KH 写道:
> > > On Thu, Jun 03, 2021 at 06:33:25PM +0800, tiantao (H) wrote:
> > > > 在 2021/6/3 17:50, Andy Shevchenko 写道:
> > > > > On Thu, Jun 03, 2021 at 05:22:40PM +0800, Tian Tao wrote:
> > > > > > New API bitmap_print_to_buf() with bin_attribute to avoid maskp
> > > > > > exceeding PAGE_SIZE. bitmap_print_to_pagebuf() is a special case
> > > > > > of bitmap_print_to_buf(), so in bitmap_print_to_pagebuf() call
> > > > > > bitmap_print_to_buf().
> > > > > ...
> > > > > 
> > > > > >    /**
> > > > > > + * bitmap_print_to_buf - convert bitmap to list or hex format ASCII string
> > > > > > + * @list: indicates whether the bitmap must be list
> > > > > > + * @buf: the kernel space buffer to read to
> > > > > > + * @maskp: pointer to bitmap to convert
> > > > > > + * @nmaskbits: size of bitmap, in bits
> > > > > > + * @off: offset in data buffer below
> > > > > > + * @count: the maximum number of bytes to print
> > > > > > + *
> > > > > > + * The role of bitmap_print_to_buf() and bitmap_print_to_pagebuf() is
> > > > > > + * the same, the difference is that buf of bitmap_print_to_buf()
> > > > > > + * can be more than one pagesize.
> > > > > > + */
> > > > > > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > > > > > +			int nmaskbits, loff_t off, size_t count)
> > > > > > +{
> > > > > > +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > > > > > +	ssize_t size;
> > > > > > +	void *data;
> > > > > > +
> > > > > > +	if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
> > > > > > +		return scnprintf(buf, count, fmt, nmaskbits, maskp);
> > > > > > +
> > > > > > +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> > > > > > +	if (!data)
> > > > > > +		return -ENOMEM;
> > > > > > +
> > > > > > +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> > > > > Are you sure you have put parameters in the correct order?
> > > > yes, I already test it.
> > > Great, can you add the test to the patch series as well so that we can
> > > make sure it does not break in the future?
> > How do I do this?  Do I need to provide a kselftest ?
> 
> That would be wonderful, great idea!

Or, as this is an internal kernel api, using kunit might be easier.

Obviously you tested this somehow, so just take advantage of the code
you wrote for that.

thanks,

greg k-h
