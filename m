Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBB3D4144
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 22:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGWTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:25:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D3C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 13:05:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l19so3876845pjz.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MokFZ3XwIYDGK3TvGYmwLd67Cho0JHFpBfKcy8kgS/E=;
        b=TALKbKTXJQE0MAbYnhH22NMWCcV22z/A4T6qDbn8kltVxqXbitgJo0VvXyQYc/16Uk
         WK0V/XKMQO9SUALpbkX3SKDGMCLkOMH5ZpWSoTTkNz2bcDSWueM1DL+R6D4MvyITIPzU
         tPzecDlxqdLqRTR4XtKWrdUZZOeWEIkZJYhww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MokFZ3XwIYDGK3TvGYmwLd67Cho0JHFpBfKcy8kgS/E=;
        b=ZAHRAoMNqptPa3xADUBhgTJQk2q043/a3XMbN/6QyMbw2XoJrJrjc0ry3bUo28X9aG
         +vcEJoTuD1JGwo5w4WyvKdclJSh/y8zP6UNL5sSFhP/6kF+qRyKoheYGD69gvkBYgUyf
         5fAwr2qzcI/6KWggLu8kd2q3wqWM3FTNKs2qf7eI+oQv+kJbl5WbPqdtpTFYdimxOusy
         Tm+lCIAPB+pMwrtIINrIqlFs4l+/yr8WNtLSekUWobLIQIU03DhKkVgDuz2AM4fXp0s9
         i42IJHs+S9UvIECpe7JpZHGAxKXueqxJtfm2PnwnRVWAHGbiiDnB66K9Oejuo7S7pQ1i
         dbeQ==
X-Gm-Message-State: AOAM530fx1+OTV5BUCs9/6DUQ3PlbAmAZsx8m6NmbnL5rNMOtL/biF+S
        xDNN2iVcwGUgFxjsxZCvL0II6A==
X-Google-Smtp-Source: ABdhPJwBPM5Ao2tmULZCEuJI7hT8hHtxHKagOdVZef1ACH97RkCuCRyo3h+6iAoMjEdIrpQWjRmgRQ==
X-Received: by 2002:a17:90b:d8f:: with SMTP id bg15mr14882797pjb.152.1627070746241;
        Fri, 23 Jul 2021 13:05:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ft7sm6905670pjb.32.2021.07.23.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 13:05:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] deprecated.rst: Include details on "no_hash_pointers"
Date:   Fri, 23 Jul 2021 13:05:26 -0700
Message-Id: <20210723200526.3424128-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; h=from:subject; bh=XsksPCw1yA95O9ZzuyNBJnhijqK4KBD6Xvu0NRJs8Rk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBg+yEF8aLpeO+OrMt/e+urZLaswp4MJP/oyEPMNu6H KBseMGmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYPshBQAKCRCJcvTf3G3AJv3yD/ 0W0YGQwo/0I524Hb+oMrryi0N03lRdhbtLVmcxBCkLUobk/GcXkaoZTStFnvDt/dv4DGd802jWe7s6 yOMiLkJq9wBXgS9FctDKOfHq3oEjxAvkLYeHzWGf2gLOxwWwCat4kskiUIL9+yzk+vBu5Axk/WgunA p5hbyuY8CJ5EuJttn+LfoTBGCIOamoWVu3d3lDvjIcvnOh6WUCLkfgVMpPs/OmvYc11+G12hRgNpyR Mv3Ee149yZhz7T2fN5Ta0GMpaRcP2VnKioOkW4Mgzfz9ANZUM5vwVuqcPqXkUrrJGDIIN5kkDcoHn9 sceZ3tPlXgrNv1cHoXIgg1Y1UVQBV0HFAJI/Rc++e9NsOi3oGbbElUQssLWdK4Z3yWTV1pqW+v4j0Y c6hqqPGvjD7tqFdm4Vm5ECyWJyWRqHUUydIpAZmQGoQP6JGs2qdvWRZdLQfryAsRQuj5yYSTEhCNtt evlRjzb3o+9QVbJMhMHUbX839OYJRcxpcioDcgc3oFYCcXJKW240X1cB+DhAkZ9TrgC6WgtgWs8ZuP zyAMb7qCCWQgNkqrbdQlg3aYRXb9KvOZwvn7v7VHmD0XAKyEdFvLacSk+5Mp0Jt+pGboXx3JcthrIo Fa3k9jfQse8gXI0XcFHao61ukDD/ZsblgfaBbsKqw6gte2qmeWe1DxJVsdbw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus decided a debug toggle for %p was tolerable, so update the
%p deprecation documentation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 9d83b8db8874..8ced754a5a0f 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -164,7 +164,9 @@ Paraphrasing Linus's current `guidance <https://lore.kernel.org/lkml/CA+55aFwQEd
   up to Linus's scrutiny, maybe you can use "%px", along with making sure
   you have sensible permissions.
 
-And finally, know that a toggle for "%p" hashing will `not be accepted <https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/>`_.
+If you are debugging something where "%p" hashing is causing problems,
+you can temporarily boot with the debug flag "`no_hash_pointers
+<https://git.kernel.org/linus/5ead723a20e0447bc7db33dc3070b420e5f80aa6>`_".
 
 Variable Length Arrays (VLAs)
 -----------------------------
-- 
2.30.2

