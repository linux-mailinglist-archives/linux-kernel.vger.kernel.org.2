Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249BB34EA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhC3OiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231982AbhC3OiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:38:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79774619CD;
        Tue, 30 Mar 2021 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115085;
        bh=g73wNQL4k2lRInaQ6dxIl0zoTR2Hfi58MBlUV2HHCkc=;
        h=From:To:Cc:Subject:Date:From;
        b=md9IPXStO783PgnO1IrO+hK6MdBy1oTGbtqgwYY5Q3FwdGSkLOt11S7DP94G9SiUs
         vJ2x6LgsYhDBzSdcKXMflQ4NSrcPDg98mq5KBiXxS8U6cFGeGn5Ze02izDv9UpRcbF
         cwOtCsM0GU6o2N2Mxy7kj63adb8GhFejM915GG2BXakf+whcA41tAi+pQK8v/g2kbY
         jE7Q+BcGxkMaamYLarzvo3/3EOnte7zaTKo9TdO45Arrfmpv32OiyWD31gqL4h36Ns
         TwrsnDmsfZv7qlfS+v/y8mNfniawIh2W2g/j4rNCXNQhPunPalz3Akpcp8KRbem/OV
         sqpghxoYqkjzA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFVj-0002Ni-89; Tue, 30 Mar 2021 16:38:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] USB: serial: add support for multi-interface functions
Date:   Tue, 30 Mar 2021 16:38:16 +0200
Message-Id: <20210330143820.9103-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single USB function can be implemented using a group of interfaces and
this is for example commonly used for Communication Class devices.
    
This series adds support for multi-interface functions to USB serial
core and exports an interface that allows drivers to claim a second
sibling interface. The interface could easily be extended to allow
claiming further interfaces if ever needed.

The final patch uses the new interface to properly claim both the
control and data interface of Maxlinear/Exar devices.

Johan


Johan Hovold (4):
  USB: serial: drop unused suspending flag
  USB: serial: refactor endpoint classification
  USB: serial: add support for multi-interface functions
  USB: serial: xr: claim both interfaces

 drivers/usb/serial/usb-serial.c | 135 ++++++++++++++++++++++++--------
 drivers/usb/serial/xr_serial.c  |  26 +++++-
 include/linux/usb/serial.h      |   8 +-
 3 files changed, 131 insertions(+), 38 deletions(-)

-- 
2.26.3

