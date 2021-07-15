Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5A3CA723
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhGOSwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:52:36 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54650
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239608AbhGOStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:49:47 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 442CE409FF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626374812;
        bh=fPdYklx7VtItYhkY/OMzFdpH0tNK7E+zuo6sStsoYAw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=dXnFa+MDY4cmTK1NjuY8Yn++9k6TthsndfdXw0Zk2KTunJHiJG68K8/+4/9F+KBC/
         r4qsJCODehW5dUpqpdbFimIdg4Hk0CjkgZKX/WFZkljHxKYAxT0reSqsAlpyb87RZV
         5JEy4+R4utkD/+5sakixYmcGweylFiWpqeUZJCla54nP30Q8KgG+cUs2rYLGmY9dOz
         vB32EPWW/dffqZiOLmK0VB/gNRC7OxQl+Cnmmst8DPoc/krvzz0ruD6ynooaE8qUul
         Uo6acg+veIYyFC9SlFhU4YnNfEoRHS55dgjpLRsT1CP8iAFLba+6+Fo7tVYGj+HZTH
         AAOqC/PfRt80w==
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso3620203edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPdYklx7VtItYhkY/OMzFdpH0tNK7E+zuo6sStsoYAw=;
        b=QcjDPUyAk9/A+5N/vLsk6zLk4MkRJj29wCNfJKjcqwi+XQOX8lYbVSZbMNbhOcV9Hq
         soOBdBcqsMB7xa6t0RCjEEh5wiexXTIWe8ncxhgLGuFDc1b4jpj5B3OgR/AFgjqquax+
         IjnPlWViUeIeWEPGVDzs57tg1CX3ohThSdGuW6LoxPYgJoB/ErOLcA/BPzET1J2JmhGS
         dsBk/tcOoUdZXW9f521m+xgZjPePHaQ09YjxDrFY6dYY8+1/85D0SQpD5WBTqSY7YtVc
         g5kFMmyNd1UKUmPLuYoeXtUiTQYuCBF2aJ04FrWNs7MW5n3/F6mpLkJ5AqokbQ9EJ2k5
         o9BQ==
X-Gm-Message-State: AOAM532l5eVY562KEDIILiM/Cl9xKca2ER7dG6vmyg2lohcKGBd8w8tU
        ROFj3Amb4Oxk0yKigjAmJ+FO0DhQ4vag0a3SzMUJ9r85goolESrXCUIlC95rSSP/c6GJLqwz5cY
        Mxs/xHCC9x8P7/yqTXv/T+xbWsS1uFwchv4Go44R7yA==
X-Received: by 2002:a05:6402:291a:: with SMTP id ee26mr9053663edb.220.1626374811799;
        Thu, 15 Jul 2021 11:46:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDBFaU71T4EBsIVkf/T/sptn3NdcA7KPUP4mSyrdNw+iSXJ4imgC6n7oCA+D5ZI3prtBjuoA==
X-Received: by 2002:a05:6402:291a:: with SMTP id ee26mr9053654edb.220.1626374811702;
        Thu, 15 Jul 2021 11:46:51 -0700 (PDT)
Received: from kozik-lap.lan (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id i25sm2790842edv.29.2021.07.15.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:46:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>, robh+dt@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: exynos7: Add cpu cache information
Date:   Thu, 15 Jul 2021 20:46:47 +0200
Message-Id: <162637471053.9353.33889175866144667.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210622130551.67446-1-alim.akhtar@samsung.com>
References: <CGME20210622130203epcas5p48a3111fc6586b1bfe0bd3cb90f783ce0@epcas5p4.samsung.com> <20210622130551.67446-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 18:35:50 +0530, Alim Akhtar wrote:
> This patch adds cpu caches information to its dt
> nodes so that the same is available to userspace
> via sysfs.
> This SoC has 48/32 KB I/D cache for each cores
> and 2MB of L2 cache.

Applied, thanks!

[1/2] arm64: dts: exynos7: Add cpu cache information
      commit: 43e7b8b864cc5319f323dfedf633071a434410f7
[2/2] arm64: dts: exynos5433: Add cpu cache information
      commit: d5c65c4aa23c52226067d7882ba2ce2055c9315d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
