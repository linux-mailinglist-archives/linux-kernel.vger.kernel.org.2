Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3344342F00
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCTS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:29:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:52095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCTS25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264933;
        bh=WM09Cf0O+T3HSwKFMKx/m00pleVmho3v7cAsPZ+STFg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DkhLN0kEnldFZ22DgoU0srwrz8q9hUT1w+SQmwF7LpeBi3EY4EZyq0fOW4Oh72Klb
         c5WOCohWdizhAP0NVHNgwRjNg7TY390fpxV5voV/QhEwQc9SdlGp11rrdJZcsyH6dy
         Qjye/iVXm3qGp2BRh8yxJq2StehSBREvk8AAhPhM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvcG-1lAV2S3uuO-00Uvzn; Sat, 20
 Mar 2021 19:28:53 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH RESEND] workqueue: Switch to new kerneldoc syntax for named variable macro argument
Date:   Sat, 20 Mar 2021 19:28:29 +0100
Message-Id: <20210320182829.688032-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tMN7k/0AgZ6VzP7oxd44cfxsAJE8meKnp6CsWyqI7gnvpK+KizC
 aRfUnwFPCipCpHrfyh0XK4Eq3gWw9aYgoYMvlcL3DCqLPNLP42w/9j5Iset19h0tUCTPYUn
 H1JZs+9Um97mdVW8rP1ejdBbBzch3ifWi1pGjol+xlztJwougbw5Cr/OljQBIK5vIGXdR1e
 KB7I4eNXoRsNNnbX/O7Xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h8j6QCBtsvM=:CcwDhPTVF7EyvSFAssdP1i
 bUEUAO7VonWRzD0bLl30MKz7Ad+T1iusscooms3oGj8Z3StcNFdEO3zHWpvlQrwKsczOjgx7X
 7iRndnjgdcfq8W259jSs068b28/8XT9e0Gcde0G7NQ3/Fd8OxAgFLALthfkarZXUB+57nXlLT
 +XIIChKFRH1uFKXZRItIrvy6XfcBcNnSzgcdgldGI/JZS6ItH1/k7qPrjAEJESMClKgP/f0sz
 PoyNc+E82QMXqCzSglgm4dsUe3AmjOfDrFuhfCIhv5VsS4zRDk6myA/2029Iaug0hBlzYQIr2
 oDzfpryxIPkOgZHWiirHjInL5YT9/dE7cmHiw7mOBpmb4E6q2oLSZzlKmQOisQPbTFpr1Np1/
 KsO7A3mbfjLn30fDya/LNHiuuCLvZZr5ONzdz4mk0nOzplcmvABA3b0sAOT63phBnkEgvg6W8
 sA7ZKm3TLK0lr1qNWKe3QjmUFFVSBJpqrN+nGZmOZPHEFzuX+5hSlD3bZXxYashaTVcw8A1sA
 VRew9Jl4XDsst1bRi0FDmoFDoYHjPeJPayJ+ixdw+yF7JoJwV8zTtIO0Z5IBjPkZDmpt0YJuO
 To+uitvvxTRU6eSBYV4QOGLdNEQWNDusR0V/9mfaRwzQYFVjuPLmfMG5jB9tZicePRKUbGB6j
 QFHunE4DkLWiI5kmYbHS08SmStsXR3dWaWLk0s0LXbvUCetBgHCNIoI0c39Qe6OTnw7e1lzzI
 YavIO2ttnOm0/hadpwcJxURFVWUG2Vuv19BrIaC4DEnr+J9Y+SrJo8Dv84CuZ0B0yTqmRqBcE
 fppAYoIy53hdf/BiZFWXbCRmEI0jXpuySSSAC6EPiKpWPWj0S2KUM2f+N1tNKeGgxJPTGLqLQ
 vjcgZsW8zqAHCvP93l9g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax without dots is available since commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

The same HTML output is produced with and without this patch.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Tejun Heo <tj@kernel.org>
=2D--
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18b..83a51c5100e68 100644
=2D-- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -412,7 +412,7 @@ struct workqueue_struct *alloc_workqueue(const char *f=
mt,
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags (only WQ_FREEZABLE and WQ_MEM_RECLAIM are meaningfu=
l)
- * @args...: args for @fmt
+ * @args: args for @fmt
  *
  * Allocate an ordered workqueue.  An ordered workqueue executes at
  * most one work item at any given time in the queued order.  They are
=2D-
2.30.1

