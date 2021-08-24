Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AB3F6BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhHXWz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhHXWz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:55:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2BF861139;
        Tue, 24 Aug 2021 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629845681;
        bh=VRPyW1VeO7gfAN1WVH2HUQN9HNXvpNgT4uXN0dtpgSg=;
        h=From:To:Cc:Subject:Date:From;
        b=flB5TcWMNT76AKxh3XR22CrIVe8y0lorcQ+fmCHwlvsCWMEVcQfSoaPUhs+8NCd3s
         w3n5+bOLR393xOnucjv1GYNkNNyLzyt0Tvn3ywytxpMLxGssKqF51mFz+pQwl6khSn
         J/2ZWz5pS1Ny9jpFU/IS94ve1YYaJ3MW2ggL++ktqzgAl6F2s7Xkk1DFDm3ssrOcZ7
         GAYAHHwG3Spard0hg/zFb3yOZuIJ3fhxZDHdulADHM7JXE5PsDXhxws+PTgpIFBQwz
         pokFrA+TYRhrdFRHJWih4350aovGhGvJB65V3RUJIoSUzco2ZsoqslXX93lpvE3VKX
         igBtg/5u03RCA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jason Ekstrand <jason@jlekstrand.net>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] drm/i915: Enable -Wsometimes-uninitialized
Date:   Tue, 24 Aug 2021 15:54:24 -0700
Message-Id: <20210824225427.2065517-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 46e2068081e9 ("drm/i915: Disable some extra clang warnings")
disabled -Wsometimes-uninitialized as noisy but there have been a few
fixes to clang that make the false positive rate fairly low so it should
be enabled to help catch obvious mistakes. The first two patches fix
revent instances of this warning then enables it for i915 like the rest
of the tree.

Cheers,
Nathan

Nathan Chancellor (3):
  drm/i915/selftests: Do not use import_obj uninitialized
  drm/i915/selftests: Always initialize err in
    igt_dmabuf_import_same_driver_lmem()
  drm/i915: Enable -Wsometimes-uninitialized

 drivers/gpu/drm/i915/Makefile                        | 1 -
 drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: fb43ebc83e069625cfeeb2490efc3ffa0013bfa4
-- 
2.33.0

