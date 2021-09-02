Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D883FF79B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348507AbhIBXFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244682AbhIBXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:05:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845EC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:04:46 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r6-20020a05622a034600b002a0ba9994f4so3794879qtw.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FYCWYSXBc6FIVn19Crt/oR7pcjs0mJQ6ExafdZiEYsM=;
        b=rEz8YekBJcOLpB0Yr51lk57pwWHu5IaxK6klbo7yxGgoqDX0L+/hl4ADHWiaQprNGY
         hDJhYrmi61hZNnpbMEc3wRp9/NgA+jVI8U03UQnqYO2axHzbabnF3HQ6ViCs18Tyb12H
         vv3hKvbVRbp84KKWsxD/paoZD1rt/wFvnWhg7jn6bQX0oesLmvTbcx4xC1Yo1vVhE6Ht
         S6Jm/g0wT3fNsIaxanFe2GX+QoA5HE3bHvUP0V+A5wMqO+9Oq2QQtlzvxa4mPgC27PsF
         aIHB6JRlJcbnO8c3imuyzsfUgBgnTT5MLUyU9B42lL8crtZTz3FuhKVrb3lC8jAdqeQq
         5nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FYCWYSXBc6FIVn19Crt/oR7pcjs0mJQ6ExafdZiEYsM=;
        b=d7MFPJAeE+XAPKsUCO/N6ugncAkZpxQCPfNbDz+Cj592o+TriJHn3DcMA+oy+wxwFo
         2xOppLph26vBTxX/Ge/TBVtEszpqWcZUqv7K2BlBWng9h7svTFHsJ+mqoN7Kj18ESuLu
         M8zffesMJgseU2NWcRP7mTor1D/FXxpBClOgYBbC4IKARBOqD+BRkmIR9ukHe9u0cYIO
         gl+Ni6wUCImjpWG03AY96y8FkPl3W2RZMW2a4vVGWECH0J5yHuXj7JT3VqznO2UQRG/R
         egbnTyNpNNM2J3qPJx0VIVMgUv4uA9LFpAtstfwRNBh3x019fFXVkUoOzabAmR4EOH+Q
         gTxA==
X-Gm-Message-State: AOAM530F6mRI2EYlh8sIg5FKzFSGesXw3Kve363qiAzV6ZpPGzYB2Dm/
        5N/5zVEJbYpEbg8OwPYfdKQNaTDElyDGNvQ=
X-Google-Smtp-Source: ABdhPJyzaPQSgONUgdNvm0oNiRziH/8EMfiopu5de6V4d/iTqvBntGX5IinA77mXVpz1LBXwGfg1S21WTpCnlJk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7cb7:1ee7:33cb:da76])
 (user=saravanak job=sendgmr) by 2002:a05:6214:d8a:: with SMTP id
 e10mr462742qve.52.1630623885909; Thu, 02 Sep 2021 16:04:45 -0700 (PDT)
Date:   Thu,  2 Sep 2021 16:04:39 -0700
Message-Id: <20210902230442.1515531-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v2 0/2] Fix simple-bus issues with fw_devlink
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf reported an issue[1] with fw_devlink. This series tries to fix that
issue.

I replicated a similar set up on my end and I confirmed these patches work.

Ulf, mind testing this?

Thanks,
Saravana
[1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Saravana Kannan (2):
  of: platform: Make sure bus only devices get probed
  drivers: bus: simple-pm-bus: Add support for probing simple bus only
    devices

 drivers/bus/simple-pm-bus.c |  7 ++++++
 drivers/of/platform.c       | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
2.33.0.153.gba50c8fa24-goog

