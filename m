Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829443A0D49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhFIHMu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 03:12:50 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:56808 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhFIHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:12:49 -0400
Received: from [192.168.1.3] (ns.gsystem.sk [62.176.172.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 8496D7A025C;
        Wed,  9 Jun 2021 09:10:54 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: nouveau broken on Riva TNT2 in 5.13.0-rc4: NULL pointer dereference in nouveau_bo_sync_for_device
Date:   Wed, 9 Jun 2021 09:10:51 +0200
User-Agent: KMail/1.9.10
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <202106052143.52488.linux@zary.sk> <202106090857.42133.linux@zary.sk> <1c4a7360-57e3-c75a-c729-1432db5b90b9@amd.com>
In-Reply-To: <1c4a7360-57e3-c75a-c729-1432db5b90b9@amd.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <202106090910.51188.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 June 2021, Christian König wrote:
> Am 09.06.21 um 08:57 schrieb Ondrej Zary:
> > [SNIP]
> >> Thanks for the heads up. So the problem with my patch is already fixed,
> >> isn't it?
> > The NULL pointer dereference in nouveau_bo_wr16 introduced in
> > 141b15e59175aa174ca1f7596188bd15a7ca17ba was fixed by
> > aea656b0d05ec5b8ed5beb2f94c4dd42ea834e9d.
> >
> > That's the bug I hit when bisecting the original problem:
> > NULL pointer dereference in nouveau_bo_sync_for_device
> > It's caused by:
> > # first bad commit: [e34b8feeaa4b65725b25f49c9b08a0f8707e8e86] drm/ttm: merge ttm_dma_tt back into ttm_tt
> 
> Good that I've asked :)
> 
> Ok that's a bit strange. e34b8feeaa4b65725b25f49c9b08a0f8707e8e86 was 
> created mostly automated.
> 
> Do you have the original backtrace of that NULL pointer deref once more?

The original backtrace is here: https://lkml.org/lkml/2021/6/5/350

-- 
Ondrej Zary
