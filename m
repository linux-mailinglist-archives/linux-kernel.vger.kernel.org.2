Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A647320AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBUOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:04:47 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:32785 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBUOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:04:38 -0500
Received: by mail-pg1-f170.google.com with SMTP id z68so8446412pgz.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 06:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pzWhTSdAe7cqn4KT2SjhkgBpropTuu+rr5Ez+qPvqEg=;
        b=nKT9XYYUATnMS4ggQqnXPb5rvQGa9FvWq/yWL4wVONznsdOXzopY59eGyuwbSjDzsh
         SpdCdvFibZ5ZTcCG+qIbRUidppaT61nTcnvgCC95iHBzwYl9d/Hi2tdoeE6UV++vJ+xV
         cAr1W76OwfH+CqqM4gYfekfBIhrZU0QNkSdhFybfnoQZZ+kT77ivoT17XywWWnePnST4
         UX1eAT/iMy+t5YdTeaESRJj3s/8jmdHy4T67XhuP37It/Yp+kAxKfQo7mCDVWrw3NTuW
         XVzW+0+0A6SQ+P9Sj+sf4m+z2M/cRXCC6ftdcV4Ubu9q4s5BUoTNP4/laoRBMMhImmNw
         M5BA==
X-Gm-Message-State: AOAM531J1wDW6Xrfy8uj8Esixbx1YnghBWJwla2p/6rd7O5hRmkpdhRz
        ygqz1SyuxkPBmt2+zUJt05bmSHoYI7g=
X-Google-Smtp-Source: ABdhPJwLdNMVeWd78rkGu1VPCg315nj6cV6hekFSpPJ1MFEEfbwTGRtC5qlb+4gN4lzwh5REMy0zFQ==
X-Received: by 2002:aa7:92c4:0:b029:1e6:c4:c821 with SMTP id k4-20020aa792c40000b02901e600c4c821mr18364472pfa.10.1613916237891;
        Sun, 21 Feb 2021 06:03:57 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id y12sm14459340pjc.56.2021.02.21.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 06:03:57 -0800 (PST)
Date:   Sun, 21 Feb 2021 19:33:53 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fix sparse warnings
Message-ID: <cover.1613915981.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the following patches fixes two  byte-order issues and a Makefile 
issue and fixes these sparse warnings


drivers/staging//wimax/i2400m/op-rfkill.c:89:25: warning: incorrect type in assignment (different base types)
drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    expected restricted __le16 [usertype] length
drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    got unsigned long
.
drivers/staging//wimax/i2400m/fw.c:514:27: warning: restricted __le32 degrades to integer
.
drivers/staging//media/atomisp/pci/runtime/isys/src/ibuf_ctrl_rmgr.c:34:6: warning: symbol 'ia_css_isys_ibuf_rmgr_init' was not declared. Should it be static?
drivers/staging//media/atomisp/pci/runtime/isys/src/ibuf_ctrl_rmgr.c:40:6: warning: symbol 'ia_css_isys_ibuf_rmgr_uninit' was not declared. Should it be static?
drivers/staging//media/atomisp/pci/runtime/isys/src/ibuf_ctrl_rmgr.c:46:6: warning: symbol 'ia_css_isys_ibuf_rmgr_acquire' was not declared. Should it be static?
drivers/staging//media/atomisp/pci/runtime/isys/src/ibuf_ctrl_rmgr.c:106:6: warning: symbol 'ia_css_isys_ibuf_rmgr_release' was not declared. Should it be static?

karthik alapati (3):
  staging: wimax/i2400m: fix byte-order issue
  staging: wimax/i2400m: convert __le32 type to host byte-order
  staging: media/atomisp: don't compile unused code

 drivers/staging/media/atomisp/Makefile   | 5 +++--
 drivers/staging/wimax/i2400m/fw.c        | 2 +-
 drivers/staging/wimax/i2400m/op-rfkill.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.30.1

