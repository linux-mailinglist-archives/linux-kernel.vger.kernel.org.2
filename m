Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68F638FBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEYHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:53:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhEYHxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:53:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621929142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2fhzr5837zU52YoYCCj7OktYsUUOPoJ2zCaPYIo83k=;
        b=FYHFW19kcHff0IwGFZ5Mi4waWtuwa+eDq8I9Hvz2IxEKqnsB7CWcTvlz7ytmv5vxSl3XP5
        C/AhJsLtMbxLxuNScTPxongo0aUnBbL6Mhw4JHQY49U+9aloLF2RlUDr5GAnY8mQbMa7ho
        K0qabBWmtya5dMLd44GRlbUdZ77olmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621929142;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2fhzr5837zU52YoYCCj7OktYsUUOPoJ2zCaPYIo83k=;
        b=jkKPQIu7zYgNJ/mnzjMS8+pVaCI2J+4jvEvclpUsXmJiPc9yNqKQ8wmzXI60hdr2VYg+l0
        ERYJWKrnSaq0IjAw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AF0BAE1F;
        Tue, 25 May 2021 07:52:22 +0000 (UTC)
Date:   Tue, 25 May 2021 09:52:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210525075221.uuzabne3qizne3er@beryllium.lan>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
 <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
 <20210524073703.GA24372@lst.de>
 <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
 <20210525072234.GA13966@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525072234.GA13966@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:22:34AM +0200, Christoph Hellwig wrote:
> For non-ANA MNAN doesn't have to be set indeed.  But we also don't use
> the value at all either.

Ah yes, I somehow though we still allocate the log buffer. Obviously, the
buffer is only used with ANA... time to fetch a coffee.
