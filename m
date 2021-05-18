Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA438712F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhERFXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhERFWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:22:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF6EC061573;
        Mon, 17 May 2021 22:21:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so12518819ejc.10;
        Mon, 17 May 2021 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WurjucYuOG4COFl5J6u446g3kHrCIJ2hLKLLFtpRi6E=;
        b=k7xbeo185fcG5VfcrBCI8NkXeMgRD92KYa9eXLNvvd4Zu1K6lRn38cAkBRWczkbE8C
         BpwT0cYMEcztOXk0r6RJiMnd0SKn/5C1abXmBBMtZzqUZQ9POy2xcVvYtqfi6vyNtyap
         bagk6AoOsx5LykeFWmwyoixaO0Hcj3KCyPxMZU1AJ72sApA7uOU8udQExncuii4AJ5pI
         XJAsDzx+uBXZvr+KuXAMsSIs43kWVUwCJjYYnsHV6k9l4Z0zpr2JU0kPdBK7qKvUql5r
         GH4CEld6ox45j68HZ7/l5GPef3iIqmxqk32Zpe9slbEMp16yKleRPjOKDm+jjF1ErsU2
         Rg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WurjucYuOG4COFl5J6u446g3kHrCIJ2hLKLLFtpRi6E=;
        b=Vgcj7IEa3D/NoD+XRePBzx524UNOAmXJ8gc+gBFb8RNIZyspjvJH+tkCM4QSLWJsQE
         p1NaK6i9nbztImMxe8sdR+F4MlpJxextVkXu9D7bI5kDEC7vUrLc3Bew3B++ac9vfIWy
         m3h5XgIcA7wpx6BdjpINx+POvwrVMJ0lkWCaH+Lfz2biKi44Q3CRwltjrx7P4K2PHVsV
         yUDARAqH4w42422+e+kz641E/QNl8F2u6uSPNQBlYl0Qf8UVursu6gYhIFwRsqnXmccR
         42Zmn4iVsxrURadKEEwdvi/K75/CI4u/muGFb1wPlTFmA/hPlCfck6tZoomxSCaCLAxi
         VMUQ==
X-Gm-Message-State: AOAM530FsypmxvhXB/ziY7zBtt2WmvNgS6j8qw8oBa6cxIp8YyFzpT+W
        65eT6RUb6OgZw2W/rFvObns=
X-Google-Smtp-Source: ABdhPJw0vmAuG+NqVZh3Ed0Fs9qPW5Zj903fabNj+QANcbyQIpqqif8kb3ygFDh2BUCCO1wsYoYH5g==
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr4098218ejd.4.1621315293759;
        Mon, 17 May 2021 22:21:33 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2db8:6100:84b8:37fd:659f:be17])
        by smtp.gmail.com with ESMTPSA id n17sm12117083eds.72.2021.05.17.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 22:21:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 1/1] MAINTAINERS: TTY LAYER: add some ./include/linux/ header files
Date:   Tue, 18 May 2021 07:21:17 +0200
Message-Id: <20210518052117.14819-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518052117.14819-1-lukas.bulwahn@gmail.com>
References: <20210518052117.14819-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An early prototypical automated code analysis of headers and the
existing MAINTAINERS sections identified some header files in
./include/linux/ to be probably included into the TTY LAYER section.

I further checked those suggestions by this analysis and identified a
subset of files that I am rather certain to belong to the TTY LAYER.

Add these ./include/linux/ header files to TTY LAYER in MAINTAINERS.

The patterns include/linux/tty*.h and include/linux/vt_*.h currently cover:

  include/linux/tty.h
  include/linux/tty_driver.h
  include/linux/tty_flip.h
  include/linux/tty_ldisc.h

  include/linux/vt_buffer.h
  include/linux/vt_kern.h

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210507

 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8923f0064784..d056f777c1a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18563,9 +18563,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 F:	Documentation/driver-api/serial/
 F:	drivers/tty/
 F:	drivers/tty/serial/serial_core.c
+F:	include/linux/selection.h
 F:	include/linux/serial.h
 F:	include/linux/serial_core.h
-F:	include/linux/tty.h
+F:	include/linux/sysrq.h
+F:	include/linux/tty*.h
+F:	include/linux/vt.h
+F:	include/linux/vt_*.h
 F:	include/uapi/linux/serial.h
 F:	include/uapi/linux/serial_core.h
 F:	include/uapi/linux/tty.h
-- 
2.17.1

