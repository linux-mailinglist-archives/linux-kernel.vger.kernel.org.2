Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C0C36E771
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhD2IzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhD2IzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:55:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FDFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:54:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gj14so2383750pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uHXXhY/T3rlk5SzYZqYvb/APFM47I0gVLkI+iRA8gUg=;
        b=KXBJi/7kdWtmb8LMRnGE+rGbgPP4Pw2GSRHeMarjuWOhrD9BU93Qi9Tsh54Y8uVNrZ
         6nHMQe3DYXakIRaqDJnST6cyZt/Kf4pOl1ZqvfodmFN0+HzxQq/1qsql73M/IWmFIXAJ
         W7ZS5Duuat1/fjHCOJ05q/LFFIKpF4YEWft/RcBbUWyn1GrKJUtoOLoPfR+lHgL78bia
         y6/N9aJTRxFAu22o7wWmetUY42uwt6+t206M9dgU3CptMdeXN44x8mWv3OV+zMjuItCh
         8Vpy+yz03iO/WcBB72U9QasJuUBw9ce6m/QsmEZT7b3SRsN5uLupPsJ88ainxB5Z1ACz
         zkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uHXXhY/T3rlk5SzYZqYvb/APFM47I0gVLkI+iRA8gUg=;
        b=cP/LlWJPMpPSTtdkpjfXxH60odwJTNpFMv8nZtCV5y9eSri9YHFC0aM7wk2Ikhg61a
         6YiO8lracrCuZdNl0Fxhb51rWxl8SN2dPFOQZ6Zwm9g28Uw1iLC8tUNz46nPtBA+PLsU
         AzOpEzQmUmYP0QW9qPeURNC8B6QwXcUCz80VD7i8wF+qsgXp6zCLMEA169Bd+HzO9jgF
         KkVDeOUktyCj6G7rYvCZWzUwtSXbl2FH0Kde5y/3JSLrm0XWt/ZIH6+7rLpJhh+2Hylf
         BrkplULhGidHKiklY6oyLkvi0X4bceCxT88kRAuxqYf6UOS6TYnmk58RgTScDubmZfJX
         xMTQ==
X-Gm-Message-State: AOAM530FEbusvvtfNt+njzHXpOoJaFG3bc09uETV3bXnkPmRPuNPAlM/
        B8wsPjejZB0rwANR3HXr9o//9xDTWepQEjYE
X-Google-Smtp-Source: ABdhPJxP1fyIxo4+FahDE5EKJD2fTHh6Q73j72AHDk28uwnyGkImsLZsYqDOHqC1zBWd7Qb987L99g==
X-Received: by 2002:a17:90a:af95:: with SMTP id w21mr8411667pjq.178.1619686459326;
        Thu, 29 Apr 2021 01:54:19 -0700 (PDT)
Received: from localhost ([115.99.169.0])
        by smtp.gmail.com with ESMTPSA id k22sm1907148pfa.93.2021.04.29.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:54:19 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:24:16 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Add blank line after declarations
Message-ID: <20210429085416.aevoiyl6kbdeciw4@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank line is added after declarations to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/pcmcia/soc_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 3a8c84bb174d..98b6d96a4435 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -63,6 +63,7 @@ void soc_pcmcia_debug(struct soc_pcmcia_socket *skt, const char *func,
 {
 	struct va_format vaf;
 	va_list args;
+
 	if (pc_debug > lvl) {
 		va_start(args, fmt);
 
@@ -464,6 +465,7 @@ static void soc_common_check_status(struct soc_pcmcia_socket *skt)
 static void soc_common_pcmcia_poll_event(struct timer_list *t)
 {
 	struct soc_pcmcia_socket *skt = from_timer(skt, t, poll_timer);
+
 	debug(skt, 4, "polling for events\n");
 
 	mod_timer(&skt->poll_timer, jiffies + SOC_PCMCIA_POLL_PERIOD);
-- 
2.25.1

