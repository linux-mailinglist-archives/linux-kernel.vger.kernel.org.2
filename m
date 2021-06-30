Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF73B85D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhF3PMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:12:55 -0400
Received: from srv6.fidu.org ([159.69.62.71]:45218 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235488AbhF3PMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:12:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 55B84C80086;
        Wed, 30 Jun 2021 17:10:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id PR1NKElp0h6k; Wed, 30 Jun 2021 17:10:24 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300e37F394900095779a208783f8e.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:957:79a2:878:3f8e])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 3A283C80068;
        Wed, 30 Jun 2021 17:10:23 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        emil.l.velikov@gmail.com
Subject: [PATCH v5 00/17] New uAPI drm properties for color management
Date:   Wed, 30 Jun 2021 17:10:01 +0200
Message-Id: <20210630151018.330354-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of https://lkml.org/lkml/2021/5/12/764 now feature complete
albeit not fully tested.

I have now corrected the DSC behavior, but still no wait to test it.

Exact dithering behavior remains a mistery so in case dithering is active it's
not 100% clear what "active bpc" means, or where the "max bpc" limit is applied.

I have no DP MST splitter at hand. I tried my best to not break anything,
but if one who has one could test it would be very helpful.

Things on my TODO list:
    - add "min bpc" property
    - rewrite "preferred color format" to "force color format"
    - make "Broadcast RGB" only affect RGB on AMD too
    - remove unreachable enums of "active/preferred/force color format"


