Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C71458BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhKVJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:58:21 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47814
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239250AbhKVJ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:58:13 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E870940022
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637574905;
        bh=dB2Lntj22dWqXlkeKbseUbDWYiS3+mH3WlSs6SjDjBE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=RnE/7WyGVAX7kbU9n1EV9x3ugPhCHyflh+nqr7Tx4bYcVeM9SE0HhHwg1CgD8hwNA
         6t7KtGFu2ubbFBQhCRPpl+qnqdoDdk3E3+V4t4CmcA5ezZTMc/xhzZyO1bKQujpS8h
         DeqlA44uh59b9wi0C6l1PLn6FGySAmrrr1Y5q4i/ARMB7GWYOitcRWayO7aqPZAnHM
         akFUs40E0dQhE3HWvc2lgfUiqk6MhF5XJFZy+SJofNxT3Gg6tCfeF9tGl7fu/bFRoq
         UWPZOP99PiN8OYvDycT21oGFART5gAicrv0RY55qZrPFF7ozFvU1z/0Tnrce7jq0sQ
         xveOlvul5b8+Q==
Received: by mail-lf1-f72.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso11748575lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dB2Lntj22dWqXlkeKbseUbDWYiS3+mH3WlSs6SjDjBE=;
        b=w/3iS7MnFgHLvTEcFhSP3lDUN3IlCw8x5sWH9/vXxedcJeq7gEoBvONECyLg0wcZPy
         dO7u3l+VcVhIA0Xk7OQdfE8bf1S+BFz0rqOuze0Da4ce0EkMi1OqKVL26Pxyg7M5NEel
         PcLVbYh1GdhgtJG6l4tbIs4zAHazA8vN/UGYbLVDujpRNKTO/Zl5YIE3pUQ9C9JDniYW
         ce3khAY4faVS2z3Mi4kx4UVUES0VzyNrD6s2A6SB+08xfXWX2ScDjxvlO3GVXqmU17A0
         QvR1KOr8hLHgZWthPxKGGmSS+Z3KAFZWuNJWI+e290QPSvQSKPYtZP7OlyBnpUoYz6NF
         tD+g==
X-Gm-Message-State: AOAM531Pt7gtmvxEZxmfCD9siDHawgjqoS1HRD3NW7HLqILBPHy0jRf0
        iC4XjHJNOBNIuZXXdmDdrOHQErr7FIwRaU4/i0zILGbqAXdpTHu46PZdCubvsJwRak8mpGTai2f
        jfZRLRGNG+qfsJd30koKJqcXkTairtcAHsnXqq1MSrg==
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr56260148lfc.158.1637574905477;
        Mon, 22 Nov 2021 01:55:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9PPFmOJ68zZGjTnhCkl6/sftwHSX1Hhvq89gHSbgzkV+wW2bmqJXFR51GWBUQPfE4nV06Uw==
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr56260138lfc.158.1637574905329;
        Mon, 22 Nov 2021 01:55:05 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u22sm908676lff.118.2021.11.22.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:55:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: refactor MOIIO and IOFV macros
Date:   Mon, 22 Nov 2021 10:54:24 +0100
Message-Id: <163757486271.327364.12120289084289830321.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119110442.4946-1-wsa+renesas@sang-engineering.com>
References: <20211119110442.4946-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 12:04:42 +0100, Wolfram Sang wrote:
> Don't use _HIZ macros but also provide a val. This is more consistent
> with the other macros and, thus, easier to read. Also shorter.
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: refactor MOIIO and IOFV macros
      commit: 3542de6a5b159fac0e7ca84d77a57ea99125d6b1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
