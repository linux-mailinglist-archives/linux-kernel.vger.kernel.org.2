Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB34E3F9C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhH0QbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhH0QbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:31:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C8C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:30:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id w7so5237019pgk.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2f+dDNnTafc8SEGH12py3+AmRo8s4UWHPLd9vKPVi0=;
        b=fIXY/HxJEVeBsShw7ZoC45sRn38f7msV8mjoL3Y97NbGj6DfPUODX+ihlctPKDzwdn
         YPD/t1EBurv45eylqBuFhOgpAUBdbBmVp0yGFrWNcs1Ckt7ZkUjBS3w0KrnDuPFEZi2G
         hhIo5TylhEWddqgaViRf0lul9BW5I+wMMvWr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2f+dDNnTafc8SEGH12py3+AmRo8s4UWHPLd9vKPVi0=;
        b=S4xRHjBQJqX7bwdhvazZ+ZqPrLPs/CKbdFnIG7pC2GBQqvVv/Fr5J2uAXLoB7OAE4E
         yDa7lrClVBEFgxhjg1ec2wHBUYtgmrDwYUShJWs3a9O8c8vGMieHzGy5H0ClQuSJcXhG
         cH0JHA6ShpOitrx7oM4lWIrgKszsfmGJYLrY449bSmIeGldYwY5yGFUjpAA2TJvQnsrE
         GRToQ/WbhdD14WhIdsc9TA6kK1Piuqj73FOyUmR9OKq9W5U7eqhq16jZcAZnAewG4HNs
         wYHCJTgSz+aoPcsjo2gxXaLEJg7hMryFYVN6oGorDSTCyXm6LQY3Aty2ZTVXdkOaf8Za
         VAYA==
X-Gm-Message-State: AOAM533MGDn6GDpPB24oS6aqid41a1uhknYrGFA/Fa47gXPe9+DwT4EQ
        mp5QlI+hUwKWlETvR5UKokmm7w==
X-Google-Smtp-Source: ABdhPJznbYulYqg2Exo4T2nPryLadDYl79zJT/PERPvrMdM1d3/6of2P3VK2Q5eZfqcdzcJBmvuepQ==
X-Received: by 2002:a63:480b:: with SMTP id v11mr8619518pga.413.1630081822183;
        Fri, 27 Aug 2021 09:30:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 202sm6965358pfw.150.2021.08.27.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:30:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/5] Enable -Warray-bounds and -Wzero-length-bounds
Date:   Fri, 27 Aug 2021 09:30:10 -0700
Message-Id: <20210827163015.3141722-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; h=from:subject; bh=G7lfn/S4lfDuvrMJFt78eLvz2QzX7RSCHJx2EUKfiPQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKRMWb5ISje3C63/e3fG+2iJekwLtKJCE+CTV1ok1 yeprqmiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSkTFgAKCRCJcvTf3G3AJspaD/ 97UJfbeR3q77gcILqldWph6Xas5R/waooSKUI7B8kcfMWSbIFP2UH37sv3hxoFbCYKw2DG46o4TqT1 gPku/jbqbtN0frzI9RuneJ5qsPkFwTcv0bYIFWc/FollTUbUaCDSCtrUASQWCwaGbxaIsECBHaYJLq bTstrJMOBbPV0pf+booD34qB1pgAF19WHjUX8WrHcps8yC3pw6FEH80FHerA0h84m1GxmsEDrYBH1U 2JLzwundYK1XJmyh9kAaA65m5C/KDmHQKbt1hvv6yipbyZ3ebELzbaMBTP4lPQ37awcDq6h5HKBGCi t4dikQrkFGbq7u4iLCaV9/KbKjECXoUxw2lpGYN5tUFp2vZhNlOOl3ZnXJlNj3+JDEmbpsWpBoBneb Tz+r9jG98tK4qycFdPTYXrMHLN3aQJe918KJiTCqc9SadDGPdMOWrymWJDtjtoxfrfxmDQOYMU+JWZ nupRIg3yV8k2i741PnR7T3F3TtoRJPokce/4CZB0SR+E/wIliNn47zBcHikiQVSowLyUq2pG7uOERw XF65I3T5t20YANDNmwFKEHbm4TXWbm032LJ7VvsbLalEzpAdcrB9goWd+h4Jji+dANzy5+fr/SPeyF ESueU/yE/ndOHFiaqOc0lcsN2e71td7jcWOhA217gmApxZK1TtuPAJSN3Ukg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- fix typo in treewide conversion (u8 should have been __u8)
- improve changelog for DECLARE_FLEX_ARRAY patch
- add acks/reviews
v2: https://lore.kernel.org/lkml/20210826050458.1540622-1-keescook@chromium.org/
v1: https://lore.kernel.org/lkml/20210818081118.1667663-1-keescook@chromium.org/

Hi,

In support of the improved buffer overflow detection for memcpy(),
this enables -Warray-bounds and -Wzero-length-bounds globally. Mostly
it involves some struct member tricks with the new DECLARE_FLEX_ARRAY()
macro. Everything else is just replacing stacked 0-element arrays
with actual unions in two related treewide patches. There is one set of
special cases that were fixed separately[1] and are needed as well.

I'm expecting to carry this series with the memcpy() series in my
"overflow" tree. Reviews appreciated! :)

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210818043035.1308062-1-keescook@chromium.org/

Kees Cook (5):
  stddef: Introduce DECLARE_FLEX_ARRAY() helper
  treewide: Replace open-coded flex arrays in unions
  treewide: Replace 0-element memcpy() destinations with flexible arrays
  Makefile: Enable -Warray-bounds
  Makefile: Enable -Wzero-length-bounds

 Makefile                                      |  2 --
 drivers/crypto/chelsio/chcr_crypto.h          | 14 +++++----
 drivers/net/can/usb/etas_es58x/es581_4.h      |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.h     |  2 +-
 drivers/net/wireless/ath/ath10k/bmi.h         | 10 +++----
 drivers/net/wireless/ath/ath10k/htt.h         |  7 +++--
 .../net/wireless/intel/iwlegacy/commands.h    |  6 ++--
 .../net/wireless/intel/iwlwifi/dvm/commands.h |  6 ++--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 ++--
 drivers/scsi/aic94xx/aic94xx_sds.c            |  6 ++--
 drivers/scsi/qla4xxx/ql4_def.h                |  4 +--
 drivers/staging/rtl8188eu/include/ieee80211.h |  6 ++--
 drivers/staging/rtl8712/ieee80211.h           |  4 +--
 drivers/staging/rtl8723bs/include/ieee80211.h |  6 ++--
 fs/hpfs/hpfs.h                                |  8 ++---
 include/linux/filter.h                        |  6 ++--
 include/linux/ieee80211.h                     | 30 +++++++++----------
 include/linux/stddef.h                        | 13 ++++++++
 include/scsi/sas.h                            | 12 +++++---
 include/uapi/linux/dlm_device.h               |  4 +--
 include/uapi/linux/stddef.h                   | 16 ++++++++++
 include/uapi/rdma/rdma_user_rxe.h             |  4 +--
 include/uapi/sound/asoc.h                     |  4 +--
 scripts/kernel-doc                            |  2 ++
 24 files changed, 115 insertions(+), 65 deletions(-)

-- 
2.30.2

