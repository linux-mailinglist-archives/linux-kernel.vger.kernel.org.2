Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47AD45D9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhKYMKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239834AbhKYMHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:07:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F2361041;
        Thu, 25 Nov 2021 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637841884;
        bh=rPq2Ad3fHPPBX3XIqL72QUl4mZ3FkBDQpkBLiVEsWqU=;
        h=Date:From:To:Cc:Subject:From;
        b=P2yvez169HuqQwUguLlRwzXohUVtZZd5vzTu13kt2HPNHFmL+pxq66biw7tef+iJx
         qZPyB78duv609Kv0nj8goIeIJ2+mM5/3EOzpecFK6L2/xMDqgtfkzTpAX6lByeaJ9P
         8j7SALghHJTJC7CIdB4CnfU0Jz4643GzM+/vTb14WWkOMgWDDAVteL9lok19HopIZB
         0u/o8s1DDXq4RhZD4jyJ7uP+q5rtO+Vu8rVEjHr/Jj3JS0LhZ5u/Bh6fX6T+JQ/MER
         fZ1OwolLvVWLXNRNZR2299C5+9ah0DUjNBooX9DiHbHnJFf7T0oOKb7wSbCipKFwjo
         Bi79t+ARDps5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mqDUD-00058k-HF; Thu, 25 Nov 2021 13:04:21 +0100
Date:   Thu, 25 Nov 2021 13:04:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 5.16-rc3
Message-ID: <YZ97xbN1Ln83r+hP@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.16-rc3

for you to fetch changes up to 88459e3e42760abb2299bbf6cb1026491170e02a:

  USB: serial: option: add Fibocom FM101-GL variants (2021-11-24 19:03:31 +0100)

----------------------------------------------------------------
USB-serial fixes for 5.16-rc3

Here's a fix for a pl2303 type-detection issue and some new modem
devices ids.

All but the last commit have been in linux-next, and with no reported
issues.

----------------------------------------------------------------
Daniele Palmas (1):
      USB: serial: option: add Telit LE910S1 0x9200 composition

Johan Hovold (1):
      USB: serial: pl2303: fix GC type detection

Mingjie Zhang (1):
      USB: serial: option: add Fibocom FM101-GL variants

 drivers/usb/serial/option.c | 5 +++++
 drivers/usb/serial/pl2303.c | 1 +
 2 files changed, 6 insertions(+)
