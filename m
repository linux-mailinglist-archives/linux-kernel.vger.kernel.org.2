Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8788381E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhEPKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhEPKTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63C4761185;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=Y90K4iDzT1mxgEqpYhzOZAeShTC+oGg4jL4yjkpiy0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bubrMmAkvj7yJJmyG3EfGBditcT3qZj35/ytp5KFj9GBgVjf2UgRg0BOChuQ0A9Oq
         2fxwShY7XHmWDyNLM4LTIuawJ8FfISfsxOzol8lyTh1t1sCq6fzlLpJv/ii3X424an
         3CqIX+31yZ/+CLt+TdkoeS6fXSYlSuhVKipac2tkAKsNZY36fMcnHW7vnocnVGye7h
         GYNwkSOs02oniNFxJ0eroGLcnfKP/rVgDuuGC02PYFmGay0odtS5ZyHwvAo0UYYZIa
         kNI7IZKWiAvvxye7hpfL15uDqMtEV2RytP3uFKBg8XjgzCgLkL7wJPwmJFxhkWuMyS
         re4rQ7CPViHAA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8C-77; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/16] docs: hwmon: ir36021.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:18 +0200
Message-Id: <ba8b5122ac9d4918fd966d0eb0a5ca9d89044b04.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+2010 ('‐'): HYPHEN
	  as ASCII HYPHEN is preferred over U+2010

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/ir36021.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/ir36021.rst b/Documentation/hwmon/ir36021.rst
index ca3436b04e20..1faa85c39f1b 100644
--- a/Documentation/hwmon/ir36021.rst
+++ b/Documentation/hwmon/ir36021.rst
@@ -19,7 +19,7 @@ Authors:
 Description
 -----------
 
-The IR36021 is a dual‐loop digital multi‐phase buck controller designed for
+The IR36021 is a dual-loop digital multi-phase buck controller designed for
 point of load applications.
 
 Usage Notes
-- 
2.31.1

