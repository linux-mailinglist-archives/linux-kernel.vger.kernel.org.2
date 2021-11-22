Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E85458BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhKVJ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:58:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47800
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239240AbhKVJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:58:11 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E1F14001C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637574904;
        bh=fs5E2FG2KHZuy/jnILr8Z75A9OX4E3rCWqYR1/W3gLs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=nf5xnvLYBTloGbm/edVH8j+nGRRxtOfpnm0GlW/1LTRL1Hxam6NaN1wbWZ/acQAvv
         WqDe34ClBMnW33OaWEGMIHKArUF/o9uPl/6pGEybu2c0wofa6mWWvu7NBOrr16Z+V1
         ApKhJY3bmN8ZWvWpXca7VfCeuwhiUZ/nIUQmT7uhNIywZWF7OXumc7aqpna7Z+o5LO
         Oer/GRs/KThN5ujqrZf0/UNzIBU5GQrvkGw0oD9C/kI1qmOKU9QFNIofiGWJd4Iwft
         YKfQyX4YGIkxpH155aLFlBWP+SkWY1EdV4pprUqcBefC/EHsrbAVKSqiiNmk7eL5NM
         6AUCUNsL1HN+g==
Received: by mail-lf1-f69.google.com with SMTP id f15-20020a056512228f00b004037c0ab223so11835416lfu.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fs5E2FG2KHZuy/jnILr8Z75A9OX4E3rCWqYR1/W3gLs=;
        b=Cx4VdGoo8mgqAHeV4YM/yHZgwWT9FOFz7GzhpOcj8H3FRBgzlYdUshosLlZMh4aFIa
         kK56KiQKMJekW9M6nomSQeZp52w+0HoAL9zLsHMcVIGUnqppWcXb++77/Wk3TJu2oswm
         EJbZ5q2dh0p0MAhYbyxkM178jPZr01CMW3PrYQjSV2n04w/Ppt+njQFZwQSUWYAukWsP
         Gf6SFVrCa1QcRgR++YqO0M3ql6llNFe5+zpJk5kGTktYK8goxJR9lKhxeSZL1453zmd/
         5ZN9zvZIYYGcBwS74uJbepZ+C8+8tuWTxiqUxi0vlBjf7Q7eqUqJI8kG8JXox1swHxBo
         un7w==
X-Gm-Message-State: AOAM531XfKwEFL7/CtqfyUMEPM5Pq2w+muaaWO7F4tawXCDSRgkvXxAv
        gA5prWMwViDPEzy0K+yZ8QM+ZFmTtjU0buVu7tNCOBSEMKbaGsF2xM839np1x4Gw4a/Idwc5AgF
        3UOXg5wTAWktoAb7/eUJly2fXE31TOMZLGO0mYMGgYQ==
X-Received: by 2002:a05:6512:39c1:: with SMTP id k1mr55423470lfu.673.1637574903974;
        Mon, 22 Nov 2021 01:55:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKegfOMZYPJTvMiaHhh7Wg7XnbjMxgUhdR0EiKSXfjtZYJ1WUEdhXV0/tIdUFcXOg82hsMyA==
X-Received: by 2002:a05:6512:39c1:: with SMTP id k1mr55423455lfu.673.1637574903789;
        Mon, 22 Nov 2021 01:55:03 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u22sm908676lff.118.2021.11.22.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:55:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: renesas-rpc-if: avoid use of undocumented bits
Date:   Mon, 22 Nov 2021 10:54:23 +0100
Message-Id: <163757486271.327364.12463737786171898002.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117093710.14430-1-wsa+renesas@sang-engineering.com>
References: <20211117093710.14430-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 10:37:10 +0100, Wolfram Sang wrote:
> Instead of writing fixed values with undocumented bits which happen to
> be set on some SoCs, better switch to read-modify-write operations
> changing only bits which are documented. This is way more future-proof
> as we don't know yet how these bits may be on upcoming SoCs.
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: avoid use of undocumented bits
      commit: 57ea9daad51f7707f61a602a743decf10cf9fea9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
