Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7594339DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhJSPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:12:38 -0400
Received: from forward400p.mail.yandex.net ([77.88.28.105]:50318 "EHLO
        forward400p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhJSPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:12:37 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 11:12:36 EDT
Received: from sas1-35b601a382d3.qloud-c.yandex.net (sas1-35b601a382d3.qloud-c.yandex.net [IPv6:2a02:6b8:c08:c505:0:640:35b6:1a3])
        by forward400p.mail.yandex.net (Yandex) with ESMTP id B3FDE642286;
        Tue, 19 Oct 2021 18:03:09 +0300 (MSK)
Received: from 2a02:6b8:c08:ff10:0:640:4fe1:bb3c (2a02:6b8:c08:ff10:0:640:4fe1:bb3c [2a02:6b8:c08:ff10:0:640:4fe1:bb3c])
        by sas1-35b601a382d3.qloud-c.yandex.net (mxback/Yandex) with HTTP id 73eMvu1D8uQ1-38DSiAdb;
        Tue, 19 Oct 2021 18:03:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxt.ru; s=mail; t=1634655788;
        bh=RySuvpUFF5Z2mnwc3pWWlYjRFA8psdGb79jKB96dvSo=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=LuYqnK6keNdYKAST6FSAFHNtkE91MS1PB7lj3MqEcXkvoNy6ClnCbKgYv1ioDICqU
         vJECXjXXppNR75wJDFwcufKKOiUm3Od2aAUbM5z4/QApjhIPttIo8zYAUUHULa3l3i
         PsrTqbm5gNTJLZpfRsEoLG6QpsCpvLyaA1Jlscrs=
Authentication-Results: sas1-35b601a382d3.qloud-c.yandex.net; dkim=pass header.i=@nxt.ru
Received: by sas2-4fe1bb3c0a49.qloud-c.yandex.net with HTTP;
        Tue, 19 Oct 2021 18:03:08 +0300
From:   sanekf@nxt.ru
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: WC vs UC mappings in snd_dma_sg_alloc()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 19 Oct 2021 18:03:08 +0300
Message-Id: <493661634654791@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've stumbled across this code in sound/core/sgbuf.c:

66 static void *snd_dma_sg_alloc(struct snd_dma_buffer *dmab, size_t size)
67 {
< ... >
80 	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG) {
81 		type = SNDRV_DMA_TYPE_DEV_WC;
82 #ifdef pgprot_noncached
83 		prot = pgprot_noncached(PAGE_KERNEL);
84 #endif
85 	}
< ... >
131 	area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, prot);

Does not this violate x86 rules about using the same memory mapping type for all mappings? It seems that the following patch should fix it (only compile tested - my x86 PCs are either without Linux or without sound, and probably in practice this might not trigger any problems since both WC and UC-minus are incoherent types):

-----------------------------

ALSA: memalloc: duly use pgprot_writecombine() for WC mapping

x86 has strict rules about not having memory type aliasing (Documentation/x86/pat.rst). snd_dma_sg_alloc() violates them by mapping first as WC (with set_memory_wc()) and then as UC- (with pgprot_noncached() + vmap()). Switching to pgprot_writecombine() should fix this.

Signed-off-by: Aleksandr Fedorov <halcien@gmail.com>
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 8352a5cdb19f..670b30c3b6e5 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -79,9 +79,7 @@ static void *snd_dma_sg_alloc(struct snd_dma_buffer *dmab, size_t size)
 		return NULL;
 	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG) {
 		type = SNDRV_DMA_TYPE_DEV_WC;
-#ifdef pgprot_noncached
-		prot = pgprot_noncached(PAGE_KERNEL);
-#endif
+		prot = pgprot_writecombine(PAGE_KERNEL);
 	}
 	sgbuf->dev = dmab->dev.dev;
 	pages = snd_sgbuf_aligned_pages(size);
