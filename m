Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1813E4402
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhHIKkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:40:31 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39998
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233857AbhHIKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:40:28 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E7C1640655
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628505606;
        bh=A7M2AilJW/lVZdtGV4sHBiigy49SQd+8vPDsg10Wywg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=k/7c+xZYb+pCLrxegcApY7ek2ySOXse7xTjlYou9FCyCJyqVvp2A34qRNMFPbOaLL
         69pOk3ybnCb/2iUiBxLQnCA6Dc0fPGywh19T4kZQ9teE8x2UzvtogMz+TRrJrxV6Pd
         9+JZ/IgsqSTx/WvnivQYjMHeWeqFnfPaP8AVQHIQZ3DW7tGmQwUltb/LpErGRUWO4I
         ikITfmGmot1a1ytNZdM9y2RcE6XQ3u4Q+tOwn8U5vlQlqbJpR6sWtK6soRZLrF5MMM
         l1DLAW2zghN/lflq6n8iUXxNtgznlPpMsS2BpxFOgCa9qEvM5dCRJD8ciAzP8k8tNE
         OQsONNZWLWN/Q==
Received: by mail-ed1-f69.google.com with SMTP id j15-20020aa7c40f0000b02903be5fbe68a9so2041654edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 03:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7M2AilJW/lVZdtGV4sHBiigy49SQd+8vPDsg10Wywg=;
        b=p1kqiaynrdLQ/2dbhk5IOQJtZ9jcIXUaxKSPz0XuCLLVEAY1kyKhKWNkp6+aC3Jl8p
         I23MV1JdOLi40wUO1HQTX/hGW7jngoazoEAQKymvtnIX3CDFVj6dlY77chDekTDKl48C
         dww8q8iCxCKLlG4YhI/+liDwpUFGT3SHvHR9aokuRVbCGEKht9esaJ4keRfoatMQiUOD
         7muSGZD3r2aNdZl0i3LRwbJwDbJ9hgqXeNuWFefQ5Si1SoVJ/S+gDVJC+dFpC1KZ+Pdb
         M5UTjNB4DjLiFpKh8XQEDHhgObTfGxUTYzg/TYTEAxwVTxcYv+a3a0NyKPz8yMXtZn83
         Yt2g==
X-Gm-Message-State: AOAM532J5TxBC27zVYg9VcCe7ILSRDAEESut2umAkYjmOY4d+17nCIUg
        h/f4Un5JwAn3d7t5tV3sr0zMUEd5rRXnFVQnihTUAAH33lsVi0oBYyy9ad6AYHzRAXq9GcvWdkF
        Sz7y4//jVyaX2nFoqOFSW6/sG2mcd7W/Zlk9wsmAPmw==
X-Received: by 2002:a17:906:58d1:: with SMTP id e17mr19211173ejs.383.1628505606570;
        Mon, 09 Aug 2021 03:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwNBxDVyqZJE/20HBUWBb/vMu6ZRyYBzmBGhNHn0UTFRQjlV7SS2wC1vaJWHqvsUUWRYmyTg==
X-Received: by 2002:a17:906:58d1:: with SMTP id e17mr19211154ejs.383.1628505606444;
        Mon, 09 Aug 2021 03:40:06 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id dg24sm1314968edb.6.2021.08.09.03.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 03:40:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] arm64: dts: exynos: correct GIC CPU interfaces address range on Exynos7
Date:   Mon,  9 Aug 2021 12:38:13 +0200
Message-Id: <162850548977.33781.16424242900051733609.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805072110.4730-1-krzysztof.kozlowski@canonical.com>
References: <20210805072110.4730-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 09:21:10 +0200, Krzysztof Kozlowski wrote:
> The GIC-400 CPU interfaces address range is defined as 0x2000-0x3FFF (by
> ARM).

Applied, thanks!

[1/1] arm64: dts: exynos: correct GIC CPU interfaces address range on Exynos7
      commit: 01c72cad790cb6cd3ccbe4c1402b6cb6c6bbffd0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
