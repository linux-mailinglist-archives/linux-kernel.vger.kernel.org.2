Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C645E3198D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBLDcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLDcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:32:04 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375EC061574;
        Thu, 11 Feb 2021 19:31:22 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id f3so4891749oiw.13;
        Thu, 11 Feb 2021 19:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+fcy8eJ5qsF+LGswZ9B+o4Smfgq4c8zrBnmFiUW1EDY=;
        b=io6VbF/7WjelBbLaVq2f2cYS3kaT1LEogyqcSdLj8nJWcVlaJWJf3SHIdwlyPRKnnC
         7MBlntE+r+xRtbxH1MST7JWcnjSOq14eyDuf8SSlpstoNmS2q+nAcI9DD3tuXb9qgBbN
         KLCKonALGHk0aEG3IIMnPKeyfb+w+80oEgDlqzxGxitehrY31WjDpv8dH/lgpUhYyoTt
         ll4Sn7RvsxdP8ZTrNa6RY/ZVKivEdEZd7x3Rq87Up77wnL1Zv3CutmIYzLP5+B+iFJEe
         Wet+Yoscm8vO6VQNFT3ADl3KlgouFxlx2rmk9WxDh+G1WGt76D9MINoRjEyqYcblgNQG
         SIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=+fcy8eJ5qsF+LGswZ9B+o4Smfgq4c8zrBnmFiUW1EDY=;
        b=QcIlfDNOSmnHxkXo/GukWMy1uPBO4GtOisWBZwRMND9C7GIVfmz+8POaglLbqJS/pB
         wTtasF0Nd5njxqQ43c0EhXBUdwqOlvMF8M6APniFNUqlavsIXJVZTsi4EjUZFYXI1tN7
         QWmwGuvZLWHaxk5K6g6NbMP5ZtFLekee1keSYn4paC/j7INrBGx+YEEHx0V5rOkZ96hq
         4sTJx2rOtOBCKPaL6M/g25z6/vuxRCWrdIefNLMDWTTZfoO8vajnSrw2Cqh+fnSSbQMQ
         9Ezn/v/Dn80pf1lXJ77DCGdghPqECElZmZN0jLSARXIyBqDlAqhQ6Kobun78jDXMyOzU
         CvhA==
X-Gm-Message-State: AOAM533rhzCzaljsauJ02I/nr8BmEbc2rKuhGx7XinQ6g2nLi9Je3A2w
        GNBU72F643RgVdLfoZqK21I=
X-Google-Smtp-Source: ABdhPJxN0XcS3eVvS4uA1P2BHXY/lkdfO6aVXJk9tay2VEhnZ7aTxFX2q6Brhzsb7sQ7j73bV4wPpA==
X-Received: by 2002:aca:3746:: with SMTP id e67mr586812oia.81.1613100682177;
        Thu, 11 Feb 2021 19:31:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e14sm1335114oou.19.2021.02.11.19.31.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 19:31:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 19:31:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.0-51-g183df9e9c2b9
Message-ID: <20210212033120.GA100407@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Feb 03, 2021 at 03:26:03PM -0600, Rob Herring wrote:
> This adds the following commits from upstream:
> 
> 183df9e9c2b9 gitignore: Ignore the swp files
> 0db6d09584e1 gitignore: Add cscope files
> 307afa1a7be8 Update Jon Loeliger's email
> ca16a723fa9d fdtdump: Fix gcc11 warning
> 64990a272e8f srcpos: increase MAX_SRCFILE_DEPTH
> 163f0469bf2e dtc: Allow overlays to have .dtbo extension
> 3b01518e688d Set last_comp_version correctly in new dtb and fix potential version issues in fdt_open_into
> f7e5737f26aa tests: Fix overlay_overlay_nosugar test case
> 7cd5d5fe43d5 libfdt: Tweak description of assume-aligned load helpers
> a7c404099349 libfdt: Internally perform potentially unaligned loads
> bab85e48a6f4 meson: increase default timeout for tests
> f8b46098824d meson: do not assume python is installed, skip tests
> 30a56bce4f0b meson: fix -Wall warning
> 5e735860c478 libfdt: Check for 8-byte address alignment in fdt_ro_probe_()
> 67849a327927 build-sys: add meson build
> 05874d08212d pylibfdt: allow build out of tree
> 3bc3a6b9fe0c dtc: Fix signedness comparisons warnings: Wrap (-1)
> e1147b159e92 dtc: Fix signedness comparisons warnings: change types
> 04cf1fdc0fcf convert-dtsv0: Fix signedness comparisons warning
> b30013edb878 libfdt: Fix kernel-doc comments
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

