Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0024040BBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhINWtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:49:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47552 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhINWtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:49:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C0F322146;
        Tue, 14 Sep 2021 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631659679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vqgHxptFilI+52z7LDkXnCdgIqfeyzwesZHjTddRvQ=;
        b=vlKcsoRevVDE4QM2CQlxH5yAblVY+W2Om5b8nNLEhiROlotFE13KJy5hvpOaJAdnqALZ66
        FRaIVBktsb7j2IHYVg56S2J/MNS7BXHHlXyn0z/kBDE0KDi2wuG0ISJQNEFsd/owfpiRlQ
        bItHfwgm7VxNv2Hsfppb14+ZP/6zo8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631659679;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vqgHxptFilI+52z7LDkXnCdgIqfeyzwesZHjTddRvQ=;
        b=0oi9K/0RQ71UYGVu2ipyGx9jQ2myDnsW0oyjjUGV4oVjW8PqLUrUbDVf4GZbkyWXjnIQml
        H4W6LOllQTLQVzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A3BD13B4E;
        Tue, 14 Sep 2021 22:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9YhkFZ8mQWHsVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Sep 2021 22:47:59 +0000
Message-ID: <4392e867-0cce-d04a-e3d1-cba152daaa1f@suse.cz>
Date:   Wed, 15 Sep 2021 00:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210914105620.677b90e5@oasis.local.home>
 <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
 <20210914145953.189f15dc@oasis.local.home>
 <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
 <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
 <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
 <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
 <20210914170553.7c1e1faa@oasis.local.home>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210914170553.7c1e1faa@oasis.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 23:05, Steven Rostedt wrote:
> On Tue, 14 Sep 2021 13:48:15 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Tue, Sep 14, 2021 at 12:38 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> > So I'll do a minimal conversion that adds "memblock_free_ptr()" and
>> > hope that people start using that. And then we can later try to move
>> > "memblock_free()" to a name that isn't so misleading.  
>> 
>> Commit 77e02cf57b6c ("memblock: introduce saner 'memblock_free_ptr()'
>> interface") should hopefully fix that panic that Vlastimil saw, and
>> the kernel test robot report as well.
>> 
>> And it should make it easy to cleanly fix that 'copy' leak too.
>> 
> 
> Vlastimil,
> 
> Can you confirm that Linus's changes addresses your issue?

Well, looks like I can't. Commit 77e02cf57b6cf does boot fine for me,
multiple times. But so now does the parent commit 6a4746ba06191. Looks like
the magic is gone. I'm now surprised how deterministic it was during the
bisect (most bad cases manifested on first boot, only few at second).

> Masami,
> 
> Care to rebase on top of Linus's change?
> 
> Thanks!
> 
> -- Steve
> 

