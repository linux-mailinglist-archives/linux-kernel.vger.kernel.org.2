Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC99536B8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhDZSdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbhDZSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:33:13 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C11C061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:32:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t22so5375890pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=608m3Xdamr06ubRwsdIwgsL0Wv5IuSrSD4XZYOe3AIA=;
        b=haK0MU9BR4DoHhZN5+KmeQHf+6zNNFdP0nVs+TRdlRsOw4atRLowzY8BEWl0htq4fW
         WmyF0pM3/RTFTBu7yCn3E8IrS0GEW0bN9mPDdofNLH5JB6O2FzlZi5eSwSJQOysovK90
         u0N4PoMl7QBtrI9SxCOJEvoN49B4qwqmZrQN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=608m3Xdamr06ubRwsdIwgsL0Wv5IuSrSD4XZYOe3AIA=;
        b=mYWYjwSTtwu9HvT0WgCy1Z8+sdkvbRQ3gsPuAqNn/t93iUH2Tcwtj0k/ZZE3N+C9Be
         vIZbb4nONsR1ULwI0lAYk+Kxc//JX5YfzZULvTfnzQjEy+T0okZvXi+7um2+sfm8vO52
         w/0wtmKyRhKqrMYNfvMHTpHtnuqxQU/izvsro/6BWANBf9uNhg1+y9SFg5NZtgUZuamA
         v8DGP9ey5BY3KzdEKiHKnVmliLjQFsryoTe5v5lYI/VVizmdzVtGHWuvJMtn4u1kd/Ft
         vS5MHQaRGfKi2lOgIeZa3ULyOcxO8BaDbr9SbIbidXI+pl32dBXZcY9zQ8PdYDBmLBqZ
         Figw==
X-Gm-Message-State: AOAM531e8Ua/t7xWNcUx3OwYWEN0giM2OO7MGz8faF5G4FLTVCOdnuSW
        nHZvfNniYH9XDEW0kxHi4QQvWKXJeqGNjw==
X-Google-Smtp-Source: ABdhPJwQvwYty5xrcCMg5pGaBH69FA1fyN0g5MWMkeOU1LLqdfVlkTINjsVsTuDzgii/2Pd+dr+A7A==
X-Received: by 2002:a05:6a00:1c54:b029:261:fc0f:15f7 with SMTP id s20-20020a056a001c54b0290261fc0f15f7mr19016814pfw.30.1619461949838;
        Mon, 26 Apr 2021 11:32:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm6371183pgk.66.2021.04.26.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:32:29 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:32:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [GIT PULL] pstore update for v5.13-rc1
Message-ID: <202104261131.DA983FFC3D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this single pstore update for v5.13-rc1.

Thanks!

-Kees

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.13-rc1

for you to fetch changes up to 9d843e8fafc7c0b15d8f511d146c0c3d7c816634:

  pstore: Add mem_type property DT parsing support (2021-03-31 10:06:23 -0700)

----------------------------------------------------------------
pstore update for v5.13-rc1

- Add mem_type property to expand support for >2 memory types (Mukesh Ojha)

----------------------------------------------------------------
Mukesh Ojha (1):
      pstore: Add mem_type property DT parsing support

 Documentation/admin-guide/ramoops.rst                  |  4 +++-
 .../devicetree/bindings/reserved-memory/ramoops.txt    | 10 ++++++++--
 fs/pstore/ram.c                                        |  7 ++++++-
 fs/pstore/ram_core.c                                   | 18 ++++++++++++++++--
 4 files changed, 33 insertions(+), 6 deletions(-)

-- 
Kees Cook
