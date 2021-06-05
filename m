Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34B39C8B5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFENUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhFENU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF44C6143E;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899117;
        bh=L7h+ou0mKQ8i1B6wVmMcnfpfNQNeeZ14Zy4GBxWvJlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lFcvFouYSJniULI2XRffUZ0+iD6KNUR8d0+jBTt7djd6IMTdmfY+BTYtAIMFiriPh
         A7ny0g5y9OfXUhW7qb1WKFDXtRhYSnPZ83uJ2yjz8UwnSR+dKNTBUU6wLWCZm39mua
         SL7J60rOSMkCYK7MjXicxZJiLcoYQEGtvSEqtL5E55LsTcqKdjtq02Qwud4ojUWAN7
         0y8k4e/F/ujPWaIMccXQlDCfD7LgvbTlFIN1+bfDLfbzQkuAvTAnf2M+uI3jVK7Woj
         Kqa7fx284ElMYptKbLxYoxXqVNe3TK83cHMgBalSsZGkDTlTS8e8jXwQRrv+OlkKes
         27xbwpTUNn0tQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GFZ-28; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/34] docs: driver-api: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:16 +0200
Message-Id: <58c025547ed70426fc12d87320568cb24d1292f8.1622898327.git.mchehab+huawei@kernel.org>
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
 Documentation/driver-api/ioctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/ioctl.rst b/Documentation/driver-api/ioctl.rst
index c455db0e1627..8593cc172f0c 100644
--- a/Documentation/driver-api/ioctl.rst
+++ b/Documentation/driver-api/ioctl.rst
@@ -34,7 +34,7 @@ _IO/_IOR/_IOW/_IOWR
 
 type
    An 8-bit number, often a character literal, specific to a subsystem
-   or driver, and listed in :doc:`../userspace-api/ioctl/ioctl-number`
+   or driver, and listed in Documentation/userspace-api/ioctl/ioctl-number.rst
 
 nr
   An 8-bit number identifying the specific command, unique for a give
-- 
2.31.1

