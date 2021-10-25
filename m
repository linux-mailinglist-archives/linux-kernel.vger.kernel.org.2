Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE78C4391B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhJYIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhJYIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:51:21 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6796C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:48:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C24AE171C8D;
        Mon, 25 Oct 2021 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635151734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding; bh=S+YXidpE6e7UM9nb+BPK898lhEqvLrFbdrbGIAn2Eqc=;
        b=YW7FL2KPDqbiv6jyienWfApMWrYs1Z1iHLkC5ZlpD7zDpPwSaGABg4WpXahuoRq/1xNf2z
        qptP0+NSqLEpVodCfkNRJq0BSfAULaKls5Z54/g0pEX11fge9csFy6+RjYtMoHnESiaFHZ
        6drXmeoIB7XHr1p2958iklZ4LdYsfqRHuNzSMUTlozSGzzhP03RTkmLiG6lUnOL1KuZlNv
        nScEUS2FSpFCFaupc8eKyYxkxWmx4SiZWC2PbvJrUNUesRKst7Gtr/i7ICzM+IIb9Gbbgy
        gSGi8xBgXNxefj0PXshZbnTGTNEpePNZk3gRVjR7LwCPBNG5gnCEth3+YY/tCA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Mon, 25 Oct 2021 11:47:03 +0300
Message-Id: <20211025084704.173755-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
The controller does not always start when the system starts up, so we do a forced reset via gpio during initialization.

Changes from v1:
- remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable

Vyacheslav Bocharov (2):
  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open

 drivers/bluetooth/btrtl.c  | 7 +++++++
 drivers/bluetooth/hci_h5.c | 5 +++++
 2 files changed, 12 insertions(+)

-- 
2.30.2

