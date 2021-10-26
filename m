Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D265043B52D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhJZPNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:13:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:15154 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234890AbhJZPNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="290772296"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="290772296"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 08:11:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="447153418"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 08:11:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfO6J-0019XK-8U;
        Tue, 26 Oct 2021 18:10:55 +0300
Date:   Tue, 26 Oct 2021 18:10:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Message-ID: <YXgafyMzK+o9FYkN@smile.fi.intel.com>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026144108.35373-1-quic_qiancai@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:41:08AM -0400, Qian Cai wrote:
> Since "size" is an "unsigned int", the rvalue "size - 1" will still be
> "unsigned int" according to the C standard (3.2.1.5 Usual arithmetic
> conversions). Therefore, GENMASK(size - 1, 0) will always return 0UL.

Huh?!

Have you run test_bitmap et al., btw?

-- 
With Best Regards,
Andy Shevchenko


