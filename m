Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8A336CFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhD1ARW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1ARW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:17:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:16:38 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u16so44094235oiu.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=MzkvnbEyxJtAGd0h3/FLJS51hociLz8+QPArNAOpdBc=;
        b=GQZjjuhIGAzVdxuyQVcsuJem/BHo5SYknlF2eR7P4LKlSDbEOW01by++aD7H2fgKmY
         07Cbz8HEF8G1lBsuw5HFAHs/ImcRpv3w6VIpsNXAf6joYcaCv4qzDHQ9gk1MlhaJJjb8
         B0InRz8lrsoMAGZI9x5XEuHXOQIFA377wz7w1/nt9W5NsH6p3JCZWNNddmVxIe95ROfm
         LLfApZ9mdqhqluiZSMI+rZjjmVVbXjHG7NwSnhZw8ycMHp2LXC975hcrhANQrZw75JFD
         ynMGo7td3x9FDk9QR4Sq6a9+zOwI+JVTwv8TuUJ4Oe3iQpKplBXTHuJ1aesSZTf8D/5V
         6feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=MzkvnbEyxJtAGd0h3/FLJS51hociLz8+QPArNAOpdBc=;
        b=XJKu7kaX+W8II9xSOv6af0CPdN/uAnLui6ulDp3y3QE7ROX17huuuQW1CMzVWzCK9r
         QKunQbPRchWGLAcuCYju5uw8sTX+Atn3erQziKtkdpinxhzP/vKOMtATZTyyKNQO2L4w
         mBekHaoQelTGlwBRoeUtf3ODLbyQEAqroIqTdHVDpCwo038j5EkBtJ6f0BFm6fWJXsfI
         ntgydDlS9fRitxz5P1GF0A37zp0j8rxl6od0Sxldx2cqeFm9OvgA+ZcZNRmDJ4Wy0cBX
         t1Z6yInplXl8lSmgfuamDaRsq9zUnPyEvRVoA5iY72TSqtIscYUSjaBWyJ9A5z4B7gvU
         xlhg==
X-Gm-Message-State: AOAM530iLZq8+5uln0eCuUP2b0dDbm8+4o05eEfM7/5LyIg5FwPr5uAo
        sSEYPyh7xAfb37G2PJPyb7v2c1zHoA==
X-Google-Smtp-Source: ABdhPJw6pyIo1JB4iyLgAOR4dBJefPZ+0/jdcjiFZ4GD/+OHli7bR89qDafU8aI9XBIet6n9f8VFKQ==
X-Received: by 2002:aca:db41:: with SMTP id s62mr18156719oig.54.1619568997369;
        Tue, 27 Apr 2021 17:16:37 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x3sm394177otj.8.2021.04.27.17.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 17:16:36 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:245c:a96e:2726:2306])
        by serve.minyard.net (Postfix) with ESMTPSA id 844DE180001;
        Wed, 28 Apr 2021 00:16:35 +0000 (UTC)
Date:   Tue, 27 Apr 2021 19:16:34 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.13
Message-ID: <20210428001634.GB18645@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a74e6a014c9d4d4161061f770c9b4f98372ac778:

  Merge tag 's390-5.12-3' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-03-10 13:15:16 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.13-1

for you to fetch changes up to 07cbd87b0416d7b6b8419b2a56bc63659de5d066:

  ipmi_si: Join string literals back (2021-04-02 12:53:42 -0500)

----------------------------------------------------------------
A bunch of little cleanups

Nothing major, no functional changes.

----------------------------------------------------------------
Andy Shevchenko (10):
      ipmi_si: Switch to use platform_get_mem_or_io()
      ipmi_si: Remove bogus err_free label
      ipmi_si: Utilize temporary variable to hold device pointer
      ipmi_si: Use proper ACPI macros to check error code for failures
      ipmi_si: Introduce ipmi_panic_event_str[] array
      ipmi_si: Reuse si_to_str[] array in ipmi_hardcode_init_one()
      ipmi_si: Get rid of ->addr_source_cleanup()
      ipmi_si: Use strstrip() to remove surrounding spaces
      ipmi_si: Drop redundant check before calling put_device()
      ipmi_si: Join string literals back

Heikki Krogerus (1):
      ipmi: Handle device properties with software node API

Liguang Zhang (1):
      ipmi:ssif: make ssif_i2c_send() void

Terry Duncan (1):
      ipmi: Refine retry conditions for getting device id

 drivers/char/ipmi/ipmi_msghandler.c  | 60 +++++++++--------------
 drivers/char/ipmi/ipmi_plat_data.c   |  2 +-
 drivers/char/ipmi/ipmi_si.h          |  8 +--
 drivers/char/ipmi/ipmi_si_hardcode.c | 73 ++++++++++-----------------
 drivers/char/ipmi/ipmi_si_hotmod.c   | 24 +++------
 drivers/char/ipmi/ipmi_si_intf.c     | 38 +++++----------
 drivers/char/ipmi/ipmi_si_pci.c      | 22 ++-------
 drivers/char/ipmi/ipmi_si_platform.c | 95 +++++++++++++++---------------------
 drivers/char/ipmi/ipmi_ssif.c        | 81 ++++++++----------------------
 9 files changed, 137 insertions(+), 266 deletions(-)

