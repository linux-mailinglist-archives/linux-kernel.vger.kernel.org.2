Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1424C3314E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCHRaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhCHRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:30:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C74C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:30:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 30so634676ple.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pPr4TEZg8eRFsyyC0gyS8i3k7JNesoOp96Z0bqlYwW8=;
        b=AIgOCaFbfqm0PaTD5lY7ZMlRGv3BK5ulfABakddZh+yraj0Z3osw9OBnVEveESDti/
         5veeMZojLMgcVELHBcHwhDsRxyGdFr/04Qk3eAIZSY/J6G36AFtpcbGeE+hmXx50va3j
         QUQFfh8+8v7XhuVYcx3WW1/d1WX9dHJGebyEWf+aUDHVLEhnU1Bv60Ri5FEF/nKOyRct
         X2eZWLlyF+LuN3IRcDG0TJIagjA+l8aBnC0BaOM4JX8I+XF9vm6TYacx8HQNc0/X2ECs
         hngsoTdA6ZeJYgjE8GaM+6cXJh0qxbfNJmY9ynovnXORcaJ2SpusQTqy8fNMgvwVkpM6
         DuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pPr4TEZg8eRFsyyC0gyS8i3k7JNesoOp96Z0bqlYwW8=;
        b=EEGGDE8FeHYV1P3UCUiZNIU9Q4xK2Zvi+4wnI8UT045XD8ehu6ifKJ6tQEjqx7emXu
         mMsPSjUd193dZMqqVZOlZOKVe2wBD1HmgunRdAqOTwRTAWjtxqoCbOVkQ5tOoQANRI6o
         o97uyVIZukx1FnpbRHkMj4tq6H67zRp2qlPIkoqTXXk7RuCOrjaF1Q/HXwLnHJL9i+pD
         +Kwl6HRUXzWiVPUYt4eNkPm42lvjHB6X2ZhXkRv1Njr94C0YvOVzWLW6cgpRYAJolhjD
         usDKo24us/dECnYnSCQL0bvlYmlT7xoK9DDbaOnSRl9ZVJgiI0WrvjCszG9+tEitaU3V
         bwKA==
X-Gm-Message-State: AOAM532eIq0i2QsERPJ26qoe25iKiRdxTO/Kd2F7VKc92gPsFZNrsNEn
        JM1BIMBoiGWDfY1N8wxjJ5vCsg==
X-Google-Smtp-Source: ABdhPJxp5FeOMPK9+lFtnyew8n2+3htoOnuDitU9jh66jK7OhfS4uRrdaIbOVg97usDkp6nVL8TiGw==
X-Received: by 2002:a17:90b:120f:: with SMTP id gl15mr25787521pjb.77.1615224608902;
        Mon, 08 Mar 2021 09:30:08 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 35sm10489466pgm.64.2021.03.08.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:30:08 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: Re: [PATCH] drm: meson_drv add shutdown function
In-Reply-To: <20210302042202.3728113-1-art@khadas.com>
References: <20210302042202.3728113-1-art@khadas.com>
Date:   Mon, 08 Mar 2021 09:30:07 -0800
Message-ID: <7ho8ft365c.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Artem Lapkin <email2tema@gmail.com> writes:

> Problem: random stucks on reboot stage about 1/20 stuck/reboots
> // debug kernel log
> [    4.496660] reboot: kernel restart prepare CMD:(null)
> [    4.498114] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown begin
> [    4.503949] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown domain 0:VPU...
> ...STUCK...
>
> Solution: add shutdown function to meson_drm driver 
> // debug kernel log
> [    5.231896] reboot: kernel restart prepare CMD:(null)
> [    5.246135] [drm:meson_drv_shutdown]
> ...
> [    5.259271] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown begin
> [    5.274688] meson_ee_pwrc c883c000.system-controller:power-controller: shutdown domain 0:VPU...
> [    5.338331] reboot: Restarting system
> [    5.358293] psci: PSCI_0_2_FN_SYSTEM_RESET reboot_mode:0 cmd:(null)
> bl31 reboot reason: 0xd
> bl31 reboot reason: 0x0
> system cmd  1.
> ...REBOOT...
>
> Tested: on VIM1 VIM2 VIM3 VIM3L khadas sbcs - 1000+ successful reboots
> and Odroid boards, WeTek Play2 (GXBB)
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Artem Lapkin <art@khadas.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
