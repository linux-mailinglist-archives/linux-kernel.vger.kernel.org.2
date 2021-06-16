Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02A43A929A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFPGbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhFPG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457B7613FE;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=L7h+ou0mKQ8i1B6wVmMcnfpfNQNeeZ14Zy4GBxWvJlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUBzmmLmlo1DCg9O4/Swqz9gD3V7ESwieyqEq8DSuTLcDbtrgLFAcx9LehSKKUqRR
         BJW9wDkrmwTGy3J+Jf7HTrwRyr4lwQkZ56J3Eiq46OmTgO4rSQgm1D8rtL6kb7O++w
         YXGdJkH1McqmXh+1a/4IOXIE1BjMNzyCUhUlvs6DzYr1T2mpGqLivZVn3wr4AbN7vL
         f3b+kgisdndfU64L3p00NMnmXX0nRE3T5MlieJqPYhU2p0rZFkpTnE7a7N/MKGP0Wb
         1682QP2vlzI3lXZYUKNqRUHDxQgiY99e9hwumdmZz8iODQ0XPhP8EktIFnLslBR8Z3
         HM06slsMj/jLQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJ8-GX; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/29] docs: driver-api: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:28 +0200
Message-Id: <095b04bff6d49b4097382398bb91102eaa3f0fd3.1623824363.git.mchehab+huawei@kernel.org>
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

