Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5FF321B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhBVPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhBVPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9217C061A2A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:13:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so19449328wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYznJRJi7sEltEuFcbESAgA/1ekiiKcyEWk34Vl4+aw=;
        b=CcgFY/TizwV98v0EjQpqqprS4kVWLxLIO+yAEtYX9MJDmQjMwKOK0zhLFhUAmTTUvo
         UYCCmjDnP3NHnqKIuslmK1ckzcpTkXYuvs0ZfCVMNzBvYmY5JxTzUGmctvKraW5OW/3m
         d3UAE7bzLdvPxuy+csHIHgHU41Y17L8S4vqx0F0JnvKxr1BGWcR0gdJnGyVtMHkBv2OD
         G+ZRlYUbp7mUHzS2OGp06688Aziy6jCbmBcL2ghihroHV2JxcYem1sy18GTKwUfACGzy
         RNfbhejFrJtQ2h2UcWWTlvOP9zx7vP2kTgELNmMdR7OqC90iRXVahtQQtVVU1CPFV8sf
         TYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYznJRJi7sEltEuFcbESAgA/1ekiiKcyEWk34Vl4+aw=;
        b=N8VUF0YtMaG+XpyniVY47ziwAs4xRtoC7MM94MHQQbgbBDTqbQzxuEYX3ATAAZ/Rag
         y6OZV0Zp+gJHExkavvuQlxJQE4XFTT6MmWEarBu2NfiliSKbiCQm3kmAWJkdrSbaHr7q
         smiprOc/RxNS1Zzq7K0LhPFDduz3Gvu3PjavD2w7934h6BT9Lw7hr7FjmlAGu23ZvEMP
         jJAhBCadqLY/Z27mCbl7y+E0h3WJ2BBNgHwgahgurulTwejTmyq3MN0zWF1Dm1HUgHLH
         evYlDHDoWhg06rI7+naC7LeVNz0BtmZpORq0m3+wmoZIPUgS6tIZRL3nEEfNPbkUBDIw
         Q6sw==
X-Gm-Message-State: AOAM531pwbSannS+69UES4KrWA+PTFWNyBE5Aek/UcINdEDLhs89z+hI
        DUIddm1OojSd5+emiq3Cnj0Ld/8+tWlZvz1xy8c=
X-Google-Smtp-Source: ABdhPJzjuRXaYt/SRvU62YQ+PqGinj8lFxjNzE0l2PB160Gii4xzWBJxkVSIXDJqoVo/mJEet+g7wQ==
X-Received: by 2002:a5d:54cb:: with SMTP id x11mr2479881wrv.165.1614006780305;
        Mon, 22 Feb 2021 07:13:00 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id q20sm25316500wmc.14.2021.02.22.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:59 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] ALSA: usb-audio: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:26 +0100
Message-Id: <20210222151231.22572-16-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 sound/usb/card.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 85ed8507e41a..acb1ea3e16a3 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -496,7 +496,7 @@ static void usb_audio_make_longname(struct usb_device *dev,
 	struct snd_card *card = chip->card;
 	const struct usb_audio_device_name *preset;
 	const char *s = NULL;
-	int len;
+	ssize_t len;
 
 	preset = lookup_device_name(chip->usb_id);
 
-- 
2.20.1


