Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0233A357F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFJVLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:11:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35868 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhFJVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:39 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lrRvp-000620-Sl
        for linux-kernel@vger.kernel.org; Thu, 10 Jun 2021 21:09:42 +0000
Received: by mail-wr1-f72.google.com with SMTP id l13-20020adfe9cd0000b0290119a0645c8fso1551595wrn.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 14:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7dHhHk/1VSEHnHckunpoSrx9SQZwojTmGD0AVXpAUY=;
        b=t1VJBQ9Kw5Xra5/geXe6rRU98Ncac3J52gxwKH11KYsTMKvlrrOmjfvlaSUY0lxHc8
         DvWrFu8YKH+zu057u+TWqSm5Il9xLNNOvBTPqwvU0rkzAhfOapusC8deMWTk2n9RyNMx
         IRzkHdsN4t6Z4RaNgtucVXPHHATm7baL+MYO63MmGaIiR1/uEscy1TVG/Yx+aBzjcnV/
         6DC/qK0p+md/bbiTQAM0Wir5b6M4zBu7vI1agvQy5QUN77Tqi6OUSdThbabzescNAEL2
         NeKg+7WHIfbqlGHsoBWi5GvjIm56vr3z9nvYaH9VgD3lmlywdNgAQO5ca9CgJzhlxL0e
         s/bQ==
X-Gm-Message-State: AOAM533lX2mFgkOIb4PNdxvwnFoYi6zLfHiGtZSwI3TjpZAsRbl2l+7w
        iSmzh+WifcxeuP9JV/ETsnO29qrqie+UmYqYfwfZIGUfmkA8yzTz7GAm4F2q9w2qYrXpbwPhvr8
        V/2OahEXsARUjW4bQm9VJF1GYwKVgYlb0BNK4BlWo/w==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr16882079wmj.25.1623359381544;
        Thu, 10 Jun 2021 14:09:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwuBYl5ka+FTgmYctjFQ69Ays85JexobkPCaXjfZdlopIM7Ho2aBDPnhA9G0ICv+aj0gxbTQ==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr16882058wmj.25.1623359381310;
        Thu, 10 Jun 2021 14:09:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id q5sm4914800wrm.15.2021.06.10.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:09:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Simek <monstr@monstr.eu>,
        Srinivas Goud <sgoud@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        helmut.grohne@intenta.de,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v23 00/18] ARM Primecell PL35x support
Date:   Thu, 10 Jun 2021 23:09:38 +0200
Message-Id: <162335936799.3768.17631711223949577836.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
References: <20210610082040.2075611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 10:20:22 +0200, Miquel Raynal wrote:
> I am taking over Naga's series, here are the major changes:
> * Cleaning of the SMC bus binding file (and yaml conversion)
> * Superficial cleaning and great simplification of the SMC bus driver
> * Addition of a yaml file describing the NAND controller
> * Full rework of the NAND controller driver. JFFS2 and UBIFS not tested
>   yet, only bare test tools have been used to proove basic correctness
>   of the helpers.
> * Addition of a couple of MAINTAINERS entries.
> 
> [...]

Applied, thanks!

[09/18] dt-binding: memory: pl353-smc: Convert to yaml
        commit: d3d0e1e857110a2f8147b1aa3a045b1fccc1e7c3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
