Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB603DB759
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhG3KqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:46:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53016 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbhG3KqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:46:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73BC420232;
        Fri, 30 Jul 2021 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627641963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8RgPRColt8mwDXSy/0GyJhYvtrefNnVPTKCBksoqRng=;
        b=rODGsFzRAd1XCkF0LEbdM65C7AEpzd9+5p3cUiMLBLQ03YkqN65obZbHVMWzqxCxXyPWxb
        WoaVwZPUyjqici5ymE7O1sdXzEGYV8hW8+ggjClb/vv+r9nBLZs/+G4DBc5X19ifOETeMy
        LdW3CjHjKSKe6TsTG9MEP4haONJlG3E=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E8D37A3B8A;
        Fri, 30 Jul 2021 10:46:02 +0000 (UTC)
Date:   Fri, 30 Jul 2021 12:45:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] lib/test_scanf: Handle n_bits == 0 in random tests
Message-ID: <YQPYZ0af97pJ4Gzc@alley>
References: <20210727150132.28920-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727150132.28920-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-27 18:01:32, Andy Shevchenko wrote:
> UBSAN reported (via LKP)
> 
> [   11.021349][    T1] UBSAN: shift-out-of-bounds in lib/test_scanf.c:275:51
> [   11.022782][    T1] shift exponent 32 is too large for 32-bit type 'unsigned int'
> 
> When n_bits == 0, the shift is out of range. Switch code to use GENMASK
> to handle this case.
> 
> Fixes: 50f530e176ea ("lib: test_scanf: Add tests for sscanf number conversion")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The patch is committed in linux/printk.git, branch for-5.15.

I would send it for 4.14 if there was another urgent fix needed.
But this one does not look important enough to hurry it up alone.

Best Regards,
Petr
