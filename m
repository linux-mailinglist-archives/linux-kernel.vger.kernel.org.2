Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5473239C8C7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFENVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhFENU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D980C61429;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899117;
        bh=10m6lRZyRVnoXgx/oN7Q2inx+Rz6qUWeZ8SRCqU0QQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0BLCVJ/PwCX7m7HWNc79fN+PlWCHsnTzVY0DeuKQkF24ZOvkMMHWRjn8unLUye1R
         8D8NFXxZ2+G05wDN1XhhlR16WV85NaC1LRrKNVCn9CZOIktC5aWzYwtRtQ5ReuSNmL
         g2ZLiM8Lm6TFOm0hpu90vFZUQ5P9NTv053aKqYRhKiQYq9aHpZhEWFc99SyZSbc7GW
         g+WeJ8OWH98LqmAAYwV74g00bhRcJ4RS/2Y1HnNI2KBy2XrIXnT0BCIo7Qx1hBt0uP
         0DkLEYMRA5U6wjyPMJpayDb9S+ZYGJP0S5SW+yVkLkXjGPXrXyuz3pSCKW0sHg6lzG
         +cCZbQyrWQgHA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GFV-0Q; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/34] docs: doc-guide: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:15 +0200
Message-Id: <2fbe5c6fdc9989f938464e0ffbd1b7f05b314c1b.1622898327.git.mchehab+huawei@kernel.org>
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

