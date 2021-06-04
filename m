Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096AA39BAEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFDOcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:32:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:32:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D22B11FD4A;
        Fri,  4 Jun 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622817044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
        b=JrFHksKTKLkUuIlW33u6X8mnJzyPXK4rlBWT8qwOMH0l4JyaE3C7PxaLMdrbu3Hoqjw7VL
        B2MtHAJEOb0wlZu6YTkUgswFSmNTGBQcXqxIG8jFgteZI0xzV0xXF6OJZZMygxRA2kuG4v
        a1u6RHGvtN5p3KycCUhL0sMCqY80Eug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622817044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
        b=d1HGi28u8GY+RKDBFCUyofVLEi6kmT8WHt0OjXejBfLPkxNrFa5hfURR6Bn0pq4VR19ZrS
        pA7pxbgCbY9YjrAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 90C06118DD;
        Fri,  4 Jun 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622817044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
        b=JrFHksKTKLkUuIlW33u6X8mnJzyPXK4rlBWT8qwOMH0l4JyaE3C7PxaLMdrbu3Hoqjw7VL
        B2MtHAJEOb0wlZu6YTkUgswFSmNTGBQcXqxIG8jFgteZI0xzV0xXF6OJZZMygxRA2kuG4v
        a1u6RHGvtN5p3KycCUhL0sMCqY80Eug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622817044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoSBmFu0e8u3Vwxa9dkANJ68mh7Ai5k4cJWqI1vhM4Y=;
        b=d1HGi28u8GY+RKDBFCUyofVLEi6kmT8WHt0OjXejBfLPkxNrFa5hfURR6Bn0pq4VR19ZrS
        pA7pxbgCbY9YjrAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 5+OkIRQ5umDdcgAALh3uQQ
        (envelope-from <jroedel@suse.de>); Fri, 04 Jun 2021 14:30:44 +0000
Date:   Fri, 4 Jun 2021 16:30:43 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RESEND PATCH v2] iommu/amd: Fix extended features logging
Message-ID: <YLo5E61tDXG9B3+8@suse.de>
References: <20210504102220.1793-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504102220.1793-1-amonakov@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 01:22:20PM +0300, Alexander Monakov wrote:
> Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
> Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks. And sorry for the delay.
