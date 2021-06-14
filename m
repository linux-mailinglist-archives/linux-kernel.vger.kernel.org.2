Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9683A64A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhFNL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:27:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhFNLMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:12:42 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E65201FD29;
        Mon, 14 Jun 2021 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623669035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcGNJNBRAjZm8s1/glzeDyOwEkQjMrKAE176L10SZMI=;
        b=i8tnla28Ays7WkWspkPEgLH9KH+nVzpPZ2eBb1KvUKOfAP4nQEyhEUerfuQGAofBCzwf8m
        H4kUIrl8sEFk9x7cTRoEtbQrXM9cNC1wyLSH0Rc1VLSFLnc+m2tfFpMW4cviX2oxGMhL/R
        Stfj1y/n+qyFvTD1wgW+VffcLSK0HxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623669035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcGNJNBRAjZm8s1/glzeDyOwEkQjMrKAE176L10SZMI=;
        b=DUOXa1TWlOC21b/XqXDjEqyCHpj2+LM9W5wuK+QxtcZLOOUilhEuhkrjHT0mxMtVNLgAPt
        jCAgzAAgGbeg73Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BAD3C118DD;
        Mon, 14 Jun 2021 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623669035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcGNJNBRAjZm8s1/glzeDyOwEkQjMrKAE176L10SZMI=;
        b=i8tnla28Ays7WkWspkPEgLH9KH+nVzpPZ2eBb1KvUKOfAP4nQEyhEUerfuQGAofBCzwf8m
        H4kUIrl8sEFk9x7cTRoEtbQrXM9cNC1wyLSH0Rc1VLSFLnc+m2tfFpMW4cviX2oxGMhL/R
        Stfj1y/n+qyFvTD1wgW+VffcLSK0HxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623669035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcGNJNBRAjZm8s1/glzeDyOwEkQjMrKAE176L10SZMI=;
        b=DUOXa1TWlOC21b/XqXDjEqyCHpj2+LM9W5wuK+QxtcZLOOUilhEuhkrjHT0mxMtVNLgAPt
        jCAgzAAgGbeg73Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id IVN9Kys5x2DpBwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 14 Jun 2021 11:10:35 +0000
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210609113903.1421-1-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7be07579-d7fd-d9b7-0c86-a8bf7fc094fc@suse.cz>
Date:   Mon, 14 Jun 2021 13:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 1:38 PM, Vlastimil Babka wrote:
> Changes since RFC v1 [1]:
> * Addressed feedback from Christoph and Mel, added their acks.
> * Finished RT conversion, including adopting 2 patches from the RT tree.
> * The optional local_lock conversion has to sacrifice lockless fathpaths on RT
> * Added some more cleanup patches to the front.
> 
> This series was initially inspired by Mel's pcplist local_lock rewrite, and
> also by interest to better understand SLUB's locking and the new locking
> primitives and their RT variants and implications. It should make SLUB more
> preemption-friendly and fully RT compatible, hopefully without noticeable
> regressions on !RT kernels, as the fast paths are not affected there.
> 
> Series is based on 5.13-rc5 and also available as a git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v2r1

Pushed a new revision branch:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v2r2

which fixes a bug in
[RFC v2 33/34] mm, slub: use migrate_disable() on PREEMPT_RT
that was reported by Mel
