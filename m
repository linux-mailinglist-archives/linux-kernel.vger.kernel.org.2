Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC13DFC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhHDIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:09:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54076 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhHDIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:09:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E244221B0;
        Wed,  4 Aug 2021 08:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628064527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvpB3zh3SOr6slWuKcuT2uU4LOafEsUV0r9cmtJhW1E=;
        b=jA8tOYOHgfa95XM8mbTftmwXKk9dXpC2EXH2PBnEr0crMFF9Gc1XLGKipZBRG8PrdVf8Rj
        ILjl9my68aeTb0ypVaC7HeS+U2jVJqB73T9Z1FlklSOrfrfKudZw9PjoOwoiWn4NQifxQL
        NGDGARL+phWhYc4NuVWF1f6xkrR5ZaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628064527;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fvpB3zh3SOr6slWuKcuT2uU4LOafEsUV0r9cmtJhW1E=;
        b=/Cl/0ponuW/tE+glDAmSw7ncgJ0akyzTe7lT46eL/PTLbwReTe74OUVRts3aaTb4JZl9Fj
        WHZy9ugYYTXoyBAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D6EB13790;
        Wed,  4 Aug 2021 08:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id He2VHg9LCmFFVAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 04 Aug 2021 08:08:47 +0000
Date:   Wed, 4 Aug 2021 10:08:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210804080847.bajae2twtnmccvq7@beryllium.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 09:23:49AM +0200, Hannes Reinecke wrote:
> There still is now an imbalance, as we're always calling
> 'nvme_unfreeze()' (irrespective on the number of queues), but will only
> call 'nvme_start_freeze()' if we have more than one queue.
> 
> This might lead to an imbalance on the mq_freeze_depth counter.
> Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
> the if() condition to avoid the imbalance?

What about something like nmve_is_frozen() which would avoid the tracking
of the queue state open coded as it is right?
