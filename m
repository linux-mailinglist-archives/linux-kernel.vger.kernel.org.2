Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B1C3FB942
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhH3PvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:51:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhH3PvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:51:19 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74F81220D2;
        Mon, 30 Aug 2021 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630338625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ceX1dMxIClr9YSJ/0dIk11Ssam9+xQ+XyrlF6BIEsAg=;
        b=AG5kyUwBn8ctqnX2+iI3inK6/Izq07j4SRmFwCUAszezt1MfHKA3kmRMqFkj+Ekmm+gv0x
        8wf+zCSI5UOhyntCRY2tSlAMKxr++F8SgfO5HpD0/qzIT74mySuLyA8I+FxbzBbvaZJiHb
        uLjnhivX+znnreLH5KNzch5qWhng7MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630338625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ceX1dMxIClr9YSJ/0dIk11Ssam9+xQ+XyrlF6BIEsAg=;
        b=ESJGojnzI4LchpjfkAqI6xi0wYJFsjXPCKieciALPDwamE+MsndawpN+SIqOgJwdJiPcqO
        G1Lxi2xjvjImGTBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5F61B139B8;
        Mon, 30 Aug 2021 15:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +v/iFkH+LGFqGwAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 30 Aug 2021 15:50:25 +0000
Date:   Mon, 30 Aug 2021 17:50:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210830155024.ekughhihfecbzzby@carbon.lan>
References: <20210830133626.139828-1-dwagner@suse.de>
 <462c31ae-446b-cc23-eb91-5e27ef04ec13@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462c31ae-446b-cc23-eb91-5e27ef04ec13@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 06:38:28PM +0300, Sagi Grimberg wrote:
> > +	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
> 
> endian conversion a zero enum? looks weird..

I though it makes sense to stay consistent with the rest and don't make
it harder for the reader to figure out why this might not needed here.

And obviously the fear of the static code analyzers...

> But,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks!
