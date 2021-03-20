Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C18A342FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCTWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCTWQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:16:39 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:16:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c4so6811079qkg.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vdUN2b328BItSMlcqgEcX36NLs9U//nc/tlpRzp+rh4=;
        b=d3r95KZAzaVWFbba5YX0MGiTNEyC0n05yuQccHmL/hnIcLcnmvavwoc2hchkpuogQm
         brHBrUoRXahj9bM2Jb9XjD+7dv1CfcE3uxRgEgWssYdrQsDYHcGEGso3nmKPmNxKaAko
         C56YvNOjdcpK3xHRZTHlRA6Zi33osXFU1I8RzMFi++HcWvt3cZM65TLcAYJNDAO0MDNk
         y5PuYVjZ3Mti7MAmK4nb5XRvB+LxQlGXvwMhq3cgwN93ThoJ8Wfnw1sgH7FdFAhZJ6ar
         e07+LyvghaPo3KhufVvsThyxJvu+wDiWcLhhTffcbFYLF6S9EcpcbnnVNlB1xzEb92s5
         /NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdUN2b328BItSMlcqgEcX36NLs9U//nc/tlpRzp+rh4=;
        b=JzGeuOcGm09s5k8jhcg9mOsxkSy2voSYGqCEu8up5JfQLROGnYJdWJmQA/pI0PMggx
         eTqeqnAzy4oKTvfM8g7F3zWudlZC4jTmCd0wiqZV9GQH0VTFkNkKBvI2KDvQcs/i3clK
         LEgXkHVC0QKmLYx2bQi86mi4jmqj3G+KGgxDlbJqFWNcnLZrhFLPwwcfDlCyKYKRoLl2
         ShZH93eHBvqnZztnZoHVhfPFjZuRCMJF5OMl4Sjr71ifk7nCcHxtKzl479mVPwC5ONa/
         C5X6tyWykJx5aVJt09XzmqucsHQYubma1wl0qGCjV2KiLx+Uv6IV0SZxW9IK9H9Vl7pq
         AJ0g==
X-Gm-Message-State: AOAM531gIvg45UpCe+T3nqc9tWtOYIdiLoy9FiYSm2Dkv5p1UGbnqyCW
        pOfLiUq8/O00ay7WCQ5ebLs=
X-Google-Smtp-Source: ABdhPJzEBHPUBFlSCzmzBacmrjskEKddtuMTXZl8H3WzpgYvK24Bs6DTijvYjSFvvXWMHVipd6hWqw==
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr4614016qka.111.1616278598478;
        Sat, 20 Mar 2021 15:16:38 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id x1sm6223973qtr.97.2021.03.20.15.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:16:38 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 2/2] ALSA: hdspm: don't disable if not enabled
Date:   Sat, 20 Mar 2021 18:16:20 -0400
Message-Id: <20210320221620.226155-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210320221620.226155-1-ztong0001@gmail.com>
References: <20210320221620.226155-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hdspm wants to disable a not enabled pci device, which makes kernel
throw a warning. Make sure the device is enabled before calling disable.

[    1.786391] snd_hdspm 0000:00:03.0: disabling already-disabled device
[    1.786400] WARNING: CPU: 0 PID: 182 at drivers/pci/pci.c:2146 pci_disable_device+0x91/0xb0
[    1.795181] Call Trace:
[    1.795320]  snd_hdspm_card_free+0x58/0xa0 [snd_hdspm]
[    1.795595]  release_card_device+0x4b/0x80 [snd]
[    1.795860]  device_release+0x3b/0xa0
[    1.796072]  kobject_put+0x94/0x1b0
[    1.796260]  put_device+0x13/0x20
[    1.796438]  snd_card_free+0x61/0x90 [snd]
[    1.796659]  snd_hdspm_probe+0x97b/0x1440 [snd_hdspm]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 sound/pci/rme9652/hdspm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8d900c132f0f..af3898c88bba 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6582,8 +6582,10 @@ static int snd_hdspm_create(struct snd_card *card,
 	pci_set_master(hdspm->pci);
 
 	err = pci_request_regions(pci, "hdspm");
-	if (err < 0)
+	if (err < 0) {
+		pci_disable_device(pci);
 		return err;
+	}
 
 	hdspm->port = pci_resource_start(pci, 0);
 	io_extent = pci_resource_len(pci, 0);
@@ -6880,10 +6882,10 @@ static int snd_hdspm_free(struct hdspm * hdspm)
 	kfree(hdspm->mixer);
 	iounmap(hdspm->iobase);
 
-	if (hdspm->port)
+	if (hdspm->port) {
 		pci_release_regions(hdspm->pci);
-
-	pci_disable_device(hdspm->pci);
+		pci_disable_device(hdspm->pci);
+	}
 	return 0;
 }
 
-- 
2.25.1

