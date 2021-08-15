Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DB23EC883
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhHOKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 06:19:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51382 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhHOKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:19:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B15B321DAB;
        Sun, 15 Aug 2021 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629022727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KA3Lnup2AQLy/Yk6gUEFbCTmb5Zx3mFkZifnI3X0rs0=;
        b=SueC7/vQkwPOfjOg8zcgFKSWd/caLTWrFDjPeYibMtrWTT41+0sW/LbxX8fy0jJEQR/SZX
        oWVWogLCXfFu1ftoZuBnj54lIx76FMXy4kFLsr2naOz1uMlLxkQvxMWTJoUJAlkxmS4Xsf
        Sz7u3CBFKfKSVMHw6eUa7ZQtZeXI0aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629022727;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KA3Lnup2AQLy/Yk6gUEFbCTmb5Zx3mFkZifnI3X0rs0=;
        b=1quTUC9SSE/B1aE3jfmfjer4CQgMLQO95qLYZgujBoljRtwXFQ1mf1DZ2zwiIHx31CD3xL
        YLb/2BZ2XI+x0RCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 150D213D10;
        Sun, 15 Aug 2021 10:18:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JXG0AgfqGGEXbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 15 Aug 2021 10:18:47 +0000
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
Message-ID: <ad5f4888-db46-fdea-3a60-b242f0084bc3@suse.cz>
Date:   Sun, 15 Aug 2021 12:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <db5a59ba-4c16-1292-a3e4-bd9f7ceb3bcb@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 4:36 PM, Vlastimil Babka wrote:
> On 8/5/21 5:19 PM, Vlastimil Babka wrote:
>> Series is based on 5.14-rc4 and also available as a git branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r0
> 
> New branch with fixed up locking orders in patch 29/35:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r1

New branch with fixed up VM_BUG_ON in patch 13/35:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v4r2

