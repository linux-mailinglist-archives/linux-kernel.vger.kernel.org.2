Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82A13777F3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhEISef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 14:34:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEISee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 14:34:34 -0400
Received: from weisslap.aisec.fraunhofer.de ([188.192.220.174]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsIbU-1lMktK3yzi-00tn3a; Sun, 09 May 2021 20:33:25 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     michael.weiss@aisec.fraunhofer.de
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] audit: allow logging of user events in non-initial namespace.
Date:   Sun,  9 May 2021 20:33:19 +0200
Message-Id: <20210509183319.20298-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8va1dg/3tYY7pypvupQ73KUAzH7sZmkxm64W1+FeOAoi2q0M6Is
 j2r1y4RJIF19JrCe+IWjWaie47e3Pw0a/rgqmXXip5wsGLaDCBEaoPdUXtCB/yoOkx55ZYN
 0ATIoKx5yClRMBxIQ34q/XF0TLcH4mQF1IdyWH7OdnMhAz0GRMKxX4Lc43MQYQwA5C4d/xz
 yV6h+ElMsPbVmG/7C8e9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:84PiVkLWRQY=:Y1OTmnl/Ok71BZeNKOEQ/R
 GBe9IN2Y7DFQOJMBK46lMmGBidUNs8v7el8EEt7zCP6qQ9Rmf0YagZFeVGoW9SQPD/P8nOJHr
 YAdGAljV4JUbSH4bk1caIT+SVbotZikvH6TRAHiNnAqnE331WVBT2XGabbQ/Z43y7N7jWCBFU
 2kyYONtCqHbwTfclb6dPXbmfI+KgJ4PjM/LdBVujwxn/NIoxzdFZQt1leL5mVNS6c+zUrYfpB
 MELf+gFTvw+vQAYdDo4BUPQnch0lxmYTkH2UwlAvzFxt46sWverQPltPSKE3zSeeYGunUOD/p
 +udLuLFp5JEYqADkRGSCn1wVgtdA4oL+iXYcHs+3cFMUFGCKssZ9wXQ8UivPehak8hILQnAgr
 fLFha60U2JqotCDZFVo0M1eKI2DNNIgIphjJwU0QWacOwZyViC5MBg2TsYSphnfErzlz9ds+x
 BwC2MA4GsqTuSsuG0cs8eP/JruleX+JjuKyIkTtbfLRxS1j6rZ4HZtR1FEvQgCuUpqB4Mv0Ji
 0zmvLFdP8h/J9Kmxf1YYk0QSuExBWWt5zucyWAw/fhr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audit subsystem was disabled in total for user namespaces other than
the initial namespace.

If audit is enabled by kernel command line or audtid in initial namespace,
it is now possible to allow at least logging of userspace applications
inside of non-initial namespaces if CAP_AUDIT_WRITE in the corresponding
namespace is held.

This allows logging of, e.g., PAM or opensshd inside user namespaced
system containers.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 kernel/audit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 121d37e700a6..b5cc0669c3d7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1012,7 +1012,13 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	 * userspace will reject all logins.  This should be removed when we
 	 * support non init namespaces!!
 	 */
-	if (current_user_ns() != &init_user_ns)
+	/*
+	 * If audit is enabled by kernel command line or audtid in the initial
+	 * namespace allow at least logging of userspace applications inside of
+	 * non-initial namespaces according to CAP_AUDIT_WRITE is held in the
+	 * corresponding namespace.
+	 */
+	if ((current_user_ns() != &init_user_ns) && !audit_enabled)
 		return -ECONNREFUSED;
 
 	switch (msg_type) {
@@ -1043,7 +1049,7 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
 	case AUDIT_USER:
 	case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
 	case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
-		if (!netlink_capable(skb, CAP_AUDIT_WRITE))
+		if (!netlink_ns_capable(skb, current_user_ns(), CAP_AUDIT_WRITE))
 			err = -EPERM;
 		break;
 	default:  /* bad msg */
-- 
2.20.1

