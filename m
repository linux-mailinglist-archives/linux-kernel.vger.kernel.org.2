Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92F32EF04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCEPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:36:49 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:38590 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhCEPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:36:20 -0500
Received: by mail-oo1-f41.google.com with SMTP id z12so76427ooh.5;
        Fri, 05 Mar 2021 07:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g0o6eQ87KIdf1+D3jUpOGRpp3kvL6eKc0GpPfwwZS8U=;
        b=XyXBzRQGzK4K1bV3R7+RhgUyj2kl8vTTdU/6GYOyarmJchC+WwLUpqaa6LmRqwxRNl
         iUqe/zpBgFhMAUhvUDh3dVdAyQKdN14QSpI6dSYEbZ2VGhslnGkvXNOw7q0jXthdqG9G
         Ipy64wWPSdsG3ugKVtDFt6zUL6odmpqOGB7j44SMywBXVVyUhQKWffr7YgPiktlsap6R
         0JWuF6YdZL/abcjcu4v2B/az6thKSUEjJrGNoPo1imAmD9urv7XFOKu79JNt+DYJllAB
         YH/+8kKx4jqqHyVnH+10aJWLHdV0RVBmd1j7ngAzlGJVC1jUZoQAUqZuPgMOlaozZ33f
         bcJQ==
X-Gm-Message-State: AOAM530IQjjfS9gMithjAfEpPF82gBv6NJhOKeSJlNNf91FenJc/FZm3
        ZFWZt2wBLca4BSFSxg6Rug==
X-Google-Smtp-Source: ABdhPJxTSYMGULmDAauZLCztHx9WYn8h7yEZJQLHRXX5u52cCx+YWs5IDU8IT/awxKlz6IlmpyAPkg==
X-Received: by 2002:a4a:88ee:: with SMTP id q43mr8290467ooh.61.1614958579778;
        Fri, 05 Mar 2021 07:36:19 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u110sm655002otb.32.2021.03.05.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:36:18 -0800 (PST)
Received: (nullmailer pid 200830 invoked by uid 1000);
        Fri, 05 Mar 2021 15:36:17 -0000
Date:   Fri, 5 Mar 2021 09:36:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.12
Message-ID: <20210305153617.GA198234@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes.

Rob


The following changes since commit 3b9cdafb5358eb9f3790de2f728f765fef100731:

  Merge tag 'pinctrl-v5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2021-02-22 18:39:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.12-1

for you to fetch changes up to b5a95bb1883e2bac1009cc88e65c71cff6f931e6:

  dt-bindings: media: Use graph and video-interfaces schemas, round 2 (2021-03-01 11:30:21 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.12-rc:

- Another batch of graph and video-interfaces schema conversions

- Drop DT header symlink for dropped C6X arch

- Fix bcm2711-hdmi schema error

----------------------------------------------------------------
Maxime Ripard (1):
      dt-bindings: bcm2711-hdmi: Fix broken schema

Michal Kubecek (1):
      dts: drop dangling c6x symlink

Rob Herring (1):
      dt-bindings: media: Use graph and video-interfaces schemas, round 2

 .../devicetree/bindings/display/brcm,bcm2711-hdmi.yaml   |  2 +-
 Documentation/devicetree/bindings/media/i2c/imx258.yaml  | 14 +++++++-------
 .../devicetree/bindings/media/i2c/ovti,ov5647.yaml       |  5 ++---
 .../devicetree/bindings/media/i2c/ovti,ov5648.yaml       | 16 +++++-----------
 .../devicetree/bindings/media/i2c/ovti,ov8865.yaml       | 16 +++++-----------
 .../devicetree/bindings/media/i2c/sony,imx334.yaml       | 11 +++++------
 scripts/dtc/include-prefixes/c6x                         |  1 -
 7 files changed, 25 insertions(+), 40 deletions(-)
 delete mode 120000 scripts/dtc/include-prefixes/c6x
