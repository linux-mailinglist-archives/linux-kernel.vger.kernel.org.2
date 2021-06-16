Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC743A9282
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFPGaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhFPG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED317613E9;
        Wed, 16 Jun 2021 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=RluDluVvgOJfMawxkXAd8MJmBCh51i/nH0Xg7JEnU2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzCd3O51Aa0LTyprfhtV1oY+MThmVmQRTvvhlUbcOw5JqMQ29Ez8RWXGV4P/hmOt1
         1l+2neyHuC2niSppanddqI6KPQeZhIiAyA5HDKUgFzSRWGpKCQExOGTkBYhCLTFmFY
         ahGCzFWIwy4Lfh8RlyJ/XjBUlZHgtAzIRJmABpicXgbyvQV5CgrCK2igr2Fu47jMDy
         Hz217X2YaDLLX1miXBBbHOK7MqK7H5yNympfqc+Pbe91LVgub1M98y122HCQr2xTad
         sE36oeNCTbJ+5xNtlKR5jcrGoAffO08oXTNH8xwvGgOg/bHgpzDCsDNEYWLEOF4kQV
         kUWW2+cyVluEg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kIo-84; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/29] docs: core-api: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:23 +0200
Message-Id: <d967d490b6655735b7df292f88859b5a1b07d0d7.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/core-api/bus-virt-phys-mapping.rst | 2 +-
 Documentation/core-api/dma-api.rst               | 5 +++--
 Documentation/core-api/dma-isa-lpc.rst           | 2 +-
 Documentation/core-api/index.rst                 | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/bus-virt-phys-mapping.rst b/Documentation/core-api/bus-virt-phys-mapping.rst
index c7bc99cd2e21..c72b24a7d52c 100644
--- a/Documentation/core-api/bus-virt-phys-mapping.rst
+++ b/Documentation/core-api/bus-virt-phys-mapping.rst
@@ -8,7 +8,7 @@ How to access I/O mapped memory from within device drivers
 
 	The virt_to_bus() and bus_to_virt() functions have been
 	superseded by the functionality provided by the PCI DMA interface
-	(see :doc:`/core-api/dma-api-howto`).  They continue
+	(see Documentation/core-api/dma-api-howto.rst).  They continue
 	to be documented below for historical purposes, but new code
 	must not use them. --davidm 00/12/12
 
diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 00a1d4fa3f9e..6d6d0edd2d27 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -5,7 +5,7 @@ Dynamic DMA mapping using the generic device
 :Author: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
 
 This document describes the DMA API.  For a more gentle introduction
-of the API (and actual examples), see :doc:`/core-api/dma-api-howto`.
+of the API (and actual examples), see Documentation/core-api/dma-api-howto.rst.
 
 This API is split into two pieces.  Part I describes the basic API.
 Part II describes extensions for supporting non-consistent memory
@@ -479,7 +479,8 @@ without the _attrs suffixes, except that they pass an optional
 dma_attrs.
 
 The interpretation of DMA attributes is architecture-specific, and
-each attribute should be documented in :doc:`/core-api/dma-attributes`.
+each attribute should be documented in
+Documentation/core-api/dma-attributes.rst.
 
 If dma_attrs are 0, the semantics of each of these functions
 is identical to those of the corresponding function
diff --git a/Documentation/core-api/dma-isa-lpc.rst b/Documentation/core-api/dma-isa-lpc.rst
index e59a3d35a93d..17b193603f0a 100644
--- a/Documentation/core-api/dma-isa-lpc.rst
+++ b/Documentation/core-api/dma-isa-lpc.rst
@@ -17,7 +17,7 @@ To do ISA style DMA you need to include two headers::
 	#include <asm/dma.h>
 
 The first is the generic DMA API used to convert virtual addresses to
-bus addresses (see :doc:`/core-api/dma-api` for details).
+bus addresses (see Documentation/core-api/dma-api.rst for details).
 
 The second contains the routines specific to ISA DMA transfers. Since
 this is not present on all platforms make sure you construct your
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index f1c9d20bd42d..5de2c7a4b1b3 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -48,7 +48,7 @@ Concurrency primitives
 ======================
 
 How Linux keeps everything from happening at the same time.  See
-:doc:`/locking/index` for more related documentation.
+Documentation/locking/index.rst for more related documentation.
 
 .. toctree::
    :maxdepth: 1
@@ -77,7 +77,7 @@ Memory management
 =================
 
 How to allocate and use memory in the kernel.  Note that there is a lot
-more memory-management documentation in :doc:`/vm/index`.
+more memory-management documentation in Documentation/vm/index.rst.
 
 .. toctree::
    :maxdepth: 1
-- 
2.31.1

