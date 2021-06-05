Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF739C8C4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFENVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhFENU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC7FB613D8;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899118;
        bh=v0tsfMQudOzaQ7dfwVoNu4Jf95yigoijEw0Kv4pa4vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGlOHDBLEKV9WFcBErXFpNxum6xOcyXBRddRhcbo++/PuUkiLeuBMlvvUVSOJev3x
         1OEy6RC2SLMiltQ1L3x1XVpbmZROr6qaavuW/zQOlWCL7b9dRvsqq+B2+UZnWXklNX
         p88rJqYvfPCfmpoCsu0o/HhBRHy6Cefwt2ZDYs3D8UvY+bQYNKom6r5AJzTkpk9zHR
         TDWGHdP8iRV//2NycELWPUNmuGCAN2WBxhaegiD1RWHx5ZlTd9yoR4BMvkCKcFZyG5
         Clkg69h70a9almXAsY8sl7TMAmaAYg1YZ/J6qdFZIlaqPVCyl22c2vkCwxy09FlAf2
         x5aDxQ6ym8lMQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GFh-4e; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/34] docs: driver-api: surface_aggregator: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:18 +0200
Message-Id: <c42fe427e6538ce7914645468ef63f83254c26d7.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

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

