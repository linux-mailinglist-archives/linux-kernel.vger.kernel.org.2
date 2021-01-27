Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD099305225
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhA0DoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbhAZWYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:24:06 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2BC0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:21:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 1A0BB312;
        Tue, 26 Jan 2021 23:21:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VKhUSPV50XM9; Tue, 26 Jan 2021 23:21:49 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 09C614F;
        Tue, 26 Jan 2021 23:21:48 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l4WiZ-00G98W-UQ; Tue, 26 Jan 2021 23:21:47 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 4/4] speakup: Add documentation on changing the speakup messages language
Date:   Tue, 26 Jan 2021 23:21:47 +0100
Message-Id: <20210126222147.3848175-5-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126222147.3848175-1-samuel.thibault@ens-lyon.org>
References: <20210126222147.3848175-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++
X-Spam-Level: ****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: 1A0BB312
X-Spamd-Result: default: False [5.00 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         BAYES_HAM(-0.00)[18.79%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents how to use speakup_setlocale to set the speakup messages
language.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 Documentation/admin-guide/spkguide.txt | 48 ++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/spkguide.txt b/Documentation/admin-guide/spkguide.txt
index 5ff6a0f..977ab3f 100644
--- a/Documentation/admin-guide/spkguide.txt
+++ b/Documentation/admin-guide/spkguide.txt
@@ -1033,7 +1033,9 @@ speakup + keypad 3, you would hear:
 The speakup key is depressed, so the name of the key state is speakup.
 This part of the message comes from the states collection.
 
-14.2.  Loading Your Own Messages
+14.2.  Changing language
+
+14.2.1. Loading Your Own Messages
 
 The files under the i18n subdirectory all follow the same format.
 They consist of lines, with one message per line.
@@ -1066,8 +1068,50 @@ echo '1 azul' > /speakup/i18n/colors
 The next time that Speakup says message 1 from the colors group, it will
 say "azul", rather than "blue."
 
+14.2.2. Choose a language
+
 In the future, translations into various languages will be made available,
-and most users will just load the files necessary for their language.
+and most users will just load the files necessary for their language. So far,
+only French language is available beyond native Canadian English language.
+
+French is only available after you are logged in.
+
+Canadian English is the default language. To toggle another language,
+download the source of Speakup and untar it in your home directory. The
+following command should let you do this:
+
+tar xvjf speakup-<version>.tar.bz2
+
+where <version> is the version number of the application.
+
+Next, change to the newly created directory, then into the tools/ directory, and
+run the script speakup_setlocale. You are asked the language that you want to
+use. Type the number associated to your language (e.g. fr for French) then press
+Enter. Needed files are copied in the i18n directory.
+
+Note: the speakupconf must be installed on your system so that settings are saved.
+Otherwise, you will have an error: your language will be loaded but you will
+have to run the script again every time Speakup restarts.
+See section 16.1. for information about speakupconf.
+
+You will have to repeat these steps for any change of locale, i.e. if you wish
+change the speakup's language or charset (iso-8859-15 ou UTF-8).
+
+If you wish store the settings, note that at your next login, you will need to
+do:
+
+speakup load
+
+Alternatively, you can add the above line to your file
+~/.bashrc or ~/.bash_profile.
+
+If your system administrator ran himself the script, all the users will be able
+to change from English to the language choosed by root and do directly
+speakupconf load (or add this to the ~/.bashrc or
+~/.bash_profile file). If there are several languages to handle, the
+administrator (or every user) will have to run the first steps until speakupconf
+save, choosing the appropriate language, in every user's home directory. Every
+user will then be able to do speakupconf load, Speakup will load his own settings.
 
 14.3.  No Support for Non-Western-European Languages
 
-- 
2.20.1

