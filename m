Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC14741BB06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhI1XaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhI1XaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:30:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A293C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:28:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so702565pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jylB27FUomRkCrHM+xh4mTWUasmip1Xiajoin8oWp3E=;
        b=NWI1NX9eXWWmTOdjr4JvOxg5hBa2b6biLsvMuVhM9/LH54tjnkMLfoIOpUJobF2WX0
         Mfq+CIrRzMeHKoAxmY7NEESaIiIklXuc6ljmL29v6ly8KTVfV8ZzfkaDuzzF0dukruGe
         noZM/vXdYq+7irLpNxPr38xcxvga0XwzXGgn1JLDgq1twB1HgQtiUp9x0vAY367S6kgi
         eXTWGckzJg3rWOQ/Qr62TmNqE9h9A+CCb81FbVVJbhGbboYJGduvXwuI8ACdVg30IF4R
         BL6UG0McdNzd293D++LAyudbR3rLQdlBl7bVn0eqf6SXIpwB8JF9+E0MBjW1bvBAJhUr
         ideQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jylB27FUomRkCrHM+xh4mTWUasmip1Xiajoin8oWp3E=;
        b=LSOs8dX4adHDRBWLHtD1wH9i9qX5Rf7aGyNR/rXzvOj0C8dBLLJahGjw1074OTJht1
         aXCmjP/jHfPJA4coQVVIIH23ANyA1u6q+2eYG6pmaG6rU+VnjxXyOh2pmbAZ3MTI/QN/
         6oqc5gnez2rfdif7B/ffB+X3tKJL6Gn4bI3dRwUlPlLXWJnhpHjfqedtmDWydpv8KDnv
         WwBx8DiuJPvQ1o/enbXow2eUMmoG5JWh7tJYw6Ewn+7bgBI2qWeE6pRCURTe+yvM81OZ
         GiM/K3k0umiVIPX732TU9w6nL5du6dQfOI+Zzbo6+FCxv+r3qBLYTqShN0tC9jSO9aoL
         Rf/A==
X-Gm-Message-State: AOAM530t7np6cLFIkv1DGgws4AKO5xpUeYmeLCY+xL/al55ZAhH3t0vY
        f1Lkickl2UKpQgJi7Ep4FTCiDg==
X-Google-Smtp-Source: ABdhPJx3CC/hEXextag5g33mpfB4YE/n0s44Oe9bHD5FM9ieQDbPdiWuDkY26XEkwA4jCTk7j7kb5g==
X-Received: by 2002:a63:334c:: with SMTP id z73mr7050802pgz.160.1632871720693;
        Tue, 28 Sep 2021 16:28:40 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id h15sm211829pfo.54.2021.09.28.16.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:28:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, maz@kernel.org,
        tglx@linutronix.de, jbrunet@baylibre.com
Cc:     lee.jones@linaro.org, saravanak@google.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: meson: remove MESON_IRQ_GPIO selection
In-Reply-To: <20210902134914.176986-3-narmstrong@baylibre.com>
References: <20210902134914.176986-1-narmstrong@baylibre.com>
 <20210902134914.176986-3-narmstrong@baylibre.com>
Date:   Tue, 28 Sep 2021 16:28:39 -0700
Message-ID: <7hmtnw9t5k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Selecting MESON_IRQ_GPIO forces it as built-in, but we may need to build it
> as a module, thus remove it here and let the "default ARCH_MESON" build as
> built-in by default with the option to switch it to module.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
