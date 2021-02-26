Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D26326307
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBZNBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:01:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:63566 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhBZNBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:01:08 -0500
IronPort-SDR: MKk+sjI6fkDf+qwPixYK9Uo0PiLGiPBrkvJHdM7xbBixYwUfKDBUqQd904N1s9bjFQMdW78qGT
 PWHuMg7nerLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="270843598"
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="270843598"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 04:59:20 -0800
IronPort-SDR: X1WOlhR3tq4jzAbAxzM37x9Ymi08+8tb1Aek+KRk5QedTqLUquA8ZW8F4+q8QosPOQqZ/QkWIe
 9+WtZgWqzZZw==
X-IronPort-AV: E=Sophos;i="5.81,208,1610438400"; 
   d="scan'208";a="404893045"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 04:59:17 -0800
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com> <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com> <YCwFBNa2npYcEIQ+@kroah.com>
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
In-reply-to: <YCwFBNa2npYcEIQ+@kroah.com>
Date:   Fri, 26 Feb 2021 13:59:14 +0100
Message-ID: <85wnuvrnml.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Feb 16, 2021 at 05:05:14PM +0100, Maciej Kwapulinski wrote:
....
>> --- /dev/null
>> +++ b/drivers/misc/gna/gna_driver.h
>> @@ -0,0 +1,41 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2017-2021 Intel Corporation */
>> +
>> +#ifndef __GNA_DRIVER_H__
>> +#define __GNA_DRIVER_H__
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +
>> +#define GNA_DRV_NAME	"gna"
>
> Way too generic, no one knows what "gna" is.
>

"intel gna" is much more verbose in search engines.
As we do not (plan to) have more "gna" drivers, is the following ok?:

intel-gna

the change would imply the following:

prompt$ lspci -s 00:00.3 -vvvv
00:00.3 System peripheral: Intel Corporation Device 3190 (rev 03)
	Subsystem: Intel Corporation Device 2072
  ....
	Kernel driver in use: intel-gna
	Kernel modules: gna

is it ok?

also, how about the interface to library (it's part of one of next patches)?:
prompt$ file /dev/gna0
/dev/gna0: character special (235/0)

can "gna" stay intact here?

I'm pointing this out, because gna exists on the market for a while and
changing the above may have some impact we'd like to avoid.

>
....
