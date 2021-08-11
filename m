Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6923E8E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhHKKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:30:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhHKKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:30:44 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 350E9221D1;
        Wed, 11 Aug 2021 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628677820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9PROUPtd8tEVskY/x6F4cQKQn0LeaTzerYxm4i+slnw=;
        b=zTIZyeUy8mE4QaOiuEp13YJvKZp5L8XAaUDYhhMYAHx6k1kyQ4hvY18ZvQ6TrWZMh+jdyH
        L3GXpO4H/jgTt9l4jZG7qpY62madXczy2FiLtK2etIFlnP+t0Sp9w4FdslWFNiWLFPrX86
        RDj5gM59hmtd/daztRelmR7gfPICYaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628677820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9PROUPtd8tEVskY/x6F4cQKQn0LeaTzerYxm4i+slnw=;
        b=2YGzMIs6bMSGM1nNVEVwRaSd49v37+r29fwBw8DUzlbZE3C1SFuGEIYZYTIoAiW0IoLOQn
        njjPEo2fxahy3xAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1D66E131F5;
        Wed, 11 Aug 2021 10:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SkrXBrymE2G0DwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 10:30:20 +0000
Date:   Wed, 11 Aug 2021 12:30:19 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210811103019.j2smukkfseqa3qdr@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <20210804080847.bajae2twtnmccvq7@beryllium.lan>
 <d43f83cf-a3cd-df16-5af8-1f530b25d1cc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43f83cf-a3cd-df16-5af8-1f530b25d1cc@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:05:04PM -0700, Sagi Grimberg wrote:
> Why is there a conditional freeze?

The freeze only happens if I/O queues have been created/started. If I
understand this correctly, this is the corner case we were only able to
establish the admin queue and fail later to setup the I/O queues.
