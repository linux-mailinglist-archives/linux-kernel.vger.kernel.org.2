Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E8E3EA264
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhHLJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhHLJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:48:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8800C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:47:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nt11so8519718pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQt6omXqa2oMiTW4NtJHxtEf8KiSaWrelVyAUYsK0bE=;
        b=DCQ6/e3ESBmlVdY/Y4C4tfY7g3iWQ3QuvgjMWMSgr+m0vjeWvcbdfYkd04aEslLLlo
         sk548mxLczLt+EBDC75wn5YABFuHH5k6E863TYDAEz0CrJ+18xgpxCUnGS8faAGTIy1h
         oetMlmrBwYPw/5V/DFnPtlXyHOTtdWDuaX5MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQt6omXqa2oMiTW4NtJHxtEf8KiSaWrelVyAUYsK0bE=;
        b=MhR1LBrQq3K7z3hIkyGJIMUpgjCXxxix1aLZ+5GthELeYCqv7l/ddb1aqgPJbcN6uS
         QFMz47eIKyIqzXaDfuvJBlKUeyH1UaJfFpllaoEr3AlE3CecmJm4/MlwxGvecuzMTow/
         oFl2EO/gJ8ldd6+dEnoQn3tttZX/UipIVbNc40VFnlWHdXm8SWgVdlOkb3NxamQFyth2
         Xd6Ths1HFV5QK3E8rXG5Qo83QONIpOpqDDZP6elwzzy8M46W5YHxh8wJetLb0Jvy+BOu
         i2661aTD5FSNycP5ZQuePqKvFmk/xnk4cdR5g+BcVTVzqRtRiGdycam+TT5Q6DQodH/b
         OyrQ==
X-Gm-Message-State: AOAM533wkJZJAwOVpVlIlP1lhiQaHKLX3KxgGdFeqQjniRX/MsHkDfYM
        JQrRuc7kyiUA9zEz49PUxvcn3Q==
X-Google-Smtp-Source: ABdhPJwLjPIA/C80CXiFfNeei/Oz9PgE+tkr6Gb7fPvYHFHZY7lYKXLplkn4Z8Kpjr8xni3u0v9zgQ==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr3583040pjh.13.1628761678473;
        Thu, 12 Aug 2021 02:47:58 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8e0d:8032:9364:612c])
        by smtp.gmail.com with ESMTPSA id z15sm2991052pgc.13.2021.08.12.02.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:47:58 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: rockchip: Add Scarlet Dumo Variant
Date:   Thu, 12 Aug 2021 17:47:51 +0800
Message-Id: <20210812094753.2359087-1-wenst@chromium.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A variant of the Chrome OS Gru-Scarlet device is missing in upstream.
This variant, dumo, is the same as the Innolux display panel variant,
but requires a specific calibration variant for its WiFi module.

I'm not sure if it's better to inherit from gru-scarlet-innolux. I kept
them separate from now, like in downstream ChromeOS kernel v4.4.

The series is based on linux-next-20210812. Please have a look.


Regards
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: arm: rockchip: Add gru-scarlet-dumo board
  arm64: dts: rockchip: rk3399: Add gru-scarlet-dumo board

 .../devicetree/bindings/arm/rockchip.yaml     | 28 +++++++++++++
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3399-gru-scarlet-dumo.dts  | 41 +++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts

-- 
2.32.0.605.g8dce9f2422-goog

