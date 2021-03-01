Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DBA327EF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhCANGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhCANGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:06:33 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3DEC06178C;
        Mon,  1 Mar 2021 05:05:52 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id p15so10370660ljc.13;
        Mon, 01 Mar 2021 05:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XaQcKx+xEqj4J77bbUCqNTa/wBywt8XOTBT7+hk34bk=;
        b=qcsm2wB2OxCl3aK9yQd95LbLODd4QZU3jUez4xUuFbsuGHv5bZ2JbJz96UOrVJi2wD
         wEz5hTs1Uhkb4nYxmKisTsNyjhedjXyFQkxkigrwv7whXwQ5u0VB/JJ3Qs3PTdz2pkk8
         ypluZODS8vUx5N+fyXQDH3ESTpLkxM3wBjqjfyMyWBuDEnfxCbpOtNQkNTmsFQpKX8ca
         DbVJ/B01Nltp+LP1IC28HFLaW95euvguF22tJhjDztFy9m93ylZUsWexXzqmQP2QQZtD
         IGZNZlPpmVb1isUvF6R19P7DvGCdF+UdjrTZIUv0fGk/q7L2YTpKTVC/e5e3yO6q4ZmN
         FfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XaQcKx+xEqj4J77bbUCqNTa/wBywt8XOTBT7+hk34bk=;
        b=kAR0q1dynF9LslGG5qKNr9H/bHVD254gbis4SyBGe+iKIMiAeaEHcqezMs47C+sZmK
         iZemiKqD9lWXVcZVkZ05Lag9RIjqW2CgRJzdGG2XT7IMM09IxSIQffBVP4RRI3j/PO/V
         I9kcE3vzLyZQ+CKNc0tz/w1EnMrML1hLaO4kqAyGKNO7gAxrLZQ1cvOeCFqKMcb/hx4m
         rnUo+jS4DghbwCcKcw2Nl7NzTQJSy2xZmLRcmGA+KyClo3bhliKQYBM94a2r84L7N7af
         MIMkVQREjhFZKCT1ohQY5MGfv7uLI+S9aLdeMfCN4kvQmqR1IbtRAkWIHf4xRoP5Kp8j
         ZO3A==
X-Gm-Message-State: AOAM533sXtmWsZtSvjG2PzZ60GPpSMUjWiCp1AafDUZOxE8Cbq/8wIIN
        uVjbljdyiyUS/hfaf6dcjHY=
X-Google-Smtp-Source: ABdhPJztbg/WcNErmE9aR9tP/dIIuEK4lh84Mx+46zqOEqLa0Xyq73sU5Cb9/Mc1TzYGLSrAjPVJEw==
X-Received: by 2002:a2e:8706:: with SMTP id m6mr9090605lji.434.1614603949454;
        Mon, 01 Mar 2021 05:05:49 -0800 (PST)
Received: from localhost (crossness-hoof.volia.net. [93.72.107.198])
        by smtp.gmail.com with ESMTPSA id h62sm1441782lfd.234.2021.03.01.05.05.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 05:05:48 -0800 (PST)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] usb: gadget: u_audio: convert to strscpy
Date:   Mon,  1 Mar 2021 15:05:36 +0200
Message-Id: <1614603943-11668-2-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of strlcpy in Linux Kernel has been recently
deprecated [1], convert driver to strscpy

[1] https://lore.kernel.org/lkml/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 drivers/usb/gadget/function/u_audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 265c4d8..5fbceee 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -549,15 +549,15 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	if (err < 0)
 		goto snd_fail;
 
-	strlcpy(pcm->name, pcm_name, sizeof(pcm->name));
+	strscpy(pcm->name, pcm_name, sizeof(pcm->name));
 	pcm->private_data = uac;
 	uac->pcm = pcm;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &uac_pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &uac_pcm_ops);
 
-	strlcpy(card->driver, card_name, sizeof(card->driver));
-	strlcpy(card->shortname, card_name, sizeof(card->shortname));
+	strscpy(card->driver, card_name, sizeof(card->driver));
+	strscpy(card->shortname, card_name, sizeof(card->shortname));
 	sprintf(card->longname, "%s %i", card_name, card->dev->id);
 
 	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-- 
1.9.1

