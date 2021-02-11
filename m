Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8F3191B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhBKR5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:57:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:44182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhBKRY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:24:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613064219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWYmxmlJhWs/eHrgE4qsJfBzpcX3ZdkLwS/bN4B28wE=;
        b=i4MF4afunucbyASG65Af2ycJnl66rT0KbW4KX8o33ltJbmpgPhMSkafixM8IvVJdDGCU/J
        5S1k4YE5oRdNEnv7Tu3dCxJrEqg4N1Wqoe0S5IADrjFRwzPVSl52tXflYojrF8Qgn4+6v6
        DCVzbBQgn609lFvGMotjJLk4K7SFwJA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4E04AC43;
        Thu, 11 Feb 2021 17:23:39 +0000 (UTC)
Date:   Thu, 11 Feb 2021 18:23:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
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
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
Message-ID: <YCVoGhe7FSHnQMOl@alley>
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org>
 <20210211123118.GB31708@amd>
 <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-11 11:08:12, Timur Tabi wrote:
> 
> 
> On 2/11/21 6:31 AM, Pavel Machek wrote:
> > Can we make this something shorter? Clearly you don't want people
> > placing this in their grub config, so they'll be most likely typing
> > this a lot...
> > 
> > debug_pointers or debug_ptrs would be better.
> 
> dbg_unhash_ptrs?  "debug_ptrs" is too vague IMHO, and I want to keep the
> word "hash" somewhere there to indicate exactly what's happening.

I understand that the long name is painful. But I would prefer to
avoid another bike shedding over it.

There was some pushback against this feature in general.
It should be used deliberately and people must be aware
of the consequences. This is why it is only boot option
and why it prints such a huge warning. The long clear
name helps as well.

I propose to keep the name as is for now. We could always
introduce an alias later when there is a wide preference
and consensus.

Best Regards,
Petr
