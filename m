Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3394937F101
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhEMBq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhEMBq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:46:56 -0400
X-Greylist: delayed 2218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 May 2021 18:45:47 PDT
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A30C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 18:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AqCekTC5qNNLCcdsWddYcLaLECMycIHElFDxC9ODVBQ=; b=FE0QKxK6RUUPSrLQsDiQPVlh0C
        pdIpoOu68oBaCdMkPLL4wIF0fIuCsALG1Qpc9ukKuar/Xbw/++zTQ3pmGENIUnqdvlGlQapQ4KEOy
        ac+YYCGD4x0BqA6O/58Bv0yEItsiMCpNSAbiTy+2ipeZbYnOD6p92LU/D8nkuo/zamfYei2cNN9K1
        P3CIYGIvre2qEXfGprRlTsDXe11kWVaKAkJjSv+Su0Mafc50MO4caX8apJR+VVzUKxpFlazXYADQD
        nylL42E1EsPN6d8wMQYGn0Tbjjla0YY7Nz/JncxSDsQvw4x6OAQjBrG/jcwcegGpEBsUivWGiHpZV
        uxVrWmYg==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1lgzqG-0003PZ-Kp; Thu, 13 May 2021 01:08:44 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id B124E162288C5; Thu, 13 May 2021 10:08:41 +0900 (JST)
Date:   Thu, 13 May 2021 10:08:41 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [5.12.X] USB controller committing suicide
Message-ID: <YJx8Gap3ISpj1WW2@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

recently (most probably since switching to 5.12.N) I see USB controller
suicides, with the effect that after that:
$ lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub


This is:
* linux 5.12.X (self compiled)
* Debian/unstable

The dmesg contains the following:
[32154.046627] usb 1-6.1.3.3: Manufacturer: Generic
[39494.338571] usb 1-6.1.3.3: reset full-speed USB device number 12 using xhci_hcd
[39509.694530] usb 1-6.1.3.3: device descriptor read/64, error -110
[39525.314664] usb 1-6.1.3.3: device descriptor read/64, error -110
[39525.506685] usb 1-6.1.3.3: reset full-speed USB device number 12 using xhci_hcd
[39540.930840] usb 1-6.1.3.3: device descriptor read/64, error -110
[39556.546966] usb 1-6.1.3.3: device descriptor read/64, error -110
[39556.738973] usb 1-6.1.3.3: reset full-speed USB device number 12 using xhci_hcd
[39561.843025] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[39567.215047] xhci_hcd 0000:00:14.0: xHCI host not responding to stop endpoint command.
[39567.215053] xhci_hcd 0000:00:14.0: USBSTS:
[39567.215057] xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
[39567.215076] xhci_hcd 0000:00:14.0: HC died; cleaning up
[39567.215091] usb 1-6: USB disconnect, device number 2
[39567.215095] usb 1-6.1: USB disconnect, device number 3
[39567.215097] usb 1-6.1.2: USB disconnect, device number 5
[39567.215117] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[39567.215405] usb 1-6.1.3: USB disconnect, device number 7
[39567.215409] usb 1-6.1.3.1: USB disconnect, device number 8
[39567.423079] usb 1-6.1.3.3: device not accepting address 12, error -62
[39567.523416] usb 1-6.1.3.2: USB disconnect, device number 11
[39567.643321] usb 1-6.1.3.3: USB disconnect, device number 12
[39567.643551] usb 1-6.1.3.4: USB disconnect, device number 10
[39567.772186] usb 1-6.2: USB disconnect, device number 4
[39567.823671] usb 1-6.4: USB disconnect, device number 6

Looking at the systemlog I see only one more line (between the rest of
the noise):
May 13 09:57:41 bulldog systemd-udevd[669]: 1-6.1.3.3: Worker [1112921] processing SEQNUM=3950 is taking a long time


My questions are:
* is there a way to get the USB devices back (I can log in via ssh)
* how can I debug this?
* known issue?

Thanks and all the best

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research  +  IFMGA Guide  +  TU Wien  +  TeX Live  + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
