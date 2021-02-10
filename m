Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C08B315EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhBJFWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231252AbhBJFWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:22:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09F9364E42;
        Wed, 10 Feb 2021 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612934523;
        bh=g8YIvUlkGhcA/pPBzQqmuSnsMBPhJKO3xghKhjPkhio=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=T3iQ62knUTWjRkaP3czi5xNj2G0BaJ5UIidUvF0x1Cv0/NYHw9ZldmaI1qulTfwyF
         XX5u3xbYNR/rk7zMdstvQPMghc92ODFFNPSJObEKVFMa9CsejWvpQRCj5G0T0zdttp
         7JA2S1HVCmRMRrfXcI404erni2SjAECK8+baJm9IZv4pd745Klsj/prkJjJ9E+9D1X
         7KBobENMp5Suz1LGWnz52A3Y90mtQTAdz2Yj2Xqv9Poa2T8U+kxUizgZj4rgAPZob6
         hpQMnqJ3+wTBwfEouR6+YyPODx5ETlnC0/81H0mYXVoHH0LxkcSV8Zyctdy6qm7F95
         7fB1hfn6G5NJw==
Subject: Re: [PATCH 1/3] lib/test_printf: use KSTM_MODULE_GLOBALS macro
From:   Timur Tabi <timur@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
References: <20210210051814.845713-1-timur@kernel.org>
 <20210210051814.845713-2-timur@kernel.org>
Message-ID: <78fb41d4-3382-2bc6-c0dd-9aa2026c04fe@kernel.org>
Date:   Tue, 9 Feb 2021 23:21:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210051814.845713-2-timur@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:18 PM, Timur Tabi wrote:
> Instead of defining the total/failed test counters manually,
> test_printf should use the kselftest macro created for this
> purpose.
> 
> Signed-off-by: Timur Tabi<ttabi@nvidia.com>

Ugh, I really need to stop sending patches late at night.  This is again 
the wrong email address.

I'm sure I'll need to post another version of these patches, so I'll 
just fix it then.
