Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8043169B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhJRK5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhJRK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:57:04 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D59C061714
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:54:53 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e87a:7c37:aec5:5884])
        by andre.telenet-ops.be with bizsmtp
        id 7Nuq2600P22VXnz01Nuq2g; Mon, 18 Oct 2021 12:54:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mcQI5-005sWI-T1; Mon, 18 Oct 2021 12:54:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mcQI5-00DbGP-E1; Mon, 18 Oct 2021 12:54:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] dt-bindings: Improve yamllint performance
Date:   Mon, 18 Oct 2021 12:54:46 +0200
Message-Id: <cover.1634551582.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Rob,

This series improves yamllint performance by parallelizing the
operation, and by restricting the checked files to those specified using
DT_SCHEMA_FILES.

Changes compared to v1:
  - New patch to parallelize yamllint,
  - Introduce find_all_cmd,
  - Only use the restricted set for yamllint.

I've been using this for the past 6 months, as it helps a lot when
writing or updating DT bindings.  Combined, this reduces the execution
time of

    make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/your/binding/file.yaml

from ca. 30 to 10 s on i7-8700K.

Thanks for your comments!

Geert Uytterhoeven (2):
  dt-bindings: Parallelize yamllint
  dt-bindings: Consider DT_SCHEMA_FILES when finding all json-schema

 Documentation/devicetree/bindings/Makefile | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
