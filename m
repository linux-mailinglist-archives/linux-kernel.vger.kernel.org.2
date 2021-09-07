Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C24024E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhIGIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:09:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhIGIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:09:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 909FD1FD5A;
        Tue,  7 Sep 2021 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631002116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE+UDLIcmL0uf5lAoyfAWlHoJhKxjw6dpsgL05G4NQ4=;
        b=mRAP/NrRrqQUFpSKeAZRgroS1r3RKbtLICl+LW39SeaHzKW6zlok4QP4NQpMGFPGbrfMV7
        qq64m8/88ZNOYO1gmeozwQiya9J7c1cHbxY8ozubmJlDEdlCtOYiZUsqfm+HEtINK+52ld
        rRPr164T9YzuLxKjAVKElMFxVO3fZDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631002116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE+UDLIcmL0uf5lAoyfAWlHoJhKxjw6dpsgL05G4NQ4=;
        b=ETUZPolDOc4zCar0SL81Gt7AIAEQFwY5ixnV3j/PWRfRIoqJwO/TGrErzQA3fsBO9njq3x
        fhMXqhEWd+cqVLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7772613C50;
        Tue,  7 Sep 2021 08:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CHaNHAQeN2HvTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Sep 2021 08:08:36 +0000
Message-ID: <b4615b3c-8217-9f32-39c7-b91c9ec3cccb@suse.cz>
Date:   Tue, 7 Sep 2021 10:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] mm/page_isolation: don't putback unisolated page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904091839.20270-1-linmiaohe@huawei.com>
 <3b36529f-ab97-ddfe-0407-66f0cd1fd38d@redhat.com>
 <2d06db75-5c26-8fe2-6883-ac99056a9894@redhat.com>
 <b0a2947b-360a-40c2-03e4-f0f67845f4c3@huawei.com>
 <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c60dc5e2-6f19-3be8-56be-555033cc9ca4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 14:49, David Hildenbrand wrote:
> On 06.09.21 14:45, Miaohe Lin wrote:
>> On 2021/9/6 20:11, David Hildenbrand wrote:
>>> On 06.09.21 14:02, David Hildenbrand wrote:
>>>> On 04.09.21 11:18, Miaohe Lin wrote:
>>>>
>>>> Thanks!
>>>>
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>
>>>
>>> To make the confusion perfect (sorry) :D I tripple-checked:
>>>
>>> In unset_migratetype_isolate() we check that is_migrate_isolate_page(page) holds, otherwise we return.
>>>
>>> We call __isolate_free_page() only for such pages.
>>>
>>> __isolate_free_page() won't perform watermark checks on is_migrate_isolate().
>>>
>>> Consequently, __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>>>
>>> If that's correct then we  could instead maybe add a VM_BUG_ON() and a comment why this can't fail.
>>>
>>>
>>> Makes sense or am I missing something?
>>
>> I think you're right. __isolate_free_page() should never fail when called from unset_migratetype_isolate()
>> as explained by you. But it might be too fragile to reply on the failure conditions of __isolate_free_page().
>> If that changes, VM_BUG_ON() here might trigger unexpectedly. Or am I just over-worried as failure conditions
>> of __isolate_free_page() can hardly change?
> 
> Maybe
> 
> isolated_page = !!__isolate_free_page(page, order);
> /*
>   * Isolating a free page in an isolated pageblock is expected to always
>   * work as watermarks don't apply here.
>   */
> VM_BUG_ON(isolated_page);
> 
> 
> VM_BUG_ON() allows us to detect any issues when testing. Combined with 
> the comment it tells everybody messing with __isolate_free_page() what 
> we expect in this function.
> 
> In production system, we would handle it gracefully.

If this can be handled gracefully, then I'd rather go with VM_WARN_ON.
Maybe even WARN_ON_ONCE?

