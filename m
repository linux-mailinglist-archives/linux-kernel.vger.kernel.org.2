Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34433956C8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEaIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:21:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39918 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:21:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 406092191B;
        Mon, 31 May 2021 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622449163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlzazUtEmtoadridASgILyqQxnhngXX4KEnMbi5q6xg=;
        b=OuD+AINjEeahKJt5AYuPK7OpdtmSIE7UGcXtvNKnEGcocYDC0JGZtvtWmXny1+b+lW05iE
        0ZYOSgq66Xw9Lpfu8UNKgo9rkL1197sb2VMPEFcm6aCDLgo4LuigFFuFnjqNvCgXddexyu
        IRHibs0bznMqcrhJDDGNyFyy+mHYsws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622449163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlzazUtEmtoadridASgILyqQxnhngXX4KEnMbi5q6xg=;
        b=ltknWAiucss/xC/IeLI9znxs3U+QnNVcxPwsnwXnDBl9cULDuoI8kMLZXAt0qHGfljyRaI
        Sm5fThRGU2stNvCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 08D65118DD;
        Mon, 31 May 2021 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622449163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlzazUtEmtoadridASgILyqQxnhngXX4KEnMbi5q6xg=;
        b=OuD+AINjEeahKJt5AYuPK7OpdtmSIE7UGcXtvNKnEGcocYDC0JGZtvtWmXny1+b+lW05iE
        0ZYOSgq66Xw9Lpfu8UNKgo9rkL1197sb2VMPEFcm6aCDLgo4LuigFFuFnjqNvCgXddexyu
        IRHibs0bznMqcrhJDDGNyFyy+mHYsws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622449163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlzazUtEmtoadridASgILyqQxnhngXX4KEnMbi5q6xg=;
        b=ltknWAiucss/xC/IeLI9znxs3U+QnNVcxPwsnwXnDBl9cULDuoI8kMLZXAt0qHGfljyRaI
        Sm5fThRGU2stNvCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ADQsAQuctGCCMQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 31 May 2021 08:19:23 +0000
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, Greg KH <greg@kroah.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz> <YK41eFeL5j4qqSnV@kroah.com>
 <0b0e5e43-2ccf-a8a4-1e3b-ab2326c55321@suse.cz>
 <be061209-7480-d1eb-4b70-883259aadffb@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <043cfec6-7881-46e8-ec9c-3b4d6611ac2c@suse.cz>
Date:   Mon, 31 May 2021 10:19:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <be061209-7480-d1eb-4b70-883259aadffb@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_SEVEN(0.00)[11];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,codeaurora.org]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 9:11 AM, Faiyaz Mohammed wrote:
> 
> 
> On 5/26/2021 5:43 PM, Vlastimil Babka wrote:
>> On 5/26/21 1:48 PM, Greg KH wrote:
>>> On Wed, May 26, 2021 at 01:38:55PM +0200, Vlastimil Babka wrote:
>>>>
>>>> alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
>>>> flush it. So only the init call that happens to be called first, does actually
>>>> find an unflushed list. I think you
>>>> need to use a separate list for debugfs (simpler) or a shared list with both
>>>> sysfs and debugfs processing (probably more complicated).
>>>>
>>>> And finally a question, perhaps also for Greg. With sysfs, we hand out the
>>>> lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
>>>> files of a cache that has been removed.
>>>>
>>>> But with debugfs, what are the guarantees that things won't blow up when a
>>>> debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?
>>>
>>> It's much harder, but usually the default debugfs_file_create() will
>>> handle this for you.  See the debugfs_file_create_unsafe() for the
>>> "other" variant where you know you can tear things down "safely".
>> 
>> Right, so IIUC debugfs will guarantee that while somebody reads the files, the
>> debugfs cleanup will block, as debugfs_file_get() comment explains.
>> 
>> In that case I think we have the cleanup order wrong in this patch:
>> 
>> shutdown_cache() should first do debugfs_slab_release() (which would block) and
>> only then proceed with slab_kmem_cache_release() which destroys the fundamental
>> structures such as kmem_cache_node, which are also accessed by the debugfs file
>> handlers.
>>
> If user is trying to read the data during shutdown_cache(), then I think
> it's possible user will get empty data, to avoid that we can call

Empty data is fine, when the cache is going away anyway.

> debugfs_slab_release() first and then do other stuff in shutdown_cache().

Everything above list_del(&s->list) should be OK, it's equivalent to normal
cache operations which the debugfs files must cope with anyway.
list_del(&s->list) is OK as the debugfs handlers don't go through the list. It's
slab_kmem_cache_release() that matters.

>>> That being said, yes there are still issues in this area, be careful
>>> about what tools you expect to be constantly hitting debugfs files.
>> 
>> FWIW, the files are accessible only to root.
>> 
>>> thanks,
>>>
>>> greg k-h
>>>
>> 
> 

