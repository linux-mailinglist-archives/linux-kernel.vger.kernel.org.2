Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5D93FD7A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhIAK1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:27:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38300 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhIAK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:27:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71AD022527;
        Wed,  1 Sep 2021 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630491971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YA/eu1n75AvTFrh7eFA15tiGyX9ZJQmZ1I4nxqfhe/o=;
        b=i8JHGyT8Gs9o13kDIYZPQ+jVK+hlXuMh2aSFKFm2lxKpMM3f57SZDP7ZBcRIGemht3nyrM
        j7GkxaSQ7H1bycl3NWKfopFUDzjfdmCjK0Un5eVM6x0QdMzJjUEzxYwVQDTyulMxQsTlx7
        HbLiJg8kOiKNkwJ1BcE4587m4QXiANE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630491971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YA/eu1n75AvTFrh7eFA15tiGyX9ZJQmZ1I4nxqfhe/o=;
        b=z36rLzSQzIZabs4vlxpWMtyeDiBxjHb8AAZtwMLGASt97Qax9PXhtj17lWv7lPyIg60Ph5
        lLdeDSP1VfmZ0WDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4A1771396A;
        Wed,  1 Sep 2021 10:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id k7oeEUNVL2HJKAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 01 Sep 2021 10:26:11 +0000
Message-ID: <07fd6599-88cc-e353-26f0-5de3eeea5b9f@suse.cz>
Date:   Wed, 1 Sep 2021 12:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210817202146.3218-1-shy828301@gmail.com>
 <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
 <20210831233839.afaenhn32nx6m2fq@box.shutemov.name>
 <CAHbLzkrXOM0Ow3YbZnj9RyvTJ8fwaUCzAizOMR5MP=TkxeLywg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHbLzkrXOM0Ow3YbZnj9RyvTJ8fwaUCzAizOMR5MP=TkxeLywg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 05:46, Yang Shi wrote:
> On Tue, Aug 31, 2021 at 4:38 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>>
>> On Mon, Aug 30, 2021 at 11:49:43AM -0700, Yang Shi wrote:
>> > Gently ping...
>> >
>> > Does this patch make sense? BTW, I have a couple of other khugepaged
>> > related patches in my queue. I plan to send them with this patch
>> > together. It would be great to hear some feedback before resending
>> > this one.
>>
>> I don't really care for !NUMA optimization. I believe that most of setups
>> that benefit from THP has NUMA enabled compile time.
> 
> Agreed.
> 
>>
>> But if you wanna to go this path, make an effort to cleanup other
>> artifacts for the !NUMA optimization: the ifdef has to be gone and all
>> callers of these helpers has to be revisited. There's more opportunities to
>> cleanup. Like it is very odd that khugepaged_prealloc_page() frees the
>> page.
> 
> Yes, they are gone in this patch. The only remaining for !NUMA is
> khugepaged_find_target_node() which just returns 0.

As Kirill pointed out, there's also khugepaged_prealloc_page() where the
only remaining variant does actually no preallocation, just freeing of an
unused page and some kind of "sleep after first alloc fail, break after
second alloc fail" logic.
This could now be moved to khugepaged_do_scan() loop itself and maybe it
will be easier to follow.

>>
>>
>> --
>>  Kirill A. Shutemov
> 

