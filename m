Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A603F030B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhHRLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:53:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52128 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhHRLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:53:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9EBA820065;
        Wed, 18 Aug 2021 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629287560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0Gg3Eo6nVGmkuIaYIfQZsHopS7vuS6RydrWjr2SAZ0=;
        b=H4f1SAxCFweJo0o0dZ9vf0GPA/zwFq6pL1EOU93hG7mUkomxOLfEJpKmikaT1AP3m9Tfob
        PTnrULDLAoi/Q6738r25PYXKq9e9XeS3KSaJI1aUZqpOojlA68mRv4wNJi35Ab1RGWfIHr
        bMkYrNE+XMiIFByhTBKXldrzBb98k9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629287560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0Gg3Eo6nVGmkuIaYIfQZsHopS7vuS6RydrWjr2SAZ0=;
        b=gcY7h83YaBWF4GPhis9FHMFXOwL+3Ec1SofRfvse0YKAXsfJqpnT7h0LpwLECu/v+fMDFl
        am0RDgOp4ag/34DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C47F6144F1;
        Wed, 18 Aug 2021 11:52:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MEfXLIf0HGFcHAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 18 Aug 2021 11:52:39 +0000
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Mike Galbraith <efault@gmx.de>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
 <e907c2b6-6df1-8038-8c6c-aa9c1fd11259@suse.cz>
 <20210817125325.d0ed45d664596d1e80a591d7@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d37d2de9-b5b2-dbdd-5228-065b475f913a@suse.cz>
Date:   Wed, 18 Aug 2021 13:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817125325.d0ed45d664596d1e80a591d7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 9:53 PM, Andrew Morton wrote:
> On Tue, 17 Aug 2021 12:14:58 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> Another fixup. Is it too many and should we replace it all with a v5?
> 
> Maybe do a full resend when things have settled down and I can at least
> check that we match.

OK.

> What's your confidence level for a 5.15-rc1 merge?

I'd say pretty good. It's part of RT patchset for a while (since early
July IIRC?) and there has been lot of testing there. Mike and Mel also
tested under !RT configs, and the bug report from Sven means the mmotm
in -next also gets testing. The fixups were all thanks to the testing
and recently shifted to smaller unusual-config-specific issues that
could be dealt with even during rcX stabilization in case there's more.

> It isn't terribly
> well reviewed?

Yeah that could be better, the pool of people deeply familiar with SLUB
is not large, unfortunately. I hope folks will still step up!


