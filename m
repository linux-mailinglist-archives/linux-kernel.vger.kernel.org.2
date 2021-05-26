Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD34391724
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhEZMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:15:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50878 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhEZMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:15:01 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by smtp-out1.suse.de (Postfix) with ESMTP id D94A3218C8;
        Wed, 26 May 2021 12:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622031205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWYxOJflFG1uSB7U04nw20Q2EPzaSUW/18EMjnBHn1A=;
        b=gOaVL66Aq3P2aUlbEeQW+wEVlUc1BXanRMehHFdMLOK39J4N5WAqkeSIvg0u7E8P/ppNNQ
        /zN68cmoBtkQq3Xj/GoTnCMAQfwJqC1VEGES5gHYUx3C5405GHCav/iUgqL0kpdnodqdJf
        sY86/wDEnMzDE8OSrf7ytnPWhEktZyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622031205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWYxOJflFG1uSB7U04nw20Q2EPzaSUW/18EMjnBHn1A=;
        b=Ne14iacTkhEN/Pil8RGLPNGrqj+yL9Q9xZ2Zov5LtLIds+pF0g3EkGLAAxXnE5ectxb+sN
        iM75pznJLEf5P2Ag==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id BD35711A98;
        Wed, 26 May 2021 12:13:25 +0000 (UTC)
To:     Greg KH <greg@kroah.com>
Cc:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, glittao@gmail.com,
        vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz> <YK41eFeL5j4qqSnV@kroah.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <0b0e5e43-2ccf-a8a4-1e3b-ab2326c55321@suse.cz>
Date:   Wed, 26 May 2021 14:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK41eFeL5j4qqSnV@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 1:48 PM, Greg KH wrote:
> On Wed, May 26, 2021 at 01:38:55PM +0200, Vlastimil Babka wrote:
>> 
>> alias_list a single list and both slab_sysfs_init() and slab_debugfs_init()
>> flush it. So only the init call that happens to be called first, does actually
>> find an unflushed list. I think you
>> need to use a separate list for debugfs (simpler) or a shared list with both
>> sysfs and debugfs processing (probably more complicated).
>> 
>> And finally a question, perhaps also for Greg. With sysfs, we hand out the
>> lifecycle of struct kmem_cache to sysfs, to ensure we are not reading sysfs
>> files of a cache that has been removed.
>> 
>> But with debugfs, what are the guarantees that things won't blow up when a
>> debugfs file is being read while somebody calls kmem_cache_destroy() on the cache?
> 
> It's much harder, but usually the default debugfs_file_create() will
> handle this for you.  See the debugfs_file_create_unsafe() for the
> "other" variant where you know you can tear things down "safely".

Right, so IIUC debugfs will guarantee that while somebody reads the files, the
debugfs cleanup will block, as debugfs_file_get() comment explains.

In that case I think we have the cleanup order wrong in this patch:

shutdown_cache() should first do debugfs_slab_release() (which would block) and
only then proceed with slab_kmem_cache_release() which destroys the fundamental
structures such as kmem_cache_node, which are also accessed by the debugfs file
handlers.

> That being said, yes there are still issues in this area, be careful
> about what tools you expect to be constantly hitting debugfs files.

FWIW, the files are accessible only to root.

> thanks,
> 
> greg k-h
> 

