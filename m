Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252F93723C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 02:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhEDAGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 20:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhEDAGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 20:06:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B501C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 17:05:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n16so3722542plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vs/iwCoGgWSTxOU7UC82l4ENSMubLlaZ/ZNv0A3YsVE=;
        b=vhNv5sA3oFi+S2+xJP4o3wjvcrSZJb9IY7Ln3ikdJKCfWLDzYddEksLCHlxOsqjZbt
         pmPYcIhtUoX+Mvo6DK8mdor+smmeGF/3oXUYfWjFwhm2vW4GeIHk0vArwbi0l5uXt3He
         jkux3mp5cOlLzG292/luw8TH0fE6sk1+1dTy6vnd8U89au0tQOGW00JwkpVO40PCSmud
         yG489mDmqOJrWimMlRrQPBCBjWDTiBWINJEPh+uaD9D2wm1HkLw91V8O2b3e8VrHKASR
         p1z4W82N99YSKl9YROX3Pcf9Fy9tmaax/f1Xir4fuN7a4io2P4nOlFXgRw8XLG3YQKG3
         OJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vs/iwCoGgWSTxOU7UC82l4ENSMubLlaZ/ZNv0A3YsVE=;
        b=jqWJbPdx01wMGEnZSHtHZFObqzJ6Mxetk5V3Lvp75Bk5/OjpNX/kjfDXT13eLpEHkS
         w1Fw+o4iEayppcM8RFBnnJVQzY0+bPvopVZ9GHf++KtHP/S6zXzYZbsftL3juroLoqwC
         HRmNA5HEud+NmbbN9C+kTv+w2Cj02dAjDKC+MQOVvn3Yr78F1DlITf9Gg9V6jotXN2fY
         ZK4Jo3ISrwS4hX27SFVPtRkVoaChpStv1gJOtbo6PsMf2alZhfGiTDDU0BIrVkdpCOCz
         K48JsSdpfs0M9EnUzp1F4U8v4VuTcZ5qYYe4hr4+i4EOggKuyl8LcEKVp79dZqOw1HNk
         F5vg==
X-Gm-Message-State: AOAM531r0tRlwDZcvTStAIWuMvIBlBKmO8BzgLyLRk3hYk+cXR4YGlAY
        wu7LAPfagbiWUOdUFGaxtkJ4mQ==
X-Google-Smtp-Source: ABdhPJxv+ZZthqzR+gyi3hdNJ+x+W/Jd7S4Zviivb1wcy5Wj3aMCX+EK5M23MjOT1tbM8rWZ3t8/rA==
X-Received: by 2002:a17:902:74c5:b029:ed:d41:1ca0 with SMTP id f5-20020a17090274c5b02900ed0d411ca0mr23224442plt.66.1620086757057;
        Mon, 03 May 2021 17:05:57 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id a18sm10034023pfo.64.2021.05.03.17.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 17:05:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: meson: select COMMON_CLK
Date:   Mon,  3 May 2021 17:05:53 -0700
Message-Id: <162008674673.40672.14279142646066453043.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429083823.59546-1-jbrunet@baylibre.com>
References: <20210429083823.59546-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 10:38:23 +0200, Jerome Brunet wrote:
> This fix the recent removal of clock drivers selection.
> While it is not necessary to select the clock drivers themselves, we need
> to select a proper implementation of the clock API, which for the meson, is
> CCF

Applied, thanks!

[1/1] arm64: meson: select COMMON_CLK
      commit: aea7a80ad5effd48f44a7a08c3903168be038a43

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
