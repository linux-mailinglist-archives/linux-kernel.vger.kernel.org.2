Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FF3A94BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:10:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:47710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231381AbhFPIKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:10:34 -0400
IronPort-SDR: IpRYbzz6g9SanLWvp+yfqGivir7Hilu58BmW2mD0voM2N2IWF9evIApMaqxqvoYvZZd1S3uE0j
 Zh7VWGkbpsfg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206172017"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="206172017"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 01:08:25 -0700
IronPort-SDR: zJ/1OX5EmUkqVqzyhny2w0M+m76INvVXrFHm0Zu38LlODpJuiyF2h2TIr5+KNpew2bgr1ReUfX
 4n/j6ru8u8Vw==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="621613886"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 01:08:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1ltQaw-002lFR-FG; Wed, 16 Jun 2021 11:08:18 +0300
Date:   Wed, 16 Jun 2021 11:08:18 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 1/5] string_helpers: Escape double quotes in
 escape_special
Message-ID: <YMmxcjeEHHzCLKtX@smile.fi.intel.com>
References: <cover.1623775748.git.chris@chrisdown.name>
 <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
 <CAHp75Vc-edpD5kz0EPsO7Q=zOPHWFckZzc17imO85dQy-PpOgg@mail.gmail.com>
 <YMk/IKA4okfYSh57@chrisdown.name>
 <796701ff-18f9-a637-fca4-808ae36b336f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796701ff-18f9-a637-fca4-808ae36b336f@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:05:25PM -0700, Randy Dunlap wrote:
> On 6/15/21 5:00 PM, Chris Down wrote:
> > Andy Shevchenko writes:
> >>> I've checked uses of ESCAPE_SPECIAL and %pE across the codebase, and I'm
> >>
> >> checked the uses
> > 
> > Hmm, what's wrong with using the zero article for "checked uses"? I mean, I don't have any strong resistance, but I don't see anything wrong with it either, and it matches how I'd naturally speak.
> > 
> > Agreed on the others, though, hopefully they can be massaged in :-)
> 
> Ack, I don't see anything wrong with it either.

I guess you know better than me :-)

I'm just a mere non-native speaker here to whom it's stylistically harder to
parse without the article.


-- 
With Best Regards,
Andy Shevchenko


