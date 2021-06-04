Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD639BE69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFDRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhFDRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:19:25 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C9CC061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:17:38 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 8CC95C800C8;
        Fri,  4 Jun 2021 19:17:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Ms01pTyamUKB; Fri,  4 Jun 2021 19:17:35 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37f2e2a0038b625C68b541A92.dip0.t-ipconnect.de [IPv6:2003:e3:7f2e:2a00:38b6:25c6:8b54:1a92])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id ABC54C800C5;
        Fri,  4 Jun 2021 19:17:34 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/4] Add "activ bpc" drm property and use it in AMD and Intel driver
Date:   Fri,  4 Jun 2021 19:17:19 +0200
Message-Id: <20210604171723.10276-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I started work on my proposal for better color handling in Linux display
drivers: https://lkml.org/lkml/2021/5/12/764

Since the first read-only property is now implemented for amdgpu and i915 I
wanted to collect some feedback, since the other two read-only properties will
be quite similar, I hope.

I have already commited the first patch in this series independently as it fixes
a function already in use.

The actuall update of the values is implemented in patch three and four in the
atomic_commit_tail() function of amdgpu and i915 respectifly. It does get
updated more often than needed with the current approach, but without harm since
just the same value is written again. A check if the update is required would be
the same amount of computation. Let me know if you know a better place to put
the update than attomic_commit_tail().


