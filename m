Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526BF34EAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhC3OkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231859AbhC3Oji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2578A619C8;
        Tue, 30 Mar 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115178;
        bh=vDIpePSNo+XqtVznFzgze6DPaKKSmI8fQ1aqspWp1U0=;
        h=From:To:Cc:Subject:Date:From;
        b=TMfN4ZKrFb8F/SkFj4QUSUJ7WpqoXrlYCdOAwPjX02/6eWO8G0vqD4wfp95yu2HvQ
         oSpnxQGABTrNC2kgpIHsfcp8p7Wsa1rYFoaHQ7xYZkcd82/zha/SZo463+cNebhkOd
         T1kJwRqkJBR/wpxS6D1izdeMURF/bD7eg/3GkP5arS2ZkQK95zsk5vHh/pSwYUUfjc
         JIb234w70F6yf2BifRZf6lY3eeBAjzCN+aEcMUKTwn0qVR5toFToWN44d6EvkVR0jb
         BcVk56GSF0VRmzAC+35rgbVxTPvOTa4UaTx6div++WGsbKwfhACDsyzTRRqfiCZzcd
         XAe02v5zJzEnA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFXD-0002PD-Nc; Tue, 30 Mar 2021 16:39:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] USB: serial: xr: add support for more device types
Date:   Tue, 30 Mar 2021 16:39:25 +0200
Message-Id: <20210330143934.9197-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for another nine models of Maxlinerar/Exar USB
UARTs to the xr driver. The various models can be divided into four
types:
	
	XR21V141X
        XR21B142X
        XR21B1411
        XR22804

with different register layouts and features.

All types can be used in CDC-ACM mode but further features such as
hardware and software flow control and in-band line status are available
in a second "custom driver" mode.

The fact that hardware flow control is enabled by default in CDC-ACM
mode also prevents using the standard CDC-ACM driver in cases where the
hardware engineers have failed to properly connect the CTS input.

The currently supported XR21V141X type stands out from the other three
by not being able to accept CDC requests without always entering CDC-ACM
mode, requiring a different enable/disable sequence and by using a
distinct register layout for certain functionality.

Expect for the above, most differences can be handled by simply using
different set of register addresses.

Note that this series depends on the recently posted
multi-interface-function series.

Johan



Johan Hovold (11):
  USB: serial: xr: add support for XR21V1412 and XR21V1414
  USB: serial: xr: rename GPIO-mode defines
  USB: serial: xr: rename GPIO-pin defines
  USB: serial: xr: move pin configuration to probe
  USB: serial: xr: drop type prefix from shared defines
  USB: serial: xr: add type abstraction
  USB: serial: xr: add support for XR21B1421, XR21B1422 and XR21B1424
  USB: serial: xr: add support for XR21B1411
  USB: serial: xr: add support for XR22801, XR22802, XR22804
  USB: serial: xr: reset FIFOs on open
  USB: serial: xr: add copyright notice

Mauro Carvalho Chehab (1):
  USB: cdc-acm: add more Maxlinear/Exar models to ignore list

 drivers/usb/class/cdc-acm.c    |  14 +-
 drivers/usb/serial/xr_serial.c | 727 ++++++++++++++++++++++++++-------
 2 files changed, 580 insertions(+), 161 deletions(-)

-- 
2.26.3

