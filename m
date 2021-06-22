Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53633AFFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFVJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:13:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhFVJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:13:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 91C4821988;
        Tue, 22 Jun 2021 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624353084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsgClS//Etyv4whU6j1KEJyiiweZikf3mJh0lbC/KWY=;
        b=RQVBbYTfi55FXnzepOzxVIxwnmTZkX+Z8FTJLbUm3rHpgtTHndAqd6JD0Qw+qOBVhOJ8f2
        iOQPOZwBrDrsQBlprqPZazDPbndroUM7uD8mJrgX2/vQJ7KQYDjVV793af3OmCZGrODQ1m
        UAJd/XLJzt3zPo7/oireDiXJUwDOugY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624353084;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsgClS//Etyv4whU6j1KEJyiiweZikf3mJh0lbC/KWY=;
        b=D1HINk5P/RMaAH6w3K1EiAoqryz/neLp+h7bAyp1BwTRQPU5cw1RC1Ilnhw+k4cU6kE7pf
        EsBYF39lycEl6HAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 856CDA3B8D;
        Tue, 22 Jun 2021 09:11:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B4691E1515; Tue, 22 Jun 2021 11:11:24 +0200 (CEST)
Date:   Tue, 22 Jun 2021 11:11:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jan Kara <jack@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] quota: remove unnecessary oom message
Message-ID: <20210622091124.GC14261@quack2.suse.cz>
References: <20210618014720.1977-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618014720.1977-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-06-21 09:47:19, Zhen Lei wrote:
> v1 --> v2:
> As Jan Kara's suggestion:
> get rid of getdqbuf() altogether and instead call kmalloc() directly in all
> the places.
> 
> 
> Zhen Lei (1):
>   quota: remove unnecessary oom message
> 
>  fs/quota/quota_tree.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Thanks! I've merged the patch to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
