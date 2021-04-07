Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D713571FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354220AbhDGQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347739AbhDGQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:17:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25AC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:17:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h25so13460693pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5sD1KlKL6NAnii2NS6zkOfpdYsLdAUo/LvqCAHs1nNo=;
        b=TV/8kyuwv6Q823GyE5cYC37jhXDpseW1gp6Hg13zwlM1j4ZTuoCjeGhm46uQo4SBVt
         I/MVnOEFgZP/rO3grbKEpjlOZhARUh5y2fnfLkw/tVKmS6BdySq2aS3hsge9YB6oGFz2
         TkW3RFw56uY1frS4SN1SriL/kz0pWmj+8vi9QS4Cb2VkxXNJo+xFGxW934CUOhwr5N/E
         u1mqbyRA7GlKB+xL0YcpLfW6F+alXQ12RmQjcZwkZoAijHSEI8TBokJd485wvuIweuus
         CLQ3Rg6YKWfOM20Jsbf0IYPXEWpm+gmendmoiNpdXil24/ZHTfWlQx88q7vYHtxoH12J
         ljOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sD1KlKL6NAnii2NS6zkOfpdYsLdAUo/LvqCAHs1nNo=;
        b=m8O/iznwl38L5Xn9IfCRiebshxyjChrEiDas8EDDoVIYG6VeZ9IXyzooTe7eF+PjQd
         FnEalsc1ryz6AYhmt9X4na4jDrg5KD75XMKD0+IciFZXTwNntTwMdPeXKuYW2sdpCovT
         ZxB1RUPNnEmCU/hicsaHxMTVlTDfAhl6Ro3Hmg2MXnEM8ZLhkUSoxcpck9zAegI74q+r
         y/FdFl9b7GIsknlwe3fOW4LrgBtmhTjt3lu3gA0i1QAHHlJl0G5A749wgquQx2IIdnsh
         ym8JUuPixcDRHqSUg19h3hqicyPk61aINX4LX9uv97AcJXSDc0DUTh+v6Uy0BgVJgCx4
         OrXg==
X-Gm-Message-State: AOAM530pkJTtvjiv+XMwS+0NaliUy+M2s/M8vhLei4NawaDyZKpAwpeW
        DpzGmIe0RyQLxQ8SII630ZSc5A==
X-Google-Smtp-Source: ABdhPJyauxOAKJWC5ozcJeVms8NkDT3FDTFrUBz5vGNLUWx8mAFiWf2HhkDwdQX6643m3TV7klOMPw==
X-Received: by 2002:a63:d242:: with SMTP id t2mr3968380pgi.431.1617812247023;
        Wed, 07 Apr 2021 09:17:27 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m195sm3009559pfd.99.2021.04.07.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:17:26 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: dts: meson: add support for MeCool KII-Pro/KIII-Pro
Date:   Wed,  7 Apr 2021 09:17:24 -0700
Message-Id: <161781223327.25927.15332865097812413350.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210402064521.30579-1-christianshewitt@gmail.com>
References: <20210402064521.30579-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 06:45:18 +0000, Christian Hewitt wrote:
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
