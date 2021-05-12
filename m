Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A123B37BCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhELMw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhELMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2412461104;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=jmDA7OBIG40e3rzXAsGJ5fdtuKiC6QO6Mo48AVXXMFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL4SydUtBWPym3d0Xl+3VdgdUWCpgr6afKhS9Uqc+AS4VcDS82cLP2ihz6GbIeqLw
         FCefDFmi/6n7F1tEU2K/51sL8IGLso+cBQBa0Mk2uS7y/eQWNM8+jl8Ot3DcKsJ2H9
         EGCzKw6UFrWSmYs9LG+N/T5ULbWdV7SONKwr+GMBJ+Q2LRYs9+c+CqTLborlcXU4RU
         mLvJPtag5QX/wNVrn5Tk7KU1QvUDbwLf8tjkoycXMiy2hpe3dvq0hSEE7QwZ6ha7K7
         vn7hK5Mzm+3ljP3HXxEHk6UADrzEs83V/vEj5lmYmx42o9eUrF3CLMFE+cx9eCXVLI
         KzJ1SyYJSZteg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018gr-3F; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Charles Hsu <hsu.yungteng@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/40] docs: hwmon: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:05 +0200
Message-Id: <8a84b20ef52e012850a88be99c4a5450abfeda13.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+2010 ('‐'): HYPHEN
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/hwmon/ir36021.rst  | 2 +-
 Documentation/hwmon/ltc2992.rst  | 2 +-
 Documentation/hwmon/pm6764tr.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/Documentation/hwmon/ltc2992.rst b/Documentation/hwmon/ltc2992.rst
index 46aa1aa84a1a..a0bcd867a0f5 100644
--- a/Documentation/hwmon/ltc2992.rst
+++ b/Documentation/hwmon/ltc2992.rst
@@ -19,7 +19,7 @@ This driver supports hardware monitoring for Linear Technology LTC2992 power mon
 LTC2992 is a rail-to-rail system monitor that measures current,
 voltage, and power of two supplies.
 
-Two ADCs simultaneously measure each supply’s current. A third ADC monitors
+Two ADCs simultaneously measure each supply's current. A third ADC monitors
 the input voltages and four auxiliary external voltages.
 
 
diff --git a/Documentation/hwmon/pm6764tr.rst b/Documentation/hwmon/pm6764tr.rst
index a1fb8fea2326..294a8ffc8bd8 100644
--- a/Documentation/hwmon/pm6764tr.rst
+++ b/Documentation/hwmon/pm6764tr.rst
@@ -20,7 +20,7 @@ Description:
 ------------
 
 This driver supports the STMicroelectronics PM6764TR chip. The PM6764TR is a high
-performance digital controller designed to power Intel’s VR12.5 processors and memories.
+performance digital controller designed to power Intel's VR12.5 processors and memories.
 
 The device utilizes digital technology to implement all control and power management
 functions to provide maximum flexibility and performance. The NVM is embedded to store
-- 
2.30.2

