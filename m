Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A972A36822C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhDVOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhDVOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:10:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B9C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:09:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h15so14086147pfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/gDYokLkAPezwBUXb2BsOr5s2Af3W3ok0V9LpWquAU=;
        b=N7ENIt8Xs1yz0f7dPTt2wNX8vJT0WXdfihgGZ458k3u9hTanbU2jzxaWIeLrhxQn/d
         iOcNH+djBrtHU4Kqx0jkHYue8jOjGc6FRX17eO6QUbmnPsDWtQQctwdYvUMwn3Hfzodg
         i0NXr9LIBghXDvgk/j0lnsClK5w1kj/1Gu0VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/gDYokLkAPezwBUXb2BsOr5s2Af3W3ok0V9LpWquAU=;
        b=jnDXnUejqQ3RIOfxqfbHHTNbV6knRboE+bg5dnZ5e2/H4GQ9PhtDO47/lOoqYrdTlc
         Jsa0qf5PBuAkrSQpYNkLxjq1QHDNjt5qV+xgCTtW06DqEAfCIAYkLENlvKU2xTu897Vy
         xoFR8q80vUSMcT7k1+PNe7L8gfZsJBjtfwFa6NMLb7G7RCDd08Lqu4dF8LImxfsrG1Tw
         MO5AWmn5UoHIDvyUH1ycx+bpt9erebXC/la4DQ0FxEIm8nF20N5WkB3vxHGmio8c9nTN
         JuUBhp9PDN/dDzju6be2bR64LXjL0M0+vOn0bk07YAJiMlNj0Sz+YBbVF2DvMPXENFhf
         60og==
X-Gm-Message-State: AOAM5300Y7lNYU3l8JmwJbBwjeYJw/2H/9+YZH+L9dmdEg4+GDrAZ69b
        yv9pmm9pqv3fKOAkZT9fvQF61w==
X-Google-Smtp-Source: ABdhPJyoDqs9mOArEmPY462NVPxiecr+xvGgEdEMAjNbX9P5K0PrbQakJOQWzfjdkXTJ7aeqkMpwWA==
X-Received: by 2002:a63:1214:: with SMTP id h20mr3698845pgl.207.1619100596840;
        Thu, 22 Apr 2021 07:09:56 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id p12sm5278968pjo.4.2021.04.22.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 07:09:56 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, arnd@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH 0/2] ARM: mstar: Internal bus madness
Date:   Thu, 22 Apr 2021 23:09:43 +0900
Message-Id: <20210422140945.4131092-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MStar/SigmaStar SoCs have some very weird internal
bus bridges called RIU and XIU. These seem to be a left
over from when the CPU core was 8051 or MIPS.

Basically they act as a bridge between the ARM CPU and the
lump of standard peripherals (ethernet, usb, sd host etc)
that has been used throughout all of their designs.

RIU has 16bit registers 32bits apart from the CPU view while
XIU has 32bit registers 64bits apart from the CPU view.
Older chips (MSC313) only have RIU, newer chips (MSC313E)
have both RIU and XIU with some IPs accessible via RIU with
the original address and via XIU with an additional address.
To make things really fun some IPs (memory mapped ethernet PHY)
have registers that are completely accessible via RIU but only
partially accessible via XIU.

The main issue is for non-MStar IPs connected to these bridges.
All of the MStar IPs seem to have 16bit registers but the
ethernet controller and usb controller are third party and
have 32bit registers.

The kernel drivers expect the registers to be at normal
offsets and not broken into two parts so they don't work
out of the box here.

I want to hide this stuff as much as possible so it seemed
like a good idea to hide it in a header and use the headers
in the unfortunate drivers.

RFC because maybe this isn't the right approach and I'm
sure the two readw()/writew()s for RIU need to be protected
somehow but I wasn't sure how.

Daniel Palmer (2):
  ARM: mstar: Add header with macros for RIU register access
  ARM: mstar: Add header with macros for XIU register access

 MAINTAINERS             |  1 +
 include/soc/mstar/riu.h | 28 ++++++++++++++++++++++++++++
 include/soc/mstar/xiu.h | 22 ++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 include/soc/mstar/riu.h
 create mode 100644 include/soc/mstar/xiu.h

-- 
2.31.0

