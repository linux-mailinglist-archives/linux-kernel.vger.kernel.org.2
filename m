Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED93DA7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhG2PrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:47:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60102 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhG2PrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:47:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75DC920057;
        Thu, 29 Jul 2021 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627573640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGETejjFkZtLsLCQCyIcbXPBMg4J1wjpmMhMDKVQqCY=;
        b=GPHZ5YADFHOGSHkdeeuWFFrOcqJXVm56o4u/Tj19A5t+18BMepw/rA1Rxos8c7VQru0TCe
        EkqTNpH8lIG/cF6JECoki9jcI14u/GBNNN3UeOW7u79qkXOw9LGsWE+7H/y78wEZDKWRha
        8sIcA5pX6GRSyrEN2zetsDXS/Qa+KtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627573640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGETejjFkZtLsLCQCyIcbXPBMg4J1wjpmMhMDKVQqCY=;
        b=KiKIixyRnw4jXrulQ/55BF7NfzU20dTCugzlQRV6eP6V85fmEFUOg4vCFPOeAA5aUnTLlY
        CENCxqaZAAH/mYBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 490B3136BF;
        Thu, 29 Jul 2021 15:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id VcccEYjNAmEaNAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 15:47:20 +0000
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210729132132.19691-1-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7ce60b82-a8c5-f31c-b344-b214a6ca38f8@suse.cz>
Date:   Thu, 29 Jul 2021 17:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 3:20 PM, Vlastimil Babka wrote:
> Changes since v2 [5]:
> * Rebase to 5.14-rc3
> * A number of fixes to the RT parts, big thanks to Mike Galbraith for testing
>   and debugging!
>   * The largest fix is to protect kmem_cache_cpu->partial by local_lock instead
>     of cmpxchg tricks, which are insufficient on RT. To avoid divergence
>     between RT and !RT, just do it everywhere. Affected mainly patch 25 and a
>     new patch 33. This also addresses a theoretical race raised earlier by Jann
>     Horn.
> * Smaller fixes reported by Sebastian Andrzej Siewior and Cyrill Gorcunov
> 
> Changes since RFC v1 [1]:
> * Addressed feedback from Christoph and Mel, added their acks.
> * Finished RT conversion, adopting 2 patches from the RT tree.
> * The local_lock conversion has to sacrifice lockless fathpaths on PREEMPT_RT
> * Added some more cleanup patches to the front.
> 
> This series was initially inspired by Mel's pcplist local_lock rewrite, and
> also interest to better understand SLUB's locking and the new primitives and RT
> variants and implications. It should make SLUB more preemption-friendly,
> especially for RT, hopefully without noticeable regressions, as the fast paths
> are not affected.
> 
> Series is based on 5.14-rc3 and also available as a git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r1

Branch with fixed memory leak in patch 33:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r2
