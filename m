Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F043DD6F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhHBNYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:24:01 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:49818
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233686AbhHBNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:23:57 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 92FD23F23F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627910626;
        bh=PcYv7A5UtpI/HN8IQPlYCtcicRurm0AO4HjAfUXrPFg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=JQ0GHuP65vX9piz3MEAq0p3R6U46Vua9V/4LJX0J8Pojfuw6HrFuY3oHI938PWvHR
         82WoZm4nUsCTPaL2rfBYo4qSyhfe1d8rSvh+xlsSeB2xcqAhtUxoqDou42BCISf2+u
         JGLRI+mvNBIzwUGdfXWPDr9NWUZVFx0zD86FVK3ETZqWig6k7pt+Ka7dlkFSsPAXCj
         MaO0MsvKR74ZCDkBBJKQnsNLXRUFHcAMDyjJ7g8og3343ljk8BVn2hvfptI1XvQQ9c
         j3+qbuI5MBCQ3trgd9J4tiwKDfOip1kMsBQ5SngvK0SvRSrwDlhzvzXYYOhB3W/uBv
         Ly/3mclpBU13A==
Received: by mail-ed1-f70.google.com with SMTP id x1-20020a05640218c1b02903bc7f97f858so7094140edy.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 06:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcYv7A5UtpI/HN8IQPlYCtcicRurm0AO4HjAfUXrPFg=;
        b=MoAqIRexMbAuVwOxHoPEJqCIt5b0K6eBtcLEyFVXtamo9oi0wr2UNuYy8/js+OHu26
         j+CeYC7tOGc/koaqpLoRo1ZZxn4G1q93IuofVKGumblSoI6JTa1DWg9xqKaCaAxDVbHU
         dPwbZj4jRxd6e1qhCWpR5yczBrF4vtEQ704oyv6FxjeffI5t5/RYxS8C3lD5z0GM9YnV
         RRhxi0/NSbhtMpOPAV33VFb130ANeMyFb+RekbUIHLlwr+fKbdAMtecaKJgnNl5HjUGo
         caY2WZ1pjivSDBwgoBcesVw2GD8BjBvlCERKxZjkJA7TdjoFJF0V/BvvpXJIYWyH+OkY
         6qFw==
X-Gm-Message-State: AOAM530+2ATqIW6R+Tf2p7wiYGa5KXiwxqW1C4Lw3BCzI4LcEJRVw+Ya
        yrbT/EvbWTOVdEriLlKlLuJW/DkRlJ+h7uKXxBv2jlKA7MGnJbqRuJrqpsd6BVB0XgDrhEcDtTg
        HhYch5LWwgQ/0s1+MYmmfP2J57+KBdTARa3Txm+wYDg==
X-Received: by 2002:a17:906:3042:: with SMTP id d2mr15817502ejd.234.1627910626320;
        Mon, 02 Aug 2021 06:23:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrA4flDvX+BAKewMQjdgTQYWuHYej9xPjsM1AuxVjzU8xxeUklp6WM1diAO6OrzbRfygP/bA==
X-Received: by 2002:a17:906:3042:: with SMTP id d2mr15817484ejd.234.1627910626191;
        Mon, 02 Aug 2021 06:23:46 -0700 (PDT)
Received: from localhost.localdomain ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id gv7sm4648671ejc.5.2021.08.02.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 06:23:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] pinctrl: samsung: Fix pinctrl bank pin count
Date:   Mon,  2 Aug 2021 15:23:42 +0200
Message-Id: <162791061524.24470.4507251211900093020.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730192905.7173-1-semen.protsenko@linaro.org>
References: <20210730192905.7173-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 22:29:05 +0300, Sam Protsenko wrote:
> Commit 1abd18d1a51a ("pinctrl: samsung: Register pinctrl before GPIO")
> changes the order of GPIO and pinctrl registration: now pinctrl is
> registered before GPIO. That means gpio_chip->ngpio is not set when
> samsung_pinctrl_register() called, and one cannot rely on that value
> anymore. Use `pin_bank->nr_pins' instead of `pin_bank->gpio_chip.ngpio'
> to fix mentioned inconsistency.

Applied, thanks!

[1/1] pinctrl: samsung: Fix pinctrl bank pin count
      commit: 70115558ab02fe8d28a6634350b3491a542aaa02

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
