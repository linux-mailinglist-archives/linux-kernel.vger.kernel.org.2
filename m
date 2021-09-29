Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10EE41CA74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbhI2QlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:41:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55892 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbhI2Qk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:40:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FC0E20399;
        Wed, 29 Sep 2021 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632933554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yesk9jGDaVQ68unRpfsU8Z5P6/4xg2xRiWVlJMEJT0Q=;
        b=EoIMT0byTfOkwfKDk06GWdcgGVJUNzzqOuD576os0qYpYFPYaEbExh68Qht+jRDacI/V+R
        ILmOHpw8Sc7Y+vGK1Qyj7tT1PtXJbpVnEHpPXRdl9iUJvTcCOoPig/eWnMzwJ56pDzHLwU
        tIEgI2AEug6pQbkzROTgeKAcc32/tUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632933554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yesk9jGDaVQ68unRpfsU8Z5P6/4xg2xRiWVlJMEJT0Q=;
        b=j4klpNIBQnKQD6WH2k+0tpVqUfJqoktudrK9gVQxQpk0alj9rFukGkVhhUbtZP0PMF3gnZ
        XV0ZM8TQehqjPmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14CB513FE7;
        Wed, 29 Sep 2021 16:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M7ovBLKWVGGuPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 29 Sep 2021 16:39:14 +0000
Message-ID: <9ddb1f1e-c81a-ac34-1c6a-4ececa6dbc94@suse.cz>
Date:   Wed, 29 Sep 2021 18:39:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     shakeelb@google.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
 <566f2009-6acf-4fb9-f7c0-edc1d6ce6561@suse.cz>
 <73b662cc-ab1f-b3bf-468a-4cd744e92d71@huawei.com>
 <YVM4NJZWNyOhZIIP@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH resend] slub: Add back check for free nonslab objects
In-Reply-To: <YVM4NJZWNyOhZIIP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 17:43, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 03:53:47PM +0800, Kefeng Wang wrote:
>> On 2021/9/27 15:22, Vlastimil Babka wrote:
>> > On 9/27/21 04:15, Kefeng Wang wrote:
>> > > After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
>> > > free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
>> > > which only check with CONFIG_DEBUG_VM enabled, but this config may
>> > > impact performance, so it only for debug.
>> > > 
>> > > Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
>> > > add the ability, which should be needed in any configs to catch the
>> > > invalid free, they even could be potential issue, eg, memory corruption,
>> > > use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, and
>> > > add dump_page() to help use to debug the issue.
>> > There are other situations in SLUB (such as with smaller allocations that
>> > don't go directly to page allocator) where use after free and double-free
>> > are undetected in non-debug configs, and it's expected that anyone debugging
>> > them will enable slub_debug or even DEBUG_VM. Why should this special case
>> > with nonslab pages be different?
>> 
>> I want the check back in kfree, this one is used  widely in driver, and the
>> probability
>> 
>> of problem occurred is bigger in driver, especially in some out of tree
>> drivers.
> 
> Why would we want to improve life for out of tree drivers?  Drivers should
> be in-tree.  That's been the Linux Way for thirty years.

Yes, there's a reason we distinguish VM_BUG_ON/VM_WARN_ON and plain
BUG_ON/WARN_ON. Picking arbitrarily one VM_ variant check and making it
always-enabled makes little sense to me, and doing it because of out of tree
drivers is certainly not a convincing argument. Commit f227f0faf63b was
correct in making it VM_BUG_ON.

> I remain sceptical that dump_page() is actually useful for debugging
> drivers anyway.  dump_stack(), I could see -- that'll tell you which
> driver called kfree() on a bogus pointer.  But how does dump_page() help?
> 

