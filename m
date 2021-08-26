Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628853F837C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbhHZIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:05:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhHZIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:05:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C8CB1FE50;
        Thu, 26 Aug 2021 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629965089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz4kMtmgcRiHH+eY6OlEi5nZ3aLXbNcHgM4etPf13YA=;
        b=RaXHj+z76JhybAusnJe/l5NgRbJwuKMyClTuYWeByEJJa/3JcL7lcatSFh3wD6+BIsO7KH
        lVKUfqGj/RN39FluYHyasW77HJs5DlJ/VQJ9i8apnUjLEz3zFh9zh7ASrPMz7HNOcUDcoj
        Bd69K7fsaoOAiDFvrRaF8RRqaRLheHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629965089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dz4kMtmgcRiHH+eY6OlEi5nZ3aLXbNcHgM4etPf13YA=;
        b=uOQW8kR7vS07Lld8N+NnGkMD3J7DCLMAXy5tHiraRSCQp1sBKlYEMVQC0k2GdVXCc9MKCk
        Dl4GJaPW/HRM9zDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6F15713A79;
        Thu, 26 Aug 2021 08:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id L3HLGiFLJ2HhBQAAGKfGzw
        (envelope-from <dwagner@suse.de>); Thu, 26 Aug 2021 08:04:49 +0000
Date:   Thu, 26 Aug 2021 10:04:49 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com
Subject: Re: [PATCH v2] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210826080449.6pzvgihxzqbsosrx@carbon.lan>
References: <20210825124259.28707-1-dwagner@suse.de>
 <42916ab0-2997-b19f-47ee-e20e8e868a86@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42916ab0-2997-b19f-47ee-e20e8e868a86@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:27:10PM +0200, Hannes Reinecke wrote:
> > @@ -506,6 +514,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> >   static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
> >   		struct nvme_tcp_data_pdu *pdu)
> >   {
> > +	struct nvme_tcp_request *req;
> >   	struct request *rq;
> >   	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
> > @@ -534,6 +543,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
> >   		return -EPROTO;
> >   	}
> > +	req = blk_mq_rq_to_pdu(rq);
> > +	req->status = NVME_SC_SUCCESS;
> >   	return 0;
> >   }
> 
> Can't you move the initialisation to nvme_tcp_setup_cmd_pdu()?
> That'll save to to have to reference the tcp request here ...

Yes, that's a why better place to initialize it. Let me spin a new
version.
