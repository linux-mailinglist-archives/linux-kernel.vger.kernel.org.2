Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1A35C2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbhDLJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241138AbhDLJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3187961241;
        Mon, 12 Apr 2021 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220314;
        bh=k1Sd4rAMYWMlDhLoHNPu6fYVil0U0AGrARqI1KH+i1A=;
        h=From:To:Cc:Subject:Date:From;
        b=oN1L6yOUFCM+nhAs28yUWvF3Alh78y1ibidFD8rR3TCxL0o58+S1Kg25pdoAPmuci
         QP3N5e1fdrDJr2UazzQAZEfU09WbKQmrDf+C/bXoDiii144GyX4A1x2fGcS3NN2dZB
         olbe5hBxHINXpwX4fdQDP5G87dD0bX3cwSZTqGvZcRikWXoZXaMmR7hbXz2aYrOKJL
         y3jntC9m8xU2EPS38ACOBsxwmNCk0KsxN0bptfKn+3xNZjFXBIrbP5KNlP2xeUxFsX
         6X41ogDgToZMLHFH7cu27PzotkbhwpKjmiFD6Yqr4MtotMom/wGWgFTUiXGUJ7zPem
         Ss/beDiJ7NGag==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVt1Y-0000Cg-76; Mon, 12 Apr 2021 11:38:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] USB: serial: closing-wait fixes and cleanups
Date:   Mon, 12 Apr 2021 11:38:11 +0200
Message-Id: <20210412093815.736-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port drain_delay parameter is used to add a time-based delay when
closing the port in order to allow the transmit FIFO to drain in cases
where we don't know how to tell if the FIFO is empty.

This series removes a redundant time-based delay which is no longer
needed, and documents the reason for two other uses where such a delay
is needed to let the transmitter shift register clear. As it turns out,
this is really only needed for one of the two device types handled by
the ti_usb_3410_5052 driver.

Johan


Johan Hovold (4):
  USB: serial: f81232: drop time-based drain delay
  USB: serial: io_ti: document reason for drain delay
  USB: serial: ti_usb_3410_5052: reduce drain delay to one char
  USB: serial: ti_usb_3410_5052: drop drain delay for 3410

 drivers/usb/serial/f81232.c           |  1 -
 drivers/usb/serial/io_ti.c            |  4 ++++
 drivers/usb/serial/ti_usb_3410_5052.c | 21 ++++++++++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.26.3

