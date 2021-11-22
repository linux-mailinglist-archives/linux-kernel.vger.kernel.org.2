Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8B5458ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbhKVNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:00:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:30848 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhKVNAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:00:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="215491133"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="215491133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 04:57:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="674054756"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 04:57:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mp8sx-009R7D-Hf;
        Mon, 22 Nov 2021 14:57:27 +0200
Date:   Mon, 22 Nov 2021 14:57:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] bitops: Add single_bit_set()
Message-ID: <YZuTt3+PPvyJsFQ/@smile.fi.intel.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <73d5e4286282a47b614d1cc5631eb9ff2a7e2b44.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZt+x2moR632x///@smile.fi.intel.com>
 <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c22b52f-9a1f-06f5-f008-d568096f5c4d@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 12:42:21PM +0000, Vaittinen, Matti wrote:
> On 11/22/21 13:28, Andy Shevchenko wrote:
> > On Mon, Nov 22, 2021 at 01:03:25PM +0200, Matti Vaittinen wrote:
> >> There are cases when it is useful to check a bit-mask has only one bit
> >> set. Add a generic helper for it instead of baking own one for each
> >> user.

> > So, you decided to reinvent hamming weight...
> > Please, drop this patch and use corresponding hweight() call.

> Thanks Andy.
> 
> There are few differences to hamming weight here. We scan only given 
> amount of bits - and we will end scanning immediately when we hit second 
> set bit. Oh, and obviously we only return information whether there is 
> exactly one bit set. So no, this is not hamming weight().

What do you mean by this?

hweight() will return you the number of the non-zero elements in the set.
In application to boolean based arrays it means the number of bits that
are set. Obviously, the condition `hweight() == 1` is what you are looking
for.

Or is there anything that missed in the equation?

> Yet, I think you are correct. My use-case does not warrant adding this. 
> I have no need for scanning only certain amount of bits.

(I guess no need to tell that eliminating bits is using mask in the parameter
 as you do anyway by supplying amount of bits.)

> I think I actually tried using hweight() at some point but don't really 
> remember why I rolled the single_bit_set. (I remember the hweight() 
> usage because I had to do some googling as I had never heard term 
> hamming weight before).

Oh, it should be a very good reason not to use hweight() since on some
architectures it might become just one assembly instruction.

> I'll see how it works out and if (when) it does I'll respin the series 
> w/o this as you suggested. So thanks.

(Side note: all your sentences but last in all of the paragraphs are ending
 with trailing space. For example, "series " and "thanks." for the comparison
 in the previous paragraph. Can you fix this, please?)

-- 
With Best Regards,
Andy Shevchenko


