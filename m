Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1529C410CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhISS3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 14:29:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhISS3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 14:29:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632076089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2KYUazECIPvhMA6qgZL1vhKItWC+1Q+3MI69AJhSdp0=;
        b=AvxfHfShGKasW4gMIEZgFRhGnqiIBOL/e35Hf8OUivzAglGntV2G0OTHdWCT1pfMahi8Do
        yWPTMZLHdUOwUCzw3RkVyCxbqabzW/tPpwvHhTKuEZGPr1bs4LQCwdZcEJi10ayDnUZ69i
        wmFeEp7iNHpa4Y/PtHhiPH1T0TbKrmhTZHQwX93mN84DMl+xKaOikFlsVOxXX8zOspn+yO
        gW0Vm/AqwUfD33TzSNt4ZW8PrzsytbKhXfBqPnVfNBcLAA4noKoKJ5vj2iymPixNctvxVT
        J8u7GzCy23V7BB5qbgXNDuWQgUeME00wXn/uJbjKTfUNrR3Z/5q/V+0UZmQC5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632076089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2KYUazECIPvhMA6qgZL1vhKItWC+1Q+3MI69AJhSdp0=;
        b=DvgJXsZKdh0Bo7YXIFPXBe1TZcMV8218HE6LjdzCpjUzryJF7q/0Czb2I/aQpW5LDoopAi
        dkYqq8PqM1KcXlCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for v5.15-rc2
References: <163207602242.947088.16824174748243890514.tglx@xen13>
Message-ID: <163207602394.947088.16084244161007584223.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Sep 2021 20:28:09 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021=
-09-19

up to:  b89a05b21f46: events: Reuse value read using READ_ONCE instead of re-=
reading it


A single fix for the perf core where a value read with READ_ONCE() was
checked and then reread which makes all the checks invalid. Reuse the
already read value instead.

Thanks,

	tglx

------------------>
Baptiste Lepers (1):
      events: Reuse value read using READ_ONCE instead of re-reading it


 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e8726c5b2..0c000cb01eeb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10193,7 +10193,7 @@ static void perf_event_addr_filters_apply(struct perf=
_event *event)
 		return;
=20
 	if (ifh->nr_file_filters) {
-		mm =3D get_task_mm(event->ctx->task);
+		mm =3D get_task_mm(task);
 		if (!mm)
 			goto restart;
=20

