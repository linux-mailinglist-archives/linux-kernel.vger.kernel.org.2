Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2B3F7973
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhHYPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:52:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45928 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhHYPwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:52:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29E6020128;
        Wed, 25 Aug 2021 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629906686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MccwDfvIRHA1wKv36RouYR5dfCf1KOnt4ZYAj6Mqvo0=;
        b=Rh1RZWSXFMYnhWwYjLw4+60Epx2V2QYHUMUCFGQYM+ttLZzn2LK9qpP7DCsJ9B88toEg7M
        lgaTSe9Ramhii3yZ4B595WOsxpuSEQUCv3wMbXWPya2E3qAU0O/do4HZTmePWtV0MabOTc
        ER73EpH6Di3lSIk63fAFx9CHvwBxP6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629906686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MccwDfvIRHA1wKv36RouYR5dfCf1KOnt4ZYAj6Mqvo0=;
        b=95N6DcY2DvXZ2+FlYlbvCwZn5Lwl1a9PeKIIGHjin2qC1Zw/J5LIooUQS1tVYotrDaf3uP
        nhuvz3a9XH4Ru6Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E5C0D13A89;
        Wed, 25 Aug 2021 15:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id XKoeNv1mJmFgXgAAGKfGzw
        (envelope-from <hare@suse.de>); Wed, 25 Aug 2021 15:51:25 +0000
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is modified
To:     "hch@lst.de" <hch@lst.de>,
        sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <20210825085345.GA31419@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2fc5b98a-b397-3be1-1957-986e8b6aa732@suse.de>
Date:   Wed, 25 Aug 2021 17:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210825085345.GA31419@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 10:53 AM, hch@lst.de wrote:
> Any reason we can't just call this from nvme_passthru_end instead
> of inventing a new API?  Right now the nvmet passthrough code never
> uses the underlying keep alive code, so it doesn't make a difference,
> but I expect we'll need more handling for passthrough commands like
> this, and we might also grow more users (e.g. the io_uring based
> passthrough).
> 
Yeah, we'll need that anyway if and when hostid becomes settable.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
