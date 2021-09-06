Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9A402049
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbhIFTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbhIFTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A568FC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q11so11085999wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8r9/+uFnb+HfHKTylFJ8NnEQdc+KqVsYNXnjIbXk+Q=;
        b=qMOzy69P1wv1FyfqtSQtoYA7bjYxfGsO13ZjcKrzReoRAxfF8Cx0hTWI7KMVhBnUbY
         6bV2mSycyKXdBAxQQka1+pXufHR7xXRbpccgwOlyKGdsESLwi1PbbL7j92jG7UGcWz1h
         IGqWPrZru5KX0e7WtTYi3nWhgAof4Bs6FlwDY93NPMM8qoRF1liCV/FHMb9ChFuDdW+W
         N1mqouorBlzTmKc6NBfkHeriB4aZ4FzPnosOocv1VXCLGSFRYrBIYHJpYjeGs8Crj5n8
         83uUjvWdCZ+z2gUlH9+WqgiZVzodX5jVT1PmM5IDBqgTXP9L99semAPebn3M26XxhrN9
         0uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8r9/+uFnb+HfHKTylFJ8NnEQdc+KqVsYNXnjIbXk+Q=;
        b=Oy6yslST12Z1hdYjH/J5QT+mC0VRpYKMHbXUQA0YYpaOBVY6fPLlN3kxuB4EmEN8Qd
         TzUuaZtFSKdI9Tw7hLegVBnZAXXwFijAP9js2TmYA9SIyBiHJInOaRwC9A6qsjszcKXX
         36qD9IZeh/CfF91ycGanh7FQu0lGGVMhUMMyWb2D7E1HKFKYuFPsdileD8vD0bAJ78U6
         /W06fHgIAxt0ZmFXooEV8mzmqGVCL7rqXP/9suOnGZJtNQgMcb5NLbubtDo2+XR+w+pn
         JQnePjVyJhZJHu4Sc+yj99xsGY+IDzVJ44MpBbBKKyxM0wUGNpMIwKb2mukWRT54vL3m
         ShQA==
X-Gm-Message-State: AOAM533LQA2FAPEnaI69pgphz63IPZfPxjKFeSnq8HdxCxH7G+3LqKNB
        XrvCmMNHowRDyqR0gzVMNS5bdA==
X-Google-Smtp-Source: ABdhPJxYOJe4fmTHCop37aOHErM7r/Pc4ZVC9e7KbEN+VtALsVnspuFPZftLq3tph04Aztose+MIxw==
X-Received: by 2002:adf:d1b3:: with SMTP id w19mr14886761wrc.152.1630954988733;
        Mon, 06 Sep 2021 12:03:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id p4sm324750wmc.11.2021.09.06.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:08 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/2]  Add a generic virtual thermal sensor
Date:   Mon,  6 Sep 2021 21:04:52 +0200
Message-Id: <20210906190454.114751-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a virtual thermal sensor.
It could be used to get a temperature using some thermal sensors.
Currently, the supported operations are max, min and avg.
The virtual sensor could be easily extended to support others operations.

Note:
Currently, thermal drivers must explicitly register their sensors to make them
available to the virtual sensor.
This doesn't seem a good solution to me and I think it would be preferable to
update the framework to register the list of each available sensors.

Alexandre Bailon (2):
  dt-bindings: Add bindings for the virtual thermal sensor
  thermal: add a virtual sensor to aggregate temperatures

 .../thermal/virtual,thermal-sensor.yaml       |  67 +++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/virtual-sensor.h              |  51 +++
 drivers/thermal/virtual_sensor.c              | 400 ++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  |  15 +
 6 files changed, 542 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 drivers/thermal/virtual-sensor.h
 create mode 100644 drivers/thermal/virtual_sensor.c
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

-- 
2.31.1

