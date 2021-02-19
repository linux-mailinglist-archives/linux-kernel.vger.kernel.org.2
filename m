Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817FE31F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBSMDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:03:05 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:58145 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230505AbhBSMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:01:56 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 30236803;
        Fri, 19 Feb 2021 07:01:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Feb 2021 07:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        KCoEIq3hXzFEDXTWDHOvgZWOU83J4ZazWlcxgY4hZb8=; b=XTdfsDcu1xOd0B8l
        WNF/LiHKwDHvEPIlMCFysawWKyjzeBpBplIO6HUKEWbX3nVNy4hYjTfl9O+O4qIG
        w2XFLDjqdFOy05i2jynh3LDq8aOF8JbK0+GEvKLImcgXx5gtlN+DJjWow5+ZEBcl
        NFz6ZirPGOT+ySb1Yl9lcfPZVxKIlfnBzHsBw0AB2tcuQ845hKGy6Q7EzD7dKqWY
        CmzPl/co6yNirNXPtMHbY2ZWmDg3lUQlRsoO3bGbicpIKq47XfshPLQYbC/PaZmG
        cejD3SuxUdztTmeMeZgxiQHWjBEleZxHmuMf0741jtD+wPJ6f6LJxAatYSb/Qwii
        XBvOtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=KCoEIq3hXzFEDXTWDHOvgZWOU83J4ZazWlcxgY4hZ
        b8=; b=j/jaPfjEYwSnvWd675dMNqnSaMxrauZXMYai3Y7J0lFYQgFKNse0zBjKx
        dYqDWK3fWp0SjXOgQMjRRGkMw3Op3nP4s0Gw3AufT9QzJieRcIKi9daoCnhQpfO1
        HBGAwOPxJv/GJlXh63EBAPDV7M/r4g2ADVoq0TWbLeFflj2/BdUydXFPog08qsoD
        bJElkqz4ymfKpvYUmWBfCEoXnj3+Qav6MF/0hIaobqJo9wqMSxFwxOVC/TyCXz5k
        RrZ+hcIuUAPRoctuL0O9sLFZge2georQJQpzfr4zDR2zVAw3W9qeW2wO6+Y7o+yd
        vfBzmWo/uT3gvTzqz5AdWfB01/zqw==
X-ME-Sender: <xms:hKgvYLPvLgv0gXT_dAB5jeWZdyKNTnRryv80L7cIkRpczeG1BnGcYg>
    <xme:hKgvYByBIc4elxc32fl1wTPXg-vuXL6uSl9H411i2W5why2BNoVng9HIQ86KrEGpX
    7XanM5a5fpT-xK5sWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:hKgvYAtFekc3cf9HwA4AbxJ4a7Zl3ARcm5DgeB9CKkMFAGLT2HmZLA>
    <xmx:hKgvYMZMZg0DOJ91y3o_kX6CbCZhtyPGqEaM8wUT_k-iPD1R_6Ru6w>
    <xmx:hKgvYH0Hu0uC3TcdhHaSQXFpga5O2h-RGO_Omg4qFA7Mx1ihOmnUqg>
    <xmx:hKgvYHv-wHfuomdJ6x8_iX0Hbi_6UJXvX0jdieXxlJY3TyXK-_fUtrB0OYA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71DEC108005C;
        Fri, 19 Feb 2021 07:01:08 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] drm/todo: Remove the drm_atomic_state todo item
Date:   Fri, 19 Feb 2021 13:00:31 +0100
Message-Id: <20210219120032.260676-11-maxime@cerno.tech>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219120032.260676-1-maxime@cerno.tech>
References: <20210219120032.260676-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only planes' prepare_fb and cleanup_fb, and encoders' atomic_check and
atomic_mode_set hooks remain with an object state and not the global
drm_atomic_state.

prepare_fb and cleanup_fb operate by design on a given state and
depending on the calling site can operate on either the old or new
state, so it doesn't really make much sense to convert them.

The encoders' atomic_check and atomic_mode_set operate on the CRTC and
connector state connected to them since encoders don't have a state of
their own. Without those state pointers, we would need to get the CRTC
through the drm_connector_state crtc pointer.

However, in order to get the drm_connector_state pointer, we would need
to get the connector itself and while usually we have a single connector
connected to the encoder, we can't really get it from the encoder at
the moment since it could be behind any number of bridges.

While this could be addressed by (for example) listing all the
connectors and finding the one that has the encoder as its source, it
feels like an unnecessary rework for something that is slowly getting
replaced by bridges.

Since all the users that matter have been converted, let's remove the
TODO item.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---

Changes from v1:
  - New patch
---
 Documentation/gpu/todo.rst | 46 --------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index f872d3d33218..0631b9b323d5 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -459,52 +459,6 @@ Contact: Emil Velikov, respective driver maintainers
 
 Level: Intermediate
 
-Plumb drm_atomic_state all over
--------------------------------
-
-Currently various atomic functions take just a single or a handful of
-object states (eg. plane state). While that single object state can
-suffice for some simple cases, we often have to dig out additional
-object states for dealing with various dependencies between the individual
-objects or the hardware they represent. The process of digging out the
-additional states is rather non-intuitive and error prone.
-
-To fix that most functions should rather take the overall
-drm_atomic_state as one of their parameters. The other parameters
-would generally be the object(s) we mainly want to interact with.
-
-For example, instead of
-
-.. code-block:: c
-
-   int (*atomic_check)(struct drm_plane *plane, struct drm_plane_state *state);
-
-we would have something like
-
-.. code-block:: c
-
-   int (*atomic_check)(struct drm_plane *plane, struct drm_atomic_state *state);
-
-The implementation can then trivially gain access to any required object
-state(s) via drm_atomic_get_plane_state(), drm_atomic_get_new_plane_state(),
-drm_atomic_get_old_plane_state(), and their equivalents for
-other object types.
-
-Additionally many drivers currently access the object->state pointer
-directly in their commit functions. That is not going to work if we
-eg. want to allow deeper commit pipelines as those pointers could
-then point to the states corresponding to a future commit instead of
-the current commit we're trying to process. Also non-blocking commits
-execute locklessly so there are serious concerns with dereferencing
-the object->state pointers without holding the locks that protect them.
-Use of drm_atomic_get_new_plane_state(), drm_atomic_get_old_plane_state(),
-etc. avoids these problems as well since they relate to a specific
-commit via the passed in drm_atomic_state.
-
-Contact: Ville Syrjälä, Daniel Vetter
-
-Level: Intermediate
-
 Use struct dma_buf_map throughout codebase
 ------------------------------------------
 
-- 
2.29.2

