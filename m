Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC54A3F5F65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhHXNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:45:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHXNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:45:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 749F92209E;
        Tue, 24 Aug 2021 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629812698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQT1R0eSRQSRF+rzGFAmoytGRsJKhqfXEc1Tzckzx/8=;
        b=QO6Onyd99Thl/apaIzjmQn/MNLhZL4OBuYG1DvbASn1odsCNXJ7A5WNVVyWu9pcKolAJQo
        Wql0VdVYNceEQaIpkt9Q7/dedkE/ST50vB+vEnwsxTFK6EguAkZNqGQ0yQSjgJmzAtyG9S
        HFvytrQ0goihl4KQvXXpMcQB27yzcQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629812698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQT1R0eSRQSRF+rzGFAmoytGRsJKhqfXEc1Tzckzx/8=;
        b=vpOGwQaLbAxn9Qpo7vy/AzUZUgjZZe1MOodHAwiqhxtzTu1MZo2Cn2N7UIUtb0UF4XD4Pc
        tBbUFZxFJ1sSNpCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5C66B13A50;
        Tue, 24 Aug 2021 13:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id akkTFtr3JGGuNwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Tue, 24 Aug 2021 13:44:58 +0000
Date:   Tue, 24 Aug 2021 15:44:57 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
References: <20210811152803.30017-1-dwagner@suse.de>
 <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:16:23AM -0700, Sagi Grimberg wrote:
> > +void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> > +{
> > +	struct nvme_ns_head *head = ns->head;
> > +	sector_t capacity = get_capacity(head->disk);
> > +	int node;
> > +
> > +	for_each_node(node)
> > +		rcu_assign_pointer(head->current_path[node], NULL);
> > +
> > +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> > +		if (capacity != get_capacity(ns->disk))
> > +			clear_bit(NVME_NS_READY, &ns->flags);
> > +	}
> 
> Shouldn't the null setting to current_path come after
> we clear NVME_NS_READY on the ns? Otherwise we may still
> submit and current_path will be populated with the ns
> again...

Ahh, I got it this time! Yes, you are right. I think Christoph has
dropped this patch from the nvme-5.15 queue anyway. I'll resend a new
version with the order changed.

Daniel
