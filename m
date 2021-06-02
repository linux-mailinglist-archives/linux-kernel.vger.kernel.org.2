Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC563398E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhFBPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:21:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhFBPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:20:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E59D336E7;
        Wed,  2 Jun 2021 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622647112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
        b=JRfdjcjezHVUWId4flW7MPoRofk3c5D4AdW7mxSCnNVBrDflbgNjb82S5WvkI8x3m+1e0v
        77O6UlA+5afJ5qOdRQzYsEsMPRTTICRhCwpueILy3T7ZKvNZGmidXx51v5MTLBqMTZBQAF
        dPOXjBpIgq0NUX86Q26XiC9tPnVYML0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622647112;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
        b=zW7ehgWWMVNp82+eHjE5dkp1SiuEYRFvQfpM28o01y8BD+lpX53mSGzKT8lQw1h+8Z7IpQ
        9tTJvwi/zc1OpHAg==
Received: by imap.suse.de (Postfix, from userid 51)
        id 03A5311CD6; Wed,  2 Jun 2021 16:07:31 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8A29F11E3F;
        Wed,  2 Jun 2021 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622638159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
        b=Ps9Uk4tk3AruLw4qiTFIcIwsJABrdJW5I6U31BJHSQzSrxmX6AevNLGDxO982AvpYgJabc
        eHyIafbNhQ59P9c40um7S8v4pFnHlFfUs1IDfRSqoztKJevZa4azzYPsapVVFkENi4NeEa
        lCazp7RCu+OjG7g/RrjPKRlNt47OfEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622638159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
        b=XYlQNIbld5R0Ky8IzRBkiK0ydxAQkpkwPKbOyrNrOKkb2qwXNcnyyHEu1AhP1HL1qv5idB
        Fv6Ywi+lAZg/fuAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 87PuIE9+t2D+KgAALh3uQQ
        (envelope-from <dwagner@suse.de>); Wed, 02 Jun 2021 12:49:19 +0000
Date:   Wed, 2 Jun 2021 14:49:19 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: reset disk to the mpath node also when requeuing
Message-ID: <20210602124919.gdzorzhbjitjr4uj@beryllium.lan>
References: <20210602123429.103935-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602123429.103935-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:34:29PM +0200, Daniel Wagner wrote:
>  		spin_lock_irq(&head->requeue_lock);
> +		bio_set_dev(bio, head->disk->part0);

Obviously, this needs to be done for all bios. Let me send an updated
version.x
