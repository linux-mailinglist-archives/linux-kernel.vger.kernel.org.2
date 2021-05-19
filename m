Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB61338919B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbhESOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbhESOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:43:33 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:42:13 -0700 (PDT)
Received: by sf.home (Postfix, from userid 1000)
        id DA22D5A22061; Wed, 19 May 2021 15:42:06 +0100 (BST)
Date:   Wed, 19 May 2021 15:42:06 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [bisected] 5.13-rc2 i915 regression in b12d691ea5e01d "i915: fix
 remap_io_sg to verify the pgprot"
Message-ID: <YKUjvoaKKggAmpIR@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph and i915 maintainers!

vanilla 5.13-rc2 got some rendering regression on gen2(?) i915 chips:

  In gtk apps cursor gets corrupted for a short period of time.

  In firefox text selection and text scrolling shows artifacts for a short
  time (seconds). As if tiny horisontal tiles (1 pixel high, ~20-50 pixels
  long) fail to refresh in time.

  I was not able get a screenshot with artifacts: pictures are always clean.
  I can grab a photo or tiny video if needed.

Bisection was straightforward and landed on:

b12d691ea5e01db42ccf3b4207e57cb3ce7cfe91 is the first bad commit
commit b12d691ea5e01db42ccf3b4207e57cb3ce7cfe91
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Apr 29 22:57:38 2021 -0700

    i915: fix remap_io_sg to verify the pgprot

    remap_io_sg claims that the pgprot is pre-verified using an io_mapping,
    but actually does not get passed an io_mapping and just uses the pgprot in
    the VMA.  Remove the apply_to_page_range abuse and just loop over
    remap_pfn_range for each segment.

    Note: this could use io_mapping_map_user by passing an iomap to
    remap_io_sg if the maintainers can verify that the pgprot in the iomap in
    the only caller is indeed the desired one here.

    Link: https://lkml.kernel.org/r/20210326055505.1424432-5-hch@lst.de
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Cc: Chris Wilson <chris@chris-wilson.co.uk>
    Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
    Cc: Jani Nikula <jani.nikula@linux.intel.com>
    Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

 drivers/gpu/drm/i915/i915_mm.c | 73 +++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 50 deletions(-)

System:
    $ Linux sf 5.12.0-11146-g8ca5297e7e38 #302 SMP PREEMPT Thu Apr 29 23:30:52 BST 2021 x86_64 Intel(R) Core(TM) i7-2700K CPU @ 3.50GHz GenuineIntel GNU/Linux
    $ lspci -v
    00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA controller])
        Subsystem: Gigabyte Technology Co., Ltd 2nd Generation Core Processor Family Integrated Graphics Controller
        Flags: bus master, fast devsel, latency 0, IRQ 27
        Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
        Memory at e0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at f000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [d0] Power Management version 2
        Capabilities: [a4] PCI Advanced Features
        Kernel driver in use: i915

Software:
    mesa-20.3.5 : i965 driver
      glamor X acceleration enabled on Mesa DRI Intel(R) HD Graphics 3000 (SNB GT2)
    xorg-server-1.20.11

Thanks!

-- 

  Sergei
