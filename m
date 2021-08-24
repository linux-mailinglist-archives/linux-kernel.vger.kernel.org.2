Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC893F5D97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhHXME3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:04:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:04:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5094E1FD86;
        Tue, 24 Aug 2021 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629806624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjVOBoLYlFPkCxcpIhB874TqF4XIjaBYDgr606Kwa/g=;
        b=1mCuHwC5K0rttzaTTUmKsPM8PzpmWeo/byJ6svKok6ftncys7yfV3cq8MrEtDUVF+Sm/f9
        dy7nHMgSBgVdOC1kEHO1KKG+wZFXO87XSLUG5bz1znkn7akVdwkBsG/FifgV7tOsWhhP2O
        XXpwYcg1cO0YJ+4YqqJ96IjsJTYnmP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629806624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjVOBoLYlFPkCxcpIhB874TqF4XIjaBYDgr606Kwa/g=;
        b=JXnX0OV1euN57lhYhpOJ/kHnYSSew9bUF9nl2Xeh4WVaaV+QE5rtPhjsIC8gppNt/XH/HN
        ETq8FQpwgSRXdzCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3811D13A50;
        Tue, 24 Aug 2021 12:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id B37+DCDgJGGkIgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 12:03:44 +0000
Message-ID: <0c438e9d-7879-a1c1-7641-5c0dc00f5163@suse.cz>
Date:   Tue, 24 Aug 2021 14:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-2-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/4] mm: Kconfig: group swap, slab, hotplug and thp
 options into submenus
In-Reply-To: <20210819195533.211756-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 21:55, Johannes Weiner wrote:
> There are several clusters of related config options spread throughout
> the mostly flat MM submenu. Group them together and put specialization
> options into further subdirectories to make the MM section a bit more
> organized and easier to navigate.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Note:

> -config ZBUD
> -	tristate "Low (Up to 2x) density storage for compressed pages"
> -	help
> -	  A special purpose allocator for storing compressed pages.
> -	  It is designed to store up to two compressed pages per physical
> -	  page.  While this design limits storage density, it has simple and
> -	  deterministic reclaim properties that make it preferable to a higher
> -	  density approach when reclaim will be used.
> -

The whole large hunk with deletion part of the block move will be rejected in
current trees because this is apparently based on older commit than 2a03085ce887
("mm/zbud: don't export any zbud API") which adds a "depends on ZPOOL" to the
above. It's thus also missing in the add hunk part of the move and if not
careful when resolving the reject, the depend will then be missing in the result.
