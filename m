Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1731D5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhBQHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:32:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:62797 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhBQHcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:32:31 -0500
IronPort-SDR: F6OQHdEUrnEZZp8n2xoJmVfhvaBnQuXjLk5UyEDr0NTi9QL3tNBRsps8C5Lq4YnClSesWHG4+i
 nl2ysRvLDO7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="267977757"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="267977757"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 23:30:42 -0800
IronPort-SDR: 69tXmDL9lkx0z/px0P1VfkdwnlW9srEkubwldGWVkNw5AkrenN577WTq2HmmPiFbp4IvsGG8Gl
 1zh96fmfclKg==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439262663"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 23:30:37 -0800
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
Date:   Wed, 17 Feb 2021 08:30:33 +0100
Message-ID: <85ft1v2lt2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Feb 16, 2021 at 05:05:14PM +0100, Maciej Kwapulinski wrote:
>> --- /dev/null
>> +++ b/drivers/misc/gna/gna_driver.c
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +// Copyright(c) 2017-2021 Intel Corporation
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME " " fmt
>
> You are a driver, you should never need a pr_* call, so this should not
> be needed.  You should always just use dev_* instead.
>

Hi Greg and all other Reviewers.

Thank You for all the comments so far.

I'm starting preparing PATCH v2 series based on them.
I'll also answer comments individually where need arises.

regards,
Maciej
