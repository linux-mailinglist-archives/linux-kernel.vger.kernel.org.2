Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56663D93C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhG1RAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:00:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1RAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:00:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79A672233C;
        Wed, 28 Jul 2021 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627491599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyXW6xUfPTUnUZJ6oH3KvHje/GF1ltuNjbTPg6/jqyE=;
        b=SLfsEOfTDWgPGZMX9EwLdou2yiJ1cNqMm1JnCc60ppYx4zP58wYCVWVP4AVkMWBzXhKOaQ
        KgKybCqoTDFIT+NMUy9RpZcjBMq0AG9LFdTPM5EGK+gql7o5p7r6PnUiil5usqMwIWn0N/
        M1iRWJvLucyPd0P0aNxMLm7aVZwb7yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627491599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyXW6xUfPTUnUZJ6oH3KvHje/GF1ltuNjbTPg6/jqyE=;
        b=0P3adp+HQmpyIEwwxzYx+Ng1ZQyFD5TrSY6CzwhiO+b13JttT4oetEw/h4adeBSFccPv7C
        fXF4gUqPAky8tJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4712E13AC2;
        Wed, 28 Jul 2021 16:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VU19EA+NAWEbDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 28 Jul 2021 16:59:59 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <878s2fnv79.ffs@nanos.tec.linutronix.de>
 <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
 <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
 <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
 <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
 <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
 <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
 <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
 <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
 <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
 <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
 <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
 <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
 <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
 <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
 <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
 <26c181c9-ec48-09e2-2d73-6fc769a19c76@suse.cz>
 <7970e9c3de5d29b93f692001a3796da1b3df45b4.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <74c71cac-f36a-9c42-2ab1-837c6a068306@suse.cz>
Date:   Wed, 28 Jul 2021 18:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7970e9c3de5d29b93f692001a3796da1b3df45b4.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 6:09 AM, Mike Galbraith wrote:
> On Mon, 2021-07-26 at 23:26 +0200, Vlastimil Babka wrote:
>> On 7/26/21 7:00 PM, Mike Galbraith wrote:
>>>
>>> Why not do something like the below?...
>>
>> Yep, sounds like a good approach, thanks. Percpu partial is not *the*
>> SLUB fast path, so it should be sufficient without the lockless cmpxchg
>> tricks. Will incorporate in updated series.

The updated series incorporating hopefully all fixes from Mike and
bigeasy, and rebased to 5.14-rc3 (Thomas told me RT is moving to it), is
here:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r0

I'll post it to linux-mm tomorrow.
