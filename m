Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792A938E449
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEXKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:45:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:64534 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhEXKo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:44:58 -0400
IronPort-SDR: a1YmwUN6XwD+GySUyMbr33k9+ZL6cKAl5dwF596Q9AhoYnow9xSa67wKMuudVmx3eYqF7yS/Ou
 WEIy+hgoiUug==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="287473960"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287473960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:43:30 -0700
IronPort-SDR: kZfhah1/2C5EEMvCeCsw6p2oOBEnM6xop1QTIeWrwbH45Z1a+RTsQLfNiofVxJVHwnJN/3MeCB
 LTMwZ393M95Q==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="475807630"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:43:27 -0700
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com> <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com> <YJ0MXK2XSISC1fIl@kroah.com> <85o8ddiv51.fsf@linux.intel.com> <YJ41h6lt8lSqaH7r@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 11/14] intel_gna: add ioctl handler
In-reply-to: <YJ41h6lt8lSqaH7r@kroah.com>
Message-ID: <85h7isif8y.fsf@linux.intel.com>
Date:   Mon, 24 May 2021 12:43:25 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Fri, May 14, 2021 at 10:20:42AM +0200, Maciej Kwapulinski wrote:
>> 
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Thu, May 13, 2021 at 01:00:37PM +0200, Maciej Kwapulinski wrote:
>> >> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
>> >> 
>> >> Add ioctl handler into GNA driver.
>> >> The ioctl interface provides the ability to do the following:
>> >>  - Map and unmap memory buffers for GNA computation requests.
>> >>  - Retrieve capabilities of the underlying GNA IP.
>> >>  - Submit GNA computation requests.
>> >>  - Request notification of scoring completion.
>> >
>> > Do you have a pointer to the userspace code that uses this ioctl?
>> > That's kind of required here, otherwise we have no idea how this all
>> > works.
>> >
>> 
>> yes, it's present under following link:
>> 
>> https://github.com/intel/gna
>
> Then that needs to go here in this changelog text, right?

link to library is already present in 00/14, I didn't want to have it in
two places, that's why not present here.
