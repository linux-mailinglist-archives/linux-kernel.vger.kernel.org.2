Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667073989D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBMne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhFBMnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:43:33 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F122BC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:41:35 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id b14so1671745ilq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODbQe1YSi6NuLMGCT7TprctatBNNgvpkRNoWp17d0T4=;
        b=gPjQp+GT70eRjAYBjje/x/PQdPOl6yFPytQOp7P1mao9ZEe5pCuMYrJY4bGYU+oDH1
         wbFEaqIa3xON7y20+yQySQn7hhydul7KGOeviE1o7lKGHfvLox9aKcomLsDXcvc3qi8l
         y9CmI9XolN2tq1oCdKdoeJhaRZ5BTIBRl+V+oB1NTGf+8OOv75x8dsJ+Rxrk2Q8yFpiq
         DPRomGaSN6kTY5ze04PbmVSOFPMRABA4a/P35GM+iCxOi5tT5HZsvXF8Kte7QI1tfYqX
         Ad6/iA6He0Ce4AJ9VXZbNzMxEKUi55BMVdCyiV+JHYNlJeZANedGfK5NfpUL3ZCoXMxl
         +z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODbQe1YSi6NuLMGCT7TprctatBNNgvpkRNoWp17d0T4=;
        b=eG4qtFH5KDAHNo956xx69k3WEnX2+EsOjG394N670N+DxFeYjkfCwNoPVBZNVOijjK
         ZhVcvioVvXlJIbBKU2244AJB1rsISPNFxURW4rtpXHMJdFPC5CDE+7yo2Wt1+WUyFw0T
         BacT88Kwi4YX+jmUG/V4S/4+DGCRUUuXxlA8X3d4gkbFmVwodEL7cyMXkw/S+raYK2ES
         o/p0BcHSFygMzcF5PoghAkRlckod4EatkwTKrZo48qfTesd5BfSwHGarZwsqEfIh1xLr
         go9nxSXOZVbOPDDgjQYpbHDua7FOUVqFIWPQH2aE2eoUDPGPpu9yp3DaMk3Kjne9Utv4
         d4RA==
X-Gm-Message-State: AOAM533aOV5ucQtuzYLu0E1dUN+m2EJJZ5OCLpC9OnPgqxIuOaZPblqY
        mtZtPS50Octxk8eYueqAYazMSw==
X-Google-Smtp-Source: ABdhPJxE5/tPWv1Lb824MsZ8rrXHHy5SF5mUlvLHc+aY0KGxLKdpaYg5Mp+ATKUnG3+eSBXAiPXYig==
X-Received: by 2002:a05:6e02:1648:: with SMTP id v8mr25141534ilu.289.1622637695128;
        Wed, 02 Jun 2021 05:41:35 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id v18sm11087054iob.3.2021.06.02.05.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:41:34 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        sharathv@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: support inline checksum offload
Date:   Wed,  2 Jun 2021 07:41:29 -0500
Message-Id: <20210602124131.298325-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline offload--required for checksum offload support on IPA version
4.5 and above--is now supported by the RMNet driver:
  https://lore.kernel.org/netdev/162259440606.2786.10278242816453240434.git-patchwork-notify@kernel.org/

Add support for it in the IPA driver, and revert the commit that
disabled it pending acceptance of the RMNet code.

					-Alex

Alex Elder (2):
  net: ipa: add support for inline checksum offload
  Revert "net: ipa: disable checksum offload for IPA v4.5+"

 drivers/net/ipa/ipa_endpoint.c | 63 +++++++++++++++++++---------------
 drivers/net/ipa/ipa_reg.h      |  1 +
 2 files changed, 37 insertions(+), 27 deletions(-)

-- 
2.27.0

