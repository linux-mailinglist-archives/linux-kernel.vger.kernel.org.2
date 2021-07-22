Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8F3D213E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhGVJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhGVJJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B025161248;
        Thu, 22 Jul 2021 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626947415;
        bh=Kbwlt8w6o/6jn6C+GN3lvDJvqGRuUEe+9My7sEXYggo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJezXu+mELcrPCJVhsc9iZCYFWmV7Z9eW/ZDCHrITUf2A+bECIQ00tScc50hYk7sd
         iMzI8mc5c7H6if5RfAn7KeUWMOsT3QSV6J8SUOg31CJ6f1TdrvuX8FFNa+wQR4uDDq
         VLLlf1pDMaHtgqCJP9VctcVMIOTpZmDUXc7bXpvIJF9M3NsYIpJ4g5csh6OS1gwbNK
         pkpNQnBmBXRhashshkyK1iKOfR0qRHXEzG1hYncpv7CqVnvlINdRDRlA9Qnj90TiQ6
         fWjAlo4pBOEX2AbW8bOqur+FPyBUDfbm1Ya90ZTuS0fhGvREV1QJxq3iP18opxjt3Q
         IORwo97aI9PTw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VLD-008lGf-CD; Thu, 22 Jul 2021 11:50:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Maxime Ripard <maxime@cerno.tech>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some characters
Date:   Thu, 22 Jul 2021 11:50:01 +0200
Message-Id: <21abe5fa495a05ac1f998ed66184a77e19ac89cc.1626947264.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947264.git.mchehab+huawei@kernel.org>
References: <cover.1626947264.git.mchehab+huawei@kernel.org>
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

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 255b7d3bebd6..176b73583b7a 100644
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

