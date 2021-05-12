Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC037BD58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhELMy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhELMxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D47176144B;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=JWI7UuEd+hrr1IeuzpK3zlUZkfi/IC2Hi1l3IWi5+9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=du4Hmag6Fx9YA2dPDcQmTw00n+kL3Hhe1S/hlBHae70EsCRX5p+cfGIW7uTBifetq
         dnM9xM1H4vBJP5UaXLRAzDhv/jGfWIFJtkKypOiAdBpbiap3a9B/grOWn2NarZiwCS
         MY0rW/TjT9W/7wO6w9xRok/aOZuqPqM0J/zvcCGlAcX93B53CZHcH674u01xShkOZU
         AMn/m9nOmg+egCnnK7hEW1n4HiGNvlP0Ua/jh0B63ExbwtzXeY+9kr2NpaulfKNvFx
         hRcBuMAIPTznqKt/cX740DzdPnqggV+c7fkIL3IP93lJ8sVEWKChsg5BUj3inY7U1A
         tubOkbYKTqbvg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKz-0018iE-0i; Wed, 12 May 2021 14:51:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/40] docs: security: tpm: tpm_event_log.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:26 +0200
Message-Id: <fbed847d22abb3855a3076b4657d98aa0e1f97ad.1620823573.git.mchehab+huawei@kernel.org>
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

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/security/tpm/tpm_event_log.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/tpm/tpm_event_log.rst b/Documentation/security/tpm/tpm_event_log.rst
index f00f7a1d5e92..9f2716c170bb 100644
--- a/Documentation/security/tpm/tpm_event_log.rst
+++ b/Documentation/security/tpm/tpm_event_log.rst
@@ -20,7 +20,7 @@ process.
 The main application for this is remote attestation and the reason why
 it is useful is nicely put in the very first section of [1]:
 
-"Attestation is used to provide information about the platform’s state
+"Attestation is used to provide information about the platform's state
 to a challenger. However, PCR contents are difficult to interpret;
 therefore, attestation is typically more useful when the PCR contents
 are accompanied by a measurement log. While not trusted on their own,
-- 
2.30.2

