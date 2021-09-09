Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1B404789
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhIIJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:08:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:08:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F38E0221EA;
        Thu,  9 Sep 2021 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631178446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WctYzwLXXPIR3jZzZAQxb473UhEPmFOZxJAH8xVIZI=;
        b=mXqPO+EiK7sj/Jz3x1pMrGbPXX600/96rShQTrKK/UXt9fFfrRu7MxTiQrgndODqdq57BZ
        b4oOSSeo3bUg24Wrwdy9dRT66NUaBGsTReo6Xizv8HpHD+7t8YgEDGg43ZZzUvO6dKJonO
        TXZRsGO0DlZGyV9LjbknfkW3JEOnZ2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631178446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WctYzwLXXPIR3jZzZAQxb473UhEPmFOZxJAH8xVIZI=;
        b=R0VZbYPF4FwG+mu+kpaQVO7BlCIbQFjerTQsdFXJHCxwxGUzSariZpM/lemDpmWA9id9uO
        Z3D5rq7Pp36Wd2DA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CF08A13727;
        Thu,  9 Sep 2021 09:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SP/pMM3OOWGsHwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 09 Sep 2021 09:07:25 +0000
Message-ID: <f9cc811d-2932-845d-da0e-eea493981d11@suse.cz>
Date:   Thu, 9 Sep 2021 11:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
 <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
 <80cfffdc-227e-c045-be74-1c08fb62c1e3@redhat.com>
 <febcceaa-7d94-c3a3-c683-7a8694981b47@nvidia.com>
 <efdab0d6-199a-1bb8-79bf-ea0a5b94c093@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <efdab0d6-199a-1bb8-79bf-ea0a5b94c093@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 10:56, David Hildenbrand wrote:
> On 09.09.21 00:42, John Hubbard wrote:
>> On 9/7/21 2:56 AM, David Hildenbrand wrote:
>> ...
>>>> If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
>>>> Maybe even WARN_ON_ONCE?
>>>>
>>>
>>> I think either VM_BUG_ON() or VM_WARN_ON() -- compiling the runtime
>>> checks out -- should be good
>>> enough.
>>>
>>> I'd just go with VM_BUG_ON(), because anybody messing with
>>> __isolate_free_page() should clearly spot
>>> that we expect the current handling. But no strong opinion.
>>>
>>
>> If in doubt, WARN*() should be preferred over BUG*(). There's a pretty long
>> history of "don't kill the machine unless you have to" emails about this, let
>> me dig up one...OK, maybe not the best example, but the tip of the iceberg:
> 
> Please note the subtle difference between BUG_ON and VM_BUG_ON. We expect
> VM_BUG_ON to be compiled out on any production system. So it's really only a
> mean to identify things that really shouldn't be like that during
> debugging/testing.

IIRC Fedora used to have CONFIG_DEBUG_VM enabled, did it change?

> Using WARN... instead of VM_BUG_ON is even worse for production systems.
> There are distros that set panic_on_warn, essentially converting WARN...
> into BUG...

Uh, does any distro really do that?
