Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3438CA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbhEUPkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:40:16 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42496 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhEUPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:40:15 -0400
Received: by mail-ot1-f42.google.com with SMTP id g7-20020a9d12870000b0290328b1342b73so10545434otg.9;
        Fri, 21 May 2021 08:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xDPtP33KT3xH91bry0p3EhN/oKeZgLH/JnhByp/Sv7o=;
        b=V4+m/Tz6J15WYRJzZ/JtjPBP6qQHuG34svANYngnPP7/gv0vZ2GRSFjaKuWA4rESbQ
         fi60cXhjQ+6gsyyyx8wFtUwnBeu1cqLQ1EGzGUinchrvu1QyhuhZK8ZXkQYBo1nTgVTO
         2oAdsNL4ckOD/Onxi2q+RPZTFwMvdfzTc4X0pU/u5qcD7h2Up8jgCLJHKiLrz5QBILmr
         qjfw+HimqSCBgr6pi8gGKBpTcgWMYht0zKm6cz5BXmd8HYoZHk5ENfJCbn5Ui8E48FGy
         DBSmHXrKE0BESbYbedRziosx7kRl84+rN3J+BEwrST0eEQL7RJCeTF00tMIzOq5VnlBT
         JA1w==
X-Gm-Message-State: AOAM531IHeYIxMt28B4pxSHcotIfUIURPG2UxGeUIVavMdEr63KsWc1L
        qJ2BgrlrYdlNz1v+SNS6kw==
X-Google-Smtp-Source: ABdhPJxduyEgUWInbH2BMQ3j2yzOzwGqwf1gZ6h8WTQ5R0Db1P7PQUBIeXk0KU91PDRafkn1gOHHsA==
X-Received: by 2002:a9d:600d:: with SMTP id h13mr8768854otj.259.1621611530886;
        Fri, 21 May 2021 08:38:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f21sm1251047oou.24.2021.05.21.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:38:49 -0700 (PDT)
Received: (nullmailer pid 4042837 invoked by uid 1000);
        Fri, 21 May 2021 15:38:48 -0000
Date:   Fri, 21 May 2021 10:38:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.13, take 2
Message-ID: <20210521153848.GA4041054@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few more DT fixes.

Rob

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.13-2

for you to fetch changes up to c17611592d9635c443bedc9be901f4463f45c6d5:

  dt-bindings: More removals of type references on common properties (2021-05-17 16:20:08 -0500)

----------------------------------------------------------------
Devicetree fixes for 5.13, take 2:

- Another batch of removing unneeded type references in schemas

- Fix some out of date filename references

- Convert renesas,drif schema to use DT graph schema

----------------------------------------------------------------
Rob Herring (2):
      dt-bindings: media: renesas,drif: Use graph schema
      dt-bindings: More removals of type references on common properties

Wan Jiabing (2):
      dt-bindings: phy: cadence-torrent: update reference file of docs
      leds: Fix reference file name of documentation

 .../devicetree/bindings/clock/idt,versaclock5.yaml   |  2 --
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml         |  1 -
 Documentation/devicetree/bindings/input/input.yaml   |  1 -
 .../devicetree/bindings/interconnect/qcom,rpmh.yaml  |  1 -
 .../devicetree/bindings/leds/leds-bcm6328.txt        |  4 ++--
 .../devicetree/bindings/leds/leds-bcm6358.txt        |  2 +-
 .../devicetree/bindings/media/renesas,drif.yaml      | 20 +++++++-------------
 Documentation/devicetree/bindings/net/qcom,ipa.yaml  |  1 -
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml |  2 +-
 .../bindings/power/supply/sc2731-charger.yaml        |  2 +-
 .../devicetree/bindings/sound/fsl,rpmsg.yaml         |  2 +-
 11 files changed, 13 insertions(+), 25 deletions(-)
