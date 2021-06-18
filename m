Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FA3AD337
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFRT7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:59:48 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3475BC061574;
        Fri, 18 Jun 2021 12:57:39 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id f5so4169156qvu.8;
        Fri, 18 Jun 2021 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7EJEdD4t44D/JXomia6XzLDMkDQTa0QGymZbz46VVU=;
        b=iRFBGqOhtmYr2gGcozlyLfVZbxJpNLg5N2U+3Xj6O7liQWVYnfyPCGR/nNGUTy9/th
         K5jOnP/qtO9QsIC0PhmucEFXrUySBo+TR4ppLIZZJinOLF7Yg6L0lruM/pFEVp4y1aA2
         7igA+rJu4KkQlSy8f/P3D/8SYxloP4DPHpLwHSoZ4auiz+++P7EiWr691hfhg9J7DW/t
         TTJ8t+iKxfrFO4uCUMPcpFEWTASYzgSN8XHif1TZ8mpnTM5TRqzwsqMwQGLrC2FZue98
         I07gpIevRgvarpGUKQD/llNN8eHi0BZpYs3yWR+foLat2bq2TYmcfSbWscjPqQZx7F+C
         5dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7EJEdD4t44D/JXomia6XzLDMkDQTa0QGymZbz46VVU=;
        b=Luy+x6sRe+C6DU25odIcGgofB9FRQa5nCG6wHQy6lRoO34LfJcBTYX+RkNv9nYVEEQ
         Prgx9knbAaqMAihFQAwhsjLSGDRiEeMV+2JTqCDu0EaNhLV3JtUAWGpHU7WAeJ68IVff
         Ug1zP+6SUWcn1W2f8D9qPt6IonVPyv86JhmSWD6/Wgf48OVipkZAVjUiZUQHJaNO8rYO
         yelLKoi4VsdPvnbQ7clGKSYbZxMX7nXutsB0pnx3Dxpj9bpHQVbyjW9SUV6kMEtN7k+8
         1DjYXRP7SF6Ruh6oFculNJrWS2MilV73s7CvrXr155huqoHJIkuRRhYzgvCWiRz60X6F
         lKBw==
X-Gm-Message-State: AOAM531fBgdS+8kKCfFIHChFL5lZPslgMLI70/vatiyNKJPM7kKQuhY8
        0i+LLgeWwZXJHAdm5dtQ+/U=
X-Google-Smtp-Source: ABdhPJyIUyQDxz2UY0b7qp2wXD/+ssfkJ79/j/7N/t8FSsiZad6mriv6DGGePeCP5WLb8DKxfk+8aA==
X-Received: by 2002:ad4:5042:: with SMTP id m2mr7417541qvq.29.1624046257839;
        Fri, 18 Jun 2021 12:57:37 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id z6sm4628404qke.24.2021.06.18.12.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:57:37 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Klimov <aklimov@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/3] for_each_*_bit: move to find.h and reconsider
Date:   Fri, 18 Jun 2021 12:57:32 -0700
Message-Id: <20210618195735.55933-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_bit() macro family uses find_bit() functions, so it's better
to have for_each_bit() and find_bit() functions in the same header. 

This series puts for_each_bit() to a proper place and optimizes its
usage over the kernel.

The series is based on this:
https://lore.kernel.org/linux-arch/20210612123639.329047-1-yury.norov@gmail.com/

The full series can be found here:
https://github.com/norov/linux/commits/bm-final

Yury Norov (3):
  include/linux: move for_each_bit() macros from bitops.h to find.h
  find: micro-optimize for_each_{set,clear}_bit()
  Replace for_each_*_bit_from() with for_each_*_bit() where appropriate

 arch/x86/kernel/apic/vector.c         |  4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  4 ++--
 drivers/hwmon/ltc2992.c               |  3 +--
 include/linux/bitops.h                | 34 ---------------------------
 include/linux/find.h                  | 34 +++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 40 deletions(-)

-- 
2.30.2

