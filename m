Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EC240F457
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245482AbhIQIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245460AbhIQIqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:46:51 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:45:29 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4H9nbC1PrKzvjfm; Fri, 17 Sep 2021 10:45:27 +0200 (CEST)
Date:   Fri, 17 Sep 2021 10:45:27 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpumask: Omit terminating null byte in
 cpumap_print_{list,bitmask}_to_buf
Message-ID: <20210917084526.uzpish2owb24szng@distanz.ch>
References: <20210916222705.13554-1-tklauser@distanz.ch>
 <aa4bc59c44b345ae814c61f6593a7178@hisilicon.com>
 <YUPQ6F8M822fLzpx@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUPQ6F8M822fLzpx@yury-ThinkPad>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-17 at 01:19:04 +0200, Yury Norov <yury.norov@gmail.com> wrote:
> [CC Greg KH <gregkh@linuxfoundation.org>]
> 
> On Thu, Sep 16, 2021 at 10:53:39PM +0000, Song Bao Hua (Barry Song) wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Tobias Klauser [mailto:tklauser@distanz.ch]
> > > Sent: Friday, September 17, 2021 10:27 AM
> > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> > > <jonathan.cameron@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Song Bao
> > > Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>; Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>; Yury Norov <yury.norov@gmail.com>; Peter
> > > Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org
> > > Subject: [PATCH] cpumask: Omit terminating null byte in
> > > cpumap_print_{list,bitmask}_to_buf
> > > 
> > > The changes in the patch series [1] introduced a terminating null byte
> > > when reading from cpulist or cpumap sysfs files, for example:
> > > 
> > >   $ xxd /sys/devices/system/node/node0/cpulist
> > >   00000000: 302d 310a 00                             0-1..
> > > 
> > > Before this change, the output looked as follows:
> > > 
> > >   $ xxd /sys/devices/system/node/node0/cpulist
> > >   00000000: 302d 310a                                0-1.
> > 
> > If we don't use xxd, I don't see any actual harm of this NULL byte
> > by cat, lscpu, numactl etc. this doesn't break them at all.
> 
> Barry, Tobias' script that uses xxd is userspace. Linux kernel never breaks
> userspace. 

FWIW, the example using xxd was just to illustrate the issue in a
concise way for the commit message. This is breaking other userspace
programs as well. Originally, I discovered this because Kubernetes'
kubelet was crashing on a bpf-next kernel. See [1] and following
comments for more information:

[1] https://github.com/cilium/cilium/pull/17394#issuecomment-920902042

> > if we only want to make sure the output is exactly same with before
> > for every single character, this patch is right.
> 
> We don't want to make the output exactly the same. The "0,1" would
> also work for the example above. But garbage characters following \0
> is a bug that should be fixed.

I think we also want to avoid the \0 itself, which is what this patch
does and is in line with previous behavior. It also looks like all other
sysfs files in that subtree expose the same content format (i.e. \n is
the last character, not \0).

Thanks,
Tobias
