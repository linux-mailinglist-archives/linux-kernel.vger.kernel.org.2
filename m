Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B9347AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhCXO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:29:41 -0400
Received: from mail.kurz.pw ([89.163.159.92]:37426 "EHLO mail.kurz.pw"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236060AbhCXO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:29:16 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 10:29:16 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F09D0123E06;
        Wed, 24 Mar 2021 15:23:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schauer.dev; s=dkim;
        t=1616595824; h=from:subject:date:message-id:to:cc:mime-version:content-type;
        bh=DxIVPfQCMqOrZn3/5HfacoYgZRK3+zxnaLQGxHn6K+M=;
        b=yTw6RPSYj4Ukv9RWSh8QyNZ43Fkqk/o6fNvu/M+eLw4HeVVhvydpa3wip0SRSgw7Xo5Oi3
        8c2hhAXtK4yB0tA8Qut8LzHV3R5wYNCqehTfs4kJ7MutwSPVgX7+Iwg6hCxBiLNZlVcYN4
        FLlLZ87pjTlwPcBLOUswyrFay2phahU=
Date:   Wed, 24 Mar 2021 15:23:32 +0100
From:   Lukas Schauer <lukas@schauer.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Alan Cox <alan@redhat.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH] fs/pipe: wakeup wr_wait after setting max_usage
Message-ID: <20210324142332.xfcuvuv2lfjkfznn@vista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiyo6ox56cbjkj3z"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hiyo6ox56cbjkj3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With commit c73be61cede5882f9605a852414db559c0ebedfd a regression was
introduced that would lock up resized pipes under certain conditions.

In that commit resizing the pipe ring size was moved to a different
function, doing that moved the wakeup for pipe->wr_wait before actually
raising pipe->max_usage. If a pipe was full before the resize occured it
would result in the wakeup never actually triggering pipe_write,
resulting in a deadlock.

This patch moves the wakeup for pipe->wr_wait back to the original
pipe_set_size function, after pipe->max_usage has actually been updated.
---
 fs/pipe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index bfd946a9ad01..58916ad905b4 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1282,8 +1282,6 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;

-	/* This might have made more room for writers */
-	wake_up_interruptible(&pipe->wr_wait);
 	return 0;
 }

@@ -1335,6 +1333,10 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)

 	pipe->max_usage = nr_slots;
 	pipe->nr_accounted = nr_slots;
+
+	/* This might have made more room for writers */
+	wake_up_interruptible(&pipe->wr_wait);
+
 	return pipe->max_usage * PAGE_SIZE;

 out_revert_acct:
--
2.31.0



--hiyo6ox56cbjkj3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEPC8mBeB4oeGPR5OQnE2+bPQ48zMFAmBbS2QACgkQnE2+bPQ4
8zPF1gf+K13g+OsRDdSXWdNCbpNPQRolHWCzgGfDtSL9zyTlLmWS7CBj6Jn/zmxK
6j914SRe8adddCHpLS9XQ16mbf6qRtyUIMCep8DY58mcZ2V5GPqf0PfvgtMGN6EQ
sVFMdiTqedbiDOv8K3fxcpRCxYu4O4rCEp0bATAzvu/w3jGm7pWWJhZn94mr/v5C
kLNMGBKltJIC/+xMvKQ/LmFB8WKTE6k5yf1qjLAp3/82ua8Wm/cYZ5izuwEWANgP
t8bhL4z3mfss+nEXAIJ6nXVZ471THjkG968DENBNYfun5EIvXXWUqFJ98F5vNt4g
kqyV2le88n/qmI4dISB0mPfbiLI53A==
=Q8eY
-----END PGP SIGNATURE-----

--hiyo6ox56cbjkj3z--
