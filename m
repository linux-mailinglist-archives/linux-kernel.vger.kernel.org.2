Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7F41AD14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbhI1Khh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:37:37 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52962
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240198AbhI1Khg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:37:36 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1B5A4019A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632825352;
        bh=vwh4L8wl0Atk7OWaqdEfWrpqoXlXPwSgxhdmp4yIVrM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=MSy4olT0Yc1R3LRRk5YnBt+E4STaYATRppEAO2Wdp8cZt6F175sXVTvJaBsICylwd
         uaEm3FBM12Z4QhWDJCcB2zZJFjEg0FYqG3QFLPc59ORVqm1B/GFVOqhdcRQrbnM9mV
         mxU4+CbMUY4vf4Fe5qbNUBr7/YoxKZFHYgpDyrbjLv4QJMRfZy5r4WqRVQMBJwY7ij
         s2TZUs6VyWV8oBI8D3htCHsX1n8x54E1EpeNlQx0ht5MRW48e8cyF+a0txDOws3zJd
         4gEY05zw7iZikSpJMGhdMyUw3tLJW68b67ScuFF9FUqq2LHY7rRz0ins+y8JlHQk8/
         L7lCOylvKpScg==
Received: by mail-lf1-f69.google.com with SMTP id r193-20020a19c1ca000000b003fc8f43caa6so18884206lff.17
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwh4L8wl0Atk7OWaqdEfWrpqoXlXPwSgxhdmp4yIVrM=;
        b=LnVS7G6SX3p4GOup34zQayVriN2XwczCwjiV3GRNs87p2C81BVur4aM2Dtlp9vcVWw
         QTHL2bEKTGPtXIrOpK6bo4bu8xJZScqGvGHE2XEydC35UHvmqhADPvn1o/eEy972hSD4
         uVQ7xmumJseb1ppYupqyZUdFWj/KLoHSRn+nBx/kYsYrSVZMoAD6xLv08FiIAI3Zl74/
         3wr08OxEtFsLEWsyEN7D+hzJB80VoSHp9tMhnqqQZjnzFvC0QN+w+22b2dggR6ZVryWH
         /ANkNJi7pcgls0fXJR9Q5KfS34+Bshfph3j1ujFh5rLqTXLJl+baeRrsvNy2HzuxNpSm
         0PZA==
X-Gm-Message-State: AOAM533dT4XxPkpWpjNFiMmulME8bIND1tyESNblt2By+D9xuBuz8Ls3
        UhrCLYTNBVoF1odA+E0jzECwEaV5cwNqNkN65bpScBJiHlBbkpI4AKAfRMuyHDzbJtISKOK5ERn
        STKphtzF1WrxLFzCxt7N+HrDYDWZz6jpcqIfN6FReYA==
X-Received: by 2002:ac2:44cc:: with SMTP id d12mr4772620lfm.159.1632825351503;
        Tue, 28 Sep 2021 03:35:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5pWbXu9VcacFdGydvg59uP9vl2Ft6kL6nDDpPttAa56jiKcNPkgXxXYFf2//tC3A9u0B8fg==
X-Received: by 2002:ac2:44cc:: with SMTP id d12mr4772607lfm.159.1632825351319;
        Tue, 28 Sep 2021 03:35:51 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l6sm1809230lfp.143.2021.09.28.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:35:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: Avoid unaligned bus access for HyperFlash
Date:   Tue, 28 Sep 2021 12:35:47 +0200
Message-Id: <163282533892.34438.5017645199634864081.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922184830.29147-1-andrew_gabbasov@mentor.com>
References: <20210922184830.29147-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 13:48:30 -0500, Andrew Gabbasov wrote:
> HyperFlash devices in Renesas SoCs use 2-bytes addressing, according
> to HW manual paragraph 62.3.3 (which officially describes Serial Flash
> access, but seems to be applicable to HyperFlash too). And 1-byte bus
> read operations to 2-bytes unaligned addresses in external address space
> read mode work incorrectly (returns the other byte from the same word).
> 
> Function memcpy_fromio(), used by the driver to read data from the bus,
> in ARM64 architecture (to which Renesas cores belong) uses 8-bytes
> bus accesses for appropriate aligned addresses, and 1-bytes accesses
> for other addresses. This results in incorrect data read from HyperFlash
> in unaligned cases.
> 
> [...]

Applied, thanks!

[1/1] memory: renesas-rpc-if: Avoid unaligned bus access for HyperFlash
      commit: 1869023e24c0de73a160a424dac4621cefd628ae

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
