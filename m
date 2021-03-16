Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9E33E010
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhCPVKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhCPVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:09:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:09:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso142659pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ckCy2DNLTFsurQYOeBCucFOTgTIh9F4lDkIMXpfp3E=;
        b=EXULXbCbiguUB9WJ14EumXRl/eZVdBDFbhjQVofG2rcVniE4EQg33oVRIMix+ZusLa
         +8MB143a5/pM7LdnjT+8wtbrqBRVMqORX/Vf6AjSR/nW5F4k3NJWdIESIus0aExuPQbQ
         mrpxY6qS757zZMH0Z9V3B+PEEx4N0ZpUFMXgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ckCy2DNLTFsurQYOeBCucFOTgTIh9F4lDkIMXpfp3E=;
        b=dmIaNQWLFiusSBawj5DF5A3WoN/wvdpxcLPOXU/WnMmqjhbkQSulQlzwFV8xmhHWXb
         K2yOoEERTiWJH/hp8WL5h171ZVjSAgCgLOayyB0r4Tg9TD9mYiG4xpuKitnuFfEzYxHA
         NvETBa5LjOSGMsX8rw0vPqqxJfeMPSnOq+3eVnGTfiPFedilAZ6oWDO69yFFX8kUstSl
         vNBXXNVwez5JHIOiF1HiRg/Gw6+KEgqpSRGcOxgK3KlThK62jyMvw0B/fAP5d+dqjdqm
         lSay6lMVUgj7ul3DQOKbUg3a4YgOw+vN0gLpnLdhyQ7rgKc73BKGc+Dm/YUHXgLXNAmH
         XVeQ==
X-Gm-Message-State: AOAM532C82F1Qul6h5nDiu8oKsnECeiwxmirFJFov2LtVYSzSyPEHbxO
        qBJs9W0i5r6NBzM0Rx9maNNGLQ==
X-Google-Smtp-Source: ABdhPJw15Vdgd1+PLOyaEZb9iqRLOxaBungyupgVM9vCCQtdviVgnn9XFWzvSCOChSmWPYvbHpV5bw==
X-Received: by 2002:a17:90b:4c87:: with SMTP id my7mr937342pjb.162.1615928939826;
        Tue, 16 Mar 2021 14:08:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:84d6:7fd1:d469:351f])
        by smtp.gmail.com with ESMTPSA id 192sm17358072pfa.122.2021.03.16.14.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:08:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     robdclark@chromium.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        eballetbo@gmail.com, Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        drinkcat@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dt-bindings: display: simple: Add the panel on sc7180-trogdor-pompom
Date:   Tue, 16 Mar 2021 14:08:19 -0700
Message-Id: <20210316140707.RFC.1.I3a21995726282f1e9fcb70da5eb96f19ed96634f@changeid>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc7180-trogdor-pompom board might be attached to any number of a
pile of eDP panels. At the moment I'm told that the list might include:
- KD KD116N21-30NV-A010
- KD KD116N09-30NH-A016
- Starry 2081116HHD028001-51D
- Sharp LQ116M1JW10

It should be noted that while the EDID programmed in the first 3
panels indicates that they should run with exactly the same timing (to
keep things simple), the 4th panel not only needs different timing but
has a different resolution.

As is true in general with eDP panels, we can figure out which panel
we have and all the info needed to drive its pixel clock by reading
the EDID. However, we can do this only after we've powered the panel
on. Powering on the panels requires following the timing diagram in
each panel's datasheet which specifies delays between certain
actions. This means that, while we can be quite dynamic about handling
things we can't just totally skip out on describing the panel like we
could do if it was connected to an external-facing DP port.

While the different panels have slightly different delays, it's
possible to come up with a set of unified delays that will work on all
the panels. From reading the datasheets:
* KD KD116N21-30NV-A010 and KD KD116N09-30NH-A016
  - HPD absent delay: 200 ms
  - Unprepare delay: 150 ms (datasheet is confusing, might be 500 ms)
* Starry 2081116HHD028001-51D
  - HPD absent delay: 100 ms
  - Enable delay: (link training done till enable BL): 200 ms
  - Unprepare delay: 500 ms
* Sharp LQ116M1JW10
  - HPD absent delay: 200 ms
  - Unprepare delay: 500 ms
  - Prepare to enable delay (power on till backlight): 100 ms

Unified:
- HPD absent delay: 200 ms
- Unprepare delay: 500 ms
- Enable delay: 200 ms

NOTE: in theory the only thing that we _really_ need unity on is the
"HPD absent delay" since once the panel asserts HPD we can read the
EDID and could make per-panel decisions if we wanted.

Let's create a definition of "a panel that can be attached to pompom"
as a panel that provides a valid EDID and can work with the standard
pompom power sequencing. If more panels are later attached to pompom
then it's fine as long as they work in a compatible way.

One might ask why we can't just use a generic string here and provide
the timings directly in the device tree file. As I understand it,
trying to describe generic power sequencing in the device tree is
frowned upon and the one instance (SD/MMC) is regarded as a mistake
that shouldn't be repeated. Specifying a power sequence per board (or
per board class) feels like a reasonable compromise. We're not trying
to define fully generic power sequence bindings but we can also take
advantage of the semi-probable properties of the attached device.

NOTE: I believe that past instances of supporting this type of thing
have used the "white lie" approach. One representative panel was
listed in the device tree. The power sequencings of this
representative panel were OK to use across all panels that might be
attached and other differences were handled by EDID. This patch
attempts to set a new precedent and avoid the need for the white lie.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 62b0d54d87b7..9807dbc1cceb 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -140,6 +140,10 @@ properties:
       - giantplus,gpg48273qs5
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
+        # A panel connected to a google,pompom board. Panel is guaranteed to
+        # confirm to google,pompom-panel power sequencing requirements and then
+        # the specific panel will be probed via EDID.
+      - google,pompom-panel
         # HannStar Display Corp. HSD070PWW1 7.0" WXGA TFT LCD panel
       - hannstar,hsd070pww1
         # HannStar Display Corp. HSD100PXN1 10.1" XGA LVDS panel
-- 
2.31.0.rc2.261.g7f71774620-goog

