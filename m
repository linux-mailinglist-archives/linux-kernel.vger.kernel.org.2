Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90748344AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCVQNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:13:05 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21359 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhCVQMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:12:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616429537; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=PRMysHNprZ3jf2UHc7wrhs76Alxf8YivXUfHuFraT286M73IEtLOyz6Nu5MWKEdsW8LSPK47eltnDwIxiCLi7EUP4nIO+/9hI+MyDUj7IXM0dZ5v3+4jX9snrH1BRme1Xikfdnhl40kNaPMZxGTMLIpBmpbiO+wYWepjemTMY3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1616429537; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=qXkPKXLIdi3YS2QxskiB00F5rS0qkdSxQYzMcJTjnMo=; 
        b=A93zRYLFYdWAi01ZZwv796KSoJ9FrLQBJ9uBA125ndMv2d+GzRNf/lwjijEmoERSucguGnuCrF/lTIJioy8+nCV5g5oNnU5v0LqDbok+mORG9r0kBv9QaGGelWMI8RsjdVgMEZOWK9YDI0FRoUUO4NAbGa5/WXJ4Vj6R4OTbMQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1616429537;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=qXkPKXLIdi3YS2QxskiB00F5rS0qkdSxQYzMcJTjnMo=;
        b=T5hPkdOkdyoV+EvrAwp/VH/mTozUZyL2Yn4mutF7Yh+y/3xv8gyogTlrnjd3C5QE
        H0xJ+aHMO3k2qqsUkD5DjSWKFA5znZL7wRRuIRr/jCRVU2PFnVVV0OwhHuzaiVZGBKM
        B7NQ1ucBFxS2BB15+l0YyarIzS+8whu204hoX8ww=
Received: from localhost.localdomain (106.51.105.21 [106.51.105.21]) by mx.zohomail.com
        with SMTPS id 1616429533738896.0472127781908; Mon, 22 Mar 2021 09:12:13 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com,
        Hillf Danton <hdanton@sina.com>
Message-ID: <20210322161147.5593-1-mail@anirudhrb.com>
Subject: [PATCH resend] jfs: fix use-after-free in lbmIODone
Date:   Mon, 22 Mar 2021 21:41:47 +0530
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix use-after-free by waiting for ongoing IO to complete before freeing
lbufs in lbmLogShutdown. Add a counter in struct jfs_log to keep track
of the number of in-flight IO operations and a wait queue to wait on for
the IO operations to complete.

Reported-by: syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 fs/jfs/jfs_logmgr.c | 17 ++++++++++++++---
 fs/jfs/jfs_logmgr.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9330eff210e0..82d20c4687aa 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1815,6 +1815,8 @@ static int lbmLogInit(struct jfs_log * log)
 =09 */
 =09init_waitqueue_head(&log->free_wait);
=20
+=09init_waitqueue_head(&log->io_waitq);
+
 =09log->lbuf_free =3D NULL;
=20
 =09for (i =3D 0; i < LOGPAGES;) {
@@ -1864,6 +1866,7 @@ static void lbmLogShutdown(struct jfs_log * log)
 =09struct lbuf *lbuf;
=20
 =09jfs_info("lbmLogShutdown: log:0x%p", log);
+=09wait_event(log->io_waitq, !atomic_read(&log->io_inflight));
=20
 =09lbuf =3D log->lbuf_free;
 =09while (lbuf) {
@@ -1990,6 +1993,8 @@ static int lbmRead(struct jfs_log * log, int pn, stru=
ct lbuf ** bpp)
 =09bio->bi_end_io =3D lbmIODone;
 =09bio->bi_private =3D bp;
 =09bio->bi_opf =3D REQ_OP_READ;
+
+=09atomic_inc(&log->io_inflight);
 =09/*check if journaling to disk has been disabled*/
 =09if (log->no_integrity) {
 =09=09bio->bi_iter.bi_size =3D 0;
@@ -2135,6 +2140,7 @@ static void lbmStartIO(struct lbuf * bp)
 =09bio->bi_private =3D bp;
 =09bio->bi_opf =3D REQ_OP_WRITE | REQ_SYNC;
=20
+=09atomic_inc(&log->io_inflight);
 =09/* check if journaling to disk has been disabled */
 =09if (log->no_integrity) {
 =09=09bio->bi_iter.bi_size =3D 0;
@@ -2200,6 +2206,8 @@ static void lbmIODone(struct bio *bio)
=20
 =09bio_put(bio);
=20
+=09log =3D bp->l_log;
+
 =09/*
 =09 *=09pagein completion
 =09 */
@@ -2211,7 +2219,7 @@ static void lbmIODone(struct bio *bio)
 =09=09/* wakeup I/O initiator */
 =09=09LCACHE_WAKEUP(&bp->l_ioevent);
=20
-=09=09return;
+=09=09goto out;
 =09}
=20
 =09/*
@@ -2230,13 +2238,12 @@ static void lbmIODone(struct bio *bio)
 =09INCREMENT(lmStat.pagedone);
=20
 =09/* update committed lsn */
-=09log =3D bp->l_log;
 =09log->clsn =3D (bp->l_pn << L2LOGPSIZE) + bp->l_ceor;
=20
 =09if (bp->l_flag & lbmDIRECT) {
 =09=09LCACHE_WAKEUP(&bp->l_ioevent);
 =09=09LCACHE_UNLOCK(flags);
-=09=09return;
+=09=09goto out;
 =09}
=20
 =09tail =3D log->wqueue;
@@ -2315,6 +2322,10 @@ static void lbmIODone(struct bio *bio)
=20
 =09=09LCACHE_UNLOCK(flags);=09/* unlock+enable */
 =09}
+
+out:
+=09if (atomic_dec_and_test(&log->io_inflight))
+=09=09wake_up(&log->io_waitq);
 }
=20
 int jfsIOWait(void *arg)
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index 805877ce5020..3e92fe251f28 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -400,6 +400,8 @@ struct jfs_log {
 =09uuid_t uuid;=09=09/* 16: 128-bit uuid of log device */
=20
 =09int no_integrity;=09/* 3: flag to disable journaling to disk */
+=09atomic_t io_inflight;
+=09wait_queue_head_t io_waitq;
 };
=20
 /*
--=20
2.26.2


