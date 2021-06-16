Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799993A9299
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFPGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhFPG3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BC5761403;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=okkMhtxXWhu7jcblc1Rd7fTE3JvHjA3XMDhYuWCIcG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idawJUMTDJ9MSzxwBFw5KStnenGAsnj3LctDAoX0gfMBZuwMb6J80+atebHf089d2
         p7C8zEivydQOBPs+bKcXGeFL2HqVBBbczofe3usrMPi4yPNE65XojLG9/nyrAYoyoM
         a8RZ4jDbUAe56zuHleK2P2osJ6lTpzb7cced6sJiNz5qe+UhohZbP3pnYr2AmaBjTq
         aPbBjHLor23Pkk+v9phlZEy5gaL0lTa6Uxef0BJASrtF+VdjWEZAw7aw8udf+34Ylr
         B2gR/n6oMbWY08WLkDshP0drsMV4kGdBySdF/P0lW30X+Pllbu1vgc3hlf5XO8R7eg
         RacaLl+veTxTQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJG-LF; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/29] docs: driver-api: surface_aggregator: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:30 +0200
Message-Id: <6097027b4de4c9015485cb73b297b98660c4296d.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../surface_aggregator/clients/index.rst          |  3 ++-
 .../driver-api/surface_aggregator/internal.rst    | 15 ++++++++-------
 .../driver-api/surface_aggregator/overview.rst    |  6 ++++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/surface_aggregator/clients/index.rst b/Documentation/driver-api/surface_aggregator/clients/index.rst
index 98ea9946b8a2..30160513afa5 100644
--- a/Documentation/driver-api/surface_aggregator/clients/index.rst
+++ b/Documentation/driver-api/surface_aggregator/clients/index.rst
@@ -5,7 +5,8 @@ Client Driver Documentation
 ===========================
 
 This is the documentation for client drivers themselves. Refer to
-:doc:`../client` for documentation on how to write client drivers.
+Documentation/driver-api/surface_aggregator/client.rst for documentation
+on how to write client drivers.
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/driver-api/surface_aggregator/internal.rst b/Documentation/driver-api/surface_aggregator/internal.rst
index 72704734982a..8c7c80c9f418 100644
--- a/Documentation/driver-api/surface_aggregator/internal.rst
+++ b/Documentation/driver-api/surface_aggregator/internal.rst
@@ -87,10 +87,11 @@ native SSAM devices, i.e. devices that are not defined in ACPI and not
 implemented as platform devices, via |ssam_device| and |ssam_device_driver|
 simplify management of client devices and client drivers.
 
-Refer to :doc:`client` for documentation regarding the client device/driver
-API and interface options for other kernel drivers. It is recommended to
-familiarize oneself with that chapter and the :doc:`ssh` before continuing
-with the architectural overview below.
+Refer to Documentation/driver-api/surface_aggregator/client.rst for
+documentation regarding the client device/driver API and interface options
+for other kernel drivers. It is recommended to familiarize oneself with
+that chapter and the Documentation/driver-api/surface_aggregator/ssh.rst
+before continuing with the architectural overview below.
 
 
 Packet Transport Layer
@@ -190,9 +191,9 @@ with success on the transmitter thread.
 
 Transmission of sequenced packets is limited by the number of concurrently
 pending packets, i.e. a limit on how many packets may be waiting for an ACK
-from the EC in parallel. This limit is currently set to one (see :doc:`ssh`
-for the reasoning behind this). Control packets (i.e. ACK and NAK) can
-always be transmitted.
+from the EC in parallel. This limit is currently set to one (see
+Documentation/driver-api/surface_aggregator/ssh.rst for the reasoning behind
+this). Control packets (i.e. ACK and NAK) can always be transmitted.
 
 Receiver Thread
 ---------------
diff --git a/Documentation/driver-api/surface_aggregator/overview.rst b/Documentation/driver-api/surface_aggregator/overview.rst
index 1e9d57e50063..26415e1ab7da 100644
--- a/Documentation/driver-api/surface_aggregator/overview.rst
+++ b/Documentation/driver-api/surface_aggregator/overview.rst
@@ -73,5 +73,7 @@ being a direct response to a previous request. We may also refer to requests
 without response as commands. In general, events need to be enabled via one
 of multiple dedicated requests before they are sent by the EC.
 
-See :doc:`ssh` for a more technical protocol documentation and
-:doc:`internal` for an overview of the internal driver architecture.
+See Documentation/driver-api/surface_aggregator/ssh.rst for a
+more technical protocol documentation and
+Documentation/driver-api/surface_aggregator/internal.rst for an
+overview of the internal driver architecture.
-- 
2.31.1

