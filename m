Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C235843307A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhJSIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234694AbhJSIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843B76112D;
        Tue, 19 Oct 2021 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634630667;
        bh=oMYVDV0hrq2jQ2hvR/yoHcbLCTqR/xm1uxpis8ztOhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEPUp8FVjt9zVrDmCY32bJYdR/wK1XgHOCrhU15BZnVcJiwVb2kMW+KDeUXVP8Uhd
         eXt41tvaesGRA7UD2xba50h7+LOWtZ2nxZWj1BYAxOYzPOfVI3sb4uAQcOoPuoSrmh
         bTj4TpCoISXz9J2R2BcJocELuGFPezhWFiP2z5GVUT0b+2bBXbIZGv/pRcfeMKcEH2
         11J1jU89onJtYPKTxQk5Snu7SLRWDF4AZDor1BA3eaQF1UOw4ZGa0dQy6LgbMjaZ5w
         FlvGLy5X150JPAyDBETC1vmlGh7njZ3R7GkrOyELR/xe7DXWUcQe2z86JfOlaXoJfQ
         ub7gAFmU671sg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mck6j-001oJv-BG; Tue, 19 Oct 2021 09:04:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        David Heidelberg <david@ixit.cz>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/23] dt-bindings: reserved-memory: ramoops: update ramoops.yaml references
Date:   Tue, 19 Oct 2021 09:04:22 +0100
Message-Id: <bccd9c181b68a1ebbaefd5dcce63e1b8a4b1596c.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634630485.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml")
renamed: Documentation/devicetree/bindings/reserved-memory/ramoops.txt
to: Documentation/devicetree/bindings/reserved-memory/ramoops.yaml.

Update the cross-references accordingly.

Fixes: 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert txt bindings to yaml")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/

 Documentation/admin-guide/ramoops.rst | 2 +-
 MAINTAINERS                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index 8f107d8c9261..e9f85142182d 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -69,7 +69,7 @@ Setting the ramoops parameters can be done in several different manners:
 	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
 
  B. Use Device Tree bindings, as described in
- ``Documentation/devicetree/bindings/reserved-memory/ramoops.txt``.
+ ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
  For example::
 
 	reserved-memory {
diff --git a/MAINTAINERS b/MAINTAINERS
index d74b08c4fb1f..1dc758a0db58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15336,7 +15336,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
 F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/admin-guide/pstore-blk.rst
-F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+F:	Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
 F:	drivers/acpi/apei/erst.c
 F:	drivers/firmware/efi/efi-pstore.c
 F:	fs/pstore/
-- 
2.31.1

