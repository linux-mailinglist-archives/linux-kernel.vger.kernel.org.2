Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5F44C452
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhKJP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:26:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56394 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhKJP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:26:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4A41FD33;
        Wed, 10 Nov 2021 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636557835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65uWoP1DQK7QlqEdSvFAIGzipx1+61pvrGfY+gp8isw=;
        b=jFiK7q62CsXBiGWsHQDacGH7V5iQqFQavEWiWjaZfQhMklWe4aCUDYmUfi7v3gg1Bsc+P1
        Cix+trxy0Al97B4ryX4Jbn2RuewUx2Bej2bPYGFQB+TCJxC8M8fxQdZ5hRsr2dIe9PGt44
        BjbvSrCJM20ZY5r+GGcGxxf3yLfp6Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636557835;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65uWoP1DQK7QlqEdSvFAIGzipx1+61pvrGfY+gp8isw=;
        b=CxRxFNJ76/YgecUNBse6J2U1z1h64owAyCvTQ57GcxCv+iCKQdUip3eDa8fWrRXqvbP7lt
        okYwJl6Fv7P3z0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F36A613BFF;
        Wed, 10 Nov 2021 15:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d1oXLQrki2HHXwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 10 Nov 2021 15:23:54 +0000
Date:   Wed, 10 Nov 2021 12:23:52 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211110152352.44l43fe5gg66mjna@cyberdelia>
References: <20211106020858.18625-1-ematsumiya@suse.de>
 <20211109080634.GA28581@lst.de>
 <20211109150405.uv2he4quk4dlud6p@cyberdelia>
 <e37edd78-a390-25a6-874b-8b69d2b80182@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e37edd78-a390-25a6-874b-8b69d2b80182@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaitanya,

On 11/10, Chaitanya Kulkarni wrote:
>Enzo,
>
>> I didn't, had to google. I see it listed on Kioxia's website as
>> CD6-V Series (6.4T model), but since customer was running on an
>> DL380 Gen10, I suspect it could also be HPE PE8030 (PN P19837-B21).
>>
>
>You can get more information about this controller using nvme-cli
>id-ctrl command.

I'm aware.

I don't have access to the system, but id-ctrl output was shared with
us.

AFAICS these are the only identifying fields, which all indicate to be
Kioxia's:

NVME Identify Controller:
vid       : 0x1e0f
ssvid     : 0x1e0f
sn        : [redacted]
mn        : KCD6XVUL6T40
fr        : GPK1
rab       : 2
ieee      : 8ce38e
...

Now something that I'm not aware. Would these change even if another
brand was using this Kioxia's chipset?

Is it crucial to have the product information (vs only chipset information)
for quirks? I'm already querying the customer for this anyway.


Cheers,

Enzo
