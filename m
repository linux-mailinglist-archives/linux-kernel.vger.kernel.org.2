Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1638AF49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbhETMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbhETMyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:54:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917AC068D8D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso2564581wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBYwcFKrYsCTbjbrQKTmoHLJiiSFsBd/2SYWAufez/Y=;
        b=Atv/WuyVLKexAPcuSkixUBWqY6CO0dK2gduGoLHaFLRvVIpwJ+MrtjaNBQvCnJ5nHr
         eHNTx15hB/n8yPeFfgA9Szrp5Us8P/SgN8aQQywqr9L5ncIee5wFPRDugk50O2JPvUOz
         EdNCZ2ypRZFTnQHuWPjqRkJV04zKL81xMmOz89RQPXgV+YgzJCPCDIxIBswnEiniBxVr
         Ux3T/PvLYDM4q6JEv3l7vFZYNbCs5hMnPMyygqx/eGv7gzuQbb2tRkTFda1RaW4dkCWq
         4Tcv2+jr0/Ynwa17LHaRx81KnPTEJXfLmiF80NjPlfagl4az3Q5Gk2dVly1HcfEAmBwL
         nqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBYwcFKrYsCTbjbrQKTmoHLJiiSFsBd/2SYWAufez/Y=;
        b=WKDyry0ifZoXkxi+5ICAaMag13KsE3eD7eo24MRiJp3TckWN69b6QXHRoFKUL69EyA
         DbKjTVf1IN1Jwoi7k682J4aWQeW8YQlU0I4Ui/PBQOc+HIm31Z2Iv+Iu59Sk1VIneBsk
         KFdx2T7Y07fBp+gq0UGga/zvmN824XE24HyFwfBrhaW5NU2eaOvpWlYz9Ur5KXg9xjGb
         qrzV3VxC86dKyhHSKq91ATcMpgudbJ0RSEyMlY9GBQ6+bQ02TsFTuMGnznjStfaRVHQy
         Wl49O30q451L6X0OQBVfdT8N9KzlSkgT0CqvVOYpL4iVjCuCf4rFQ4V32qpiT1yrKQPZ
         oNJg==
X-Gm-Message-State: AOAM532fpBJFJz0yrkVxzn+6LX7BGahefWcUDFnaOqEL2ZfSowgKMrQw
        8FEEa0xp1WP85PORIxaPnvUBuQ==
X-Google-Smtp-Source: ABdhPJy3HAhGdYxDbgzvUXcIf+78K3LKutGvMz5lblmb8zzowzFLXzUCMmFB3EX/uNLAi9/rpRw1sg==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr1615481wmh.83.1621513149899;
        Thu, 20 May 2021 05:19:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Al Longyear <longyear@netcom.com>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        Andrew Morton <andrewm@uow.edu.eu>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Michael Callahan <callahan@maths.ox.ac.uk>,
        Michal Simek <michal.simek@xilinx.com>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Paul Fulghum <paulkf@microgate.com>,
        Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>,
        processes-Sapan Bhatia <sapan@corewars.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 00/11] Rid W=1 warnings from TTY
Date:   Thu, 20 May 2021 13:18:55 +0100
Message-Id: <20210520121906.3468725-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (11):
  tty: vt: selection: Correct misspelled function sel_loadlut()
  tty: serdev: core: Fix misspelled function name
    __serdev_device_driver_register()
  tty: tty_io: Fix a few kernel-doc related misdemeanours
  tty: n_tty: Fix some misdocumented functions
  tty: tty_buffer: Fix incorrectly documented function
    __tty_buffer_request_room()
  tty: tty_jobctrl: Fix 2 incorrectly documented functions
  tty: pty: Fix incorrectly named function pty_resize()
  tty: n_hdlc: Fix a little doc-rot in n_hdlc_tty_read()
  tty: serial: st-asc: Demote a kernel-doc formatting abuse
  tty: n_gsm: Fix function naming and provide missing param descriptions
  tty: serial: xilinx_uartps: Fix documentation for
    cdns_uart_clk_notifier_cb()

 drivers/tty/n_gsm.c                |  6 ++++--
 drivers/tty/n_hdlc.c               |  4 +++-
 drivers/tty/n_tty.c                | 10 +++++-----
 drivers/tty/pty.c                  |  2 +-
 drivers/tty/serdev/core.c          |  2 +-
 drivers/tty/serial/st-asc.c        |  2 +-
 drivers/tty/serial/xilinx_uartps.c |  2 +-
 drivers/tty/tty_buffer.c           |  2 +-
 drivers/tty/tty_io.c               | 17 +++++------------
 drivers/tty/tty_jobctrl.c          |  4 ++--
 drivers/tty/vt/selection.c         |  2 +-
 11 files changed, 25 insertions(+), 28 deletions(-)

Cc: Al Longyear <longyear@netcom.com>
Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
Cc: Andrew Morton <andrewm@uow.edu.eu>
Cc: Bill Hawes <whawes@star.net>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: -- <julian@uhunix.uhcc.hawaii.edu>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
Cc: Michael Callahan <callahan@maths.ox.ac.uk>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Paul Fulghum <paulkf@microgate.com>
Cc: Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
Cc: processes-Sapan Bhatia <sapan@corewars.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
-- 
2.31.1

