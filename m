Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5341E332E44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhCIS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:27:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:34136 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCIS04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:26:56 -0500
IronPort-SDR: L4Bnj4u6DTGgMrLFSe6igXX55273ihzW+GGZuzw/jZ/+ss/iUxLyzEUE2PvfoEbR9C3eivm24L
 7mUhyShrUgyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188399795"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="188399795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 10:26:50 -0800
IronPort-SDR: DsIsB94LmBqxVFlg3gxJEokxZbihTfvRnqEL8y2qSbmpk1zDuUp9i4UumqBgGXw3M05AAQp1je
 +AI/3o0NEWng==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="409842966"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 10:26:47 -0800
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com> <YCwFBNa2npYcEIQ+@kroah.com> <85wnuvrnml.fsf@linux.intel.com> <YDjxu+0zvz3zsRb3@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
In-reply-to: <YDjxu+0zvz3zsRb3@kroah.com>
Date:   Tue, 09 Mar 2021 19:26:44 +0100
Message-ID: <85wnug2nff.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Fri, Feb 26, 2021 at 01:59:14PM +0100, Maciej Kwapulinski wrote:
>> 
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Tue, Feb 16, 2021 at 05:05:14PM +0100, Maciej Kwapulinski wrote:
>> ....
>> >> --- /dev/null
>> >> +++ b/drivers/misc/gna/gna_driver.h
>> >> @@ -0,0 +1,41 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0-only */
>> >> +/* Copyright(c) 2017-2021 Intel Corporation */
>> >> +
>> >> +#ifndef __GNA_DRIVER_H__
>> >> +#define __GNA_DRIVER_H__
>> >> +
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/mutex.h>
>> >> +#include <linux/types.h>
>> >> +
>> >> +#define GNA_DRV_NAME	"gna"
>> >
>> > Way too generic, no one knows what "gna" is.
>> >
>> 
>> "intel gna" is much more verbose in search engines.
>> As we do not (plan to) have more "gna" drivers, is the following ok?:
>> 
>> intel-gna
>> 
>> the change would imply the following:
>> 
>> prompt$ lspci -s 00:00.3 -vvvv
>> 00:00.3 System peripheral: Intel Corporation Device 3190 (rev 03)
>> 	Subsystem: Intel Corporation Device 2072
>>   ....
>> 	Kernel driver in use: intel-gna
>> 	Kernel modules: gna
>> 
>> is it ok?
>
> Why not intel-gna as the kernel module as well?
>
>> also, how about the interface to library (it's part of one of next patches)?:
>> prompt$ file /dev/gna0
>> /dev/gna0: character special (235/0)
>> 
>> can "gna" stay intact here?
>
> Again, I have no idea what "gna" is, so you might want to pick something
> more descriptive?
>
>> I'm pointing this out, because gna exists on the market for a while and
>> changing the above may have some impact we'd like to avoid.
>
> If it exists but Linux does not support it, how would anyone know about
> it?  :)
>
> Please use real terms where possible.
>
> thanks,
>
> greg k-h

summarizing gna name justification topic, is the intel_gna.ko driver's
following layout within kernel code OK for You?:
1. driver/module name:
   prompt$ lspci -s 00:00.3 -vvvv
   00:00.3 System peripheral: Intel Corporation Device 3190 (rev 03)
     ....
     Kernel driver in use: intel_gna
     Kernel modules: intel_gna

2. mv drivers/misc/gna/* drivers/misc/intel_gna/

3. prompt$ file /dev/intel_gna0     
/dev/intel_gna0: character special (10/120)

# ..., /dev/intel_gna1, /dev/intel_gna2 for subsequent devices
