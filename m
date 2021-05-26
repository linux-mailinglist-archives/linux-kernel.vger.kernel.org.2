Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8439154A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhEZKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:48:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhEZKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:48:18 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 06:48:18 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0DF081FD2A;
        Wed, 26 May 2021 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622025595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KD821Af/b6RRIHsdgv0g22hq7wVaU0ZGBhHOcUjSdrM=;
        b=qzYHum4jCmWudPtkF1t+pQnFXyvfT4HZIggrgc/t02N/lrOSENX/d65Y7fIaYjGql2i0zK
        3JiBSsKraXPEIbARudiFb5bLzUeunKF6w5B5MN+30KrwkYQJeyCSK98TVKEr/RWWR3mSCq
        mh/3CEFMU+CWVPpyGsr9EST+IxrH9qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622025595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KD821Af/b6RRIHsdgv0g22hq7wVaU0ZGBhHOcUjSdrM=;
        b=mw4n6QUXmfTZ8CHmQrjbpWWdcYC5kpTmZjjphapFFDOx8ZOWPvfl5CN3JvIQ8ayjExcRD0
        xFS+0KWfjs3WbPDw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id DC7F211A98;
        Wed, 26 May 2021 10:39:54 +0000 (UTC)
Subject: Re: [External] [PATCH v2 1/4] slub: Restore slub_debug=- behavior
To:     Muchun Song <songmuchun@bytedance.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
References: <20210526025625.601023-1-swboyd@chromium.org>
 <20210526025625.601023-2-swboyd@chromium.org>
 <CAMZfGtVdzwjJLuUvcmgivKZNU1TK+ePFH9wgcm6jH86FWFHbJA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d6a4c360-0bbc-e36f-0824-04562c92f411@suse.cz>
Date:   Wed, 26 May 2021 12:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVdzwjJLuUvcmgivKZNU1TK+ePFH9wgcm6jH86FWFHbJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 6:04 AM, Muchun Song wrote:
> On Wed, May 26, 2021 at 10:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> Passing slub_debug=- on the kernel commandline is supposed to disable
>> slub debugging. This is especially useful with CONFIG_SLUB_DEBUG_ON
>> where the default is to have slub debugging enabled in the build. Due to
>> some code reorganization this behavior was dropped, but the code to make
>> it work mostly stuck around. Restore the previous behavior by disabling
>> the static key when we parse the commandline and see that we're trying
>> to disable slub debugging.
>>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Fixes: e17f1dfba37b ("mm, slub: extend slub_debug syntax for multiple blocks")

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> 
> Is it caused by the commit ca0cab65ea2b ("mm, slub: introduce static
> key for slub_debug()")?

Yep, looks like a better Fixes: candidate.

>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>  mm/slub.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 438fa8d4c970..2f53e8a9c28e 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1396,6 +1396,8 @@ static int __init setup_slub_debug(char *str)
>>  out:
>>         if (slub_debug != 0 || slub_debug_string)
>>                 static_branch_enable(&slub_debug_enabled);
>> +       else
>> +               static_branch_disable(&slub_debug_enabled);
>>         if ((static_branch_unlikely(&init_on_alloc) ||
>>              static_branch_unlikely(&init_on_free)) &&
>>             (slub_debug & SLAB_POISON))
>> --
>> https://chromeos.dev
>>
> 

