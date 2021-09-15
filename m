Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8B40BFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhIOGkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhIOGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631687925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2jrv4qpH+SsfqVOrOyTWjCAMipmK09EdyvQxDfD9z+o=;
        b=PVN7GqOITNaYTWkFZkDSvpJlXbhBshvrYLFwF4fSMHLYuqbUqycvBvfQcoFZ3YHQnL3K5B
        1SWKzHnwi3p/eHQ+w5DEBGJPct6qVZHWVizYhzu2iGON6GfPvCYgNhjVM/3Q7bVD2Xw9/7
        uFKPGIi6zvDPb4TP0/yA8A0jotSbbwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7qemqFm_PtCHmUhwK6aNNQ-1; Wed, 15 Sep 2021 02:38:41 -0400
X-MC-Unique: 7qemqFm_PtCHmUhwK6aNNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A72684A5E0;
        Wed, 15 Sep 2021 06:38:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A210C5D9D3;
        Wed, 15 Sep 2021 06:38:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 290BE18003BF; Wed, 15 Sep 2021 08:38:35 +0200 (CEST)
Date:   Wed, 15 Sep 2021 08:38:35 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     bibo mao <maobibo@loongson.cn>
Cc:     Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/qxl: Add qxl dma fence release function
Message-ID: <20210915063835.36bhpadzbzuj7shw@sirius.home.kraxel.org>
References: <20210914062352.6102-1-maobibo@loongson.cn>
 <20210914062352.6102-2-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914062352.6102-2-maobibo@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:23:52AM -0400, bibo mao wrote:
> Add qxl dma fence release function, previously default dma fence
> release function is used, and fence pointer is used to free 
> the memory. With this patch, actual qxl release pointer is used
> to free memory, so that dma fence can put at any place of 
> struct qxl_release.

Why?  Is there a problem with struct dma_fence being the first
element of struct qxl_release?

take care,
  Gerd

