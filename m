Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B9639C867
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFENU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFENUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5447B613D8;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899117;
        bh=asTkRaIynv0EXyPf2YOE4npgGc5H+lLigxxTS3UFkZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWjNieVyd9OpRyqw850ZLuEqUL6ind5aa7j0879u/Jb5eDn/PJnP0uH/ZuWkuBbcN
         o8mwd4xJS0BNWwM5XomJPU4LNkqmDdP8ENQdCsgsjeyP2itBOtACYNk2yp0HfVlSTh
         1mNHJ5MycYr7UVJ1OvSwZeSpStg4n+5fVRoDdm73aet2Wwz1osGXxB6AqqkUD86X8a
         lvuYLIeq4SioFxBzHkiuE7NYUr7b6P1rhkmu0C/dH6TPSNWbud0LrM1y7ECbKt28H3
         qhWGaLwvZChMpRq9Rrwrg+ZmImvGuJGvALEl3IgE6mOzK/l3a+0VKxOCqkrpeGq2E6
         dRWnB8RyiZgag==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCB-008GEX-8w; Sat, 05 Jun 2021 15:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/34] docs: devices.rst: better reference documentation docs
Date:   Sat,  5 Jun 2021 15:18:00 +0200
Message-Id: <0c0302e9294a3c3694a3c362d4b54b336e7ef9c8.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to use either :file: or :doc: tags for documentation,
as automarkup.py automatically converts Documentation/*.rst into
a cross-reference.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/pm/devices.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index 6b3bfd29fd84..d448cb57df86 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -217,7 +217,7 @@ system-wide transition to a sleep state even though its :c:member:`runtime_auto`
 flag is clear.
 
 For more information about the runtime power management framework, refer to
-:file:`Documentation/power/runtime_pm.rst`.
+Documentation/power/runtime_pm.rst.
 
 
 Calling Drivers to Enter and Leave System Sleep States
@@ -655,7 +655,7 @@ been thawed.  Generally speaking, the PM notifiers are suitable for performing
 actions that either require user space to be available, or at least won't
 interfere with user space.
 
-For details refer to :doc:`notifiers`.
+For details refer to Documentation/driver-api/pm/notifiers.rst.
 
 
 Device Low-Power (suspend) States
@@ -726,7 +726,7 @@ it into account in any way.
 
 Devices may be defined as IRQ-safe which indicates to the PM core that their
 runtime PM callbacks may be invoked with disabled interrupts (see
-:file:`Documentation/power/runtime_pm.rst` for more information).  If an
+Documentation/power/runtime_pm.rst for more information).  If an
 IRQ-safe device belongs to a PM domain, the runtime PM of the domain will be
 disallowed, unless the domain itself is defined as IRQ-safe. However, it
 makes sense to define a PM domain as IRQ-safe only if all the devices in it
@@ -805,7 +805,7 @@ The ``DPM_FLAG_MAY_SKIP_RESUME`` Driver Flag
 --------------------------------------------
 
 During system-wide resume from a sleep state it's easiest to put devices into
-the full-power state, as explained in :file:`Documentation/power/runtime_pm.rst`.
+the full-power state, as explained in Documentation/power/runtime_pm.rst.
 [Refer to that document for more information regarding this particular issue as
 well as for information on the device runtime power management framework in
 general.]  However, it often is desirable to leave devices in suspend after
-- 
2.31.1

