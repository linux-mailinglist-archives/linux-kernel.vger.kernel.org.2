Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4219394DA2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhE2SSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhE2SSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 14:18:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2804C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 11:17:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kr9so4328249pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EBv4uq0gAcs2Ea+HzNHlkHPHnRxd1M6/qKglYmxqnfg=;
        b=CyDcLycXtcubpdxgKnrfBkmwXxnEl1JCiG6eN7c4qvp2bEQtFaINGPHqcpDXdWHX5g
         6ZS4Q7ZYN2S11UaX6gjSCQcaDEtiFyG7raxi9lFaBt4H5pUbVN/Le2gOxWdCIUyGjxSS
         HyFFwuOgufgpPbNhNLmL7eZGmh80SswHWgr3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EBv4uq0gAcs2Ea+HzNHlkHPHnRxd1M6/qKglYmxqnfg=;
        b=dACnSSIc9OGNQSY0/WAaSygLd4BOqszTCThr8OvvSQ+l6Fp0TzJQ4GJU/F986qMmX2
         u8KkJYsMouBgfUI9r4Bnqi/DjxH2ZlY0qYzbMezDMuixP98Ap9SSgtPkYT1qNsG5jkkS
         iiVyzi3jFRlEbHYZaxK9HVhlhZ5xZZKpnUL2BgT8kKeJFB3nWfTetJ/gbqEG2xbWCoiQ
         wIZMTvFZFygkgwuTaq2N/RYB2KsuOEewmSjPSo7+e/prChS99PyU4l0W4jEhWetditKB
         mxcWNO/Gn2glILpZ6MqrVVjYx3Osbc532P5P8WBDNGfe74E6a+tIARPTXL3pKBApkiEO
         0baA==
X-Gm-Message-State: AOAM532dEBKJktlrRkbC9CvmB13zD8qckBU44zSujcsZf6xr5cKggaxW
        f9NXH+K6yff5jfkax0qfG77wBw==
X-Google-Smtp-Source: ABdhPJzJsWU8U49xLRAM+2X2W+yyk4irL2ZMQG74Rxv8i1/tkPPT+vJyfktAhFug736V+h+ApJNzSw==
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr10977578pjb.22.1622312221448;
        Sat, 29 May 2021 11:17:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18sm6869186pfr.49.2021.05.29.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 11:17:00 -0700 (PDT)
Date:   Sat, 29 May 2021 11:16:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [GIT PULL] seccomp fixes for v5.13-rc4
Message-ID: <202105291116.B0B7D78D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp fixes for v5.13-rc4. This fixes a hard-to-hit
race condition in the addfd user_notif feature of seccomp, visible since
v5.9.

Thanks!

-Kees

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-fixes-v5.13-rc4

for you to fetch changes up to ddc473916955f7710d1eb17c1273d91c8622a9fe:

  seccomp: Refactor notification handler to prepare for new semantics (2021-05-29 11:13:27 -0700)

----------------------------------------------------------------
seccomp fixes for v5.13-rc4

- Fix addfd notification race condition (Sargun Dhillon)

----------------------------------------------------------------
Sargun Dhillon (2):
      Documentation: seccomp: Fix user notification documentation
      seccomp: Refactor notification handler to prepare for new semantics

 Documentation/userspace-api/seccomp_filter.rst | 16 +++++++-------
 kernel/seccomp.c                               | 30 ++++++++++++++------------
 2 files changed, 24 insertions(+), 22 deletions(-)

-- 
Kees Cook
