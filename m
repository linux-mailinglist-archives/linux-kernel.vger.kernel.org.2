Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6441C31B12F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBNQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhBNQTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:19:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0243564E26;
        Sun, 14 Feb 2021 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613319522;
        bh=p7z/PAaa9h8hWJe6xkCOxc27Iz8NTK/cuu7aFF86WkY=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=cr47/pgH8otatIkf4s0WP8E/DL4cl6cg+Cp3P4QJfEPwl+hwz8uzt4b8wzgO16coJ
         mvKynNsIrHj224XeqhAjKZyy3ngkzWhRagSYDBXzrJYoVNr/JFp5p72kQ+oc/bUF7J
         mrjV4oyV256Lac/o3zu+AvKjSHdHz5gziavIJvZIlMEpDFRxGon/0bwnZGogdwGpiR
         BCVOtD+bhbOTpl5k50mkbppBBDDLyKA2euFTzxNhtDlhdCJtR7JzJZBCPqC/7u1HUj
         1FFL2ptwj2Q+U1mHwPCSvRw3M9EEELHeO/mfUkReSpSUyr05B5X3WA3V5iV0O9aqGk
         VqHU5qNAizXYg==
Subject: Re: [PATCH 0/3][v4] add support for never printing hashed addresses
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
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210214161348.369023-1-timur@kernel.org>
Message-ID: <2e7bd5a2-2def-e615-2b46-9d167bcf3439@kernel.org>
Date:   Sun, 14 Feb 2021 10:18:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210214161348.369023-1-timur@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/21 10:13 AM, Timur Tabi wrote:
> Although hashing addresses printed via printk does make the
> kernel more secure, it interferes with debugging, especially
> with some functions like print_hex_dump() which always uses
> hashed addresses.

I believe that this version addresses all outstanding issues, so unless 
there are any complaints, I would like for this patch set to be merged 
for 5.12-rc1.  I don't know who should pick it up, though.

Thanks.
