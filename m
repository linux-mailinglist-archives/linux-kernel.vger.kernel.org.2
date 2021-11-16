Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42060453322
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhKPNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhKPNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:49:08 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B75C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:46:11 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so32722997otg.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=24Uh5VRqdE59aVg7rczh+ITIY+lbDTFREP3wgwh5mSY=;
        b=JpUrV2DzG4SHvmMhNauH5/CFKuSKrqgFrMwQdm5s5rWeL36qEgNoQWL4yjtaGvD4vx
         +S+xxSK07NJ+w4lYvbs9zsPTPBVGOB95iwNDqzEKEajSjLIiAvv59ixU3G34vNlx0xbT
         shqeEWflwWSqVRylelg1oSp0U+T1+9CGT0Nn9MALs/xj7+fXd+Gxd8fdMfrSvrAwTQ44
         2hfKWVrO/HQ0mnPuXNyzkM9BoMc5IQRE4kzirPyy17e3p+r4EoLKQXIKnRPY6I/4/dRJ
         bp9lVBgG1Ap3a7xlueuHD2fpQgeoHdKTGbGIcGkMkRwK+DL85+N5KiPNa75ITRCFIZy9
         N4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=24Uh5VRqdE59aVg7rczh+ITIY+lbDTFREP3wgwh5mSY=;
        b=4qC5AIvMex1byLeHnmIB7t3pKYP1l2KX/t/SwnTvAaFyIeLki2cuyCRks1iY+/wHrO
         uRxDK+lgxOF8iLyXlFNf1o1h6ey6MXTvTei0d0mQbYjdkVTTp/hgTeBXezR8L0Nj+gHY
         nvxr8/ngB2NZAEMIR793CX86A9i8rs4qlNwkgXYBvfBhGwJxxW3R+sToTjMzG0O/XV0a
         CfOT5e32ewFt82Qgghm91BBQJahXL/GeCDLUaOiLWgOvyF5Hn9tAWAQcFz4ptZ+ATBz+
         g76Gifh9RaG78o8fxn0OguAPlSFUnKkk7/ihBX6mz0zmO6LhvLZpboCh6ICOr0jddwEo
         A6Mg==
X-Gm-Message-State: AOAM530G5xUW0j5Y+1eVjNRVelYRL1wKqVXxz9TsDtRJ0RvlqfrLOoyk
        qdz4FxB0dSBDsceBMYNIOke9G4u6kExE+FRkZcE/Ql8szbNkPg==
X-Google-Smtp-Source: ABdhPJyI+WTMf9Dl27teHnY9G571XZTHRg5enG+0OPLGulkaxOQUIiAlPFAwtUUlu13lm9BILzpBltR4ima8ZcBdfSQ=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr5994793otl.351.1637070370872;
 Tue, 16 Nov 2021 05:46:10 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Tue, 16 Nov 2021 19:15:59 +0530
Message-ID: <CAHP4M8UvwsS6QpV6PX-qf=d2u9Qw35Hafv-BTMGUWeSc0nUBXA@mail.gmail.com>
Subject: Mouse stops working at random intervals in latest kernel
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I have been seeing following errors at random times.
When this happens, the (wireless-)mouse stops working. The USB-dongle
has to be removed, and re-inserted again to get the mouse working
again.

This has not happened before, only observing it since last 2-3 days.
Kernel is mainline at 8ab774587903771821b59471cc723bba6d893942.

Anyone seeing similar issue?


###########################
Nov 16 18:15:19 host-x86-64 kernel: [ 5005.107017] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:19 host-x86-64 kernel: [ 5005.186745] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.374638] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.562650] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.642638] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5005.830670] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:20 host-x86-64 kernel: [ 5006.018544] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.434527] usb 2-1.2: device
not accepting address 11, error -32
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.514531] usb 2-1.2: reset
full-speed USB device number 11 using ehci-pci
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.930613] usb 2-1.2: device
not accepting address 11, error -32
Nov 16 18:15:21 host-x86-64 kernel: [ 5006.931546] usb 2-1.2: USB
disconnect, device number 11
Nov 16 18:15:21 host-x86-64 upowerd[1241]: treating change event as
add on /sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2
Nov 16 18:15:21 host-x86-64 kernel: [ 5007.102858] usb 2-1.2: new
full-speed USB device number 12 using ehci-pci
Nov 16 18:15:21 host-x86-64 libvirtd[855]: internal error: Missing
udev property 'ID_VENDOR_ID' on '2-1.2'
Nov 16 18:15:21 host-x86-64 kernel: [ 5007.182555] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.370518] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.558677] usb 2-1.2: new
full-speed USB device number 13 using ehci-pci
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.638657] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.826664] usb 2-1.2: device
descriptor read/64, error -32
Nov 16 18:15:22 host-x86-64 kernel: [ 5007.935063] usb 2-1-port2:
attempt power cycle
Nov 16 18:15:23 host-x86-64 kernel: [ 5008.538604] usb 2-1.2: new
full-speed USB device number 14 using ehci-pci
Nov 16 18:15:23 host-x86-64 kernel: [ 5008.956553] usb 2-1.2: device
not accepting address 14, error -32
Nov 16 18:15:23 host-x86-64 kernel: [ 5009.034629] usb 2-1.2: new
full-speed USB device number 15 using ehci-pci
Nov 16 18:15:24 host-x86-64 kernel: [ 5009.450570] usb 2-1.2: device
not accepting address 15, error -32
Nov 16 18:15:24 host-x86-64 kernel: [ 5009.450881] usb 2-1-port2:
unable to enumerate USB device
#######################################


Thanks and Regards,
Ajay
