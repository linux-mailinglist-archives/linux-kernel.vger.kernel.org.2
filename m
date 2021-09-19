Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24B410AA2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhISHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 03:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230463AbhISHyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 03:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A12FE611F0;
        Sun, 19 Sep 2021 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632037966;
        bh=WdwtFfMy28r+sBybSIq6bYfhIIywUctEKEPF7euBt48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJ6M6QYwx9oAN2gVTZwL0/ugST75FL9SLfBd+MuyNEm2pJJojgK2qUfJFda25hZsm
         2me9pitJRw2+JpKEmluNgDFFslhULuL2IFlwyMYxrDRzCatdIcQkFRvfyxqth7NJ9E
         8fSWFuE+jANRCfEo73KRNICgDVaeHe9efjK1jtoM=
Date:   Sun, 19 Sep 2021 09:52:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Yury Norov <yury.norov@gmail.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpumask: Omit terminating null byte in
 cpumap_print_{list,bitmask}_to_buf
Message-ID: <YUbsOtEQ4la3hfrf@kroah.com>
References: <20210916222705.13554-1-tklauser@distanz.ch>
 <aa4bc59c44b345ae814c61f6593a7178@hisilicon.com>
 <YUPQ6F8M822fLzpx@yury-ThinkPad>
 <20210917084526.uzpish2owb24szng@distanz.ch>
 <CAGsJ_4wftev=z1tf7fzVKS5wRPneWSOimSxG+E0qy2CGuRykKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wftev=z1tf7fzVKS5wRPneWSOimSxG+E0qy2CGuRykKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 07:33:52PM +1200, Barry Song wrote:
> On Sat, Sep 18, 2021 at 1:27 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > On 2021-09-17 at 01:19:04 +0200, Yury Norov <yury.norov@gmail.com> wrote:
> > > [CC Greg KH <gregkh@linuxfoundation.org>]
> > >
> > > On Thu, Sep 16, 2021 at 10:53:39PM +0000, Song Bao Hua (Barry Song) wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Tobias Klauser [mailto:tklauser@distanz.ch]
> > > > > Sent: Friday, September 17, 2021 10:27 AM
> > > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> > > > > <jonathan.cameron@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Song Bao
> > > > > Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>; Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com>; Yury Norov <yury.norov@gmail.com>; Peter
> > > > > Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org
> > > > > Subject: [PATCH] cpumask: Omit terminating null byte in
> > > > > cpumap_print_{list,bitmask}_to_buf
> > > > >
> > > > > The changes in the patch series [1] introduced a terminating null byte
> > > > > when reading from cpulist or cpumap sysfs files, for example:
> > > > >
> > > > >   $ xxd /sys/devices/system/node/node0/cpulist
> > > > >   00000000: 302d 310a 00                             0-1..
> > > > >
> > > > > Before this change, the output looked as follows:
> > > > >
> > > > >   $ xxd /sys/devices/system/node/node0/cpulist
> > > > >   00000000: 302d 310a                                0-1.
> > > >
> > > > If we don't use xxd, I don't see any actual harm of this NULL byte
> > > > by cat, lscpu, numactl etc. this doesn't break them at all.
> > >
> > > Barry, Tobias' script that uses xxd is userspace. Linux kernel never breaks
> > > userspace.
> >
> > FWIW, the example using xxd was just to illustrate the issue in a
> > concise way for the commit message. This is breaking other userspace
> > programs as well. Originally, I discovered this because Kubernetes'
> > kubelet was crashing on a bpf-next kernel. See [1] and following
> > comments for more information:
> >
> > [1] https://github.com/cilium/cilium/pull/17394#issuecomment-920902042
> >
> 
> cat, lscpu, numactl tools were tested. the above was not in the test cases.
> Anyway, if some apps depend on the last character, this patch makes
> sense. we need this one. sorry for missing the test case.
> 
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
> 
> Greg, can you please help merge this one into 5.15?

Yes, will apply it to my tree soon.

thanks,

greg k-h
