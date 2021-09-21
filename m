Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0CD41309A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 11:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhIUJNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 05:13:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37132 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhIUJNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:13:53 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSbp5-0001bM-FU; Tue, 21 Sep 2021 11:12:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Arnd Bergmann <arnd@arndb.de>, hjc@rock-chips.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, kernel-team@android.com,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, airlied@linux.ie,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        daniel@ffwll.ch
Subject: Re: [PATCH v2] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
Date:   Tue, 21 Sep 2021 11:12:17 +0200
Message-Id: <163221552907.1876143.10392170678364292267.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210911034317.1719619-1-palmer@dabbelt.com>
References: <20210911034317.1719619-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 20:43:18 -0700, Palmer Dabbelt wrote:
> cdn_dp_resume is only used under PM_SLEEP, and now that it's static an
> unused function warning is triggered undner !PM_SLEEP.  This marks the
> function as possibly unused, to avoid triggering compiler warnings.

Applied, thanks!

[1/1] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
      commit: f7c57a4566115657c16fd6603b6ef8a21bae5194

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
