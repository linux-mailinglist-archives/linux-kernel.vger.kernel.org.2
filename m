Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FD37FB55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhEMQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:18:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:44135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235012AbhEMQSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620922632;
        bh=qcKzTKCSddo160zYY1C/zfO0rIDl0AEk7qhy2DrxVVA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Cj1hmNAM8N6HWzkuLNtLcDXcmVxvGVld/5YCa9Ye/fMjwsdMzy6B/CbogYHni4Nks
         WHwZUCDCSxQcUUoWLqcMqAiOAK6iQhyQwWrc6MrbeqMOwsEXV+8XvOQfphLVC46+se
         ZwH2ps2vZTFRD5zGOaaLfc4zOuU4uQMwBdCkFpOI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.126]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJlc-1lFu5r3iCa-00jGTw; Thu, 13
 May 2021 18:17:11 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RESEND] kthread: Switch to new kerneldoc syntax for named variable macro argument
Date:   Thu, 13 May 2021 18:17:01 +0200
Message-Id: <20210513161702.1721039-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HpH9niYyRuRivQZWERtV8ZkCts+oaO5iOIps5uiL2OYJlQFFwH1
 GPl7aH65D/bR1CFF96LLvQw9+zXyHlgZrw2XO8JBhzdAXvGRRV1SrpxRMMXUscE2XR+N9wY
 gpkNQWC+q288mmNWTvQcGuJK1CET7+Jflx9hPHwK2Z06PrC0oWoxBNhD97R4HeM5PQsjD4K
 7dUZnTzLdvkMCnyAVmLdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ds6tdE+jM6U=:8wy9gb1DWsSQCf07ekRNWK
 L6s9ojoaxj7BZF2EMSfVJytGQN3FLmbLu+PQmUhT3wokY3UsXIrkSbbOUaXtAZjurG+BJBOLF
 2Ybkz6jYISNCI7dtEEkc76T2+TUnooG3lpdphgcobNjfoAG9SMlbZc4rlCyGBTpn6OuR1f+M1
 l5X9NyRxtoEwQjy1geJdOZkdCxE3Sheae52EvjMnuMW/Yr+zcm2zVo8pPBTBCaIltAfGAljB9
 ObJ2yHouDQS0rXoGjqCVDdZ2/mYMyujLrqriI+TQMEGP6XQIGk34+9h2/It8aVGXhBv/kSv74
 X9vBaahZ86bpTc/GMpLlA55HdADzShnnmBKV8dP7Z7MAWs0oBpTskIZRzTzBi++VEvU9Jc9Ye
 3DKH7x3fDdRJYki52mg3zraqQo4nZmBU7V4AtIQPzyG13SoLNVgPIUUQzKKQ9mJ4zjkJ4mnNN
 M6bUloJmCApt/8g8juxCavpiCOtwiVDZ2h5U+Vk3EN4ARnfQC33k8pqwnHdJRKs3cdmdXQn3J
 +h5bn+BKwqKGLJBQg4Le8lodIFw4xX+BKmm9L87p64mEZ2x+RCDh4N08QJwdX1Jb1o6jyyyRl
 m/Wr9dChWAnhQS+Cn0aY9fXObEkvN94BfU+DiDgdSAEwsAuvg2hJIiUwV6uDbCD0DKc9mnTfy
 d0IamYuu4lYNXtR535VEQWkc6flpW4cQuOZaBKTiB2hQUDrtFK6wyIevt9fGQMuzZ9TKAUtzX
 FaCcX1ptXSE/tfSyLVNwzsum6b/tyB5WgZaxfX2OdRgl/9YHYqmLXROCL8QqRKs4M3R1cbmhG
 sOpXLDIAcOZjaE7q4uynIndzGRmKjtwl6UpSCtiQkxGTOV0tMs+m6TKoyPf6Ei6tclAgvNDUp
 I6BT5kwqNJC7EVegjduRbkVGj7f89Moomcl60MVPUN+cqgZ23yi66OXJx3XsIfGkW5aGyShkO
 w/LbhKd6T0lk3WyDW+4HkvGtSbQvnGOq/nR38zhPmEv0vYz4pnnYrL/vYudjXGd8s/MaZ3L/m
 X7/nNvA1L+zXaU3cNkiycl7bLKbsetIqGQ8ZcWM5B3BT0WsqmSq8Y65KBQc2DtqxKkHP9Y6Kt
 vUKhEADUSU2x9uEfN23N9FqlfsPyfwYEOCaeO3ImN+nc24jhwf6AsuOL2AsFKZk0aMw6kbM6s
 A+rQah3Jmr4HwfEIZidLnq9iy/XhpiK7SYnxqnTmpqNYIFyM+u53l5bPCeW2oAujczvsJla4o
 Z5HyYPSBiwKT3NXKJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax without dots is available since commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

The same HTML output is produced with and without this patch.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/kthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2484ed97e72f5..db3eafea168ff 100644
=2D-- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -18,7 +18,7 @@ struct task_struct *kthread_create_on_node(int (*threadf=
n)(void *data),
  * @threadfn: the function to run in the thread
  * @data: data pointer for @threadfn()
  * @namefmt: printf-style format string for the thread name
- * @arg...: arguments for @namefmt.
+ * @arg: arguments for @namefmt.
  *
  * This macro will create a kthread on the current node, leaving it in
  * the stopped state.  This is just a helper for kthread_create_on_node()=
;
=2D-
2.30.1

