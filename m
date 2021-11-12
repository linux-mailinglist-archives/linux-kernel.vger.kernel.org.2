Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6050444E079
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 03:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhKLCuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 21:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLCuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:50:37 -0500
X-Greylist: delayed 1194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Nov 2021 18:47:47 PST
Received: from hz.preining.info (hz.preining.info [IPv6:2a01:4f9:2a:1a08::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF79C061766;
        Thu, 11 Nov 2021 18:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=preining.info; s=201909; h=Content-Type:MIME-Version:Message-ID:Subject:To:
        From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jdDMVUa9v4ZQsJJWYzaKZGtSp5X4bWCNZQKo+u6ZTc4=; b=MhRC7wRd41Deq465A2b6mRTpOP
        wzRyKiu0heDyGXWkbFpFM7FCJIL1eV0TpitnDra55nmfSbP8/vDo5FLpCBrN/3PshjA9GGWaFCpps
        TU06Bykq9kAinnU9V3BMArh/zhDAt3Day+12ffHpzsAMLKd4ml0L4/FHhVN3+MVuk3zrCATJ3aowp
        jLoaPI2/IpolkU09JR1TyElRWH8ggelB0S0wheZ9EgZymgqDTDl29ppsFv32BqBSzm/hYUiYkDaP2
        ah5Aafv4RoglYy07N23I8vItPcWQHeGhj//liu0WPnI1c7/XNiTrC5oHom5BII67UUkuZLEKpDqsz
        665JjKQQ==;
Received: from tvk213002.tvk.ne.jp ([180.94.213.2] helo=bulldog.preining.info)
        by hz.preining.info with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <norbert@preining.info>)
        id 1mlMIA-0005md-B6; Fri, 12 Nov 2021 02:27:50 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
        id 225411A383C6E; Fri, 12 Nov 2021 11:27:45 +0900 (JST)
Date:   Fri, 12 Nov 2021 11:27:45 +0900
From:   Norbert Preining <norbert@preining.info>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [5.12 - 5.15] xHCI controller dead - not renesas but intel
Message-ID: <YY3RIdKBbIL3Dw/q@bulldog.preining.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

(please Cc)

I see quite some discussion here about hanging USB controls from
Renesas. Interestingly, I see the very same behaviour with my Intel USB
controller:
00:14.0 USB controller: Intel Corporation 100 Series/C230 Series Chipset Family USB 3.0 xHCI Controller (rev 31)

It happens again and again that:
Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: Abort failed to stop command ring: -110
Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: HC died; cleaning up
Nov 12 10:57:58 bulldog kernel: xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command

and I loose all mouse/kbd access.

I have the feeling that it happens more often/at all when I redirect my
USB webcam to a virtual machine using virt-manager.
Before the above happened, the log showed
Nov 12 10:57:06 bulldog kernel: usb 1-12: reset high-speed USB device number 47 using xhci_hcd
Nov 12 10:57:11 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 12 10:57:27 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 12 10:57:27 bulldog kernel: usb 1-12: reset high-speed USB device number 47 using xhci_hcd
Nov 12 10:57:32 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 12 10:57:48 bulldog kernel: usb 1-12: device descriptor read/64, error -110
Nov 12 10:57:48 bulldog kernel: usb 1-12: reset high-speed USB device number 47 using xhci_hcd

where 
HD Pro Webcam C920 as /devices/pci0000:00/0000:00:14.0/usb1/1-12/1-12:1.0/input/input40

I am currently running 5.15.1.

Is there anything (besides ssh-ing into the machine and unbind/bind the
pci device) I can provide or do?

(Please cc)

Thanks

Norbert

--
PREINING Norbert                              https://www.preining.info
Fujitsu Research  +  IFMGA Guide  +  TU Wien  +  TeX Live  + Debian Dev
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13
