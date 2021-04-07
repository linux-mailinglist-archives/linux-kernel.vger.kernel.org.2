Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2823571FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347793AbhDGQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhDGQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:17:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD94C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:17:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f29so10979213pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkQmVpMRcrPLSpRzP7dgecYRXq//RT6p4q1X4WEKNnw=;
        b=aOFaiO1sq92U5rT3rqHZzy0CqSci1sKFt1gzalxF0j0IiPHSkXRWw4ZMP24yMCfe0m
         DhS0TL7UDg+53OGmzKNcxcSmzONzd+FFFqypJeqzYhh8U2g3zfclpKnr0h0B0nTvNjtC
         LTsYqs6lDJwfYYZZLDFlRUdYcapUon/T5nNz1qoQvEPhsVFuQ20CsgRb9pClWb349j2L
         H8RvAfInuvthmM9p65Qs2Fu/NlEtWtRdmZciuZpgW6F7726943MGZw8O7bUe0WfEX3WN
         Dl2soYywUEJ38mI8xkzDH8GSXCqBYeDk4e03UnBJkYCK+mYwHTnbyirgaLjLI1tvkvWN
         PEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkQmVpMRcrPLSpRzP7dgecYRXq//RT6p4q1X4WEKNnw=;
        b=AqOuMWcIPZabEHrxk5W9D5cC+6cL/GJJVDw12e3K2qk0ir33ZeCmfi0dXgUoWuKznT
         TEf++cUzsGVZtT6A4rIWH1C4boLK5UZIxLu9Zfd4TEbC4nJzx4MAqDHz9+hkMxckz08u
         o9mTyF9tEkBM9mDgUiw6oQyoO9LHTUjB2r1BdBoktR6Vg7U/Yq3Q7Vdg4gtOdAAAO6gm
         gWMhX0exDpi5PuR5cqMhm1OkqQih/J1D/kq+wCCet/N4KsdcyLc2gY1LGhgliTYnHKTx
         wK8cjt4apyAeSJDih9/J1x3ZUTlWqKSRRiLWjsws+flxsA8Y6jZONfC1O+4I25OsbgUh
         VrDQ==
X-Gm-Message-State: AOAM532/EFluBLUTQuxDRZ5CNc5W6UZ6p1ewNQQGjUpoJyf+GhnOs0zn
        hluPQGTculxPD/8cp77vEeNhEg==
X-Google-Smtp-Source: ABdhPJz8tD/aoietkR/S+yJ5l3waT2txM2yHKjP7dEAdhaToxJ+HWpYCwyYfF3RNpOgdmtyM4sNDLQ==
X-Received: by 2002:a65:4046:: with SMTP id h6mr3933614pgp.345.1617812245675;
        Wed, 07 Apr 2021 09:17:25 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x2sm22778587pgb.89.2021.04.07.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:17:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     Drazen Spio <drazsp@gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: meson: add support for MeCool KII-Pro/KIII-Pro
Date:   Wed,  7 Apr 2021 09:17:23 -0700
Message-Id: <161781223326.25927.5710421341360861748.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210329154753.30074-1-christianshewitt@gmail.com>
References: <20210329154753.30074-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 15:47:50 +0000, Christian Hewitt wrote:
> This series adds support for the MeCool (Videostrong) KII Pro (GXL)
> and KIII Pro (GXM) Android STB devices. These are quite popular due
> to the embedded multi-standard tuner card (which is sadly not-yet
> supported in the kernel). Both devices closely follow the Amlogic
> reference designs with keys/buttons/LED details taken from known-
> working vendor kernel device-trees.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: amlogic: add MeCool KII/KIII Pro bindings
      commit: 0bbfea7c0469cbe0914c1800b70f607ed7638870
[2/3] arm64: dts: meson: add initial device-tree for MeCool KII Pro
      commit: d5454e7ce24a28bd22beb2fc02f1571b5748dfbb
[3/3] arm64: dts: meson: add initial device-tree for MeCool KIII Pro
      commit: 727d93ed3ba67307a82c3ac5ebc7e335265e8b9e

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
