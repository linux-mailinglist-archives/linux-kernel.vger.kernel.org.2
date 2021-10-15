Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1542E9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhJOHWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:22:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55268
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234352AbhJOHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:22:27 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 57A943FFFC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634282420;
        bh=jPoFv7RX4zxC2hKTIcuot+gzhC8n3whHEgMFsK0pfdk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Wi+ogZTJZdaY6mcmc9KFST571qN0utFLT/x6sCqQvHPvSD2zYiZxMPJT6i3KZ/VN+
         bm3Z5P0NNa44HztOyfljZcKXoO2vX50BFIxdffYXGXaYrWcHloSEduTdVPYYqkpcfC
         dTALTqT5rZ49asYy8StpdblEccPmfUy8Nv09muTclbMVYZ/CER+QbLfFfkvIpPQroO
         Plr7z2V8pa5do6VpEW/icwAJwPfn8SdaPR1kjYiPvZsn1DGBCSFjn9eG8oBRTp/6Yr
         IzLjVcpPdp7jI0n9mAX+nbwnQUfw1Q8iW0a3lPq3CYcY5h04FCNOu3ovs/N+gicqEM
         2EknZ05J0Rfzg==
Received: by mail-lf1-f69.google.com with SMTP id x7-20020a056512130700b003fd1a7424a8so6008852lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPoFv7RX4zxC2hKTIcuot+gzhC8n3whHEgMFsK0pfdk=;
        b=kxut1VfKEFWQTwoCKM6PBRmfX3ZnThcefklEWJAfotK+1ieghhuXp/ejp4wgcmTgTP
         f1c93YtZaF5Y9MSH5ZT5MWJUcPnmrvO9bpPW/FQJNkdDw2B3pOldv+6uMjzfub7KWmN8
         n9Sdx/sqZ9qZv4hq0avd9pUotCuvvFXYvvMc7I7f/RBlPTkGWa+DR3mDXMhRXrWlvzpm
         OOZzk+mTwk0ZG9pGuC3bYlp3jQzsS1W94QqTxwDJJTclZnFl67NL/3MxPJz36981Wkul
         Ehez7ICMJe6sXXFhm2Fv+MNh7cxyu0dpozrBwVAJUQn4UU9PGyPZHXw9Mdq3O8AE6QuG
         DVcw==
X-Gm-Message-State: AOAM530CVaDqUo3LWQ+fpKJ2M1A3O1zgYGm6uUDq738NO7N8Eg94zp8w
        mi1uQdrGXR3bCfpPkOXsKe78uJy6gQ6KhmcLkTxfHlUes8n/dlIT/jtVyHUaFlFmkoK4cITANv4
        y4HIO3xhqfPGx89eHuvDm5a/SvM6ldeimK2wv9f6dRw==
X-Received: by 2002:ac2:5c06:: with SMTP id r6mr9962987lfp.103.1634282418724;
        Fri, 15 Oct 2021 00:20:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwVsjS33QPbqSHZteu5iA8nRklnWLz0E6WPJnIYimgt0bCA7/8aqX4UtJxAL/759Ranc5EOw==
X-Received: by 2002:ac2:5c06:: with SMTP id r6mr9962963lfp.103.1634282418487;
        Fri, 15 Oct 2021 00:20:18 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id 5sm428200lfy.156.2021.10.15.00.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 00:20:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/9] tegra20-emc: Identify memory chip by LPDDR configuration
Date:   Fri, 15 Oct 2021 09:20:13 +0200
Message-Id: <163428239295.5772.13742394976706710476.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006224659.21434-1-digetx@gmail.com>
References: <20211006224659.21434-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 01:46:50 +0300, Dmitry Osipenko wrote:
> Support memory chip identification by LPDDR2 configuration, which is
> needed by ASUS Transformer TF101 tablet device that doesn't store RAMCODE
> in Tegra's NVMEM.
> 
> Changelog:
> 
> v5: - Added new patch which adds vendor prefix for Elpida Inc.
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: Relocate DDR bindings
      (no commit info)
[2/9] dt-bindings: memory: lpddr2: Convert to schema
      commit: 8a3294b74ac621ab03ef88cb964c13089ffdf015
[3/9] dt-bindings: memory: lpddr2: Add revision-id properties
      commit: 3c1a1b4b191978559cae5c626da012ef897c1139
[4/9] dt-bindings: memory: lpddr2: Document Elpida B8132B2PB-6D-F
      commit: 624f42157b99d253e6a52a7f93123eb0dbe1b26c
[5/9] dt-bindings: Add vendor prefix for Elpida Memory
      commit: 8712faaf12106bc70fcaef2cb89f7958faddbe59
[7/9] dt-bindings: memory: tegra20: emc: Document new LPDDR2 sub-node
      commit: ab4dd82cf5f8dd1943acf9243058262bc33c5af6
[8/9] memory: Add LPDDR2-info helpers
      commit: 5c767f684651e74f81c4d6a363e3779af3a77cc0
[9/9] memory: tegra20-emc: Support matching timings by LPDDR2 configuration
      commit: 4964b3e5c9ad4ad85b44f826a12c008af826545c


(dts patch not applied)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
