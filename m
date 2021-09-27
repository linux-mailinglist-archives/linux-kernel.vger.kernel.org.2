Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343B74199E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhI0RFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:05:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46248 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhI0RE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:04:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 004DC20181;
        Mon, 27 Sep 2021 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632762200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eGUfOqPu/lBwkmpXEEWf9be9AIbg3skC9AUOGR+PNc=;
        b=eY+WNJRUcWKQSCqIUh5pqlcUJnX7wu1s2AewRudU0KhKD6YTAp405SJN5p0eUASBp1erpw
        JOCLZFzVeIuxd63kO3h5Y+NVt96K7a0XLoxOqwCWNRzjYJiwVCNWGHxY5Lgzz6475G7n4W
        KhT0vUSX2ddzMpb0husjLKJ4ipWt9C4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632762200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eGUfOqPu/lBwkmpXEEWf9be9AIbg3skC9AUOGR+PNc=;
        b=N0RG5IjFRwQwL708PF1zjGwojvl15FahJuW0VPxsCnIuIcGg5hkEqkoVyVqimZDBghq42t
        LOWzqqDwkci8kpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D23A713C08;
        Mon, 27 Sep 2021 17:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BaiNMlf5UWEbCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Sep 2021 17:03:19 +0000
Message-ID: <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
Date:   Mon, 27 Sep 2021 19:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [QUESTION] is SLAB considered legacy and deprecated?
In-Reply-To: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 11:03, Hyeonggon Yoo wrote:
> Hello there,
> 
> I've been working on adding 'lockless cache' on sl[au]b for a while.
> But what it actually does is actually adding 'queuing' on slub.

Yeah, I pointed out those threads from 2011 that called it exactly that...
was there any conclusion why that was not ultimately merged?

> So there is a fundamental question coming into my mind:
> 	'is SLAB considered legacy and deprecated?'

To some extend, but not yet in a sense where we would have a deadline to get
rid of it. In some contexts it's still being preferred, AFAIK. But it's okay
if new optional features require just SLUB - for example PREEMPT_RT.

> It seems there are little development on SLAB and people think that
> SLAB is legacy and deprecated, so CONFIG_SLUB is used by default.
> 
> But I think both has pros and cons for their own:
> 	SLAB: more temporal locality (cache friendly)
> 	but high usage of memory, and less spatial locality (TLB misses) than SLUB.
> 
> 	SLUB: less temporal locality (less cache friendly) than SLAB
> 	but more spatial locality (TLB hit), and low usage of memory
> 	and good debugging feature.

I'm not so sure about the usage of memory, SLUB can easily use more I
believe. Instead of caching some arrays of objects it will have one or more
private slabs per cpu, and the slabs are larger-order pages.

> Why do people say SLAB is deprecated/legacy?

Do they?

> Thanks,
> Hyeonggon
> 

