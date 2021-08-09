Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCD53E4223
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhHIJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:10:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhHIJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:10:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95AC621F44;
        Mon,  9 Aug 2021 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628500187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoQMlqTicS0HtimnKTTbCDkN5674ozjQ0AoY71P8px0=;
        b=YO1Vd1BF59SZJsXEP03mFbkDMzLgDLCuLDrBJwug4jMtdOKccpi1RcpsydKPbhTg9RXf6s
        UiSoaisfiNLLmWrcml0Ule+E3n2nSnj9gRDDcGfa/oeDW8N38aAiAEox3gFIv7qlXrSdEa
        yfLEyVdVG/lXo13re9arw/Hb1q1Yjng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628500187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoQMlqTicS0HtimnKTTbCDkN5674ozjQ0AoY71P8px0=;
        b=Y0kK/8oHEapwTCj0LNczmKG5p33oMgaTxfbDwlqKYdCLGoN8EX2nu0wgQoGOzzmu/3VPRq
        czyeTZZL3hXQ28Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 85D33132AB;
        Mon,  9 Aug 2021 09:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id wPliINvwEGFTLgAAGKfGzw
        (envelope-from <dwagner@suse.de>); Mon, 09 Aug 2021 09:09:47 +0000
Date:   Mon, 9 Aug 2021 11:09:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, yi.he@emc.com
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210809090947.luoqaooi7gc6u6yu@carbon>
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Fri, Aug 06, 2021 at 12:42:00PM -0700, Sagi Grimberg wrote:
> > @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
> >   	size_t			data_remaining;
> >   	size_t			ddgst_remaining;
> >   	unsigned int		nr_cqe;
> > +	u16			status;
> 
> Why is this a queue member and not a request member?

I was not sure if the TCP transport specific error handling should
impact all other transport (size of struct request). Also I tried to
avoid accessing cachelines which are not already in use. Except this I
don't see there should be no problem to put this to struct request.

Daniel
