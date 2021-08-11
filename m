Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C060F3E8EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhHKKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:32:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48730 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhHKKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:32:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 89530221D2;
        Wed, 11 Aug 2021 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628677906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpLDPZd/N2/VcLHworm+Mh4R910b9m4Ub0D/eTKpZ2c=;
        b=VbVynxJn3fn2qBccx43dG5RN+NVZw3aHD5cjvxnZ5rKYdjuQsvDMB3Al86aCK7tCfP0AKK
        /ovX2lHHToJW+qgSviR6HEyPdpUKbZZEoiNVvrX33cP5rJI6ZDcleJStVKwc5K+MjUABhL
        tIDHI5P5plKELLqIZyr0tVo3bhFcrCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628677906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpLDPZd/N2/VcLHworm+Mh4R910b9m4Ub0D/eTKpZ2c=;
        b=9pnAPYyX7BnYcKFd8cyLrvcHazFsOhpr/jdI5zJ8HW59Gk4gssjbYPKcor7+nnfKHMagHd
        rK0PknAIjWdbsRCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 78E2E131F5;
        Wed, 11 Aug 2021 10:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IpSAHRKnE2EQEAAAGKfGzw
        (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 10:31:46 +0000
Date:   Wed, 11 Aug 2021 12:31:46 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210811103146.ytqj5mqpioiba56x@carbon.lan>
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
 <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:02:36PM -0700, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> > 
> > On Fri, Aug 06, 2021 at 12:42:00PM -0700, Sagi Grimberg wrote:
> > > > @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
> > > >    	size_t			data_remaining;
> > > >    	size_t			ddgst_remaining;
> > > >    	unsigned int		nr_cqe;
> > > > +	u16			status;
> > > 
> > > Why is this a queue member and not a request member?
> > 
> > I was not sure if the TCP transport specific error handling should
> > impact all other transport (size of struct request). Also I tried to
> > avoid accessing cachelines which are not already in use. Except this I
> > don't see there should be no problem to put this to struct request.
> 
> It is the correct place, lets see that it doesn't increase the struct.

It should not according pahole:

        /* XXX 7 bytes hole, try to pack */

        void *                     pdu;                  /*   144     8 */
        int                        pdu_remaining;        /*   152     4 */
        int                        pdu_offset;           /*   156     4 */
        size_t                     data_remaining;       /*   160     8 */
        size_t                     ddgst_remaining;      /*   168     8 */
        unsigned int               nr_cqe;               /*   176     4 */
        u16                        status;               /*   180     2 */

        /* XXX 2 bytes hole, try to pack */

Daniel
