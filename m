Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B839FDF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhFHRpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:45:23 -0400
Received: from srv6.fidu.org ([159.69.62.71]:56084 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbhFHRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:45:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 7F84FC800DD;
        Tue,  8 Jun 2021 19:43:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id SRbOlgtfnunT; Tue,  8 Jun 2021 19:43:26 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37f4F60006a44b0068bFE089d.dip0.t-ipconnect.de [IPv6:2003:e3:7f4f:6000:6a44:b006:8bfe:89d])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 7DE2BC800C1;
        Tue,  8 Jun 2021 19:43:25 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/7] Add "activ bpc" and "active color format" drm property
Date:   Tue,  8 Jun 2021 19:43:13 +0200
Message-Id: <20210608174320.37429-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I started work on my proposal for better color handling in Linux display
drivers: https://lkml.org/lkml/2021/5/12/764

In this 2nd revision the first two read-only properties are now implemented for
amdgpu and i915. I post it here to collect collect some additional feedback, if
someone sees an improvement opportunity.

I have already commited the first patch in this series independently as it fixes
a function already in use.

Some of the feedback from the first post is already implemented.

The actual update of the values is implemented in patch three and four and six
and seven in the atomic_commit_tail() function of amdgpu and atomic_commit()
function of i915 respectively. They do get updated more often than needed with
the current approach, but without harm since just the same value is written
again. A check if the update is required would be the same amount of
computation.


