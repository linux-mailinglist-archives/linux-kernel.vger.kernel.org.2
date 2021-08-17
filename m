Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9C3EEFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhHQQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:00:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54688 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhHQQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:00:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CB661FF56;
        Tue, 17 Aug 2021 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629216003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfPpjLZl+e2ihE9ZAdJcjGrDaNX/gNFEvHKaIz4T3Xw=;
        b=D9Wk3QW5T/a80jNzIogPImUsnbrsOfupHDXuDUtYzLEpGRC1zzLu7BF5PJRqfhLYOzRnXO
        S/v+NDlWlQ/GwSOSRY0xKmiI7IAHgOANn9sBZyu9ccQF1mQ3IGiRXOPKR2QPY5M+0Y2rkT
        QmvOv/tvGQK4UgMtENiVe2kd3Kvew6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629216003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfPpjLZl+e2ihE9ZAdJcjGrDaNX/gNFEvHKaIz4T3Xw=;
        b=7o5EySNUB3cCTO/cmk+xm0ys1BdwpccG75B4jQGgYbQdLw6Zyg90BW8En5uUFN5yXdv+lF
        xD5OtMWkx+5WeTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A32813CEA;
        Tue, 17 Aug 2021 16:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Iim5GgLdG2EQVAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 16:00:02 +0000
Subject: Re: [PATCH v4 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <db5a59ba-4c16-1292-a3e4-bd9f7ceb3bcb@suse.cz>
 <ad5f4888-db46-fdea-3a60-b242f0084bc3@suse.cz>
 <4dc4a6cf-e16a-00ca-2234-586c9b3043a1@suse.cz>
Message-ID: <c7a0f104-e33e-a36a-08c5-62e0631493f0@suse.cz>
Date:   Tue, 17 Aug 2021 17:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4dc4a6cf-e16a-00ca-2234-586c9b3043a1@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 12:23 PM, Vlastimil Babka wrote:
> On 8/15/21 12:18 PM, Vlastimil Babka wrote:
>> On 8/10/21 4:36 PM, Vlastimil Babka wrote:
>>> On 8/5/21 5:19 PM, Vlastimil Babka wrote:
>>>> Series is based on 5.14-rc4 and also available as a git branch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r0
>>>
>>> New branch with fixed up locking orders in patch 29/35:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r1
>>
>> New branch with fixed up VM_BUG_ON in patch 13/35:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r2
>  
> New branch with fixed struct kmem_cache_cpu layout in patch 35/35
> (and a rebase to 5.14-rc6)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r3

Another update to patch 35/35, simplifying lockdep_assert_held() as requested by RT:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r4
