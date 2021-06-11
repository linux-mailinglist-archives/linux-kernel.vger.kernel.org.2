Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114A43A47D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhFKRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:25:35 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:35550 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFKRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:25:34 -0400
Received: by mail-il1-f174.google.com with SMTP id b9so5883313ilr.2;
        Fri, 11 Jun 2021 10:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qEYgvms6GcvO0l0piA/elDD6OPG4/YU42eSsTHmuAvE=;
        b=Ws2ctmXmdOTP6oOx5haljTBvh0pbKK0tQC8b5QVs5zo4YDvjHXl4lds/YkHpWvdtw1
         H825oO3y/O8FQqxTDTfyd03BVgjEMNKNNZvXhNxQgVnDjytAUimFtV3R7CbyC9khadFs
         HtIr2q68iiaNl0UsqDv0HFE1UbKJ503KOjTL8x01ZaYteM5Xz8Qt2dzMU+SdpHeHWSSV
         TgvFFdqX21uwutTYDJtDq/c5JeQBHMxJZINVQDKU6qBQyoTzPS5v/BEMCKhzA6TmfY0B
         2KvEJ8oZgTePCLuYbXKGUefCvAuO1RrWc5ikdiLVsu2EjvVxBZTqt67ilUjCgpM5ncca
         72vQ==
X-Gm-Message-State: AOAM533XpE6E+DsSnO8s+8pdyd7eQOASeKsAcNjMTK8ti20ECi5ZHs1p
        PMl+Z30jmXwxkoMMaXEVGQ==
X-Google-Smtp-Source: ABdhPJxl1k1XtlKdfqXpDDOGOnQ85pGzP4uSbRVmCoa4gltDFTku32Mi//jaBKEjtDP9XtaitWwFzw==
X-Received: by 2002:a92:9411:: with SMTP id c17mr4258049ili.264.1623432202165;
        Fri, 11 Jun 2021 10:23:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k10sm3471364ion.38.2021.06.11.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:23:21 -0700 (PDT)
Received: (nullmailer pid 1158294 invoked by uid 1000);
        Fri, 11 Jun 2021 17:23:20 -0000
Date:   Fri, 11 Jun 2021 11:23:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fix for 5.13, take 3
Message-ID: <20210611172320.GA1154861@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull this single fix for DT.

Rob

The following changes since commit c17611592d9635c443bedc9be901f4463f45c6d5:

  dt-bindings: More removals of type references on common properties (2021-05-17 16:20:08 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-3

for you to fetch changes up to 8929ef8d4dfd53a05913e22561784ece5f6419c7:

  media: dt-bindings: media: renesas,drif: Fix fck definition (2021-06-08 20:03:57 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.13, take 3:

- A single fix for broken media/renesas,drif.yaml binding schema

----------------------------------------------------------------
Fabrizio Castro (1):
      media: dt-bindings: media: renesas,drif: Fix fck definition

 Documentation/devicetree/bindings/media/renesas,drif.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
