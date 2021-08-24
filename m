Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8912F3F6062
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHXO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHXO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:29:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA4C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:28:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u3so44826165ejz.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMcyNN7HiHMTjPn985fqINOzKmFYb659Kz/R21GSs+Y=;
        b=jpFaHM/b38XWLVP7EUSG0aHR0u2g52qR/KJ4/xj19QvUI/BGh/8Pd1l0/ndBcWHLHd
         Pw/kukD6RuvDS6AfxeiwbAnKUrf7MDErSwzDPifFKcAyorhTUPXn8e9p3LfMrb3NR1OI
         R/eZua7JFZesoen32e6QrqOt9IlC+7BrvFzgFTTSIWMavvb0u4nIG/koviTCgjNyXF4b
         5MITFtxi5EgWZ4j/aurQxZxZBzJuCEu/cD/lu5r5riX/kP9BMwaFfwiNgxiZJivf6hB0
         znQiNmJYISyE9wkArsG9e2THfCwF/InIWRCGgjWzsv95139uFZHL3bp8ZgbyPULMZ21f
         ObEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMcyNN7HiHMTjPn985fqINOzKmFYb659Kz/R21GSs+Y=;
        b=YP65qzm7+qbX4uijcd6JAiiBZNj3YKH9dxZ0feivGPyJAH67f+Geg8O1bGBievIpyy
         5M7ruinJfJwcc+lZ6gBf+/LhinzyA5IVPTVdNNsK1UUOWlrFNZrCTaWkWRzx8OATQI3D
         ULshPr/p/E/9D4NzBeV9HI56hP0MiC4cKwd/Mk3Sl1gEzxGEpii4Zgh2eJWWIjXSKr8v
         Yb0BvkzrtTuQYZp/muI+vN2us5kbgrW9H5AJZzykmBitGynixBbAQCt5r8mAd4wh26Ex
         12afT4pzSENo0eXGsTjqlG/3GjqZ0+QfYZeJbXPs/6o5TBY0NGbMJDIR6NgYtscTJrgi
         5rjA==
X-Gm-Message-State: AOAM530zOYLlJsz2BMXKDjas0WNdrsSzDNIHZKXJF78JC+vknhRdAxk9
        JYKHXnNLFftBiPg3LB6mlZM=
X-Google-Smtp-Source: ABdhPJwxQtG/9GIA0HUWnyfmiW0egIEqfupR1GQYDenzMr3t9XHObXhM0gtMgYI0i9ZQ4/KKAFmInA==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr40650069ejr.435.1629815307688;
        Tue, 24 Aug 2021 07:28:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id r2sm11873480edv.78.2021.08.24.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:28:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/2] staging: r8188eu: Use new usb_control_msg_recv/send()
Date:   Tue, 24 Aug 2021 16:28:21 +0200
Message-Id: <20210824142823.16845-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core in usbctrl_vendorreq().

After replacing usb_control_msg() with the new usb_control_msg_recv() and
usb_control_msg_send() API of USB Core, remove camelcase from the pIo_buf
variable that is passed as argument to the new API and remove the initial
'p' (that probably stands for "pointer") from the same pIo_buf and from
the pintfhdl and pdata arguments of usbctrl_vendorreq().

Fabio M. De Francesco (2):
  staging: r8188eu: Use usb_control_msg_recv/send() in
    usbctrl_vendorreq()
  staging: r8188eu: Make some clean-ups in usbctrl_vendorreq()

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 65 +++++++++------------
 1 file changed, 27 insertions(+), 38 deletions(-)

-- 
2.32.0

