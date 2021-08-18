Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCD3F0306
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhHRLuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:50:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51708 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhHRLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:49:49 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 188FD1FFB9;
        Wed, 18 Aug 2021 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629287354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kIIwbBMCo0jcO7goEPPzyNXcpgv0ZfRxkw1OI2DKg9U=;
        b=cvDQUSmaMajNBAaWANNjFAPuYf014CtCoH5fbTcsllTDHIkK4+Rik8SP1o6ovkc8a/AEtN
        xgOZD4CgrcMLajonJiusPhvKzMjTxoYGNvlYNpPtcdL/8u8n9xOCVvaVrB0Adzf3ubzIuX
        hIctoGpeDmTDqiXvdiAnq3KV3wNZpqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629287354;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kIIwbBMCo0jcO7goEPPzyNXcpgv0ZfRxkw1OI2DKg9U=;
        b=gP+PGR+0oBO93iDjr4AVDXc3qR1HzgxCSwy/MyDPrnYBCX+k2und7Jod4kJgHtkh8RwJPg
        HPDI0TSV33dXWHDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 08284136DE;
        Wed, 18 Aug 2021 11:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WtrLAbrzHGGfPwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 11:49:14 +0000
Date:   Wed, 18 Aug 2021 13:49:13 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210818114913.lfy2nzc7kssul6er@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
 <20210818114309.ovkutmwvmrgugv4i@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818114309.ovkutmwvmrgugv4i@carbon.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:43:09PM +0200, Daniel Wagner wrote:
> On Thu, Aug 12, 2021 at 01:03:07PM -0700, James Smart wrote:
> > try this. Moves the location of the freeze and will always pair with the
> > unfreeze.
> 
> Yes, this works. Do you send a proper patch out or should I just pick up
> this patch and add a commit message?

Forget it, the commit message is still the same. Let me respin this series.
