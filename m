Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099C73723C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEDAGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 20:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhEDAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 20:06:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D6BC061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 17:05:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t4so3034343plc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 17:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDzDiZKgkuBIzy2dA89gX09XTeJ0XvlvWikD1ZLB35M=;
        b=BYhlbG9htRgrcm+j6xb+5irs8Y2dtX5BPN5vT5dthFFmdc2wdcqYLSvoBiQPgxhkdY
         HoVp94XBkH6mPX4rCVCDF+zBm45SWZtY8IWGXZNTNrmLvCavxTjNeQzFv8T8TmB9wVA2
         7888+TcYr5UOpB+lvNwW85F0nGc6AYEEZu+ujGZM+YpgLVZBKY1PU0BtwXu1l5bUCYB0
         8OCyyxQfF7OLxOe1pCS9xGID8DbETrBqZofbsGwN2eKv3Nla4gx6WzK7/j5lMFwGete8
         wf2zgsy3Td3kI5HUP+SDTfiY778dus1rTEXM4kkj8qnIr+hrf/cxm5gaBwBiXvasAy/t
         UgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDzDiZKgkuBIzy2dA89gX09XTeJ0XvlvWikD1ZLB35M=;
        b=I4aII2VSr/Jig6/7zWLnbZCpUthxaR/sTsBxm9qmWYeIyKKuIujEke+hB9QXFi7cy9
         GfmFSktBtIVLJob/zrViK/1TkYB2MhJaXwZtKFH2j23IQIKZDmxaEmHkbu7e//wqJAjT
         NXyxtSwboFwZMzsphdMTjqjUt5LpOz1w7C7o3MFf+ulojczALUGo3h7ognMXcaZI4VTB
         gh9YUMbw1G9VpwlJkImTer+KLwFeIwAE32HTf6fVL0gNKwcZzVIwmGn+3SRlWgz6CPC3
         Qidl5IrTVPXd4rKSQTVB0YZIa8gLIezthwn0tlK5HHPE9CoTcb8VCwcQ/rX5uxGObgMi
         rwrQ==
X-Gm-Message-State: AOAM530CAzdatcTxa4aB6eUZlc0ADD5tLtrYB5qDANRDT1pDw4PV5K/F
        M4R97Z9chadZCk75w/tE7H4n7Q==
X-Google-Smtp-Source: ABdhPJz5KY4WXvst87q3waruwTbClvq21tHkxMG77SNnVmypEkEmefQ2ACx56GjiUXnBm9I1L+fwcg==
X-Received: by 2002:a17:902:b68c:b029:e6:bb9f:7577 with SMTP id c12-20020a170902b68cb02900e6bb9f7577mr23126893pls.0.1620086756012;
        Mon, 03 May 2021 17:05:56 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id gm17sm10499510pjb.11.2021.05.03.17.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 17:05:55 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: vim3: enable hdmi audio loopback
Date:   Mon,  3 May 2021 17:05:52 -0700
Message-Id: <162008674673.40672.13568672227710431914.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429084253.59692-1-jbrunet@baylibre.com>
References: <20210429084253.59692-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 10:42:53 +0200, Jerome Brunet wrote:
> Enable audio capture frontends and a tdm decoder.
> This makes it possible to loopback the audio played on the hdmi codec,
> which is the only output interface at the moment.
> 
> Of course, one TODDR device would be enough to do that but since
> the 3 FRDDRs are enabled on the playback side, let's do the same on the
> capture side.

Applied, thanks!

[1/1] arm64: dts: meson: vim3: enable hdmi audio loopback
      commit: ed678d85ab2ebb75d23b68c1b4af4dd068f14edd

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
