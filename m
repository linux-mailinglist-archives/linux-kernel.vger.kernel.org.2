Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDF37832E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhEJKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232677AbhEJKfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9332B6191D;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=l5qEtyehlyXvv/SDET45/vq79ol14S8NVaAHOXDTcyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0s4/sCpLX8dUqr3yiQfShgVZSZ03jRS5yubk3BbNc0DnvOxVkJYOhXHu3TADVXvh
         43Ozg2Yx/tqKfgLdOrlELynryWvELECKvrtAed5SFABpvTGMgWe70ZKh8I8iZ1Loe5
         VXU39W3GA8N6OTEvmQAczKGWqKIyvCigQITV2G7gucuhPm9Ub08oJWv9Fs3fHuir72
         n/rR9khB+/2vMWBJItqiGJnJX7OkNXqzmn2FJxzQIa/8bsmoekWYO/vkZapKATKa4x
         jSmjJqZq2dlUWJhHEnN5FFZYEFS4Akt5WF3yjpYMDD0I72RvRHjuo4OjjMGKEJkKB8
         alViREAP/T09Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UY0-9h; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 44/53] docs: gpu: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:56 +0200
Message-Id: <36bc1118467da645a57515743c9f6c1cd86abe8c.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/gpu/i915.rst       | 2 +-
 Documentation/gpu/komeda-kms.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 486c720f3890..2cbf54460b48 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -361,7 +361,7 @@ Locking Guidelines
 	  real bad.
 
 #. Do not nest different lru/memory manager locks within each other.
-   Take them in turn to update memory allocations, relying on the object’s
+   Take them in turn to update memory allocations, relying on the object's
    dma_resv ww_mutex to serialize against other operations.
 
 #. The suggestion for lru/memory managers locks is that they are small
diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
index eb693c857e2d..c2067678e92c 100644
--- a/Documentation/gpu/komeda-kms.rst
+++ b/Documentation/gpu/komeda-kms.rst
@@ -324,7 +324,7 @@ the control-abilites of device.
 
 We have &komeda_dev, &komeda_pipeline, &komeda_component. Now fill devices with
 pipelines. Since komeda is not for D71 only but also intended for later products,
-of course we’d better share as much as possible between different products. To
+of course we'd better share as much as possible between different products. To
 achieve this, split the komeda device into two layers: CORE and CHIP.
 
 -   CORE: for common features and capabilities handling.
-- 
2.30.2

