Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35CD38FB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhEYHOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:14:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEYHO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:14:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621926779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFrLKjx227jLbVbX0QuAMdsMDPH43Of7iC/2lHJE1RM=;
        b=cnuk98THGytIPMklHLkASVx3uVxo8jS8XpVUZatQLOfnWtLA11EHI25tgT1pL1Vz+EwX7d
        8oBSIihU5MS5pueinvNaypCGc86WOou65GAR4M6o5A0ZaW7Tg+GMd4JpwoLaIOiB+WPybT
        UVdlw1Nbn2UHePFitgDN0u4phDd8l4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621926779;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFrLKjx227jLbVbX0QuAMdsMDPH43Of7iC/2lHJE1RM=;
        b=e5+zqMx+Xl4i8jMrp5X7spni6sgBQ5571DtYJTJJgsnk/IwUY1Bg91tt62drPHvlzMg3+R
        4HsVgM2ytQzeV7BQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7853AEAA;
        Tue, 25 May 2021 07:12:59 +0000 (UTC)
Date:   Tue, 25 May 2021 09:12:59 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
 <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
 <20210524073703.GA24372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524073703.GA24372@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 09:37:03AM +0200, Christoph Hellwig wrote:
> I think we should add a sanity check for that and reject the broken
> controller if that is not the case rather than working around it.

Alright. I understood from the spec, that in the non ANA case the NN
field should still be case though?
