Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EC4505E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhKONsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:48:38 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48568
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236501AbhKONo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:44:29 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 404C33F19F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636983693;
        bh=W9TxYBi8xwenWIBn6BQqnXfpAh7fA6t6YIh8inQiH2M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Vo/Jzai1uJnI/evB6hfGuxeuJc1oT+IuxlxirLufoQQ/7hXLZk0E6Z4TDmopkVwSH
         Oqkqqi+U0DghAJ9VTw5Q1VAXhL7qvV/yAxkSbjKf3h5LIHe0H2rzGeuLAmtxPEnMx5
         stMa8V4yPpWkbs796bzYPFzJuB62JX93ppEdbKu/kT2XlYlir0q+pPf16bAQxIHbzu
         zGBrze97+3b++acZZRzZF49rimtmMPQYPP8Vrejpc6s74iaKUz0UNmEEu2vxz1fPEj
         W1IJPQ9ahxUg9tgErjlgJH+qNxrQzk/Y70N+LagOzwPi+zw/3b/8NQvZC4CXtIJx5U
         90u24Pu63v5dA==
Received: by mail-lf1-f70.google.com with SMTP id z12-20020a0565120c0c00b004037427efb7so6733926lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9TxYBi8xwenWIBn6BQqnXfpAh7fA6t6YIh8inQiH2M=;
        b=htXkHGIWhXzaqIzkeexyETuN3F+NiRf6GtDzv69ff/CwCm/AxZfx/wDA32gOolzBDX
         +o5xQL7Cu7pxEPcBjHFWHZr9Yib8TUqrovFbOM9ECbHogzELN0TfUlGuvASp5sJW1BdQ
         4MuSg+Zm3kybCtrXJ1YvXxhlJcipmpNY80J+TyQp3m+qoLEpXEnN5+ombj4gz+D04RaD
         IRWoMuIgnLbcUdzhxj9mepzgoOYhm670dzUdAIO5VcnPFms7xVeLYVY3p3EvYnvyIKyw
         GvL7UoIbVntu0wjgcmfFaRhn2v9szA+CM1iDCtYul7eCMMun9gFvFf2Vz9jBIkAvqNbV
         fv2A==
X-Gm-Message-State: AOAM533rUv1y3cim5fywHk7k69nu7pvtM8NK2HoSvOfxOF1w4Pi+dZeH
        hwIodnAApZyzJs6GHEk9JDr3tdos+QnbAjOvvQ3QpzFwoLFqRQ3MgpSSJLa3tHpl1+ZEgg88L4b
        PPkLqSNQ7F4ibz43CKrrYXR0h+ECeCTZm0kzkLLhi5A==
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr29162854lfu.59.1636983692700;
        Mon, 15 Nov 2021 05:41:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrPrLBQAmwLdJ8XBy0kTXbK9lXu2tr3L4nIiQC0WlfOZzt6acqyS+eR+YwzMYf2vnWA0+3Jw==
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr29162838lfu.59.1636983692545;
        Mon, 15 Nov 2021 05:41:32 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id i3sm1421786lfu.156.2021.11.15.05.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 05:41:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] samsung: exynos-chipid: add Exynos7885 SoC support
Date:   Mon, 15 Nov 2021 14:41:27 +0100
Message-Id: <163698368315.132512.12680181156505233960.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211101004853.55810-1-virag.david003@gmail.com>
References: <20211101004853.55810-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 01:48:53 +0100, David Virag wrote:
> Exynos 7885 has product id "0xE7885000". Add this id to the ids with
> the name.
> 
> 

Applied, thanks!

[1/1] samsung: exynos-chipid: add Exynos7885 SoC support
      commit: 214f78060713fe13e3ba3701dff51e46d9576a9c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