This patch causes my little-endian microblaze qemu emulations to fail
silently (no console output) in next-20210211. Reverting this patch
together with "scripts: dtc: Build fdtoverlay tool" fixes the problem.

Big endian microblaze emulations are not affected. I can't say if other
emulations are affected because I see too many boot failures in -next
to be able to track down all individual problems.

Guenter

---
Bisect log:

# bad: [671176b0016c80b3943cb5387312c886aba3308d] Add linux-next specific files for 20210211
# good: [92bf22614b21a2706f4993b278017e437f7785b3] Linux 5.11-rc7
git bisect start 'HEAD' 'v5.11-rc7'
# good: [d69fe59127a072f06e51bf101b82413056859ddc] Merge remote-tracking branch 'crypto/master'
git bisect good d69fe59127a072f06e51bf101b82413056859ddc
# bad: [9cbf23a8700e40ce348e5dc83c95add50c8689d3] Merge remote-tracking branch 'spi/for-next'
git bisect bad 9cbf23a8700e40ce348e5dc83c95add50c8689d3
# good: [635a8e981a1f34802668307e0b7bb8834d850a66] Merge remote-tracking branch 'drm-misc/for-linux-next'
git bisect good 635a8e981a1f34802668307e0b7bb8834d850a66
# good: [dbb24458a99eed64fdcc88630e8ac38376720f96] Merge remote-tracking branch 'block/for-next'
git bisect good dbb24458a99eed64fdcc88630e8ac38376720f96
# good: [f82648f1c7dd4709ff34cae8a98978fbf8e47d33] Merge remote-tracking branch 'integrity/next-integrity'
git bisect good f82648f1c7dd4709ff34cae8a98978fbf8e47d33
# good: [b18e8865643e421fc3537d7eb446f1eb9edfdf1b] Merge remote-tracking branch 'iommu/next'
git bisect good b18e8865643e421fc3537d7eb446f1eb9edfdf1b
# good: [6589daf8bb98c75ad1065edad87c099ffb9f5d87] dt-bindings: spi: sunxi: Add H616 compatible string
git bisect good 6589daf8bb98c75ad1065edad87c099ffb9f5d87
# bad: [322322d15b9b912bc8710c367a95a7de62220a72] dt-bindings: ethernet-controller: fix fixed-link specification
git bisect bad 322322d15b9b912bc8710c367a95a7de62220a72
# good: [6e09d75513d2670b7ab91ab3584fc5bcf2675a75] hwmon: (lm70) Use device_get_match_data()
git bisect good 6e09d75513d2670b7ab91ab3584fc5bcf2675a75
# good: [9183908e70e913d2db052588172968da55d82af5] dt-bindings: Fix errors in 'if' schemas
git bisect good 9183908e70e913d2db052588172968da55d82af5
# bad: [59b48a715107d5719b75250059864fa775837425] scripts: dtc: Remove the unused fdtdump.c file
git bisect bad 59b48a715107d5719b75250059864fa775837425
# bad: [79edff12060fe7772af08607eff50c0e2486c5ba] scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
git bisect bad 79edff12060fe7772af08607eff50c0e2486c5ba
# good: [b775f49fbc8b07b0c3a4079e6f09f192eaf6e92f] scripts: dtc: Fetch fdtoverlay.c from external DTC project
git bisect good b775f49fbc8b07b0c3a4079e6f09f192eaf6e92f
# first bad commit: [79edff12060fe7772af08607eff50c0e2486c5ba] scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
