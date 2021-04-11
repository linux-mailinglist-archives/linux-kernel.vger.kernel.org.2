Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391635B25A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhDKIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:12:53 -0400
Received: from mout.web.de ([212.227.17.12]:38547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKIMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618128737;
        bh=4lwNBAgcm4xph5hy1MYndCnDHws8xOophrXb5sD1I8I=;
        h=X-UI-Sender-Class:From:Subject:To:Date;
        b=BZjxDREu1cLO1mA9XEfXmC4D+vYe6ExKAwCTSDkZe1q5nZiZEDvAYlnK0bkCJg8cz
         dXz7QtsgSEskeEjS4joeX2MBKt+ua+zP1/7d+60bCEBR3M2Ry8+bctw2E24m+Zj6Vl
         a9fC8kbkfvOZfKnlX8RNRDPyj4nLdDQok6FJJqys=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcV4-1lSl7T1o9i-0079sV; Sun, 11
 Apr 2021 10:12:17 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] x86: Ensure asm/proto.h can be included stand-alone
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <b76b4be3-cf66-f6b2-9a6c-3e7ef54f9845@web.de>
Date:   Sun, 11 Apr 2021 10:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PaiUrPAxWoouTM+NdfA0bLdPLd/AI7R8Vr1ly4hUxAfAbFhAWQw
 XPQtcSnoXnSrIZ31XQmW8mJzNxRRFdAAoy9IAUbYpH0O0TTETq0qOURV9EA23sD6fEq/EVK
 YXl4j6FS4b6+NQR5QHhKdIXhhtUsWR9JSidGRjFx4oGwrQN/9Fnp/eZH7qL6bJwbIsVVaeJ
 9DiEmGs5GsE/Y297HnTcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7lHoLv8baO8=:60wsLi2iM4KceB7fJvS/z6
 y8t8kVsPFCUjm1lRxQ/51cxax8XoqWIj2M9RYxXRPO0UVJsLsYc/GfOqL1BP1WOnaDjIdjvyQ
 RIY8xPEK8ZGY9A/7dxL0XSRilSHk+xETU8xZaAu2sumIqG/MYKSddxW6pERmwDX/WBKHbaL2K
 JSt+zDrJyU6x5nKJ/RjVUZbiBSvzJPztX3rmznbowudO4oTOFgrWTax2jAN/XxBTBTGEg/Qr9
 7iDYdoP6uwr1roeZqAyqsWIRIQoOQwFcJwpo+QQCKhX24zh2PQvLGg1jkA7VznJCqObC1yq8d
 858SAWcOfjwqEdFvDQEbcXMaaIaUX0Fxdgoh43caO4l1lxBQZhvR0NDQUXV0jpMsB5cf1ZtEs
 HYT0eIRo0cA8eMhR5HJQyaWtvvvyflVVUQ/QkK35HFTw0V0lUuQhTmndjKj6Fsem521X9jlPI
 Z4z0UWF1sMooDCOMcDm8Mx8fY2mnj5EO65wT5zaf3kbRkFd5oNTf6dllEqK+JxN7WbjiU5A10
 VibKA3nfQpp77YHmF8XYTK3Jv9aM/5HgeI74GallwBAI2LV+sCetNY7WkVEZx2c1SnK6YPaV3
 nk7/NfwywVHm3IaXGTE6+/bTkePcZiylT/QelNjByEy74FsFJW+qqbGrrFktNqff/Nq0yc9la
 64DjJPEAcgt0c5/oC3mgX3Ky5H6iTiCysRo7KZUdXeglqHeJQ/oBSWus9KAAcAQwP43dGmdz5
 kN/CAALw8E+VH+IwXW4YgVY8CWGeyx0XlymRDazpf9jRa3q4/fcb1h937XgzXx/GXWtTbPnZr
 XxHjq/WhJtE+4q9GxvcDiyuLxN4+NiaO3hBHSBLuuKRt8VufT/no4RetCwdIKbX8/bnKfoEQH
 kxWbXnhab6WjGlNHerolkY+wdmaOkpYuAnDxK1QgE58n+1kJ9UirVTA30IIUMwY4LlDS2xX0k
 zVQHcnndgrsIFBVqAn+c45ACYMjE5oE1JX74d61+uUGy+BZxv1kFTqVyY41PS+hWQXnYfVYhH
 +A9vaVFgIHmC6zeG7YHdZn4aualnXFUu3X40vgLZxxAfGLPOctivCK8HA78GMxB+Yirok1XKW
 ahesmEG9rBDvYmjj0/AU6bLfpC7pJBw2VcBGqzs51/f1zeIV6QL+BXddEXTDrQGFp/iyNXpu4
 dILh7olRgqYw2JTVLC3EK2BITMupU0j5xxXcs//eOK28BhAtSjtls8M/z9gRa9l0cNA80=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoids

../arch/x86/include/asm/proto.h:14:30: warning: =E2=80=98struct task_struc=
t=E2=80=99 declared inside parameter list will not be visible outside of t=
his definition or declaration
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long=
 arg2);
                              ^~~~~~~~~~~
../arch/x86/include/asm/proto.h:40:34: warning: =E2=80=98struct task_struc=
t=E2=80=99 declared inside parameter list will not be visible outside of t=
his definition or declaration
 long do_arch_prctl_common(struct task_struct *task, int option,
                                  ^~~~~~~~~~~

if linux/sched.h hasn't be included previously.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 arch/x86/include/asm/proto.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index b6a9d51d1d79..8c5d1910a848 100644
=2D-- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -4,6 +4,8 @@

 #include <asm/ldt.h>

+struct task_struct;
+
 /* misc architecture specific prototypes */

 void syscall_init(void);
=2D-
2.26.2

