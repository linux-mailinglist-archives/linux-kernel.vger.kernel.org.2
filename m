Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4983DB1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhG3DIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhG3DIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:08:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB141C061765;
        Thu, 29 Jul 2021 20:08:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e21so9368131pla.5;
        Thu, 29 Jul 2021 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FGli0G5ovwMHnEV6R6FenXzO7sxU6LjELt5khjX4A+E=;
        b=VwkM08Y4LHHttykzFq9x2l4TW7pUVaswpnJEDUXkUUO6TvEdalDhhzjDRjP/kMBD9u
         qpLNqlTxaZK05gifeKOCGD6S4KLAdt9/05m3dlBenlzWHFYbEEMC4l8fu0FDuQ0mzgIa
         0BI49FXDhHei5M+V4BrSiSPPA3dgOz23OTYfAfRjFrtPRVoLaLUpc8LBKHCeTXi/uPr+
         1uq71jl1jAwKzadVYCiE/+6P9XGE2TPDZuHm8pJBixaj4Npf9qkknRTn3Cm5LUHbCO35
         8jbL7TJeSqgXaix5/TUw2R1Fp/1T7HXoDe/r6mEF73oiu6UOQoZEZMpePhlKnRl0BCMd
         vOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FGli0G5ovwMHnEV6R6FenXzO7sxU6LjELt5khjX4A+E=;
        b=KyXKt1BUEhyTPjohmb5OvahjRVqYM47W4/JBrQwTfzgVF8815gE5FNVitt+uY46FCQ
         oqJP62uHsyWiipxHCBwyMRndC5buMo6mOW3XtyGeP73VxJhGmqeV7TjV33KCYAkJxGOF
         aFGN/el6obj4rmxHcaFPT/7PQEylO8PMLnDiZ7YT7b47c7Pj79wUnls3j9UUeOI6oIn5
         kOMIp84YYzFJEZqHHYQuEjg8R+tA4zmz2bH/YXotBgpQ1c6SRmtw8RFpBc02XAWE2hlN
         UpCfOOZMedCvMkHwExpcoBWqck39NMggVtqO1cF5PYtciJhreAaJ3u6KqP381ggkEUL/
         Pe4g==
X-Gm-Message-State: AOAM530mZHUNy/HI2EYOxDt4zg+L1BL1CXO3bfKKBsChgqevtu2nSgKr
        7d8ckoPf8SHEzKXvxkPThCuavaBp0bCLXA==
X-Google-Smtp-Source: ABdhPJyza6LJi7DuYemwCdW4J3yYhmFdBbdaVD3GRF+khUjcrsEl27kn2s/1EEByESWhy6DjnGXoaQ==
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr755732pjb.192.1627614526229;
        Thu, 29 Jul 2021 20:08:46 -0700 (PDT)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id p10sm283859pgr.14.2021.07.29.20.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 20:08:44 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:08:38 -0700
From:   Matt Turner <mattst88@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Arnd Bergmann <arnd@arndb.de>, Chen Li <chenli@uniontech.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        David Hildenbrand <david@redhat.com>,
        gushengxian <gushengxian@yulong.com>,
        He Zhe <zhe.he@windriver.com>, Mike Rapoport <rppt@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        tangchunyou <tangchunyou@yulong.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PULL] alpha.git
Message-ID: <20210730030838.5mp7srx73wuttx5m@ivybridge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4v74npvwpxrqo5o"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v4v74npvwpxrqo5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few changes for alpha. They're mostly small janitorial fixes but
there's also more important ones: a patch to drop the alpha-specific x86 binary
loader (from David Hildenbrand), a regression fix for at least Marvel platforms
(from Mike Rapoport), and a fix for a scary-looking typo (from Zheng Yongjun).

Thanks,
Matt

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 640b7ea5f888b521dcf28e2564ce75d08a783fd7:

  alpha: register early reserved memory in memblock (2021-07-28 20:49:18 -0700)

----------------------------------------------------------------
Alexander A. Klimov (1):
      alpha: Kconfig: Replace HTTP links with HTTPS ones

Arnd Bergmann (1):
      alpha: fp_emul: avoid init/cleanup_module names

Chen Li (1):
      alpha: remove undef inline in compiler.h

Corentin Labbe (2):
      alpha: __udiv_qrnnd should be exported
      alpha: defconfig: add necessary configs for boot testing

David Hildenbrand (1):
      binfmt: remove support for em86 (alpha only)

He Zhe (1):
      alpha: Add syscall_get_return_value()

Mike Rapoport (1):
      alpha: register early reserved memory in memblock

Prarit Bhargava (1):
      alpha: Send stop IPI to send to online CPUs

Zheng Yongjun (1):
      alpha: convert comma to semicolon

gushengxian (2):
      alpha: Remove space between * and parameter name
      alpha: fix spelling mistakes

tangchunyou (1):
      alpha: fix typos in a comment

 arch/alpha/Kconfig                |   2 +-
 arch/alpha/boot/bootp.c           |   2 +-
 arch/alpha/boot/bootpz.c          |   2 +-
 arch/alpha/boot/misc.c            |   2 +-
 arch/alpha/configs/defconfig      |   1 +
 arch/alpha/include/asm/compiler.h |  11 ----
 arch/alpha/include/asm/syscall.h  |   6 +++
 arch/alpha/kernel/osf_sys.c       |   4 +-
 arch/alpha/kernel/perf_event.c    |   2 +-
 arch/alpha/kernel/process.c       |   2 +-
 arch/alpha/kernel/setup.c         |  13 ++---
 arch/alpha/kernel/smp.c           |   2 +-
 arch/alpha/kernel/sys_nautilus.c  |   2 +-
 arch/alpha/kernel/traps.c         |   2 +-
 arch/alpha/math-emu/math.c        |   8 ++-
 fs/Kconfig.binfmt                 |  15 ------
 fs/Makefile                       |   1 -
 fs/binfmt_em86.c                  | 110 --------------------------------------
 18 files changed, 31 insertions(+), 156 deletions(-)
 delete mode 100644 fs/binfmt_em86.c

--v4v74npvwpxrqo5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGTBAABCgB9FiEEvu9JS1spHrMAon8T7S7Rn4WzaCwFAmEDbTBfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJF
RUY0OTRCNUIyOTFFQjMwMEEyN0YxM0VEMkVEMTlGODVCMzY4MkMACgkQ7S7Rn4Wz
aCxBlwf6A1KJKyMAmG5vLTMwLOMxFX5C4lv+PZPADoUSejlowMNbZfR2YDmDQ0G8
l/tE11JM/2TSX5vcj+Hku7QlhO32QiW3bkd6eZMzFSG3ZDWmwIICVrsyPIqbr5xq
FgU6X0l5ng13XJwA6OlHOUcNuv08Y2i69KByWu4shw6tP7TBA/y5LH39iC7qg/dB
ETuQckM+03hiVGtxQLKPHA/zP3BQDn1SjdYm9MlNrQ9VVQSyPRSMsqKw6n2/CPrY
zxn3WCNMtaS4KcH/kuBPDW5u3p26xAXLCZ2Fi91bCp7deFYp1p1lKyeVUO6Bn5CA
IEU1D9PjRVQpVcttmxvYeN+IDXpwrA==
=CT1b
-----END PGP SIGNATURE-----

--v4v74npvwpxrqo5o--
