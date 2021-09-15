Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC940C0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhIOHjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:39:08 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50780
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236616AbhIOHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:38:55 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 86C1940262
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631691456;
        bh=VNhuMSVYlZ4RBI+HKhhCa21E7CHalYPb5KZF4Ga++fk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=d4PhT/B/Withgs/PtbcwedTYKqwZ+96+rmurQFdSzd2whvlt5fXix0ddUHA9eC3HV
         3+zM55Fx5wsGSZ4plwhQI2GbpSwx/G4r3d+xMqnAQufhaHUN230mxjbKRECSTsbRUG
         0GBDyH/p2n+4Z/vtCmEefKejx3W4PGvOjHSxy8G4VlEd6pGfwMjXlaawZdD2UaYBSW
         80hGv5VyCxF62VuUbAaheVfDM8MJzRG7MglRlqslA5wZvYHarloOKhjRX5fxJ4GyfP
         2z+Sx+HMss0SOPsWjUJhaTqI3GSX1RvCb7iyZbEnoNi/emY+XxtLPuU8A2bxCUSLaF
         OoeWSqcYCgtUw==
Received: by mail-ed1-f71.google.com with SMTP id o18-20020a056402439200b003d2b11eb0a9so1057824edc.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VNhuMSVYlZ4RBI+HKhhCa21E7CHalYPb5KZF4Ga++fk=;
        b=U5QkptWnvQp0yTl4cPToPR2/YXYCUlSHM1Hg7t1eFQA5NKGyutirz94aTWLr+66I4o
         kFM6GG/UMxw4x79NOEhOBakLIUeI4AN/L0lxcnw1rGR7g859/nExGDFUXEusYHwXSile
         0i/T1/mGK4H1d+t5gVTfRZdCjtvk8mjEWskJv1VpeHEHaV2Vfhfi+JRBbw2tYmUjZGR8
         wWRScbk8ll4db/rAkdN9QB18e1OVSZSm3OxtrU1rX51X73bhUG289wYp17cw6+h0sH/z
         ej4yFt2Bw0Ibjj/GJPp1ZwCTHk3w6nJ1hCuWkB7OcxQ4DTFQp8PeBdPQL9KUEjqd3RXS
         XkmQ==
X-Gm-Message-State: AOAM531dXh+C9LIFRnArlMdSDXc/P6FFSjaTYxm/BS6yEB6BN5IJ+rSL
        +sT9iBJ7ZDuvESFwJUgMXisowMYd8BySbIG6uQgCx27hy6UTTHLp9OImRCGrCZD2stl/seeCC8C
        e4yAWKUgO5FT1OlhEsMQLqltZwVgFXyPtuZS9vjkuzQ==
X-Received: by 2002:a05:6402:104a:: with SMTP id e10mr24334296edu.139.1631691455980;
        Wed, 15 Sep 2021 00:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSzwU3Zeg/51JAZYchT+uOWuELdhcjWBmcCJ7x2Vabn8Iq1N66iQvk09tApR5D6ty9v5slQA==
X-Received: by 2002:a05:6402:104a:: with SMTP id e10mr24334288edu.139.1631691455872;
        Wed, 15 Sep 2021 00:37:35 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d22sm5871832ejk.5.2021.09.15.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:37:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: make the array list static const, makes object smaller
Date:   Wed, 15 Sep 2021 09:37:26 +0200
Message-Id: <163169144169.13297.295852962982920269.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819133155.10441-1-colin.king@canonical.com>
References: <20210819133155.10441-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 14:31:55 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array list on the stack but instead it
> static const. Makes the object code smaller by 110 bytes:
> 
> Before:
>    text    data     bss     dec     hex filename
>   37713   21992      64   59769    e979 .../tegra/tegra210-emc-cc-r21021.o
> 
> [...]

Applied, thanks!

[1/1] memory: tegra: make the array list static const, makes object smaller
      commit: d71b90e3633ff4af8e915ba7adc3c26f7f5edcfe

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
