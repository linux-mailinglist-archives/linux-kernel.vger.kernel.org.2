Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CCB3F88B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbhHZNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:23:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54454 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhHZNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:23:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4D6F11FD59;
        Thu, 26 Aug 2021 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629984172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PLvumcZvpq67fhsZlC53oM4Ky7cTiR667Yrn4EucAoA=;
        b=HFAbyj7lzW5m6F0kE9WmxPdhOT5ZQ3Cb9hnXWV+XN7YchRB1XQcFGoa1tWPbxzDHqEODyE
        FhNhdV+HrOGtoehIdrPMJKo+K6uCZyfV+DknqVl2eN0vzQf51yQlsQqf87fTS8Cbn4y7FZ
        XOpuWjXz4zJ1quc9HFxx1bWWeRJ2Hvo=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BFC36A3B8D;
        Thu, 26 Aug 2021 13:22:51 +0000 (UTC)
Date:   Thu, 26 Aug 2021 15:22:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking
 address of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
Message-ID: <YSeVq7nvVKgCL4HL@alley>
References: <202107150148.RpWnKapX-lkp@intel.com>
 <CAHp75Vfu1rhUV+SOq2ikFWd2G6x9j3BT6OLPhPcf8VZE5Umeqw@mail.gmail.com>
 <20210716114105.GF3@paasikivi.fi.intel.com>
 <YPF3m01nYlt3On7V@smile.fi.intel.com>
 <20210819081053.GW3@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819081053.GW3@paasikivi.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-08-19 11:10:53, Sakari Ailus wrote:
> On Fri, Jul 16, 2021 at 03:12:11PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 16, 2021 at 02:41:05PM +0300, Sakari Ailus wrote:
> > > On Wed, Jul 14, 2021 at 10:45:26PM +0300, Andy Shevchenko wrote:
> > > > > >> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
> > > > 

Is there any plan to fix this, please?


> > > > Why is it packed in the first place? Is it used on unaligned addresses
> > > > in other structures? But even so, why should it matter?
> > > 
> > > It's packed since we wanted to avoid having holes in the structs. There are
> > > other ways to do that but it's ABI dependent and is prone to human errors,
> > > too.

> > What holes can you think about in the above mention structure?
> 
> Probably not that one but it has happened in the past that the struct
> memory layout has been unintentionally different in different ABIs and that
> has not been the intention, but rather a bug.

What kind of bugs did the different ABI caused, please? Incompatibly
between 3rd party drivers that were built with different compilers?

I am not familiar with these problems. I wonder if there is a better
solution. I guess that it might be a common problem affecting most
drivers.

Anyway, the non-aligned struct members might create slower code.

> Packing has been added in newer structs to avoid that.

And this smells with cargo-cult programming. People might make all new
structures packed even when it is not really needed.

Best Regards,
Petr
