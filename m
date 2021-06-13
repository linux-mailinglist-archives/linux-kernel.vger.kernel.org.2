Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785353A5A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhFMSiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 14:38:54 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44637 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhFMSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 14:38:52 -0400
Received: by mail-lj1-f169.google.com with SMTP id d2so16886769ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABCZuN3t1TlhXpGL1G5x2Ki4iTUdcfdjekYhFBxIM58=;
        b=BCYjyrvt6+vAHcrfJ4JdKOt7Z7iDGaaiHjupD8+mJIR1FALC6ukaJyPYJv5S/6NtZ8
         xeY3ph1P3kr7MAey6NOYat6yowGQRrDda1+HCn/yYQInYaqwS0Wfi60uolvdqn3bN13a
         eEGcmvuPL5D9Yor8KKc/ZsRA1ArEmDKGz/ZKUOkJdNIMRN1dhekRXY1wF6+ESwmH01xh
         vWeKGOOY1g2Bsldxp3hlwhtBdkvWidTn+mPylPqQqSixmOWwJPI9ccDn0fCGz7gHYPCE
         wrs6VtaOgzArlZNEW83JI1+UCdg64AZu9HHYwDiHxG+buflqdhiZtXYAw4JMvh/n0c/w
         ynRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABCZuN3t1TlhXpGL1G5x2Ki4iTUdcfdjekYhFBxIM58=;
        b=AXhBJon9PDIVLNfpM18ULkr9S2axw0xrdEujI34zBgD+0FqIPFAdbcPGKOq83SrOQ3
         Xo2WvOUeaLrhAbi4KfYWC5KI3KgaNow2syo1IhGBzCnwPT1qP3fIcCNJ992un6AcT3XG
         Q6O+F/XzDbX6TA4SU7S2fvp8VWdDFJjBDiJnaCAaSICCu9wVb4JfdO5+Kr20LYnDmi8V
         OdfV+Gjz2ZyLKnaMp+4O5JWo1NhBlhtoFpAWDQjislIIrEGQa3opDhhMYya4GNcurz3t
         PeDtsI86w2/ZhXihdDu0iRmJ+7BZyARh+rZW9leVkB93hbH+8YATWJqnAdIRpiW+uns5
         DPiw==
X-Gm-Message-State: AOAM531SL8esdL62SDoittCdfnWAHApNM5QsecnMNM4HqDIE/J6dklWe
        b2Fb34BVrN3jOs4gXQk7GvfXm70t5WzFFhXo
X-Google-Smtp-Source: ABdhPJys6iUk47YA7nWrTTeLUIq63E6kg/b8lzDwkiIPE04hoQDdV/v88ZnlGrmOnPzg+Gief66l5g==
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr10904765ljn.266.1623609337157;
        Sun, 13 Jun 2021 11:35:37 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e12sm904984lfs.157.2021.06.13.11.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 11:35:36 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH 0/3] ACPI MDIO support for Marvell controllers
Date:   Sun, 13 Jun 2021 20:35:17 +0200
Message-Id: <20210613183520.2247415-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The MDIO ACPI binding has been established and merged to the
Linux tree, hence it is now possible to use it on the platforms
that base on the Marvell SoCs.

This short patchset adds ACPI support for the mvmdio controller.
mvpp2 driver is also updated in order to use the phylink in
ACPI world. For the latter a backward compatibility is ensured
- in case an older firmware is used, the driver would fall back to the
hitherto link interrupt handling.

The feature was verified with ACPI on MacchiatoBin and CN913x-DB.
Moreover regression tests were performed (old firmware with updated kernel,
new firmware with old kernel and the operation with DT).

The firmware ACPI description is exposed in the public github branch:
https://github.com/semihalf-wojtas-marcin/edk2-platforms/commits/acpi-mdio-r20210613
There is also MacchiatoBin firmware binary available for testing:
https://drive.google.com/file/d/1eigP_aeM4wYQpEaLAlQzs3IN_w1-kQr0

I'm looking forward to the comments or remarks.

Best regards,
Marcin


Marcin Wojtas (3):
  net: mvmdio: add ACPI support
  net: mvpp2: enable using phylink with ACPI
  net: mvpp2: remove unused 'has_phy' field

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      |  3 ---
 drivers/net/ethernet/marvell/mvmdio.c           | 27 +++++++++++++++++---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 22 ++++++++++++----
 3 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.29.0

