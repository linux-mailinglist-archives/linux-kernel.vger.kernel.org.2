Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57835DDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhDMLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:40:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38722 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhDMLjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:39:00 -0400
Received: from zn.tnic (p200300ec2f0b8400d01b5005d8257d7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8400:d01b:5005:d825:7d7f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C4F181EC0104;
        Tue, 13 Apr 2021 13:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618313919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8LLIP4MVOHmMuRIMnBjiUKHHsTTVk9M0d7ol+ja3uRw=;
        b=Zb8Usl6pKoaY1/coJom+cM7hv2VAuknDAP44xEHaaac+5eN4QHzscFW0VtiDmuLQjr/MHH
        HcxoAExNV9r1TJ3BBqVEEwrrfHxU4FICRvFQkhyeYCx2/lfNNJbnK5hFosE89DwtMnSkVj
        6S7INZ+jMEbnbTy92sec1BQGgfnpEIk=
Date:   Tue, 13 Apr 2021 13:38:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/submitting-patches: Document RESEND tag on
 patches
Message-ID: <20210413113834.GE16519@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217183756.GE23634@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

here's the next piece of documentation which should be generic enough.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 13 Apr 2021 13:26:29 +0200

Explain when a submitter should tag a patch or a patch series with the
"RESEND" tag.

This has been partially carved out from a tip subsystem handbook
patchset by Thomas Gleixner:

  https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de

and incorporates follow-on comments.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/process/submitting-patches.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index ab92d9ccd39a..9284735e0b34 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -346,6 +346,16 @@ that you have sent your patches to the right place.  Wait for a minimum of
 one week before resubmitting or pinging reviewers - possibly longer during
 busy times like merge windows.
 
+It's also ok to resend the patch or the patch series after a couple of
+weeks with the word "RESEND" added to the subject line::
+
+   [PATCH Vx RESEND] sub/sys: Condensed patch summary
+
+Don't add "RESEND" when you are submitting a modified version of your
+patch or patch series - "RESEND" only applies to resubmission of a
+patch or patch series which have not been modified in any way from the
+previous submission.
+
 
 Include PATCH in the subject
 -----------------------------
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
