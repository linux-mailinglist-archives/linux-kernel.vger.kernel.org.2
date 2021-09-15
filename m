Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44A40C0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhIOHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:52:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44972
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236741AbhIOHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:52:27 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4BF7B40257
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631692268;
        bh=3UuhH6DfF97G63xEabBbDhstzQxGbUL43IU2MzmFk4s=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=HL1KlyxrNlfVppylO/bXUAkUmxQmRdlsunv21wWCdEb8jF8Lh8k2YNIYn9qKNEOeN
         G/Y08WBlQtIVVhhzkwVdeNNXBpCkAMXPHlvhhMUOFN6+6VFBVrDCn59sFEJ4Kdpu8U
         85v2UC09FujN9lhUiodHiyKGpkatyvrELNzdNT/q7/CBeJV5yz1oCp0kQqRAeq01L3
         JuD4J5MQeh9kJ5qpWjqivsEilJgl1ohs2BNDNhpXLJc8TXJWzaPbciZkTNWQKiVPQ8
         xV4KIcOLkoLHyJ+/QrqtyxaQacpCbDT4lVOCweG6WTX3LfzeAtEU9DJaXmUVd3KhF3
         BOjVqpYqwGzYQ==
Received: by mail-ej1-f69.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so1062227ejy.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UuhH6DfF97G63xEabBbDhstzQxGbUL43IU2MzmFk4s=;
        b=n0lk3ZxKKUV1S9w23fGL00/VS5JIGeHDqqELS5jCfLmZLz8xI4e1fLMffMCJbzB3ei
         6MheOeMPDyg5vEDvxTLRvk6St06TEHgGR6lnj0e0jBVPvqG6PMlFzwyNHs+aB71LG2Bj
         PQ9IuKZvipUMQNWbK++5PpaqUaMwMNIM1U+zkYmdcrlcEJ4Y9WCZtihaxvN3CmACDYgP
         i04Azjp3QEBdMDEHO2WlJHWs5lpKhTPF7o8nabixXIJJY3CawTchonsPrfuiLC8Gipu4
         DOC8epDEhBJ7BygCRcGnvllsMVVFCnXDlALzw5gWqpkpXJjHFksFG4c7lnvZN7tY1vWj
         ErFA==
X-Gm-Message-State: AOAM532MzEzuC7eTh6kSESytEEIwoxga9IqkyVSm8aIrIWl3K09jXg8l
        1PXlNum2Rnd4yncdfjvRLg477lwWoYzyNl61T9f5WdHB6V1YwubajYHH+6x4J76DWft0uE6CE6g
        GBNwaHebN7YsOCWN26/u52zrFlKX3hshzO+gQJeF8rQ==
X-Received: by 2002:a17:906:9aca:: with SMTP id ah10mr15858273ejc.471.1631692267470;
        Wed, 15 Sep 2021 00:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ3105Y/iQTlTiucEVyhs8Y5dCC+GLZzdNSu4AJG3m4GNgDvfkECg7+b3PmxdlHBXvw0U+bA==
X-Received: by 2002:a17:906:9aca:: with SMTP id ah10mr15858264ejc.471.1631692267342;
        Wed, 15 Sep 2021 00:51:07 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n11sm591922edr.51.2021.09.15.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:51:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 4/4] ARM: dts: exynos: align PPMU event node names with dtschema
Date:   Wed, 15 Sep 2021 09:50:58 +0200
Message-Id: <163169222223.16372.15525688455985156121.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820150353.161161-4-krzysztof.kozlowski@canonical.com>
References: <20210820150353.161161-1-krzysztof.kozlowski@canonical.com> <20210820150353.161161-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 17:03:53 +0200, Krzysztof Kozlowski wrote:
> Use hyphen instead of underscore and align the PPMU event node name with
> dtschema.
> 
> 

Applied, thanks!

[4/4] ARM: dts: exynos: align PPMU event node names with dtschema
      commit: fb9b199e562d66af90f61d70eb737fa5e4deac2c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
