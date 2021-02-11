Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA706319232
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhBKSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhBKSSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:18:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32D0C64E62;
        Thu, 11 Feb 2021 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613067461;
        bh=a/ICQhvy+vCwAeCKLCXy2crzr066Jt2P9U56XoLiHhs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KIv+jTuyjEVZseLzLn1Wm+cD02eF4xmTW3WG2LJDxOIw3yqu30mH/OpY6bHr7W7tY
         KTtFfbMWDkpi8KA+3oA8wWsnG/VWTv/5hhOHotIfBiCOwtjtOJKQBrOeMJjIi9kXPN
         PTl8KGvZ1jRjJszND4A2inKib1zRUkHI+LxkCYO8KLbWsi1s7kvtVsw2fxfvHd2n64
         EdXAhs7OmWErMWLKP9ouC0DNSddtQ8O282p37B2tVwc1rwlY/qeDh6ej8DgrLsCrPo
         b9owFfDmXLxdiRIotAZ7t0ZW5zaa+NKnvNwt7yM6FNZgRtdfeoVLURjMgVM99eKW6J
         LpAhlhta/fTQw==
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
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
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org> <20210211123118.GB31708@amd>
 <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org> <YCVoGhe7FSHnQMOl@alley>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <b643cf05-d6dd-9a86-c085-88534a2b867c@kernel.org>
Date:   Thu, 11 Feb 2021 12:17:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCVoGhe7FSHnQMOl@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 11:23 AM, Petr Mladek wrote:
> There was some pushback against this feature in general.
> It should be used deliberately and people must be aware
> of the consequences. This is why it is only boot option
> and why it prints such a huge warning. The long clear
> name helps as well.

This is my thinking as well.  I wanted it to be a bit obnoxious.
