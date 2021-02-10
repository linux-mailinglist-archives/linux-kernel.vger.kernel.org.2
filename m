Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADA3167B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhBJNPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:15:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:33400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhBJNPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:15:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612962889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YXlzSTaXY6VGS+lXun8+3WilTa+ZmzeXpybuBpOGnB0=;
        b=tc8DXR3zb3fPd+DpCb/lbZWXNwTb4QRhZ16qpJYpxZmKE3auPVVXFVToVze7O0tm5ttPkK
        y9g24hF8MV7RgiZDK+JkOd1Ve7j1YRB624GenhhyRi8Jh2Ctwom7f64n0U822vUKfzkrhS
        EvlUz+DSXVm5mZomNqJZs6rwwj0nrsA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E805AE3F;
        Wed, 10 Feb 2021 13:14:49 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:14:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] lib/test_printf: use KSTM_MODULE_GLOBALS macro
Message-ID: <YCPcSMqxFdI2LrHS@alley>
References: <20210210051814.845713-1-timur@kernel.org>
 <20210210051814.845713-2-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210051814.845713-2-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-09 23:18:12, Timur Tabi wrote:
> Instead of defining the total/failed test counters manually,
> test_printf should use the kselftest macro created for this
> purpose.
> 
> Signed-off-by: Timur Tabi <ttabi@nvidia.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
