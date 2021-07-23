Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143553D42CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhGWVjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhGWVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:39:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E067C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j17-20020a17090aeb11b029017613554465so5583812pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/aIOHI86Md8+7aRLP6KogpBCvx6+c9epmyU3U5xlb4=;
        b=drtY9R/lcyztqSAm9e5BJBDsuyIEZNAw4hLUrjv9cTfDMfx5IFh7OrSlQy5MozZ09s
         7TaZuaxpvuZBsPPXRojRxMeR9/wAiKlOR7GdPPL93Ij2MpxkARzzChMFKBIQxlHYRxmP
         GHDB6v2f2ocKDqtkjdNMUJtzkSifapJumuzbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/aIOHI86Md8+7aRLP6KogpBCvx6+c9epmyU3U5xlb4=;
        b=b9W/tH+MnIHS9/fwOPhiM0nvx3VFlp0Gn4irtWSgQzuq2aUC0V58iaSjcUADBaWck0
         c32WWz0lIkjG5Larx2+J8AOCSDP0/EMa/AH82dd9uwMNuIQGPwD3NvjLR6jtnJhT5jJp
         TYKGM9TaSw/VmFi4/P3p2mz+S1xyd2Q9S8IOwv2KL+luTFl31MfpcdInVOg+s/SCXrRh
         hoj5Q8USZueaBlBhADbEbyzc/QlwnarUR99XrzawxzZSV3+Np+/UQFNEAT7bS9qk6cFq
         SBxH6EgHW1aBGa7kvtyvBmCsWH5SsQIZsXroTikSJecweQHsY90Ts/IGjQTa1tPZsGHY
         D46w==
X-Gm-Message-State: AOAM532kKJXPFar09lmDMwaV2aXukgrLLvww1n2w/yJXMqz6N0E/EcUl
        Gqzt40U28yyBE86Z9ROtvhyh+A==
X-Google-Smtp-Source: ABdhPJxxNULsNhrwG19c1Nx2g4DrC1PCMP894UgkBDoQ+D3jvgZD0QrkLJXHnmIFeVvfSLvBCpJwvw==
X-Received: by 2002:a17:902:ab88:b029:12b:d2ee:c26f with SMTP id f8-20020a170902ab88b029012bd2eec26fmr2627086plr.38.1627078777847;
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h21sm1883548pfh.67.2021.07.23.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:19:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 0/3] lib/test_stackinit: Add assigned initializers
Date:   Fri, 23 Jul 2021 15:19:30 -0700
Message-Id: <20210723221933.3431999-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=609; h=from:subject; bh=DHN1AJsInnHOFrkW5ZzfccEROoE6nwehLp5ORzOE8hE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg+0BzuLziN9AOlXnW/3Ztg/LucdLyHqlgjAXuQRJN L0r/J2GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPtAcwAKCRCJcvTf3G3AJvtTD/ 0TjMl/42NgHK+OxQAvHpf/mSTqJz0WN6sQ/5C6N24iZ3u6ewuA9yLVsU8WsLDz2thue0NhvF+VvLw+ DVQlK3w+8kEP5aG7M+uVsfbgkf+WF5zypJP4FEBC29whN2h1bywM0b3Ewh5WlyrWeWjYslW5zKPgzx sTvNxbA0SWQL7gjTwHTD4Ky6PtSCuk93DJwe8hK1Aucr09fRrdWO/SDI0ya6Y5K93xRqui7HfPtOHu zQaACEyxvnnOWNCbYN4O6qtMrM/7/cCkMx0iRW73tjSRg3/d1P0gseoeiwhOkUCcmVh2hHK2kOPqIq ThA7h8Y5cYnXGjBFxIlb8c1PHgRIq/CdiNuhUlk/Ik6AMY41XfJxHjwM82A7LqytQ0cyfuTxycWzMX 3l/LLIcouRdyKgSpTOFsR6k6kOQQxih7t1FUrAy1ctfPnnslCjJSLR8PvyrSJq7DJaZUvD+2fXdIRa b3lyy7O1MQt4QT2qcBKj3evhHjCJ3IlwSXbejalCdT65SEfUqxs3nR1yopKvPoABb/WpMEyDJX13tx d7eR7PEfogSBPpIijz/ZomF5QL7192g22GGPXjssAJD6WxmB9EYnqnXJD7AD6QP56bMWvBaaIs6tOu 3b0zf+IHKIgNWjXUlHbTqMtfVQ0Qr7iP/XhKHIBs28coregy3k2Hm8+X7UBA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a series of changes to test_stackinit.ko to expand the tests and
provide a stand-alone build, in support of the recent work in GCC for
the -ftrivial-auto-var-init={zero,pattern} option[1].

Thanks,

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2021-July/575224.html

Kees Cook (3):
  lib/test_stackinit: Fix static initializer test
  lib/test_stackinit: Allow building stand-alone
  lib/test_stackinit: Add assigned initializers

 lib/test_stackinit.c | 252 +++++++++++++++++++++++++++++++------------
 1 file changed, 185 insertions(+), 67 deletions(-)

-- 
2.30.2

