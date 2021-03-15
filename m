Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE57F33C2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhCOQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhCOQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:56:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD59C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso20705222wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSH4pySW1EvgNL2eE6g+1Sm6NzHPVilyMhDhmhbVIH0=;
        b=SVyyby+bHXxIuDsogvieAo0CsmMkNY9hM33D/7luLD96ikvJsPAqx8bKP3CrM6P69X
         yMGK07F988/svrnbPuNYnq1/LgVEi22erA7KJD/xZYF+wiPpiyXqUkGnWAMRlucTHH+l
         lL8eRLcp+N6UaeKp590f9rO1OCqWG23lL50H5FULys4fqRXQpI4FQ5muFTNlBlrEciL9
         tyZHPTVrBQtnkIe+6xxN3BP/H0E+KeMLGZ4xrqGd2H2MuajZVqc+6U9HS2kpPgFJSvmE
         BEPeQyqe1aq5f6OHrDU9bCA6TS26Jfa8pQWTz2XqJEUm3DbdvieAtr7TkiZejZL/8wVV
         Ui/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSH4pySW1EvgNL2eE6g+1Sm6NzHPVilyMhDhmhbVIH0=;
        b=pZuyNUj9+xl0Av05KpKpzTBd3PQPCfgBCvVA42xWDDt63BQ0hAJPyY3QbAM3p1w8A8
         Svw/4t+EHJsh6+0xxTKQTlvzEInyeO71DFh1zOXpoSCA/AMzcCGMBfCnxQ3XcI6SenSt
         Y1xmP2T4Xs0Wp8X9Er4jQSRUqtFipVj4UfNYBOrJMMzlON4aK0J6rJQy27wX8dQiiqLi
         ekog94nfdo82oTsjQ84044OTpdLzjK3kUtIP8bmbSiK/j/HdYmnNAyqWRf/E593lKj6g
         a0Mu6kH3ONvImYUIqzCOaV8+nv+FwXMsd+cKmbIrsmyWtKvkINcueRTGwqTuKu7a2fGT
         Tysw==
X-Gm-Message-State: AOAM532AoONDcO6ZOH9VOleLS4NQY26ZZeY2mtjiVShTW2JBHB37SCjM
        KGIx0/oV/yW7/E3dOnpzYI9ZLqVYTLB5XA==
X-Google-Smtp-Source: ABdhPJzbkeheDpbuU0MOGJO7aRF1AZGUsw2EODbvMTKa5b8Mn9wpcFrA3ltQBzRmOZvwburCgfR0fQ==
X-Received: by 2002:a05:600c:1553:: with SMTP id f19mr587720wmg.33.1615827413909;
        Mon, 15 Mar 2021 09:56:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id o2sm227656wmc.23.2021.03.15.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/5] soundwire: add static port map support
Date:   Mon, 15 Mar 2021 16:56:45 +0000
Message-Id: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, SoundWire device ports are statically mapped to Controller
ports during design, however there is no way to expose this information
to the controller. Controllers like Qualcomm ones use this info to setup
static bandwidth parameters for those ports.

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

Changes since v3:
	- updated kernel doc for more clarity on m_port_map

Srinivas Kandagatla (5):
  soundwire: add static port mapping support
  soundwire: qcom: update port map allocation bit mask
  soundwire: qcom: add static port map support
  ASoC: dt-bindings: wsa881x: add bindings for port mapping
  ASoC: codecs: wsa881x: add static port map support

 .../bindings/sound/qcom,wsa881x.yaml          |  9 ++++++
 drivers/soundwire/qcom.c                      | 31 +++++++++++++++----
 include/linux/soundwire/sdw.h                 |  2 ++
 sound/soc/codecs/wsa881x.c                    |  7 +++++
 4 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.21.0

