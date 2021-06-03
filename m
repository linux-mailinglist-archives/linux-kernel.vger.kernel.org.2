Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C383399F98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFCLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:14:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35192 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:14:54 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lolHh-0002uO-4N
        for linux-kernel@vger.kernel.org; Thu, 03 Jun 2021 11:13:09 +0000
Received: by mail-ed1-f69.google.com with SMTP id s18-20020a0564020372b029038febc2d475so3091344edw.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1eW48TF+kn97p/tCScb4CXIGoVstsbFd7+OIDFPx+g=;
        b=dk0zICNZd9/ZL0EnYlt+S4D8sDhq72Q/rfga1us1WNZAipWKquiIHfvS1Yh5/w6PSi
         L+IB7PG/pRUrnlDZQUGm8IWzbfGoJMfyoMOdRKMmEwLzbVAMRlsv5oKLeC8ncJSCU5rb
         NlziscLujjOpntF5BR827liWnmIoEcAQuZgfaWtUoRDfR3sciHG5GfhiPF51Pe+gzy2Z
         uJsJpthoM+tUMl+mZruiZN4DiZpotIblXJp8Rc6X+i8dPMd3LRkfMjGbMnKNpIZJnW6K
         3tUdJ7+uR3eamrVfGYJpPyABFDeS1k33DH9h94edhZ3/0zXwvf/hSldDW55fFpHB+/2e
         ApDA==
X-Gm-Message-State: AOAM532PfN/lq3oFNK7X5rDqv3Bv+gKwMWHRYf0HnwSLCpZ5Mgk3vnb5
        3RWz579lB7bhqCcNOEvsVB5WWAU2KY/y1q2+ipdxFAkb5wDj0DFMguxwOBI4hEFtVzgcFJ9bxw5
        gScrKd3jkyLJtB0y2gG2+pz2aI1WlhD9RRTfy5VaikQ==
X-Received: by 2002:a17:907:c06:: with SMTP id ga6mr38724706ejc.229.1622718788687;
        Thu, 03 Jun 2021 04:13:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5mMb6gokmBb+/YueV0BJ21Ub6XLQA6El3LZxhSK4RrTFrIhcEHKyBFfAusAlL4X9wMEQMOg==
X-Received: by 2002:a17:907:c06:: with SMTP id ga6mr38724701ejc.229.1622718788568;
        Thu, 03 Jun 2021 04:13:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id n18sm1401133ejx.41.2021.06.03.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:13:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/2] memory: renesas-rpc-if: correct whitespace
Date:   Thu,  3 Jun 2021 13:13:02 +0200
Message-Id: <162271877396.29314.2661816128507717037.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601160608.312446-1-krzysztof.kozlowski@canonical.com>
References: <20210601160608.312446-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 18:06:07 +0200, Krzysztof Kozlowski wrote:
> Use spaces instead of tabs as word separator.

Applied, thanks!

[1/2] memory: renesas-rpc-if: correct whitespace
      commit: 8c84a7335e71de1f045247eb035d55712e13222a
[2/2] MAINTAINERS: memory: cover also header file
      commit: 717cd731de8983483f6f41611b0d60aa3c267ff9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
