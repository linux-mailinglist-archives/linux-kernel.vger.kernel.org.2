Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1189239587C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEaJ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 05:56:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 05:56:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDB272191F;
        Mon, 31 May 2021 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622454902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlh6DDaopcTSgBwlUip1FcUMxp4Lt8TiZSFROJe92wc=;
        b=RlvjapcMXhOjtT9Z7TZeKhC8Vw2bcEhEuQGCwdiPq1tlvtJNMn/eLHTkYcek0qtj+FE6hR
        vApnpTk4STPpxXJrw+WnCxj39CPQ9Ie9szCuxHOlhiuSpYGANxdE+mmKrC/+r+54T7yHoI
        3/YTik1saqGz4m+P+ipZ093Gbl9b13Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622454902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlh6DDaopcTSgBwlUip1FcUMxp4Lt8TiZSFROJe92wc=;
        b=p9h8vmKkWU90nKTUhZVz5JVHzFIL8Y5mj8H2N1/3eBQArCWlheyp7Uxk+CSNclPReNf+1T
        zyq7opf4c2RYVdBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9032E118DD;
        Mon, 31 May 2021 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622454902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlh6DDaopcTSgBwlUip1FcUMxp4Lt8TiZSFROJe92wc=;
        b=RlvjapcMXhOjtT9Z7TZeKhC8Vw2bcEhEuQGCwdiPq1tlvtJNMn/eLHTkYcek0qtj+FE6hR
        vApnpTk4STPpxXJrw+WnCxj39CPQ9Ie9szCuxHOlhiuSpYGANxdE+mmKrC/+r+54T7yHoI
        3/YTik1saqGz4m+P+ipZ093Gbl9b13Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622454902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlh6DDaopcTSgBwlUip1FcUMxp4Lt8TiZSFROJe92wc=;
        b=p9h8vmKkWU90nKTUhZVz5JVHzFIL8Y5mj8H2N1/3eBQArCWlheyp7Uxk+CSNclPReNf+1T
        zyq7opf4c2RYVdBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id VWNrInaytGCpZwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 31 May 2021 09:55:02 +0000
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <86d843f0-bbef-7c3b-6b6a-5d6b32434bee@suse.cz>
 <b43fad97-5f40-c94a-7cb4-9a31edd6668f@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <dca0fe16-18ed-fa6f-6062-2659e061c26b@suse.cz>
Date:   Mon, 31 May 2021 11:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <b43fad97-5f40-c94a-7cb4-9a31edd6668f@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
         FREEMAIL_TO(0.00)[codeaurora.org,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,kvack.org,vger.kernel.org,kroah.com,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 8:55 AM, Faiyaz Mohammed wrote:

>> I don't see any of the symlinks under /sys/kernel/debug/slab/, so I think the
>> aliases handling code is wrong, and I can see at least two reasons why it could be:
>> 
> 
> I think I missed one thing, when CONFIG_SLUB_DEBUG_ON enable or
> slub_debug is pass through command line __kmem_cache_alias() will return
> null, so no symlinks will be created even if CONFIG_SLAB_MERGE_DEFAULT
> is enable and to store user data we need to enable CONFIG_SLUB_DEBUG_ON
> or pass slub_debug through command line.

So you're saying that caches with SLAB_STORE_USER can never be aliases as the
merging logic will prevent merging with any debug flag, including STORE_USER. So
if we ignore aliases, it means we will not create the debugfs files for caches,
where opening the files would just return error, so we don't lose anything by
not creating the files in the first place.

In that case, for consistency I would recommend to skip debugfs creation for all
caches without SLAB_STORE_USER (even if the caches are not an alias). I think we
can make this decision now as it's a whole new debugfs subtree so we don't break
any pre-existing code.
