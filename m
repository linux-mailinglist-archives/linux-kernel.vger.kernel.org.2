Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2144AFFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhKIPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:06:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33278 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhKIPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:06:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA363218EF;
        Tue,  9 Nov 2021 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636470247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fr24ghdlwEpZ82n6LkCEJ0aL6GBcbiWiegw0cT/TQ8w=;
        b=dFHQdlVpdL893Exnno5b9YW5K/jx3oo8yOxTiI4GwuXKT3fxQ2lc1QLxmtdv0YUrgImQsp
        C/F4ddtqWqIBfGO5oCQHwnpmk5dJ1zL7ltUG3o+Pf3D038vEMLww7PLaAuey2xYcuY851Z
        xBzbLChvr4IhbVTpn8183nA0zFpkEfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636470247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fr24ghdlwEpZ82n6LkCEJ0aL6GBcbiWiegw0cT/TQ8w=;
        b=8p89m5xOX6cWcHJuBwThTBEo6EVtzsJVW8eMqhXYhcG7vfsxCSzbGgLCA8za75eJzGsJmY
        m8WYl8IRPozLGiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AC8513A6A;
        Tue,  9 Nov 2021 15:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VeiZDOeNimH7CQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 09 Nov 2021 15:04:07 +0000
Date:   Tue, 9 Nov 2021 12:04:05 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211109150405.uv2he4quk4dlud6p@cyberdelia>
References: <20211106020858.18625-1-ematsumiya@suse.de>
 <20211109080634.GA28581@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211109080634.GA28581@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09, Christoph Hellwig wrote:
>On Fri, Nov 05, 2021 at 11:08:57PM -0300, Enzo Matsumiya wrote:
>> +	},
>> +	{
>> +		/*
>> +		 * This Kioxia device times out and aborts I/O during any load,
>> +		 * but more easily reproducible with discards (fstrim).
>> +		 *
>> +		 * Device is left in a state that is also not possible to use "nvme set-feature"
>> +		 * to disable APST, but booting with nvme_core.default_ps_max_latency=0 works.
>> +		 */
>
>Overly long lines here, but I can fix that up.

Missed that, sorry. Thanks.

>  Do you have a product
>name for this device or is just a nameless OEM controller?

I didn't, had to google. I see it listed on Kioxia's website as
CD6-V Series (6.4T model), but since customer was running on an
DL380 Gen10, I suspect it could also be HPE PE8030 (PN P19837-B21).


Cheers,

Enzo
