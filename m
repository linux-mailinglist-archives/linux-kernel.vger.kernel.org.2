Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B481730858B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhA2GPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhA2GO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:14:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p15so5238390pjv.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5XPU2O92MWNnCS3LVkCZpTO8otBVCUVbbrYWvGV4XU=;
        b=B1d8OMzUWxIcJs3Nh5oCqsfJaWFt4KFNUhkf0zXV53Jm52BfVmRXvqbq8TcRIUM8i8
         gDPRtWeMChqoYd4SxJwOCATj+9P0/p1lPBJ7rMI3BoxR3OLohzmulkPcRp2a1OeH1Lrj
         QWu2wxCq9ssjTX7j/KSJYf2AIVvxmTBR/tdS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5XPU2O92MWNnCS3LVkCZpTO8otBVCUVbbrYWvGV4XU=;
        b=DMXviJtPqqwJF10VK7mJiNingPD6jSN2wXF7vvWt5bgJfXJD+Y4wrW0nYc6bPgHyj8
         qBK+yuS7YtzpYrykcS/xrVeb7NdBYQG60RxTyrGZSBvIJaDaJKLzDayzsIxCOE2+4XJj
         6xs19dfOC+rF4ZwBijUzV5JGcSy/xV2o0SZqy3yX8iJFVEVvgA2/PhP0lgs3YaUUZPxE
         UPSOLOBRbxf7vLdQclzw4yNmW+pm36ERdG78r2GpW1zKWX6xUiVPICNuj62BZsUyeM8j
         qj9b0g3V45wsNpo05rPx7XF51QsM4ZNiJ/lTVbq96p8OUfCsSzmsVlzoTRr16KEi8Tzp
         jbHg==
X-Gm-Message-State: AOAM531hoB9m7/8mnDINSDEGR9aeiiI0n7ZvPOHJEdiCbXgqgT+6gOBk
        izsK8Ou1DojLr9ehJ6pNL80RDQ==
X-Google-Smtp-Source: ABdhPJyxB6vx5pQsRDOZMdlIx2/tW7HucM03QMW9SkTmUrh/OcTHy8sq9gjZULItqURsORdeeT/Plw==
X-Received: by 2002:a17:90b:3c8:: with SMTP id go8mr3103108pjb.105.1611900856579;
        Thu, 28 Jan 2021 22:14:16 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id 17sm7551013pfv.13.2021.01.28.22.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:14:16 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com, bleung@chromium.org
Subject: [PATCH 0/6] usb: typec: and platform/chrome: Add PD revision numbers
Date:   Thu, 28 Jan 2021 22:14:00 -0800
Message-Id: <20210129061406.2680146-1-bleung@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Power Delivery has a 3 entity handshake (port, cable, partner), and as
of USB PD R3.0, each entity may independently support either Revision 2 or
Revision 3 signaling and protocol. In order for userspace and the kernel
to properly process the data objects received from a particular SOP*, we
must know to which revision of the spec each conforms.

This series adds individual version numbers for the partner and the cable,
and exposes them in the appropriate sysfs in /sys/class/typec.

I provide as a first implementation of this, platform/chrome's cros_ec_typec
driver, whose underlying status messages convey the SOP and SOP' revisions
already.

Thanks,
Benson

Benson Leung (6):
  usb: typec: Standardize PD Revision format with Type-C Revision
  usb: typec: Provide PD Specification Revision for cable and partner
  usb: typec: Add typec_partner_set_pd_revision
  platform/chrome: cros_ec_typec: Report SOP' PD revision from status
  platform/chrome: cros_ec_typec: Set Partner PD revision from status
  platform/chrome: cros_ec_typec: Set opmode to PD on SOP connected

 Documentation/ABI/testing/sysfs-class-typec | 20 ++++++-
 drivers/platform/chrome/cros_ec_typec.c     | 26 +++++++--
 drivers/usb/typec/class.c                   | 59 +++++++++++++++++++--
 include/linux/usb/typec.h                   | 11 ++++
 4 files changed, 108 insertions(+), 8 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

