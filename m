Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799EB3A3FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFKKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFKKNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C8061073;
        Fri, 11 Jun 2021 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623406311;
        bh=RubL5mI4Cz0ynQjXkZCs2IMOwgFTJT53K83CuEjWGYc=;
        h=Date:From:To:Cc:Subject:From;
        b=b8j/wRj7QIP3mJ2EwN8+HqXOgfNzzSqgLiZHJpmU5Uih1AFD1sKq7RlI7pRGaoKBD
         ZA5DpbGqENo6U9ykjKjYt3WhVqXLEBXK0XQlfmnDb7nKW34SxxIZeK9Qovpt+JNRYR
         A094umtiwi+N3YUEmeOKD+fCCmBt2eIaSLx4i+e4pJDxlYxmib0w6JFKlOcw59Qd8h
         osGv9nbvsRJu1nh/8YebhcPhS2U7LDTT6PS5CWsl4Xz4b2t74Qvrsz9Ny3pRm+hVJ8
         sdqGEMFsQ4SpV/7UXRG/S7NEbS9cNEZ8Et/F3Qq8XxTfR6L07YAGHV71xr1MaycmUb
         TBDtV7Rt2lGHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lre8g-000201-9d; Fri, 11 Jun 2021 12:11:46 +0200
Date:   Fri, 11 Jun 2021 12:11:46 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.13-rc6
Message-ID: <YMM24hYHEe78rHoJ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bc96c72df33ee81b24d87eab953c73f7bcc04f29:

  USB: serial: ftdi_sio: add NovaTech OrionMX product ID (2021-06-05 12:26:01 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.13-rc6

for you to fetch changes up to 63a8eef70ccb5199534dec56fed9759d214bfe55:

  USB: serial: cp210x: fix CP2102N-A01 modem control (2021-06-10 16:59:00 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.13-rc6

Here are two fixes for the cp210x driver. The first fixes a regression
with early revisions of the CP2102N which specifically broke some ESP32
development boards. The second makes sure that the pin configuration is
detected properly also for the CP2102N QFN20 package.

Both have been in linux-next over night and with no reported issues.

----------------------------------------------------------------
Johan Hovold (1):
      USB: serial: cp210x: fix CP2102N-A01 modem control

Stefan Agner (1):
      USB: serial: cp210x: fix alternate function for CP2102N QFN20

 drivers/usb/serial/cp210x.c | 84 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 6 deletions(-)
