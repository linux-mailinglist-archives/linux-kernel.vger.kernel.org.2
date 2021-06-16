Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34893A929C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFPGbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231532AbhFPG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4434C613FB;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=10m6lRZyRVnoXgx/oN7Q2inx+Rz6qUWeZ8SRCqU0QQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4jHZ1HDdq6T04odSzzj5HViTbmbDaYA2PCNO0VdxBftWIFpwvlWjt7D1Ji8sav2h
         UlqhgKTjco3E+ZT4bk+jfqEaJcEWuCCMK/sHOGnKp1VUGvlJtQSi3qnYlIW27cHZfS
         2BzHzkO29Jd42sXHhrMs7OV1o+rZs0LtM65eAk1uDGf0XCSS55wIoP1/3bm8YBIkcf
         zN6CRs7uPAG6YBJzDi/jkEGEG0Imiad5kslVdbA56MjRvn+utg+sLbls9qsexqLGNd
         Ba9SbQc1yWrnG9VOPggz4fvPVy1rl8EZ8NqOkBvDe6fa2Cze4Gwivl6rtFLqIck/MC
         HqcWBvtl3yg+Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJ4-Ex; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/29] docs: doc-guide: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:27 +0200
Message-Id: <d6cbe5183406e3378ed4bd0f84f4bcf85a15009c.1623824363.git.mchehab+huawei@kernel.org>
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
 Documentation/doc-guide/contributing.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc-guide/contributing.rst
index 67ee3691f91f..207fd93d7c80 100644
--- a/Documentation/doc-guide/contributing.rst
+++ b/Documentation/doc-guide/contributing.rst
@@ -237,10 +237,10 @@ We have been trying to improve the situation through the creation of
 a set of "books" that group documentation for specific readers.  These
 include:
 
- - :doc:`../admin-guide/index`
- - :doc:`../core-api/index`
- - :doc:`../driver-api/index`
- - :doc:`../userspace-api/index`
+ - Documentation/admin-guide/index.rst
+ - Documentation/core-api/index.rst
+ - Documentation/driver-api/index.rst
+ - Documentation/userspace-api/index.rst
 
 As well as this book on documentation itself.
 
-- 
2.31.1

