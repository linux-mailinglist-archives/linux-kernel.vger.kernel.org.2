Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEB3A3E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhFKIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:37:03 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44719 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFKIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:36:51 -0400
Received: by mail-wr1-f44.google.com with SMTP id f2so5093589wri.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6233O0GArx42MHHhi909Htn7GrRXyApuMRfZbUdfJho=;
        b=fykdr5jTH5oeAecoh2N42ksse6Fo45qfvZJQ0iaIoffrC6GOy3qmD0bh9hvt9gNTgt
         YntabDXqpYcQgOTgXy1e0xii7eTFTLmxz6Vo9PUm/f6LFULyeAVVMvGEUVW3TAF6OB9f
         Y2mAgDtcRA9/0RzNqXDmLIykem/jJqXO//63GFKpyWnBORLDjiLkQOKTrSpqh4iJm2FM
         8npJsxODEBJojTiBOIMhF92V9vAfy6wmANxkhC5VbAkLHeYTtWwRuSYauHmaWLPUMrUJ
         cHAWKf5gibbV95qOXsKINGkKPOwwKJgT8deictfBEyNuruYo3H4pkOjNHImMSCNBmiiX
         VhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6233O0GArx42MHHhi909Htn7GrRXyApuMRfZbUdfJho=;
        b=gm6DQIAf+Sl/sW15TdSlADlSgvt5Znut6aF2bbD5ENLWlAEza2o3bgvN/zJSma9+uz
         UiVCXkSTTJ+ScfGWBoyt/ysw7XhsZN3c9i3y4KNFE4891jOOGjsthlApdHViEAPVNmN3
         p4gvkwlKH3earrrVCy0W1lq4AO3foQb97BqQmBGQ+qg5v4jLmKlgzxvITiUBtZm88eGs
         vR/UaXlkEVj3hpKSURho5aArs+ciAdgvPB8y+rrJt3uToMPxxPbBvG9Chu29p8WnnezQ
         ARdTZEoQWQuYYmuwJFgIg5mmZWlxPgtTuhYC/952LuPRd4neymhd/EWxP6YxH8XCo1N9
         Ow1A==
X-Gm-Message-State: AOAM531yNvYk+cliKdImHdWepS6iSZzUcunogWeFm5yZbQv3xGVr97LQ
        AmMRBpqsA40MiT1m4Xvg8bx6epajZR5GFg==
X-Google-Smtp-Source: ABdhPJw05PyDrJITS5nra4FXk4ddichSo/RL1g9nh5Q0EYZ/1TT04FzsYMRfZrsdQpYHI/blDY1/Qg==
X-Received: by 2002:a5d:58c8:: with SMTP id o8mr2630443wrf.299.1623400433172;
        Fri, 11 Jun 2021 01:33:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/9] nvmem: patches (set 1) for 5.14
Date:   Fri, 11 Jun 2021 09:33:39 +0100
Message-Id: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.14 which includes
- these are mostly minor fixes in provider drivers like missing
  MODULE_DEVICE_TABLE and improve comments
- fix in core for missing of_node_put.
- setting correct provider type in sunxi sid provider

thanks for you help,
srini

Bixuan Cui (1):
  nvmem: sprd: Add missing MODULE_DEVICE_TABLE

Christophe JAILLET (2):
  nvmem: sprd: Fix an error message
  nvmem: core: add a missing of_node_put

Douglas Anderson (2):
  nvmem: core: constify nvmem_cell_read_variable_common() return value
  nvmem: qfprom: Improve the comment about regulator setting

Rajendra Nayak (1):
  nvmem: qfprom: minor nit fixes

Samuel Holland (1):
  nvmem: sunxi_sid: Set type to OTP

Srinivas Kandagatla (1):
  nvmem: qcom-spmi-sdam: add missing MODULE_DEVICE_TABLE

Zou Wei (1):
  nvmem: sc27xx: Add missing MODULE_DEVICE_TABLE

 drivers/nvmem/core.c           | 19 +++++++++++--------
 drivers/nvmem/qcom-spmi-sdam.c |  1 +
 drivers/nvmem/qfprom.c         |  9 +++++----
 drivers/nvmem/sc27xx-efuse.c   |  1 +
 drivers/nvmem/sprd-efuse.c     |  3 ++-
 drivers/nvmem/sunxi_sid.c      |  1 +
 6 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.21.0

