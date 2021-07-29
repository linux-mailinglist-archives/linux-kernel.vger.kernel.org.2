Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D823DA7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhG2PbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:31:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41894 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhG2PbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:31:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76C62223D8;
        Thu, 29 Jul 2021 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627572664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2m726m+2wxt57i9gZ/k9MeOfhTZ1jyoJeyncQd54dbs=;
        b=XdOwpXmQwuLD31H+AWc74BaCxtiToy0dhuJ6bkTL+EIEp8xziOpME1JZvaITyWKGa3ez6J
        +y8oMMQPTx9NjMFuimw3muT2c1PneBB4m0Fp2mnIorHZ8QJZaUEoIqo88auw5mh7X2RVGJ
        EJkFH08OJhDG9QoAMYX74jrIjGYCn9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627572664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2m726m+2wxt57i9gZ/k9MeOfhTZ1jyoJeyncQd54dbs=;
        b=to1CXyAof4Oz5vxw1tJzyKCXmVdyzPD36AGwf6FOeOvR76c7ryglew76bhPJ21rd8FF4aS
        HlDQuYD5rXKME1BA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 43F7813738;
        Thu, 29 Jul 2021 15:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mkZPD7jJAmFHLwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 15:31:04 +0000
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210729152400.ed35ocv5jtpf3ns5@linutronix.de>
 <803269ba-d4f4-6016-067f-8f9e02b3c794@suse.cz>
 <20210729152901.uvbgquzwyk7lt7a3@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <280c3134-798d-1134-3ac4-43957bbaaaa3@suse.cz>
Date:   Thu, 29 Jul 2021 17:31:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729152901.uvbgquzwyk7lt7a3@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 5:29 PM, Sebastian Andrzej Siewior wrote:
> On 2021-07-29 17:27:18 [+0200], Vlastimil Babka wrote:
>> On 7/29/21 5:24 PM, Sebastian Andrzej Siewior wrote:
>> > On 2021-07-29 15:20:57 [+0200], Vlastimil Babka wrote:
>> >> Changes since v2 [5]:
>> > 
>> > With PARTIAL enabled on top of -rc3:
>> 
>> Is that also PREEMPT_RT? Interesting...
> 
> No, plain -rc3.

Thanks, probably screwed up put_cpu_partial() with my cleanups, will check.

> Sebastian
> 

