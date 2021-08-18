Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10CF3F02F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhHRLnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:43:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33520 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhHRLnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:43:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0F3721FE5;
        Wed, 18 Aug 2021 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629286989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDES0WgtFkq46xcCB56We13uRLgKpFMl/f/27zVfgWw=;
        b=NcZMCCuMYPjzQT1BFbim4flVCxORBu/2y/H2fYEoGs5IAgNr+xi91PHnKodoeILmkaoS12
        grs7WFQOUFg2uRjZMyB9P9aCih4CmJbwgl9Q9cqbug2QGTbZuDqQU0rkNizO5fpEHhuhWL
        gVzvvZHKVREa3Egcpg77JkSdRLkqFe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629286989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDES0WgtFkq46xcCB56We13uRLgKpFMl/f/27zVfgWw=;
        b=gC5wJcY7Y4JrJB8KXRt5htJGyS07xl/EoLBQ2r/BmV1hJky119bKwyWxXC08aRnf2dbmFd
        hFjP0n/YjZscNVAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DD941136DE;
        Wed, 18 Aug 2021 11:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id T5kvNk3yHGHgPQAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 11:43:09 +0000
Date:   Wed, 18 Aug 2021 13:43:09 +0200
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
Message-ID: <20210818114309.ovkutmwvmrgugv4i@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 01:03:07PM -0700, James Smart wrote:
> try this. Moves the location of the freeze and will always pair with the
> unfreeze.

Yes, this works. Do you send a proper patch out or should I just pick up
this patch and add a commit message?
