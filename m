Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99C4195C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhI0OCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:45 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64362 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhI0OCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:02:14 -0400
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 18RE07Fv028280;
        Mon, 27 Sep 2021 23:00:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 18RE07Fv028280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632751208;
        bh=+Hloq7pOWn+uCkJoTRCg/87ciA9Hg53ptAbmWaWlSNI=;
        h=From:To:Cc:Subject:Date:From;
        b=rsMuJ8ftbFfHF2vWJhdb7xNenWQmLOEYRydU83zeYdXTr2nNvryEiBJUxFEkVuUx8
         rVFCFCFWAkyC+3JjV13cfUWgU5o7xlNy/OEMtc38cnhtt14pjNiYYeL+jyDZsxPC+S
         BpwVxnhojJd+DA83hKqHMdidPEGZA5N/rw6uD5ABy8HvfkFfSX9yyd3xbLkn0XQi/J
         /xZgu9AgZwsND/iM+wDqvvj3GadK+/VQkB9fkHc/D5wvd8ijOWCKAazbs9dv3QqVvF
         D9xT18IZbpg0xo6AQEeHKuP92zeekXTJUKd0+k0F1RnIg86gBzaV4tER6bUpQIZzET
         E6Aj3YyeWL/4w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RESEND PATCH 0/4] block: clean up Kconfig and Makefile
Date:   Mon, 27 Sep 2021 22:59:56 +0900
Message-Id: <20210927140000.866249-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a resend of
https://lore.kernel.org/linux-block/20210528184435.252924-1-masahiroy@kernel.org/#t



Masahiro Yamada (4):
  block: remove redundant =y from BLK_CGROUP dependency
  block: simplify Kconfig files
  block: move menu "Partition type" to block/partitions/Kconfig
  block: move CONFIG_BLOCK guard to top Makefile

 Makefile                 |  3 ++-
 block/Kconfig            | 28 ++++++++++------------------
 block/Kconfig.iosched    |  4 ----
 block/Makefile           |  2 +-
 block/partitions/Kconfig |  4 ++++
 5 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.30.2

