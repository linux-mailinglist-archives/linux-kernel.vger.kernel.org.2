Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816213E0C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhHEBdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:33:44 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com ([98.137.68.206]:43231
        "EHLO sonic304-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231964AbhHEBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1628127208; bh=1xrWKh5TgmovRoSe4Y8HZf+3WeuagNCGYghLM3FUw6c=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To; b=OA9XeJt53xahUIh0EznnTR/n8hqoa+pyWqkIV1JrPl1A+YK1TxAUYRhDDizhaNXYiIJh/cncHfmrpToDB1QtujCNH1MBVMwYCBZCuVrZbsW5jiakO3evAyN71FfeLyNqY866/iNh+z+Zk+o7a0zj0/HZBVubSMr3YuKfRKgqUBjbu0rYXy1q8uMs55Tp5hpOIAof1nhmpJcarXoSocfhMJvnAHzH4jVsVnb8ndvaj7Z0XwSHWW5nlSkNWdBHABo1y6hQ2jfji98xiibvIfprcAbYZ8Roj2h4VTXxJa9SqcaAV+MZMsE7dUSeZ8P0AoxuGHrPL8J+tfj6AHielBCdRg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628127208; bh=wd1QN/TGi76xQdk45sgC+Q+pTZzEb1W4wR9XOLWKz1j=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=AYEp/q4x89Xw18Xna1fnchejDhTL/fm2BvL5ZMfRaArFq1onzTfZpzMxYdP2zzSQYszIqq+VBPMjO0yXmSllxvQ0Gbuc2aDFrP4X4z3N47uog7e/M5GH7XBIr+YF/XQIU4OR2x9itv6/goaqINKXd39XsfAyDdvaQY0hFrDM2x4/czavclW2HJUzsYBSYu87KYlv+WfyCT/cYAKw9LSZT4KXrKJLALgkjtVLVP8hrPXJkItRCvAk8NI26f6KPAB3GFbD65QNjCTr/Ci3hAMhaDh522DNWKMLZmGtYg1aNkS4VN+5E5HVUzC7C9u6nSt67qHWflQ9AWR/qP4nzx4qHw==
X-YMail-OSG: qUImXvEVM1kqSEmfoulbZ1xMKa0j3vtXseDtasmARnLDHbxnyN9iMgZ4ETlwsao
 2N3GCh1ugpaxhEQyQ4PVv0n4DVIxYbBvNyka_J52AT2YvvllVhjoUa0OeeZcLXAxqgV8UYEVTrY6
 3zR8ng_9QbwZ.s9yRF0JlBGefbRHNjtLsIxMiEFKvdc7EzKx3QdBVLMBDzuDr5fLuMRIK3Y51iyx
 C4yrqlkr81c_6DN7rFNpwJp.wZziuoDNf2cWLwBEkd5VSUwjuIFZ8sYpmZvM0sdi0kmvnZC2pxTq
 8TIytaRIgdnPL8h5xhJ_Ws4X_aSwYOxKEunbsfTjdUH_0IdL.86a.EldplPNXYWkmov70iDDPZJ3
 E6OQo0tuFPBsdexQRTqfIfzPjjMHRROGrZQlm_ZCAuHQKY0W39q6LoeNnwzN5KzGZE3v815livbH
 RP7zZXdWgF3iCO7r2AXgO1Ssi4aQPkTcLWHVAtOgGHG408ClPFVW3jGr2XZ6dZE4NSOsV6mZn25i
 M4CAmD_GNP2ZB8zBKBXOsfD1Km0NcophQ1ofHsnNrl95O9vui8bRkBeZiQUTYsUy9uvuqAH09bcf
 sqZs8ZNv0.u8pgWKz98mtSGFr4TDGh9vVUAcHW1ahiJGXcycduIxllKRZNl.0PgaSHft8FEGZYTi
 t4tMReq8B_yDmJ0lFy1ZB6M_uKQS.YFeDNRCd3i.lErBjmbYJXO5ze4hPLmyPXnmtIM1wFE55_M1
 1FJUSkPX5Hwv977NLllzuDpEIF.JyaWlazVhHFVQYTZHQRDoP0jJ2j1dsmlSFXHBTLY4Z4pbtrb3
 9oFiNfC0R9rejhwltC2Oi5M9LffoZcBi0DHEu84Z8HbQptdIcxOPp6Koh9vSnScwb..JlPKz.9xa
 hR0OfzZnpQMIcM7dypWDEFMWenTLHXmGy4eMRjyDymKp7z6QdlNm8NdrKxCG21EbLujzTA0QE.D7
 JllwEmGHwDFW9ULOcwWzBFB6EC8XcxX_Wu6fm0o02AbNGh3e8sPKmIbCzedh9jiCI8mdho4oOzLK
 49bIKD4gughjqELsyht0UCCev0OUBoP1N.ouxZjto7KblDrW3NFEdMozIb3lXEp5G9dY4N4A0yxG
 Qw4okydW.e95rJBEUiGjfXVtd1kFWGCkofczVwEdenoHcj51GZe9_omo5jz7ougZHB2iY.WY7um1
 qL6Bb0gOvdmxYt8KSZeT0z4Sz_M5F6G4G9vh_PLwC0ku2LpsTEavbFppAzYj412iQdriZFmkjdCp
 K30DsAGnPTquBdqaSIVVaaLqP0HeaK7VivrgIKF59jJbGJ8WSmYuJKI0SAJgdFYRFRHs2es6q2MS
 yHawMbMsx5GYq4bULC1jL1inigYkr8kjSsYT8YPh.C9zy1VulkRJW4FXrKcFkRVJzJcIiiYO6uP6
 e7ffY6Vyv3zMhLgnO3bygY1t_y1Uxdch5GScVBNz0W4YNSLRfZu5WVTUXala_oQIDMILNFjZgtHQ
 lLAm4snPjhdnZZYL9DYvIwxt44SLquK6GecKYREA.e5EFKCmA5lyxNsMELBib5TlGwzDLbB0RMx.
 a7DSBwsDHkJ7oCx8G_v8owLwoOfxiZbWVxygp0DdIMa5fNUsI3fEXOXexb1gCN65pWnTq3sR76rn
 Tsb1LPKS7cJ_2wNP3SyzmQO40ZBCLMJwiWJOJk7R2xzxRGyd3Hz4v0RpnwefylUIxC.QzqZnIfz9
 SVm66LLzrOGuVKvlSLbKRPpvpdFO7s1rO5Fd59r0ooC5kLMCcmFWC72aONw7NfYvCYSDF0OoIx7U
 kHWcSL8v9zSSFzUfBr9oqGtm1MByP9nYxEX3GkDo66Id6ipUCvi2.lZJiv0R0ickdSNNrfjijonp
 zzIA0ZcrkNTgNVJtPqvIf5QIAFOoSQyT4LW2btDkyVSxs_3W7_cMniB_DMfosmPsuzJDkEH9Sccl
 luBskc1nlKwmd6OLFGJspCNxwGmc2AkFuhkhG4tlLi7ArUq3QATEfodKUayIFlulr6d1E1F8ayyP
 kbmiD0yDbESs6D.bgkA6OAq6ib5GAwpfjOQyJWf5N2OOBqqkpqJrw.zIWtjXF.2t35KzBR_Lsicu
 3BX7QoZT01kGsiXU79RZI69rLz5A_yBi1Fjuhi7olDQueS0JRR_2_oFCIz_JDiS644iNt2G6KnzY
 h7mL0gM3T6CMNTrBSf6Smrkhz2NSYty..AExH66jYd7y_LlNffbnpXZVjh7KU7GdQKRvXkpH6WMZ
 5mRMH1G9uQzREUisdmTNkPvuNOX.ulLlE1ouPqJpHHPRgsnAwnjnsl2PF53An8VIWEVd6ExwLgfA
 KVg9DhHCqrLhav2ySQT2DjbFP.KRnvIGFWdsKmj9ce9FX7ZOg04VIbWJxl4ZABHedV58913Bfjg1
 upSqAdxxpx84g.qEuTMrz7OuNA43cUgwTnt.MxFmqvd.RnbxUfbWL0KDS_B6p.sKqNBDLGc3w1i5
 iVAmANcVinFoUwR_tKwDHoQoJDYIHRjnh0nU-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 5 Aug 2021 01:33:28 +0000
Received: by kubenode544.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0fb3b7ac0e701e905232dbd565dfae20;
          Thu, 05 Aug 2021 01:33:26 +0000 (UTC)
Date:   Wed, 04 Aug 2021 21:33:22 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] pipe: increase minimum default pipe size to 2 pages
To:     linux-kernel@vger.kernel.org
References: <20210805000435.10833-1-alex_y_xu.ref@yahoo.ca>
        <20210805000435.10833-1-alex_y_xu@yahoo.ca>
