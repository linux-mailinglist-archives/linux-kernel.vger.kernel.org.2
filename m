Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07C442F149
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhJOMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhJOMtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:49:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFBCF60E74;
        Fri, 15 Oct 2021 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302036;
        bh=E5k2HTIRbUfBsfEugTyFO8a3KkwFdQqwxFYzhmB0Fok=;
        h=Date:From:To:Cc:Subject:From;
        b=BX1kxrWzyjA+IhqoEGFPxmatLeG5hnhaZ1Nwu2jFOSOzXCTryWjTEDj8yKY9c04n6
         9FHou7PBMz9xnNq1Sy2AJMF0LDraBNvQARoOihT7X1S5wlLmfy+iwivNiI9CVm3giJ
         B7JlUE8gXmMlb9lNDnpvi8HSsx3bcykaZIP9SBM2vRhR2zaKjyP12I/6PVMzakaRlA
         jN4qeRi7zo3t2o0V+756hjKuGFq7mhGWDFAsu4uTHNkhA/WPwKTelVW5OjRtrYW/c9
         RQBZwcRIwoJOgWP9TVrEtC5VFFOnDRMp7ig/KrdbgPg9nHrQgwGCurWoGL9/xIrg2h
         DgAPBs8sApMHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mbMcA-0003wS-OQ; Fri, 15 Oct 2021 14:47:10 +0200
Date:   Fri, 15 Oct 2021 14:47:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.15-rc6
Message-ID: <YWl4TnaWxDLv/V5z@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.15-rc6

for you to fetch changes up to 11c52d250b34a0862edc29db03fbec23b30db6da:

  USB: serial: qcserial: add EM9191 QDL support (2021-10-07 15:39:06 +0200)

----------------------------------------------------------------
USB-serial fixes for 5.15-rc6

Here are some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Aleksander Morgado (1):
      USB: serial: qcserial: add EM9191 QDL support

Daniele Palmas (1):
      USB: serial: option: add Telit LE910Cx composition 0x1204

Tomaz Solc (1):
      USB: serial: option: add prod. id for Quectel EG91

Yu-Tung Chang (1):
      USB: serial: option: add Quectel EC200S-CN module support

 drivers/usb/serial/option.c   | 8 ++++++++
 drivers/usb/serial/qcserial.c | 1 +
 2 files changed, 9 insertions(+)
