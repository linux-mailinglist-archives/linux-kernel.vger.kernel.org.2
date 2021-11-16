Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857B5452F27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKPKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:34:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56618
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234174AbhKPKeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:34:44 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE26B40829
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058705;
        bh=g5kT88EclUTS2mZGyESS2Hco+eCrz9DKbUmHpnwpdJI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=T3K/NAbZ9JkTwqPo6/PR2fssfdYo90IgBnD7Nylg7Bej4XrYc+oAIC3XPcCc/JzJl
         xaER/H8fscF/jQjkA8R700vVGQ7l0vbsSj5jV+lp/A2BiSW4hYUR5AMPNNDdq4ygYF
         JLvWO/7Wm/9TmflamuEENM0pdBDfS8gYp82RlIgK/mD5i0BETchqemXCTvvxLq6cs0
         I2gopi6MB3rq9KBKU157+TEET/sClLByzfbFyu64CvnM2eDylgIKFWdhFSVkPdKwls
         owVBbgnX9KW1k5/1P3sS3ZCd3+UWNMaXVVU5aUVycF6Yorr0DemB1v9uIPDmMuBDUc
         BNGdqBLfsnvkw==
Received: by mail-lf1-f71.google.com with SMTP id d2-20020a0565123d0200b0040370d0d2fbso7992669lfv.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5kT88EclUTS2mZGyESS2Hco+eCrz9DKbUmHpnwpdJI=;
        b=HSRMzagW+6rai8uysX6czbDLNSqETBwBUfroySJsrT8OiYwXaA1kYzJXn9iOQG9NAk
         +V0IWQYhUVKsvQ/OVw8UlDCVyCVenRYlad52OUhc8yPo29e4pXtGxnDRvsU5YeeA5XDQ
         zI6xPpJpOMxAQ/KnGEsrwSeCTh13NbGhaV+0FMNRSzKgNDa+x/0YgMSz4q+vaaF+mmKY
         tvnWKeN5WytaVb2ycbJvdQ3+pXapbjOSF1c6z8DF1mlxAwzm/sZEccj+HfAUKSbF1mfe
         OlkhO1o+HTKH7FI29HG+mDxenLaetVASAlYrLCqoSIwE4QhfF68xeP9PxeFYVwqyloRb
         42dg==
X-Gm-Message-State: AOAM5320dZiNgPcXBET2diBZT2ev2mLzIVdUoxo9DrtiSpZRsg7vcG47
        G2S6+TUFl/2rozV/NJQ4BGQabbd8UK73hCqDcvvK0H6zUBA7RnoAN6RWRTVIxEfxlkJLuqWOj9E
        La5kCn2IqqCN3QEulcStOT2HLTf/+Tcj78KyT6nnKBQ==
X-Received: by 2002:a05:6512:3a91:: with SMTP id q17mr5473892lfu.425.1637058705239;
        Tue, 16 Nov 2021 02:31:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUH80JQXZBEvDWfVj29pNQ2Zba/7Rx08vt0/WpoIec8KWneuc1zgQFATOcJm/krv8sKR6wdQ==
X-Received: by 2002:a05:6512:3a91:: with SMTP id q17mr5473855lfu.425.1637058705021;
        Tue, 16 Nov 2021 02:31:45 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j5sm1114418lfe.219.2021.11.16.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:31:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 5/7] memory: renesas-rpc-if: Return error in case devm_ioremap_resource() fails
Date:   Tue, 16 Nov 2021 11:31:04 +0100
Message-Id: <163705866144.26823.3259399993902920486.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025205631.21151-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 21:56:29 +0100, Lad Prabhakar wrote:
> Make sure we return error in case devm_ioremap_resource() fails for dirmap
> resource.
> 
> 

Applied, thanks!

[5/7] memory: renesas-rpc-if: Return error in case devm_ioremap_resource() fails
      commit: 818fdfa89baac77a8df5a2c30f4fb798cc937aa0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
