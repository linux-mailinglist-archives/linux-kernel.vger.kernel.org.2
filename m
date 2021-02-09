Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECAD314D93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhBIKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhBIKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:48:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C6BC06178B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:48:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q2so19708394eds.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TCYYyYxqAgiBLSJ5bSlirMCh5sbeOM7VGMK5TP60Fss=;
        b=b9Yo9T36flpzfkT2q8cgN1WmWZFVS9xHxt2vib3CMlEM7QCeY1Zccd85r3GZ/1TryE
         laJtCaAHhmRp9KnQZwiACvemLIxSh7T0nIU9pquP9yEBN+NYa0+8SAr4v7No4m7nvENv
         SQepPxRcSVjemsI9d+sW4a5XO6pKTuw9syxPE59pB4GHwI3LiJuJuPTHUZj+p3wm1UZ7
         9YWGNMxgRlWy3RfVLOqr+Oakt0wL5L8bvckZ81XwykgjXFZ/XwacFkMJvQduUnuwJrKi
         KRcTG/RffwlODLsA5eQJ1U3sPJMUdeMqaocox6XrXuICYV2N69D+TED5wMe9dX6um6LT
         tcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TCYYyYxqAgiBLSJ5bSlirMCh5sbeOM7VGMK5TP60Fss=;
        b=qezsd0jfo6Ez60COJRNS9HQcwV3yVs+O7zhiI4oJgFbPFJ99YxRbq/Wt0ERIKKXW0d
         WvQzxX9HZr0caljkKTIPtjEXL7Xi/1k8uGwFFO2MlJN2rW1bjyqlugFD80nH8bipmlDe
         xgvO4E/p/pHyUpSuKe0kapnD1f7/tpwRT+UvIRyM9XoxLYcvTw+Pw1NTHFGKd4Y129kp
         zlIGyS+ZtyxFMPE46YKtk2H/u5vhFM8vWRSetoH0yZDBE38e5zjvfQgmHjOAnBfeIkca
         jDLSWUUOKZNKZGVCLiZyBMZYPupMAod0HOL/9vgTLEgmNeH84lZzTiXUuEoWxHVuX7fL
         ko5A==
X-Gm-Message-State: AOAM531E5flhbEGhT23ycrVhgJMqxFkZdWzd9dg0957WmyKg3lV3Umyh
        y/lleCxN+Iy7M+zL+ds6VWal6Ch3lR8Wmg==
X-Google-Smtp-Source: ABdhPJzr01m5XL3lUEjgU7CoTO4lCwwZmN3dNOuZ4rreKz1xClAsawbZD2Q3iYy3QDVjKGuPLNRi2g==
X-Received: by 2002:a50:c04d:: with SMTP id u13mr21924511edd.226.1612867691478;
        Tue, 09 Feb 2021 02:48:11 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a15sm9852924edv.95.2021.02.09.02.48.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 02:48:11 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 0/2] usb: misc: Add support for Microchip USB5744
Date:   Tue,  9 Feb 2021 11:48:08 +0100
Message-Id: <cover.1612867682.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the series is adding basic support for this USB hub. The key part is
running reset over GPIO line and when i2c is connected it is necessary to
send command to boot the hub. This chip is available on Xilinx
zcu100/Ultra96 v1 board.

Thanks,
Michal

Changes in v2:
- s/USB_USB5744/USB_HUB_USB5744/g
- Fix order in Makefile and Kconfig

Piyush Mehta (2):
  dt-bindings: usb: misc: Add binding for Microchip usb5744 hub
  usb: misc: usb5744: Add support for USB hub controller

 .../bindings/usb/microchip,usb5744.yaml       |  56 +++++++++
 MAINTAINERS                                   |   2 +
 drivers/usb/misc/Kconfig                      |   9 ++
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/usb5744.c                    | 115 ++++++++++++++++++
 5 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
 create mode 100644 drivers/usb/misc/usb5744.c

-- 
2.30.0

