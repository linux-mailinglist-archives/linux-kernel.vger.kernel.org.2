Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BA3E525C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhHJElG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:41:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41682 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhHJEkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:40:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 172B32006A;
        Tue, 10 Aug 2021 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628570430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Y/sP8LfiTsJxTKh1jcNI240g0lSB0n6FnLOLxf7FcU=;
        b=SNHqhH1dwQxTK5O93b38QKAsqRD6cQWnl+jKxhTsDeFlujz4laX4RKpIHtsKl8tv+u686K
        0dXqz7T2nwchC2qaxBJHgx1SRo3uHfATU2tVDNB+z+AiGjebOOnSxihdeNVRc2sy5KL5Yy
        904SgAb9E2PT9ial0MNgLYnUK68ozps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628570430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Y/sP8LfiTsJxTKh1jcNI240g0lSB0n6FnLOLxf7FcU=;
        b=Gi94EeIRco/frTg5kTDJwaEf5uu3kPX6As9DdZz5GmOjHvtZbMC8+gWUxhaUT+wCI3Eltg
        ncDYlqgqFWLbl/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C0E113A76;
        Tue, 10 Aug 2021 04:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CSmYAj4DEmFRXgAAMHmgww
        (envelope-from <dbueso@suse.de>); Tue, 10 Aug 2021 04:40:30 +0000
MIME-Version: 1.0
Date:   Mon, 09 Aug 2021 21:40:29 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <llong@redhat.com>
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
In-Reply-To: <20210809203554.1562989-1-aquini@redhat.com>
References: <20210809203554.1562989-1-aquini@redhat.com>
User-Agent: Roundcube Webmail
Message-ID: <9cc4f4f1a8bcecf5dcb72c4d0aff9e70@suse.de>
X-Sender: dbueso@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 13:35, Rafael Aquini wrote:
> sysvipc_find_ipc() was left with a costly way to check if the offset
> position fed to it is bigger than the total number of IPC IDs in use.
> So much so that the time it takes to iterate over /proc/sysvipc/* files
> grows exponentially for a custom benchmark that creates "N" SYSV shm
> segments and then times the read of /proc/sysvipc/shm (milliseconds):
> 
>     12 msecs to read   1024 segs from /proc/sysvipc/shm
>     18 msecs to read   2048 segs from /proc/sysvipc/shm
>     65 msecs to read   4096 segs from /proc/sysvipc/shm
>    325 msecs to read   8192 segs from /proc/sysvipc/shm
>   1303 msecs to read  16384 segs from /proc/sysvipc/shm
>   5182 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> The root problem lies with the loop that computes the total amount of 
> ids
> in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger 
> than
> "ids->in_use". That is a quite inneficient way to get to the maximum 
> index
> in the id lookup table, specially when that value is already provided 
> by
> struct ipc_ids.max_idx.
> 
> This patch follows up on the optimization introduced via commit 
> 15df03c879836
> ("sysvipc: make get_maxid O(1) again") and gets rid of the 
> aforementioned
> costly loop replacing it by a simpler checkpoint based on 
> ipc_get_maxidx()
> returned value, which allows for a smooth linear increase in time 
> complexity
> for the same custom benchmark:
> 
>      2 msecs to read   1024 segs from /proc/sysvipc/shm
>      2 msecs to read   2048 segs from /proc/sysvipc/shm
>      4 msecs to read   4096 segs from /proc/sysvipc/shm
>      9 msecs to read   8192 segs from /proc/sysvipc/shm
>     19 msecs to read  16384 segs from /proc/sysvipc/shm
>     39 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
