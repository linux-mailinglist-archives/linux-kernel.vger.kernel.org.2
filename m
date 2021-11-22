Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DF458AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhKVI6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:58:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:14195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhKVI6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:58:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="215462024"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="215462024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 00:55:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="456212291"
Received: from rmcdonax-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.217])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 00:55:31 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 18/20] linux/power_of_2.h: Add __IS_POWER_OF_2(n) and
 __IS_POWER_OF_2_OR_0(n) macros
In-Reply-To: <CAK8P3a0b7_yMExXEiH-4sKnN2Smh+BDB+=dyNvPWVcLvR_zG5w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
 <20211120130104.185699-20-alx.manpages@gmail.com>
 <CAK8P3a0b7_yMExXEiH-4sKnN2Smh+BDB+=dyNvPWVcLvR_zG5w@mail.gmail.com>
Date:   Mon, 22 Nov 2021 10:55:28 +0200
Message-ID: <87r1b8o9hb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Nov 20, 2021 at 2:01 PM Alejandro Colomar
> <alx.manpages@gmail.com> wrote:
>> +
>> +#define __IS_POWER_OF_2_OR_0(n)  (((n) & ((n) - 1)) == 0)
>> +#define __IS_POWER_OF_2(n)       (__IS_POWER_OF_2_OR_0(n) && ((n) != 0))
>> +
>
> There is already is_power_of_2() in include/linux/log2.h, which would
> be preferred
> in most cases. If you need a macro version, put it in the same file
> and explain why it's
> needed.

Also, the macro argument n is evaluated 2-3 times. Please use
checkpatch.pl --strict argument on the patches, and it'll give you hints
about this stuff too.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
