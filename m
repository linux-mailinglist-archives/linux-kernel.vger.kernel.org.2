Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690E23B2688
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFXEyx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Jun 2021 00:54:53 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:34238 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhFXEys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 00:54:48 -0400
Received: from glidewell.localnet (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 2E7E54FA68;
        Thu, 24 Jun 2021 00:52:02 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/radeon: Fix NULL dereference when updating memory stats
Date:   Thu, 24 Jun 2021 00:52:01 -0400
Message-ID: <12410445.c4f2iDpdjA@glidewell>
In-Reply-To: <085b7f51-15b8-42e0-fcf0-66da839542c8@amd.com>
References: <20210622212613.16302-1-mikel@mikelr.com> <085b7f51-15b8-42e0-fcf0-66da839542c8@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 23, 2021 2:55:04 AM EDT Christian König wrote:
> Please rather keep the new resource as parameter here and update before
> adjusting bo->resource.
> 
> This way you also don't need to export radeon_update_memory_usage().

I wasn't sure exactly what you intended with the request to "update before
adjusting bo->resource".

Assuming the statistics update is done as part of radeon_bo_move_notify(), I 
believe that function cannot be called any earlier in radeon_bo_move(). If it 
were, the source object would be invalidated before it moved.

So I assume you're suggesting updating the memory usage earlier in 
bo_move_notify (before the early return for ghost objects).

Thanks,
Mikel
