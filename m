Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5157D310806
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBEJhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhBEJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:33:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD48C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:32:35 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l23so4472179qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGg5NihQIpPD83e5GUVNZdEroDTx9eDW0neqQhYbaEU=;
        b=XBq042kpAYB7CZsmACUuiXRHOkDS0Lw9/mRiqAj7fXql1wv58wMJBd+Z+3JQ9jdWdv
         AuwIZdmHEPJHeKcJmVNvYpjAcOtFKDLYXyW/5+kawnugBCr6JSHCT7Vc+E8jquQs89UG
         nYUQ0Z5oJZNlNg/TprhI0rWDg33OM5nHLwZnkg6mtAknvIkltbFAG9thfKwIR04nfUbA
         XD+FAngVvwwNnRnE9AYHiM+TbrC2PRTpo+vWe3ZvOjEeBSgUBNM75PxFm6QPC2Nl1EGG
         qjsso2KipCksWZ55GHcjUqtBY7rmvTQddDpEXTDh7BRexSt+6ZBfZieDvzXTSpzm2z9N
         VThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fGg5NihQIpPD83e5GUVNZdEroDTx9eDW0neqQhYbaEU=;
        b=AKMtkqLFUmo38skdn1TCMoRsGkAOkrY6PkhXZh367dbCyMURN4Z1QVz5bRigdYJdR+
         yFnoI6JxYVFBW6dMPda+06cYRk17kZ/MqYUmiHJ7jj4euCwnKObNWT7hk0NW5PoJxiAF
         uN4ufSJ0eLj+JWejJqbRuoASC0ybDZzOAIMaRiHHv80ElEXBJdsjGjOZ1ZjqB3MUGJ6q
         yswkN9iYDJjGDgOfYXbdWvzinIdhQn3STjq5LoeA/+t8dTVf0Go0mcWeLk0YEmlLIjHb
         qp4zejNm4vz8zL0h1vZafcjnnNEi9U0I8xKuES9BVC11FYlhsSezkMNEqbDt7i3MYMF1
         OKOA==
X-Gm-Message-State: AOAM530eUhBoBYR69np/maesaF8I4Vb3WXf+cqfWYEtKULkWiuO4+EA/
        hqG+fpkbsj5FFLAPWH9jpPTrljZU+gYlmzDG
X-Google-Smtp-Source: ABdhPJzHIrDZnsVVVcK7xUcHbBqLjdI6dEECLL8MlZC4XAPWoROBGvBgsrxXgcvELwzE+exEUFWnEA==
X-Received: by 2002:ac8:3683:: with SMTP id a3mr3370737qtc.367.1612517554835;
        Fri, 05 Feb 2021 01:32:34 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.157])
        by smtp.gmail.com with ESMTPSA id f8sm7182232qth.6.2021.02.05.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 01:32:34 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] sound: x86: Trivial spell fixes throughout the file intel_hdmi_audio.c
Date:   Fri,  5 Feb 2021 15:02:14 +0530
Message-Id: <20210205093214.637121-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/confgiuration/configuration/
s/Calculte/Calculate/
s/unreference/unreferenced/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 sound/x86/intel_hdmi_audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9f9fcd2749f2..89ddd9dd8fde 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -342,7 +342,7 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,

 /*
  * function to initialize audio
- * registers and buffer confgiuration registers
+ * registers and buffer configuration registers
  * This function is called in the prepare callback
  */
 static int had_init_audio_ctrl(struct snd_pcm_substream *substream,
@@ -611,7 +611,7 @@ static void had_prog_dip(struct snd_pcm_substream *substream,
 		frame2.regx.chnl_cnt = substream->runtime->channels - 1;
 		frame3.regx.chnl_alloc = ca;

-		/* Calculte the byte wide checksum for all valid DIP words */
+		/* Calculate the byte wide checksum for all valid DIP words */
 		for (i = 0; i < BYTES_PER_WORD; i++)
 			checksum += (info_frame >> (i * 8)) & 0xff;
 		for (i = 0; i < BYTES_PER_WORD; i++)
@@ -1109,7 +1109,7 @@ static int had_pcm_close(struct snd_pcm_substream *substream)

 	intelhaddata = snd_pcm_substream_chip(substream);

-	/* unreference and sync with the pending PCM accesses */
+	/* unreferenced and sync with the pending PCM accesses */
 	spin_lock_irq(&intelhaddata->had_spinlock);
 	intelhaddata->stream_info.substream = NULL;
 	intelhaddata->stream_info.substream_refcount--;
--
2.30.0

