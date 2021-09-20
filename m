Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC0410FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhITHGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhITHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:06:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC5AC061574;
        Mon, 20 Sep 2021 00:05:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 17so16369171pgp.4;
        Mon, 20 Sep 2021 00:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Pc9p5CeYocJsFTsxO2J3P5SkG+9sBB3CRGrdNGvJ86w=;
        b=hbmwZqj3MpKQ5//Hg10kU6Kj8T04rOQQtH9AWjBljqu3Pxs/4Q1pkTbp14+1JpVMyS
         63HcbV4pZl++7Rlt3dSRBeSnOKHdMJc2dM7JwxX2P89coD2bAIXs9akKSZt4xw7GmaLs
         N7GepXnWxgCnFi24KlLWI4eOa3UvwMAU4HRD+bbF8TU7PT0/wBsdSealXQjH5gIsJRj3
         mDmO6+A2sTLkbtF87sDF5KlLe03C1q+9lshJQxNVdeJQWtvIL+PC7dJFXT+mOq3hmj21
         rh+E8gmCT/UARrWcEmLtbl7fvmjCMRkyzNk+hLgbuYcRxMJsWziXPa1oJvtbVnijnB71
         dGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:cc:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Pc9p5CeYocJsFTsxO2J3P5SkG+9sBB3CRGrdNGvJ86w=;
        b=4IMa/PDanxau6NwiuASK9VgxXPtIM34GL8c9QvyNKs8qZqHEoStXG4FjVqQqxXbBJq
         WMOLhhjYHijgVibW3p1NabNBq7gEi+fvxiW70AOtkALVIe47/e5drvKNNZCuk7k2N7ow
         dCWh9+SBlgq6E8Bxa9efqrUJtn9GnEvbBdpy6hRXe+egTGdE/syo1F0z+2geVX4V6JSE
         Bkw6kUewUepZoZo+/qetcrp5wF4yY/SY4V0fGy80yDfvcl9iv0wRnNlK+bSvrC2SSIPC
         PrPeHQYbB0hMuzoKeaXOXF3zSvskz3DTusWsV6BriLRNk8Na9choX7olV2JcjDsPUAYv
         BTpA==
X-Gm-Message-State: AOAM532OMJHnTlXMra1q87Cbg80/g19vBlJPPQIcwOFgJsJlwuuMKknS
        ffhQjMejuJjhaLwiqlx2aRk=
X-Google-Smtp-Source: ABdhPJy0g/g/0MXLpBUsJfWEhVRkdyUgSGWsPHG4TnjrOKnWaswLMzGC8Sdf8xnA4o4sa03Behlz4Q==
X-Received: by 2002:a62:60c2:0:b0:446:b494:39cc with SMTP id u185-20020a6260c2000000b00446b49439ccmr10743109pfb.22.1632121504570;
        Mon, 20 Sep 2021 00:05:04 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h17sm5814700pfk.66.2021.09.20.00.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 00:05:04 -0700 (PDT)
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] drm/i915/guc, docs: Fix pdfdocs build error by removing
 nested grid
To:     John Harrison <John.C.Harrison@Intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Message-ID: <4a227569-074f-c501-58bb-d0d8f60a8ae9@gmail.com>
Date:   Mon, 20 Sep 2021 16:05:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested grids in grid-table cells are not specified as proper ReST
constructs.
Commit 572f2a5cd974 ("drm/i915/guc: Update firmware to v62.0.0")
added a couple of kerneldoc tables of the form:

  +---+-------+------------------------------------------------------+
  | 1 |  31:0 |  +------------------------------------------------+  |
  +---+-------+  |                                                |  |
  |...|       |  |  Embedded `HXG Message`_                       |  |
  +---+-------+  |                                                |  |
  | n |  31:0 |  +------------------------------------------------+  |
  +---+-------+------------------------------------------------------+

For "make htmldocs", they happen to work as one might expect,
but they are incompatible with "make latexdocs" and "make pdfdocs",
and cause the generated gpu.tex file to become incomplete and
unbuildable by xelatex.

Restore the compatibility by removing those nested grids in the tables.

Size comparison of generated gpu.tex:

                  Sphinx 2.4.4  Sphinx 4.2.0
  v5.14:               3238686       3841631
  v5.15-rc1:            376270        432729
  with this fix:       3377846       3998095

Fixes: 572f2a5cd974 ("drm/i915/guc: Update firmware to v62.0.0")
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi all,

I know there is little interest in building pdfdocs (or LaTeX) version
of kernel-doc, and this issue does not matter most of you.

But "make pdfdocs" is supposed to work, give or take those tables
with squeezed columns, and at least it is expected to complete
without fatal errors.

I have no idea who is responsible to those grid-tables, so added
a lot of people in the To: and Cc: lists.

Does removing those nested grids look reasonable to you?

Any feedback is welcome!

Note: This patch is against the docs-next branch of Jon's -doc tree
(git://git.lwn.net/linux.git).  It can be applied against v5.15-rc1
and v5.15-rc2 as well.

        Thanks, Akira
--
 .../gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h | 10 +++++-----
 .../drm/i915/gt/uc/abi/guc_communication_mmio_abi.h    | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
index 99e1fad5ca20..c9086a600bce 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_ctb_abi.h
@@ -102,11 +102,11 @@ static_assert(sizeof(struct guc_ct_buffer_desc) == 64);
  *  |   +-------+--------------------------------------------------------------+
  *  |   |   7:0 | NUM_DWORDS = length (in dwords) of the embedded HXG message  |
  *  +---+-------+--------------------------------------------------------------+
- *  | 1 |  31:0 |  +--------------------------------------------------------+  |
- *  +---+-------+  |                                                        |  |
- *  |...|       |  |  Embedded `HXG Message`_                               |  |
- *  +---+-------+  |                                                        |  |
- *  | n |  31:0 |  +--------------------------------------------------------+  |
+ *  | 1 |  31:0 |                                                              |
+ *  +---+-------+                                                              |
+ *  |...|       | [Embedded `HXG Message`_]                                    |
+ *  +---+-------+                                                              |
+ *  | n |  31:0 |                                                              |
  *  +---+-------+--------------------------------------------------------------+
  */
 
diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_mmio_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_mmio_abi.h
index bbf1ddb77434..9baa3cb07d13 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_mmio_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_communication_mmio_abi.h
@@ -38,11 +38,11 @@
  *  +---+-------+--------------------------------------------------------------+
  *  |   | Bits  | Description                                                  |
  *  +===+=======+==============================================================+
- *  | 0 |  31:0 |  +--------------------------------------------------------+  |
- *  +---+-------+  |                                                        |  |
- *  |...|       |  |  Embedded `HXG Message`_                               |  |
- *  +---+-------+  |                                                        |  |
- *  | n |  31:0 |  +--------------------------------------------------------+  |
+ *  | 0 |  31:0 |                                                              |
+ *  +---+-------+                                                              |
+ *  |...|       | [Embedded `HXG Message`_]                                    |
+ *  +---+-------+                                                              |
+ *  | n |  31:0 |                                                              |
  *  +---+-------+--------------------------------------------------------------+
  */
 

base-commit: 242f4c77b1c8cebfdfa0ad5b40e2e4ae0316e57d
-- 
2.17.1

