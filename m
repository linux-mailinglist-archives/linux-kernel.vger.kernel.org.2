Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35931B2D0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 22:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhBNVfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 16:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBNVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 16:35:15 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CBC061786
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 13:34:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w36so7403024lfu.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iPtze6FmhbcdVdAPT6QONzh4sS5usExY2cycsOaMmIw=;
        b=cKycaOtQTY41AeqIErFCMpOVHbHVj2kDU4FU6JHI7NYZ4sfBA8sg4hiBLcvxJwUHOh
         RPkPO0IujkWqOL5YE/MB24dGIQl5EZbXOdexxpz9jHBU7haNMahjqU1YNz5jZAfo6t1A
         plL7nYA6jGwVDAPObTXxivUuDK0XgkUgGW02OrKpxEdJdMkTuki1lA/ryvSbsSmQhnCN
         prvkdz3pR64FEffxFHgHkiqn096RY0S3JWSJuPEnE5Jj472qz1mNEtLaswzIrSGadIOI
         +dBbtkn98ypD02/xWi3H3oTUWFG4WiURIm9yMrFCWcPZFficFZdGIYl7S1xLsYttBsaQ
         XiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iPtze6FmhbcdVdAPT6QONzh4sS5usExY2cycsOaMmIw=;
        b=jmuVLTD3fakRQ5CKojhffvrTtrRsq3f5ySm/X+PdJlraq4noZO+HEvzc73quKU2Rpn
         yctUzmeb6BZcxUhWks6OEIg3Q0tguMJr/Xm/jMihZb23gbhwd9PMmbCrccMV2Nk+rN+A
         MxuBWhJZG99k+Vv09u6togxACNd7hdf6QE9FARqD7Npe6Ta0cu647G5ehlbJ4V6aB7g7
         //SpsmEtjHQH/SOdOcSnOee9RfcFRGvSf2HrENLDu5V5EPCHQdmsb1LbcLfpbK3lY4Am
         tAqYFGgLSRPFkj+FO3nvymJJ+DCa1TN2FueR3BnrVspXwxq+otQwNUmfaG2mfDKOYino
         lmyw==
X-Gm-Message-State: AOAM531MjMuZHGprcpNzKqmc6HsSMEArpH/ZUW7AzlYpqILAxHHotlmM
        VXqprkEc57yprhqkg3BACIlNIA==
X-Google-Smtp-Source: ABdhPJyp3+ibejlV5sLro6YrM2yNvuWuPDO128if+t2CK6kgXSbev1DbSxFXmpLcoOiIzE59kx37rg==
X-Received: by 2002:a05:6512:2148:: with SMTP id s8mr7475046lfr.305.1613338472898;
        Sun, 14 Feb 2021 13:34:32 -0800 (PST)
Received: from localhost.localdomain ([85.249.43.69])
        by smtp.googlemail.com with ESMTPSA id h11sm2500066lfd.243.2021.02.14.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 13:34:32 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     junak.pub@gmail.com, robert.foss@linaro.org,
        sakari.ailus@linux.intel.com
Cc:     todor.too@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        jacopo@jmondi.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] media: qcom: camss: V4L2_CID_PIXEL_RATE/LINK_FREQ fixes
Date:   Mon, 15 Feb 2021 00:34:02 +0300
Message-Id: <20210214213404.8373-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is the start of the work discussed in the "[RFC] Repurpose
V4L2_CID_PIXEL_RATE for the sampling rate in the pixel array" thread [1].
I plan to send a few other similar patches for other CSI receiver drivers,
and if the current patchset needs to wait for those before it can be merged,
that's fine for me.

The reason I decided to post the camss patch first is the patch [2] by
Vladimir Lypak. The second patch in this series is the Vladimir's patch
rebased onto the changes done by the first patch. By replacing getting
the pixel clock with v4l2_get_link_freq() my first patch also fixes the
integer overflow which Vladimir's patch addresses. So the second patch
only needs to fix drivers/media/platform/qcom/camss/camss-vfe.c which
the first patch doesn't touch.

The resulting patchset is free from the "undefined reference to `__udivdi3'"
issue [3] as the u64 value is only divided by a power of 2, which doesn't
need do_div().

Vladimir, please confirm if this patchset fixes the integer overflow
for you, and if you are OK with your patch going on top of mine like is
done in this patchset.

[1] https://www.spinics.net/lists/linux-media/msg183183.html
[2] https://www.spinics.net/lists/linux-media/msg186875.html
[3] https://www.spinics.net/lists/linux-media/msg186918.html


