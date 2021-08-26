Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD613F871E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbhHZMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:18:24 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42187 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbhHZMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:18:24 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 18D5722256;
        Thu, 26 Aug 2021 14:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1629980256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ph0v+Bk7Np1hcCXD7mWsaKWmwgPPFWEPG+SQv38Uy3I=;
        b=Fv1/NAqTNUuuth3zPm7X0Ir//6tzhF2bNK0eh/vTzdpTdujEGy5Z6qLODK0i7xLIFkH0PV
        m5BumCufw0obsOXFckyj2q3t4m5CZDJaEnMpo06+5XXZzPyrDVEoJvbFmCrtXIqNAq+dx6
        +c9U4whUhq33k2WwLUN5z3h6UTALRBc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Aug 2021 14:17:35 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/3] drm/etnaviv: fix dma configuration of the virtual
 device
In-Reply-To: <20210826121426.GR22278@shell.armlinux.org.uk>
References: <20210826121006.685257-1-michael@walle.cc>
 <20210826121006.685257-3-michael@walle.cc>
 <20210826121426.GR22278@shell.armlinux.org.uk>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ebbb3cb0b07e45cc4171747fae844633@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-08-26 14:14, schrieb Russell King (Oracle):
> On Thu, Aug 26, 2021 at 02:10:05PM +0200, Michael Walle wrote:
>> +	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(40);
>> +	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> 
> Please use dma_coerce_mask_and_coherent() here instead.

It will be removed altogether in patch 3/3. I just moved the
current code around here. I could drop the code moving in 2/3. I
wasn't sure whats best.

-michael
