Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24942353595
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbhDCV3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhDCV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 17:29:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F2C061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 14:29:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so5756553pfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=C2W7sSHQpp01hEDFBVNMnmEDRVDgq5uaUIb7w4hRpj8=;
        b=CfMwjQxIhUqiG71/LMDXkKpKiI+InZgxVD+eNajtZOXcri4hfo3Dxd9mt/qKYUSjOa
         Ne6RzYGd0NuVQtEAOajWmpfpWNA1mM5+qI/Duh08Tq1m2qYxNP+wAjIkmKMqkWJL+TGb
         I1IF6nGd//Ojld+kLuOOspSnB1vVudUZNljS4Y02r2pYH6395Nx15795icl2N9q0k24o
         mzDLz++Xx38emD+ctczWJBm+9FCBlSJkiVWdaHwZ9rHcvCaFZGzwQ9bfkF4XYOfIYtRX
         GE+ifDE1HyeGa90FWjE0vbLzyqLrQHlYPgJA9vU6r2X/V+zKIQ4sqZMiiw3jd6vwmFM8
         HANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=C2W7sSHQpp01hEDFBVNMnmEDRVDgq5uaUIb7w4hRpj8=;
        b=VvnXahtO7Kojad7OT+cBfLKdSyBTlUmKYX7vY69gugrJA9FZeMw+U692sdOhYHo2pM
         KKqudp8wrJdeGiFflflGC4rkyha6bJT5Pw5ucpRKEAApjwnQBp8Ezo3MDAOYL05sUjGx
         +leCNr5llZnkbC6XjtOgSB7rPovkXoBMBg2V+10/68jTGKSiF53TvSCFIy7nSwTcxQY9
         AwC4F2FXKbMnlXF5OexGFM5dg04wxPSkrzZ+1AWX0NCYJ+kaGve3DAw1hPs4GtzKV2oY
         47r9aiSpR4aF/r11rsuHOEvVjVDnVaBXk7pqs932d9nGY7eUV9cOWqWADUstmBSav7tc
         bAGg==
X-Gm-Message-State: AOAM532F2jgLmfz/9cOcagsQWfhYocSdVgpX1w4gB3YX4DzLHf4WJh8l
        WQs8pqQJV7LBDT9TgIopMook9YQAl4E=
X-Google-Smtp-Source: ABdhPJyXs1avsc2uG9jG5DPYAat8SjzS7ToEXJO649FmsQ6vds4Lo4tcrhU0UBjBD/AjY2iXuLwF4w==
X-Received: by 2002:a62:2742:0:b029:222:b711:3324 with SMTP id n63-20020a6227420000b0290222b7113324mr17423214pfn.7.1617485387897;
        Sat, 03 Apr 2021 14:29:47 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id i21sm1411388pjv.22.2021.04.03.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 14:29:47 -0700 (PDT)
Date:   Sun, 4 Apr 2021 06:29:44 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Holenko <mholenko@antmicro.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fixes for 5.12-rc5
Message-ID: <20210403212944.GC3288043@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull,

The following changes since commit a5e13c6df0e41702d2b2c77c8ad41677ebb065b3:

  Linux 5.12-rc5 (2021-03-28 15:48:16 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 1683f7de65dbf0a2c6a7d639173fe92430a28930:

  soc: litex: Remove duplicated header file inclusion (2021-04-04 05:46:46 +0900)

----------------------------------------------------------------
OpenRISC fix for 5.12

Includes:
 - Fix duplicate header include in Litex SOC driver

----------------------------------------------------------------
Zhen Lei (1):
      soc: litex: Remove duplicated header file inclusion

 drivers/soc/litex/litex_soc_ctrl.c | 1 -
 1 file changed, 1 deletion(-)
