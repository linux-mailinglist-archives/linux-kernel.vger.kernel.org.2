Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290DC3494D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCYPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:00:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59732 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCYPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:00:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lPRSx-0003iZ-Uo; Thu, 25 Mar 2021 15:00:07 +0000
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: drm/ttm: switch to per device LRU lock
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Huang Rui <ray.huang@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org
Message-ID: <22ad0b20-b879-bcad-5c94-80c162a9da74@canonical.com>
Date:   Thu, 25 Mar 2021 15:00:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with Coverity in linux-next has detected an issue in
drivers/gpu/drm/ttm/ttm_bo.c with the follow commit:

commit a1f091f8ef2b680a5184db065527612247cb4cae
Author: Christian König <christian.koenig@amd.com>
Date:   Tue Oct 6 17:26:42 2020 +0200

    drm/ttm: switch to per device LRU lock

    Instead of having a global lock for potentially less contention.


The analysis is as follows:

617 int ttm_mem_evict_first(struct ttm_device *bdev,
618                        struct ttm_resource_manager *man,
619                        const struct ttm_place *place,
620                        struct ttm_operation_ctx *ctx,
621                        struct ww_acquire_ctx *ticket)
622 {
   1. assign_zero: Assigning: bo = NULL.

623        struct ttm_buffer_object *bo = NULL, *busy_bo = NULL;
624        bool locked = false;
625        unsigned i;
626        int ret;
627

   Explicit null dereferenced (FORWARD_NULL)2. var_deref_op:
Dereferencing null pointer bo.

628        spin_lock(&bo->bdev->lru_lock);
629        for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {

The spin_lock on bo is dereferencing a null bo pointer.

Colin
