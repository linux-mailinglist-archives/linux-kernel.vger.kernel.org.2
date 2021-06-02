Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280B539855B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhFBJha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhFBJh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:37:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E61DB613B1;
        Wed,  2 Jun 2021 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622626546;
        bh=ymyLVNAEeFw8CcWthFa27prfSO0YR8SIlIaa4wgaC9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpSnTvySokVKfQotXa5lBXJ0ZEbyU1ULEA6DeY1BwEn7rS46niT4z1Z7hz/ptuk1A
         14clYqUZOkgJd4n6euiW/MPK8dXSd1rECQuV+ZU82HJSXvn1vIzc3wq2B12cISewPv
         2/FRK4e8NNY+GA+9N0Q4ngHaHR4zkP8Tj/lbNBms=
Date:   Wed, 2 Jun 2021 11:35:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "tiantao (H)" <tiantao6@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
Message-ID: <YLdQ75ewxWhnC3wy@kroah.com>
References: <1622516210-10886-1-git-send-email-tiantao6@hisilicon.com>
 <1622516210-10886-2-git-send-email-tiantao6@hisilicon.com>
 <YLW+hZwoImx2wjwS@kroah.com>
 <4c9c7c17-e8d1-d601-6262-8064293a06a9@huawei.com>
 <YLcivXNwm75V+I2m@kroah.com>
 <d3c1ec35-fa62-46ed-9227-866e0a3c96b8@huawei.com>
 <CAHp75VeL4UMFX6oZWaFscTX6Ta5s714NeisR=vTh6mYMjyPi6w@mail.gmail.com>
 <f84f92f5-8462-0556-e457-4e302e1e8cb6@huawei.com>
 <YLdKDXYKm7jqorGa@kroah.com>
 <547f8273faa146699dd50173b33f03e2@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <547f8273faa146699dd50173b33f03e2@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:20:45AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Wednesday, June 2, 2021 9:06 PM
> > To: tiantao (H) <tiantao6@hisilicon.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; tiantao (H)
> > <tiantao6@hisilicon.com>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Andrew Morton <akpm@linux-foundation.org>;
> > Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Rafael J. Wysocki <rafael@kernel.org>;
> > Jonathan Cameron <jonathan.cameron@huawei.com>
> > Subject: Re: [PATCH 1/2] topology: use bin_attribute to avoid buff overflow
> > 
> > On Wed, Jun 02, 2021 at 05:00:16PM +0800, tiantao (H) wrote:
> > >
> > > 在 2021/6/2 16:48, Andy Shevchenko 写道:
> > > > On Wed, Jun 2, 2021 at 9:45 AM tiantao (H) <tiantao6@huawei.com> wrote:
> > > > > 在 2021/6/2 14:18, Greg KH 写道:
> > > > > > On Wed, Jun 02, 2021 at 02:14:49PM +0800, tiantao (H) wrote:
> > > > > > > 在 2021/6/1 12:58, Greg KH 写道:
> > > > > > > > On Tue, Jun 01, 2021 at 10:56:49AM +0800, Tian Tao wrote:
> > > > ...
> > > >
> > > > > > > > >     /**
> > > > > > > > > + * bitmap_print_to_buf - convert bitmap to list or hex format
> > ASCII string
> > > > > > > > > + * @list: indicates whether the bitmap must be list
> > > > > > > > > + * @buf: page aligned buffer into which string is placed
> > > > > > > > > + * @maskp: pointer to bitmap to convert
> > > > > > > > > + * @nmaskbits: size of bitmap, in bits
> > > > > > > > > + * @off: offset in buf
> > > > > > > > > + * @count: count that already output
> > > > > > > > > + *
> > > > > > > > > + * the role of bitmap_print_to_buf and bitmap_print_to_pagebuf
> > is
> > > > > > > > > + * the same, the difference is that the second parameter of
> > > > > > > > > + * bitmap_print_to_buf can be more than one pagesize.
> > > > > > > > > + */
> > > > > > > > > +int bitmap_print_to_buf(bool list, char *buf, const unsigned
> > long *maskp,
> > > > > > > > > +                  int nmaskbits, loff_t off, size_t count)
> > > > > > > > > +{
> > > > > > > > > +  int len, size;
> > > > > > > > > +  void *data;
> > > > > > > > > +  char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > > > > > > > > +
> > > > > > > > > +  len = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> > > > > > > > > +
> > > > > > > > > +  data = kvmalloc(len+1, GFP_KERNEL);
> > > > > > > > > +  if (!data)
> > > > > > > > > +          return -ENOMEM;
> > > > > > > > > +
> > > > > > > > > +  size = scnprintf(data, len+1, fmt, nmaskbits, maskp);
> > > > > > > > > +  size = memory_read_from_buffer(buf, count, &off, data, size);
> > > > > > > > > +  kvfree(data);
> > > > > > > > > +
> > > > > > > > > +  return size;
> > > > > > > > Why is this so different from bitmap_print_to_pagebuf()?  Can't you
> > just
> > > > > > > > use this function as the "real" function and then change
> > > > > > > > bitmap_print_to_pagebuf() to call it with a size of PAGE_SIZE?
> > > > > > > Do you mean do following change, is that correct? :-)
> > > > > > Maybe, it is whitespace corrupted, and it still feels like this function
> > > > > > is much bigger than it needs to be given the function it is replacing
> > is
> > > > > > only a simple sprintf() call.
> > > > > >
> > > > > > > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long
> > *maskp,
> > > > > > > +                       int nmaskbits, loff_t off, size_t count)
> > > > > > > +{
> > > > > > > +       int len, size;
> > > > > > > +       void *data;
> > > > > > > +       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > > > > > > +
> > > > > > > +       if (off == LLONG_MAX && count == PAGE_SIZE - offset_in_page(buf))
> > > > > > > +               return scnprintf(buf, count, fmt, nmaskbits, maskp);
> > > > > > > +
> > > > > > > +       len = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> > > > > > > +
> > > > > > > +       data = kvmalloc(len+1, GFP_KERNEL);
> > > > > > Why do you need to allocate more memory?  And why kvmalloc()?
> > > > > Because the memory here will exceed a pagesize and we don't know the
> > > > > exact size, we have to call
> > > > >
> > > > > snprintf first to get the actual size. kvmalloc() is used because when
> > > > > physical memory is tight, kmalloc
> > > > >
> > > > > may fail, but vmalloc will succeed. It is not so bad that the memory is
> > > > > not requested here.
> > > > To me it sounds like the function is overengineered / lacks thought
> > > > through / optimization.
> > > > Can you provide a few examples that require the above algorithm?
> > >
> > > so you think we should use kmalloc instead of kvmalloc ?
> > 
> > What size bitmap would trigger a vmalloc() call to be forced here?
> > 
> 
> According to kvmalloc_node(), only if size is larger than PAGE_SIZE,
> kvmalloc will move to vmalloc if kmalloc fails to get memory. Otherwise,
> it will return error.

I know, so how big of a bitmap would you need before a kmalloc call
would fail given that there is almost always free memory in these
"smaller" amounts.

And if there is no memory, why not fail like normal, this is not
something that needs to be complex and crazy, it's just a sysfs file to
provide information.

Please do not over-engineer something that does not need it, until you
have proof it is needed.

thanks,

greg k-h
