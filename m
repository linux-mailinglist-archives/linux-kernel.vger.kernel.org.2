Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D540B242
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhINO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234452AbhINO4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89E416112E;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=U/rjBRCMz8JCgCNhy/QYJ+duzkOcKbP/UB9ONK8C6/k=;
        h=From:To:Cc:Subject:Date:From;
        b=ZOIEzZUBslaTNFgA7r2pvqOj6ndXrE4UFMwzWO/fvR9cYPclC5ZQb4uxN332eoVl/
         qP5NhSKWn7U33og9jfthQ7pm3OduqO8LR5vgtjtkAj7xAGLWdMeO5zcpZVxZIsWfbr
         RIY/oE4d65zH5px9OTAmC62IX+yg4sbWT9aAVJm6v91hyB6rSIO6l1lFtpkpBilHAM
         7qo0dCUZe3PuwAqwIgcG+fYYBC56BmiQpaz7Qz1D2s1emObGyHLugP+svDeMzPoB23
         8zaxIOhz+M6xwusSmUdvVIN9VVQ9tuaGvX0pACpVrjRWcImMHrV5WzIU3rsGo5dIKv
         DiENfYHNeYaxw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L6h-Gc; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/8] Add some missing ABI symbols
Date:   Tue, 14 Sep 2021 16:55:13 +0200
Message-Id: <cover.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This series contain some things I detected when using scripts/get_abi.pl.

Most of the patches here add documentation for some symbols that
were upstreamed a long time ago, but, up to today, they weren't
defined.

There are still a lot to be addressed, as, at least on my desktop, there are
8k+ undefined symbols:

	./scripts/get_abi.pl undefined|wc -l
	   8792

Mauro Carvalho Chehab (8):
  ABI: stable/sysfs-module: better document modules
  ABI: stable/sysfs-module: document version and srcversion
  ABI: testing/sysfs-module: document initstate
  ABI: sysfs-devices-power: document some RPM statistics
  ABI: sysfs-devices: add /dev ABI
  ABI: sysfs-bus-pci: add documentation for modalias
  ABI: o2cb: add an obsolete file for /sys/o2cb
  ABI: sysfs-bus-usb: add some missing definitions

 Documentation/ABI/obsolete/o2cb               | 11 +++++
 Documentation/ABI/stable/o2cb                 |  2 +-
 Documentation/ABI/stable/sysfs-devices        |  7 +++
 Documentation/ABI/stable/sysfs-module         | 25 ++++++++---
 Documentation/ABI/testing/sysfs-bus-pci       | 17 ++++++++
 Documentation/ABI/testing/sysfs-bus-usb       | 43 ++++++++++++++++++-
 Documentation/ABI/testing/sysfs-devices-power | 14 ++++++
 Documentation/ABI/testing/sysfs-module        |  7 +++
 8 files changed, 117 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/o2cb

-- 
2.31.1


