Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118B841BB00
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbhI1X3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbhI1X3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:29:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83E7C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:27:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e7so729216pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UW/aPYuyLtT3YksmTjRLPV3v7TvHXeedKMA+JyjT1Xw=;
        b=pW7FKmKyda+D6uWULpgvmJlmtp9o5p4CJ8lEcmHO+P3STFdOB6g5wlE4M0p4zxKJfM
         YmBXxjkjjgO65dlaY5oF+FP/iEC3fZJUjsP/LPLqF5wxMxMiyqnRe1kRbg6zWBnjC0Pp
         3cEh3WJYIsr9AKZv8I9P8Ohp7nOxkZl6iDHmGq4LhH3DenADBOguLUMeeS4f6tAKXmpd
         OobFkxwpJrYSz6726NQo+UV3QuGIwW6WB7AXHNT1J+OrrOh0Q2T8gJVu1oxGjON+Zb0Y
         UgoQUZ/lP4Vl5vutCUp70NbfBXWib2lVLwZe3E5M3JEyBhsSzIG44qUKkbw/N9zO03SK
         c9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UW/aPYuyLtT3YksmTjRLPV3v7TvHXeedKMA+JyjT1Xw=;
        b=Wi7oQLEIUzh8efhb2U+A82/+Bi/oFK+G+/1cfsvS11jfBmeOnCWB0bXevPzYsX+eSG
         wr8ZiFOUerjp809Pxt7QaTER2FZ7lSBk1Y1PmWudPWFdNsMj2Z77kPZt/SPOWKKu8z4C
         v56CWwTNuQVaev2icQlZMJ/nE1/+R2SnBcPxrrMlG2m+aQokimDEj3R0NgEuZ0+xA1M7
         3Mw3LvJ0VpKHVWFK+hFJiq66kX7Hyy5nUgPBRc4jrf5yjVn3lEFdf4VV+heuR/re15mL
         LzA96VmkM1Np6qpsGKD8b1v0SbkX5aKs69kKrEBfG8Ee2TW3hf+1SqLnQIP5VVJRO1Lw
         QSDA==
X-Gm-Message-State: AOAM531x6+KYa3px1pOYya0gsSyVdYzvq3oPlmXLNORIhvSn/bqq2qyc
        aXFRc1PUiIVSHv2jRNwxad8BR3rSXBtGzSMZ
X-Google-Smtp-Source: ABdhPJxiY3bgggHm3kAeKAzoIrjUenbaCmREsqN+Y/N61Nicv8zxRfW7J3iZdh/U0pFnlJfW6ekXog==
X-Received: by 2002:a63:d250:: with SMTP id t16mr6913292pgi.95.1632871671291;
        Tue, 28 Sep 2021 16:27:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id c9sm228016pgq.58.2021.09.28.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:27:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, maz@kernel.org,
        tglx@linutronix.de, jbrunet@baylibre.com
Cc:     lee.jones@linaro.org, saravanak@google.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build
 as a module
In-Reply-To: <20210902134914.176986-2-narmstrong@baylibre.com>
References: <20210902134914.176986-1-narmstrong@baylibre.com>
 <20210902134914.176986-2-narmstrong@baylibre.com>
Date:   Tue, 28 Sep 2021 16:27:50 -0700
Message-ID: <7hpmss9t6x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the Amlogic GPIO IRQ controller as a module
> by switching it to a platform driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
