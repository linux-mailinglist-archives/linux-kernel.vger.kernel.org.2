Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38793D4FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhGYSyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 14:54:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32804 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhGYSyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 14:54:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 033B91FE27;
        Sun, 25 Jul 2021 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627241687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58zEBXrPLD3qIcovdJf/tEHB4Pi7h5B4g5e9c0cpHBI=;
        b=CSEXtQQNOtW5QAs5T9pdlvNg2Kj/xz79knkHk/KTqcX95cmJv7ZCXPRugEJVc/qU3JsbMZ
        rTUc+Y3rWyxpuVg+wKl9wDvZLSDfyYGzOoF/A/pezjbhqJwcPZvRuK7bIWgktWJc+mZMr7
        hHMuZ0PAaN5veRzLZisIwFxjmTHeHHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627241687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58zEBXrPLD3qIcovdJf/tEHB4Pi7h5B4g5e9c0cpHBI=;
        b=kByQjoG8+WONbaViiSEgnP5jxDOhHifNyIHuiknbHJzJ6UgyRo354wAe6Zbv/iOgVmQGiT
        XQxmBJ8Gey4KqWAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C2CA71333A;
        Sun, 25 Jul 2021 19:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7j9PLta8/WDNOAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 25 Jul 2021 19:34:46 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
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
Message-ID: <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
Date:   Sun, 25 Jul 2021 21:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/21 9:12 PM, Vlastimil Babka wrote:
> +	/*
> +	 * On !RT we just want to disable preemption, on RT we need the lock
> +	 * for real. This happens to match local_lock() semantics.
> +	 */
> +	local_lock(&s->cpu_slab->lock);

OK I realized (and tglx confirmed) that this will blow up on !RT +
lockdep if interrupted by ___slab_alloc() that will do
local_lock_irqsave(). So back to #ifdefs it is. But should work as-is
for RT testing.
