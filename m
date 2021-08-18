Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432683F0A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhHRRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhHRRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:30:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA7C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:30:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso5589021pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0BrIgVGw/jCYpqJ3H+F4qUtbfNvuOB1X91iZBuDC9A=;
        b=ad89yAgXBvfkM7spD8Sv7sX2M8JXooM0nNTjjnjpxEWjGLZ+/x8DRYVlawSP2AWynx
         xa/ddOs+k/3LkmkcG9sIwm7LhTury8Re7Z9xDaoOGlQUQUj2N8Y+LAGzciS1No5rLekQ
         yQ0ubA7IhdJSx6stObIDwrv/dHQMmUU6v+vLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0BrIgVGw/jCYpqJ3H+F4qUtbfNvuOB1X91iZBuDC9A=;
        b=BPcnTYYNhwN9ZK14UgnpZMsGlXKmW7iydKKBxuUMgqK5aHqKbBz5tD/SkuAgiTIuIV
         ICYuL87P8H91GLwpHsyO1tsx/ZZiOkE2CezJ6sGRslu9XGAl154CKYrKfPxBLK9mJRhE
         HrXC1SqWjoWtAxDnJrkLFTQSvpe1Fl64uC3FmLCS6pAyjkDwjGhVD+w0Zg3GryvDwkQq
         qi/cUFa3+QZ9DuSFamejyqzG5g25vRZUTnKeLIcsixHsYImAMfhx+okZXPdOCf535XxU
         i5KpLNJ3Uzp9XXSR465U6EZX5+D1MPAijBbKVmfuFm5cMCiIWJCAGmXx/IOBp2xRvkF5
         KtUg==
X-Gm-Message-State: AOAM5315QjnYziE5uQoZOPXbB4jnougMPNGd0sI2wFblZDpZET8hgpen
        LCwhg1ouLMU3p49WqY4S44wbEA==
X-Google-Smtp-Source: ABdhPJyXScRZGfEaKhr+9LvN0h45ICPwhBofxuzETltNHug2/+3Ps8ajNcaW7BhsAWvF5GeBwrOePg==
X-Received: by 2002:a17:903:2446:b0:12d:b732:4656 with SMTP id l6-20020a170903244600b0012db7324656mr8294673pls.25.1629307822401;
        Wed, 18 Aug 2021 10:30:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm384041pfn.173.2021.08.18.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:30:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] USB: EHCI: Add register array bounds to HCS ports
Date:   Wed, 18 Aug 2021 10:30:16 -0700
Message-Id: <20210818173018.2259231-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; h=from:subject; bh=9B2VM9Lpb8IVZx7MEMfRI517cmacE2jksMMxurJKH7g=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUOpZQ9I4PVphZK8YzvgrpCcsAqL8NiVWEHUpjTW BCvM8SiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1DqQAKCRCJcvTf3G3AJhfsEA CqZbMM71xrQTnirsBMBBDWAT7q9ChVvUxdhSuKtWqaWLyVrbKhwSSG7P+pQJCl1R42zdQdINXf+FLX S5WL/0vKEcTaaXAb658WmwA++UeYw8ka+PsyuLlOUS4hAeQPwQNMWseqy3rd5Y77IEQIYg9a1exUbU DjKhaTcUZWFLfWlPqb/YMrMdQFHcTo0ya61NXAROnWNcyOmvbH0ba+Gtfm3PsLd9tcVTV+AdjxGOs6 i7FWbAVifR9BYbCXPQWWUYlLy6QzaEiHBrj/ID8adu9hQI83t/PrUQy4t1uCt7fGe0TzZIFpjtyZ0r 6/CgfODGYatxkVKgag3A6wMkkaMhPMmhfGMq2sLIMqJRksUBpERGYYyH9P+jt6K+CVj+4M4dNyapT0 IZPnZ+R+O31jF6ubOXxdSveEzG7j0K4efjB6T22qjiptVgrVBhXKhFTDGxb/fPZpHMogpBG10Ystzw SDgCC9D9or6E9XJqgHhoLnUw+6KlYXCflgmBeRIzASlvIhHw+B4E4/177DxZEo2WCHT7EkqlW+6KfP Ih1tgAQ1V74j3tJBdFq3V7mi4sg8auW3mU3LqKlWKeA1htCuK1Tc2N+Yjxxep3e/H+j9r06IQGjyzF x8TYHBctspZt9seKEPTzza0t2N5Jn1eD2Sjf3UGAmWu2mbkfT5mA5eozi+og==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is cleaning up some of the remaining things to be able to apply
-Warray-bounds and -Wzero-length-bounds globally. Only after doing my
own version of the port_status patch did I find Arnd's earlier
patches, including for the weird Broadcom stuff[1].

No binary differences.

v2:
- use 0x80 as base for brcm registers (stern)
- switch HCS_N_PORTS_MAX to decimal (stern)
- update various comments (stern)
v1: https://lore.kernel.org/lkml/20210818043035.1308062-1-keescook@chromium.org

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20200527134320.869042-1-arnd@arndb.de/#t

Kees Cook (2):
  USB: EHCI: Add register array bounds to HCS ports
  USB: EHCI: Add alias for Broadcom INSNREG

 drivers/usb/host/ehci-brcm.c | 11 ++++-------
 include/linux/usb/ehci_def.h | 33 +++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.30.2

