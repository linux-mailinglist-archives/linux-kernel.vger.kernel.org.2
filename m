Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DF3E9827
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhHKTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhHKTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:00:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0508CC0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:00:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f3so3928556plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3CsU35fOhbuuli30dohmgqLObcTY79znFpJHx0d+Vy4=;
        b=QV3izP3GAULcDtht5Wp/Vmx2A8dV/jbUdWU7ehJ8dQb/Fvb5mnk2dHxZcbIj3smvTl
         qj+LG9z3h8GCJEAd0/WcSNjUdLQbzlEZV0Y85HcwNdd3aIITKNCTZwD7OlG7hZ02jLXK
         xD9VzXnZt7QeXxYSgu5R6v+E/rE5O57HcU11s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3CsU35fOhbuuli30dohmgqLObcTY79znFpJHx0d+Vy4=;
        b=o2F/yc5SpqDWY591NpgwFG/LXzA41OGwFe3yyxrda8+S91PzJBKoMP4df8y6NjOOfN
         mpojfxz9oS/yTC3tpnoy49608ZnC13e56hjrvVGlXrjFXTIZ68Mmu7jvtsfyEbIlLdXx
         F4WewzgQpq8k+GD/Pa7AwTSmkd3v+0KmfNVi/wuwKi/FIDFFdDj+/Bsa0kEQC+/zTtam
         tcLHQon/FOlvamhYqmQC/QhA1ULVcQ9EyV+TDCroHqrp46aCiAhv1CbYlyEl7qwZoFGf
         IXZr8sx1cESfz3UwmOJfNGwqyBJzgnt+y3W57Ylv2LOjyDtOyhXwoUKzO1UiRUzzNMia
         hZcg==
X-Gm-Message-State: AOAM530GckQc+ikAQKJc8z05/O3mknezMjvaat+wQGhnOcP0OElt4giJ
        YktKMEUQyN3Df+hmdsEWHcDeOQ==
X-Google-Smtp-Source: ABdhPJydDJLT6ZY8AFeY16wf3Xr5X0+LI6c+dBnlYCGoGGMgiuWtHqdPvGxbAFeCo/n6enZ+X7tgHg==
X-Received: by 2002:a17:902:e744:b029:12d:6479:83a3 with SMTP id p4-20020a170902e744b029012d647983a3mr324604plf.30.1628708428538;
        Wed, 11 Aug 2021 12:00:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4sm216401pgt.22.2021.08.11.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:00:28 -0700 (PDT)
Date:   Wed, 11 Aug 2021 12:00:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Hsuan-Chi Kuo <hsuanchikuo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Wiktor Garbacz <wiktorg@google.com>
Subject: [GIT PULL] seccomp fixes for v5.14-rc6
Message-ID: <202108111159.123B4811F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these small seccomp fixes for v5.14-rc6.

Thanks!

-Kees

The following changes since commit 9a03abc16c77062c73972df08206f1031862d9b4:

  selftests/seccomp: Avoid using "sysctl" for report (2021-06-28 12:49:52 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.14-rc6

for you to fetch changes up to b4d8a58f8dcfcc890f296696cadb76e77be44b5f:

  seccomp: Fix setting loaded filter count during TSYNC (2021-08-11 11:48:28 -0700)

----------------------------------------------------------------
seccomp fixes for v5.14-rc6

- Fix typo in user notification documentation (Rodrigo Campos)

- Fix userspace counter report when using TSYNC (Hsuan-Chi Kuo, Wiktor Garbacz)

----------------------------------------------------------------
Hsuan-Chi Kuo (1):
      seccomp: Fix setting loaded filter count during TSYNC

Rodrigo Campos (1):
      Documentation: seccomp: Fix typo in user notification

 Documentation/userspace-api/seccomp_filter.rst | 2 +-
 kernel/seccomp.c                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Kees Cook
