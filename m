Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C013E00F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbhHDMOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:14:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhHDMOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:14:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B120221F5;
        Wed,  4 Aug 2021 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628079263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5B+43VdvWYmHPc+aHhOHSoSNPB1WrgbUZsiW5Y9uO8=;
        b=pY2uN4RA8lAod4hzjmKX+xok+aUaUwIEQ6tDIDshn/w0eN3lZ9NKo1KKw1wG3PB679ghv/
        Dt7627cr8srQ61lp8Md9bDLlxwplFH7MVh21fWnADoDKFnJzNcl+C4h4IqPnwd9FS7dne9
        xvirYv/1qo32BytLeEQHRQwhmAPiXjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628079263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5B+43VdvWYmHPc+aHhOHSoSNPB1WrgbUZsiW5Y9uO8=;
        b=ot16R5nMPdWTgdOBYJGwdJh6OdZLKmuGXPv6OfKCp9isD2MikOn9S6Z6kWHBXpBCwimLHA
        EeoJOF2f49Yuy4Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2EC5713672;
        Wed,  4 Aug 2021 12:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id a5i+Cp+ECmECJgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 04 Aug 2021 12:14:23 +0000
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210804120522.GD6464@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ab68595e-6166-df7c-b324-514fe166ba74@suse.cz>
Date:   Wed, 4 Aug 2021 14:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804120522.GD6464@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 2:05 PM, Mel Gorman wrote:
> On Thu, Jul 29, 2021 at 03:20:57PM +0200, Vlastimil Babka wrote:
>> Series is based on 5.14-rc3 and also available as a git branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r1
>> 
> 
> FWIW, I ran a corrected version of this series through a few tests. Some
> small gains, no major regressions in terms of performance on a !PREEMPT_RT
> configuration across 6 different machines.

Thanks a lot, Mel!


