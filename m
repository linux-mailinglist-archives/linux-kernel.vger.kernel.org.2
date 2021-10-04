Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B41420A25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhJDLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:36:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhJDLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:36:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73048222D2;
        Mon,  4 Oct 2021 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633347258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCIcbz578d05l8H6orwYONZYlALfoCLI+RMgU0tteQM=;
        b=jwtkeGlJbe1185EhljyGhHf4T7eG8yv0WGhGRTiLIX/EOarfB1kMltTmzeLaTU1UbTN97Y
        v/n4/plRBRGfrPs4Raw9n1GgRCkP6bkWFvafNl2f/gWuSZJjIiWf8N5HQNHNfr0k9nrE7m
        bAxDqHoeLgNnbHa50tTvQRQGBY53tQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633347258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCIcbz578d05l8H6orwYONZYlALfoCLI+RMgU0tteQM=;
        b=c7mE1xQhR4T8/hpz9RbCTXOZ+oEvqfmGPvX+uxCO2JaYeYNbcaXLG3CiUINn8cuyHL5zUW
        tMF0Kq/FRjpVjzCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A63101348D;
        Mon,  4 Oct 2021 11:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q7f7J6DmWmEsBAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 04 Oct 2021 11:33:52 +0000
Message-ID: <8224ddae-88f5-63ab-c375-473462c50efe@suse.cz>
Date:   Mon, 4 Oct 2021 13:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20210928111231.GA2596@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <b3c5bd9a-5fbc-8388-a4ab-6c20864dc7c6@suse.cz>
 <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211003055928.GA7643@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/21 07:59, Hyeonggon Yoo wrote:
> Hello Vlastimil! I'm happy to discuss with you.
> I hope this discussion to make us think about slab allocator.

Yeah, it's useful, thanks for asking!

> On Fri, Oct 01, 2021 at 04:07:56PM +0200, Vlastimil Babka wrote:
>>>> In some contexts it's still being preferred, AFAIK.
>>>
>>> In what context is SLAB or SLUB is preferred?
>>
>> I don't know the full answer. With our distro we have used SLAB, and
>> switched to SLUB after verifying that there are no major regressions.
>> Better debugging features were perhaps the major reason.
>>
> 
>>> And what is the core reason that SLUB is used by default?
>>
>> The usual reason in MM, nobody objected :)
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0acd82080768
>>
> 
> What was the decision based on ? performance measurements or anything

I haven't been around back then, so don't know. Also tried to find this
particular patch (and possible replies) in the linux-mm lore archive,
and didn't succeed. Might have been event sent off-list by mistake.

> else? 'Because nobody objected' is not a good reason to make a decision.

:)

>>>>> So there is a fundamental question coming into my mind:
>>>>>     'is SLAB considered legacy and deprecated?'
>>>>
>>>> To some extend, but not yet in a sense where we would have a deadline to get
>>>> rid of it.
>>>>
>>> What makes you to say 'To some extent'?
>>> That's what I'm curious about :)
> 
>> "To some extent" because SLUB is default and if some new stuff was added
>> that only worked with SLUB and not SLAB, there wouldn't be major
>> objections expected.
> 
> You said new features are added to only SLUB and there are no
> objections expected, But what makes you to do so?
> 
> You are not saying why. what you are saying is just only result.
> What is the mind behind maintaining SLUB and neglecting SLAB?

David explained it well. I'll add it's a question of motivation, people
generally add features to the subsystem they prefer, and most prefer
SLUB these days, and in that case we don't require the same feature to
be added to SLAB (or even SLOB) as well. But if someone wants to, we
also don't stop them - but to some extent. If someone suddenly came up
with "SLUB has this nice debugging and SLAB not, so I will reimplement
it there" we would be questioning hard if the code churn is really needed.

