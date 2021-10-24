Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025DF4387DF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJXJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:23:00 -0400
Received: from msg-1.mailo.com ([213.182.54.11]:60982 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhJXJW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635065950; bh=E2tcnfIOs4VQxTRgaEgAcHrVxoiBA+I6A+FeEJVzwcQ=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=AVtE24uPtzlIwFUp3B7qFlpQvPIIzTlrknFWENxEYHNN/JCcaKLIoM/nxxB1FlwLo
         saKevNPC4z32AIyIzNgAAakXDUhjSCq8lW9MDVRVH7fbaTvfKHsEPl1vYsCiUFhtjj
         LEhBe+9WcVnQFpXGFVkXcU8ZbdojDD1FJ5Yc6ODQ=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 24 Oct 2021 10:59:10 +0200 (CEST)
X-EA-Auth: 8dMeRQZuRzWHMWnIWSQMrkQQCwFfk1khZN6P/8qvFfeIh/IogdqMwni4BAHv1wHPLmvkWcH5Lhavg8uBp9xvKKBy30UmMVV6llDJjpQmqnQ=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1 0/4] Add tfa9897 speaker/receiver modes switching
Date:   Sun, 24 Oct 2021 10:58:36 +0200
Message-Id: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two tfa9897 are used in tandem on some devices (eg. alcatel-idol347)
to drive two speakers, for both receiver (earpiece) and speaker modes.

This series:
1. adds a control to allow enabling only one tfa9897/speaker
   (for the typical phone-call usecase)
2. adds a control to switch between speaker and receiver modes
3. adds support for an optional gpio also used to switch modes

Stephan Gerhold (1):
  ASoC: codecs: tfa989x: Add switch to allow disabling amplifier

Vincent Knecht (3):
  ASoC: codecs: tfa989x: Add support for tfa9897 RCV bit
  ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
  ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios

 .../bindings/sound/nxp,tfa989x.yaml           | 10 ++++
 sound/soc/codecs/tfa989x.c                    | 47 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.31.1



