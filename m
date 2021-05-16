Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C404C381DFF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhEPKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhEPKTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7958461205;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=lGbf/j42/4jnjE/bobLO5RJWrALBdbYzO9Tzev+J9G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzfs12ngjC+3vZuyy2szlHovtA8pYQbgvBwC+XLWoeu9hrE5gd7AMkQ1n7U7WJbM2
         EFUcZjglqjjnFSsG6cFV5y8ddTxiHpHYaqToMo5GyQyS60yTToJ31TgGrNeyLSWxtc
         G38GabMM73vtBHnN8qLfzLXEJIdcT7g1sDtDUsxE5EBjSQ8iceIu0q60eiyqvXzO/O
         fkL4gLXBx2w12TBfIPI0glB0knIFqGEFlytiFIMzctPU165kkO/FFrtNtxasArWzJw
         vUJTTzZRx3u8Mx2E7OPMAZgMPw/2Pcj40YkrSdX8IQ5sHxvDaG15E96pWYkGgNB0Ul
         0uz0CLeyyzs5w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8y-MB; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/16] docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:30 +0200
Message-Id: <f560414dfc677712126ae8b28e755e610d142c42.1621159997.git.mchehab+huawei@kernel.org>
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

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index e6365836fa8b..90a58da36569 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -3368,7 +3368,7 @@ This ensures that the device can be closed and the driver unloaded
 without losing data.
 
 This callback is optional. If you do not set ``drain`` in the struct
-snd_rawmidi_ops structure, ALSA will simply wait for 50 milliseconds
+snd_rawmidi_ops structure, ALSA will simply wait for 50 milliseconds
 instead.
 
 Miscellaneous Devices
-- 
2.31.1

