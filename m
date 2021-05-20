Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8422738A4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 12:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhETKI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 06:08:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234495AbhETKCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 06:02:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B5D9ADCE;
        Thu, 20 May 2021 10:01:21 +0000 (UTC)
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210520013539.3733631-1-swboyd@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/3] slub: Print non-hashed pointers in slub debugging
Message-ID: <b7574917-eecd-0a83-0d55-d8fefecd3536@suse.cz>
Date:   Thu, 20 May 2021 12:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210520013539.3733631-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC folks from the no_hash_pointers debate

Full thread with patches here:
https://lore.kernel.org/linux-mm/20210520013539.3733631-1-swboyd@chromium.org/

On 5/20/21 3:35 AM, Stephen Boyd wrote:
> I was doing some debugging recently and noticed that my pointers were
> being hashed while slub_debug was on the kernel commandline. Let's make
> the prints in here meaningful in that case by pushing %px throughout.

But we actually added no_hash_pointers exactly so that we don't push %px in
hexdump and others. So I don't think this will be accepted.

> Alternatively, we could force on no_hash_pointers if slub_debug is on
> the commandline. Maybe that would be better?

That would certainly be more acceptable, but maybe still too much, dunno. I'm
neutral on this approach, let's see what others think.

> The final patch is just something else I noticed while looking at the
> code. The message argument is never used so the debugging messages are
> not as clear as they could be.
> 
> Stephen Boyd (3):
>   lib/hexdump: Add a raw pointer printing format for slub debugging
>   slub: Print raw pointer addresses when debugging
>   slub: Actually use 'message' in restore_bytes()
> 
>  include/linux/printk.h |  1 +
>  lib/hexdump.c          | 12 ++++++++++--
>  mm/slub.c              | 24 ++++++++++++------------
>  3 files changed, 23 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> 