In-Reply-To: <20210805000435.10833-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Message-Id: <1628127094.lxxn016tj7.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.18749 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, the following program prints 4096 and hangs.
Afterwards, it prints 8192 and exits successfully. Note that you may
need to increase your RLIMIT_NOFILE before running the program.

int main() {
    int pipefd[2];
    for (int i =3D 0; i < 1025; i++)
        if (pipe(pipefd) =3D=3D -1)
            return 1;
    size_t bufsz =3D fcntl(pipefd[1], F_GETPIPE_SZ);
    printf("%zd\n", bufsz);
    char *buf =3D calloc(bufsz, 1);
    write(pipefd[1], buf, bufsz);
    read(pipefd[0], buf, bufsz-1);
    write(pipefd[1], buf, 1);
}

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---

See discussion at https://lore.kernel.org/lkml/1628086770.5rn8p04n6j.none@l=
ocalhost/.

Patch resend to linux-kernel@vger.kernel.org (typoed email last time).=20
Sorry if this messes up your mail clients.

 fs/pipe.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9ef4231cce61..8e6ef62aeb1c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -31,6 +31,21 @@
=20
 #include "internal.h"
=20
+/*
+ * New pipe buffers will be restricted to this size while the user is exce=
eding
+ * their pipe buffer quota. The general pipe use case needs at least two
+ * buffers: one for data yet to be read, and one for new data. If this is =
less
+ * than two, then a write to a non-empty pipe may block even if the pipe i=
s not
+ * full. This can occur with GNU make jobserver or similar uses of pipes a=
s
+ * semaphores: multiple processes may be waiting to write tokens back to t=
he
+ * pipe before reading tokens: https://lore.kernel.org/lkml/1628086770.5rn=
8p04n6j.none@localhost/.
+ *
+ * Users can reduce their pipe buffers with F_SETPIPE_SZ below this at the=
ir
+ * own risk, namely: pipe writes to non-full pipes may block until the pip=
e is
+ * emptied.
+ */
+#define PIPE_MIN_DEF_BUFFERS 2
+
 /*
  * The max size that a non-root user is allowed to grow the pipe. Can
  * be set by root in /proc/sys/fs/pipe-max-size
@@ -781,8 +796,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	user_bufs =3D account_pipe_buffers(user, 0, pipe_bufs);
=20
 	if (too_many_pipe_buffers_soft(user_bufs) && pipe_is_unprivileged_user())=
 {
-		user_bufs =3D account_pipe_buffers(user, pipe_bufs, 1);
-		pipe_bufs =3D 1;
+		user_bufs =3D account_pipe_buffers(user, pipe_bufs, PIPE_MIN_DEF_BUFFERS=
);
+		pipe_bufs =3D PIPE_MIN_DEF_BUFFERS;
 	}
=20
 	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
--=20
2.32.0


