Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE8354792
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhDEU3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhDEU3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:29:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1055C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:29:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so6232679plt.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Th7mo+vc+gvliasVJy1K9tXrLo9RUNstWRPIZSS1pcE=;
        b=KihwHVZFW3sDrluFAhSe7CXCym6kBvL/NZnNocdsNQONk3FIExpDeTh6M8tv8ZMF9s
         aZqQE5md+oSNNS0HudUUmDKwQj/4pgjzg2m8hJAOzWbDp1n9in5b0YXdJWXTls0oApzv
         jnwTWevnSCSxYfmNWXsBuCy7Gqp1jAfp3s54w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Th7mo+vc+gvliasVJy1K9tXrLo9RUNstWRPIZSS1pcE=;
        b=Y+kXZMJcCo3lBFxwnSWb0hhWYYvfulr7n8U4jM5ljY2pTDltvoMakWE+9gWTPD/aUY
         +o1/4pKqgNYpACC4P4IsbZS22JSZY9HAVYcMmyXpEHxxIykkWkydWx50eb0b0M2HVGNo
         Js3dv4KKrW0QKBzV8wxvDLzOauWHxVjk44GOV9b3ohaY4ozP3J80hEOCqkqAsvt1KpJI
         eW7g8BBq0JNfSKsNjlVTf9bRn9AAvHEjkMO4pDvXssyfxb6p18Cf6euR8p0cmIseTqrj
         O/+70UojvicswqG6oYNTIOZxenMPN2ohrO/+4ZyL2ax6/66EOHAjfHfF9yYv/2ngJbk6
         pj5g==
X-Gm-Message-State: AOAM530NbAd5NmxpM0zwLSbj1C9BjVgoxLszNCPTuNaaksdAXrf1qvVy
        2O0IWRExA1ndRjih2bmSCf8c2A==
X-Google-Smtp-Source: ABdhPJzmAnjWh6V29s2KvCH3F0nAQ949qqFRvs8e1jsJO819iREo0hoH89bV5uFgJ3br3HUracXfbg==
X-Received: by 2002:a17:902:b602:b029:e6:cabb:10b9 with SMTP id b2-20020a170902b602b02900e6cabb10b9mr25297590pls.47.1617654540797;
        Mon, 05 Apr 2021 13:29:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:2926:73d2:2f29:3222])
        by smtp.gmail.com with UTF8SMTPSA id x22sm16091259pfa.24.2021.04.05.13.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 13:29:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
X-Google-Original-From: Gwendal Grignou <gwendal@google.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Subject: [PATCH v2 0/2] platform/chrome: Update cros_ec sysfs attribute after sensors are found
Date:   Mon,  5 Apr 2021 13:28:55 -0700
Message-Id: <20210405202857.1265308-1-gwendal@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attribute "kb_wake_angle" in /sys/<cros_ec hw path>/chromeos/cros_ec,
used to set at which angle the embedded controller must wake up the
host, is only set when there is at least 2 accelerometers in the
chromebook.

The detection of these sensors is done in cros_ec_sensorhub, driver that
can be probed after the cros_ec_sysfs driver that sets the attribute.
Therefore, we need to upgrade the cros_ec sysfs groups in the sensorhub
probe routine.

The first patch cleans up cros_ec_sysfs by using .dev_groups driver
field, the second patch fixes the problem.

Gwendal Grignou (2):
  platform/chrome: Use dev_groups to set device sysfs attributes
  platform/chrome: Update cros_ec sysfs attributes on sensors discovery

 drivers/platform/chrome/cros_ec_sensorhub.c |  5 ++++-
 drivers/platform/chrome/cros_ec_sysfs.c     | 22 +++++++--------------
 include/linux/platform_data/cros_ec_proto.h |  2 ++
 3 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.31.0.208.g409f899ff0-goog

