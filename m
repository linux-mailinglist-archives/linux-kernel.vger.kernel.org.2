Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AFB332847
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCIOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhCIOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:15:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96472C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:15:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h98so15853863wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITjSKt2+hgLxV+pJeV70ZxWkeY46z8D/gW74nzxpexQ=;
        b=cIR0awXA4ZwNU6o+0+jVnRL7Babi+PksJnzMSiQ7MadA4GGA9063k/iup2S9q6G5uv
         wZ3uw7uVZjQv+dNVhtkz/shlR01AgsyXABjs+uNtJck975Uhehz0tpV5Vms01BN37L9r
         HbkZyKKoirlUdO4d/UUs542iUJ/oR5Ivxq4ca56n94Dn0WpLgZhsI9SjMOjDzl3Ef1AK
         oJxebeVWNWX3+PbhBXWNSZg0WTbsnxjccXA1I5yKTYs5rkVARjemLZiXiYhcXT4cn2/6
         7g5rrMgRlAd3mSsZVT6r5sKDwMPHVWOUQnPpgt7AdZu5e/09T22PNZNOtOz/5D3j4z7m
         uVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITjSKt2+hgLxV+pJeV70ZxWkeY46z8D/gW74nzxpexQ=;
        b=PbLQrc6XE1t99crho13y29+p78IC1OsII5WCne4vd4ury8mXFEVPeFVwngkdZf+IEa
         ebSRge0DD/VaJnMMm5SmelHNMgrf93FUdj4zrQ2wq2DzLAYEpHHmu2hyrHWiCjIGFlaj
         Or0D1l4jBABgagCBsGDXpw4dE5bqlCp1AJ3Qk9pYBoP1SX0qgk4J77cdE4i8VPY/L4U2
         gtd+peafW/VmOVk25IsEdJ5cuyJQkVjxYwq5yOtWWd7xUEsS/0swrfK9kHVq16EYCPym
         28/u7h3o6TVOG8NGmIcPNUVJEy4fZBrxVYaCLWz66flwRmMxyr3ma4UOOJCeQy1DD3wj
         fdeQ==
X-Gm-Message-State: AOAM531fwzIzJcWoacfwunorbCUuGHomh9GPq6vOolUDUEyzDTERFjaC
        ZTw6q6XmC9P/6IjxQYXUd4NHLQ==
X-Google-Smtp-Source: ABdhPJxDXMPd2fcO0YWat53zH3/GB5WmZ45cb3wtWE2C8qsiuF2eJgclfNU+g/If55JxBW+DEwPjcg==
X-Received: by 2002:a5d:4fcb:: with SMTP id h11mr29800438wrw.66.1615299332299;
        Tue, 09 Mar 2021 06:15:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u20sm28007579wru.6.2021.03.09.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 06:15:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] soundwire: add static port map support
Date:   Tue,  9 Mar 2021 14:15:09 +0000
Message-Id: <20210309141514.24744-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, SoundWire device ports are statically mapped to Controller
ports during design, however there is no way to expose this information
to the controller. Controllers like Qualcomm ones use this info to setup
static bandwith parameters for those ports.

A generic port allocation is not possible in this cases!
This patch adds a new member m_port_map to SoundWire device so that
it can populate the static master port map and share it with controller
to be able to setup correct bandwidth parameters.

As a user of this feature this patchset also adds new bindings for
wsa881x smart speaker which has 4 ports which are statically mapped
to the 3 output and 1 input port of the controller.

Tested it on DB845c and SM8250 MTP.

thanks,
srini

Srinivas Kandagatla (5):
  soundwire: add static port mapping support
  soundwire: qcom: update port map allocation bit mask
  soundwire: qcom: add static port map support
  ASoC: dt-bindings: wsa881x: add bindings for port mapping
  ASoC: codecs: wsa881x: add static port map support

 .../bindings/sound/qcom,wsa881x.yaml          |  9 ++++++
 drivers/soundwire/qcom.c                      | 30 +++++++++++++++----
 include/linux/soundwire/sdw.h                 |  2 ++
 sound/soc/codecs/wsa881x.c                    |  5 ++++
 4 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.21.0

