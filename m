Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A331A60D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBLU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBLU3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:29:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76BC364E01;
        Fri, 12 Feb 2021 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613161746;
        bh=czE9tqeAxREhaNvBy6f3QpgF4Gi6kmxTebwcxdGejsM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xq4F2eDH/aAsoe4KG0AMOE6Q7APVwpcPHiOzQsLTiKgV0R7lVPE63NMXdEb9gPioQ
         dObKghkWj9cI6X+wcYznNDrjOSKBbNeWwhCdyR18DxckNQ/Eq9a0kS68FAb+m/TJFs
         8/ybfTenXeKJuO4E+kIgD7whN5lDGdobSJ5ql1igItmF3pD937NYm24GEyZXQXG8w8
         cCZz7g2qJSSaDZSTM1f8KpDeXQDIvk9CewhYyyaEmoExUCxcYl7KxPKd//2qxskX//
         bnNG0y9Q75qLD0DFQHaD6jfTASxw7F0d5fA6YvTaWyBauSQ2GzVjz2qLtVTi625bSZ
         m04b+DGuqD+4Q==
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
To:     Petr Mladek <pmladek@suse.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
 <20210211172026.GL308988@casper.infradead.org> <YCZR/VQ6M61JIEN0@alley>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <99425ccf-a8e4-19fd-a504-eac2cfe31585@kernel.org>
Date:   Fri, 12 Feb 2021 14:29:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCZR/VQ6M61JIEN0@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/21 4:01 AM, Petr Mladek wrote:
>> no_hash_pointers ?
> I am fine with this.
> 
> I am still a bit scared of a bikeshedng. But AFAIK, Mathew was most
> active on proposing clear names. So, when he is fine with this...
> 
> Anyway, we should use the same name also for the variable.

Ok, unless there are any objections, I will change the parameter and 
variable to "no_hash_pointers" in v4, which I will send out later today.

I hope this patch set gets accepted for 5.12.

