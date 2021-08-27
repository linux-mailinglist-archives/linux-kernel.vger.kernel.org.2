Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046EA3F9704
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbhH0JbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:31:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:53485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244668AbhH0Jap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630056586;
        bh=LqTyT87+0e6RUnBr2YRqilZ5WZkM0FGfXzBRJc9wq9c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=OWk+GHoB0TG+aWJjTddL2kYdBvbf9YPfU+Ow/xcFsrc2x558WcnCkP74Kx/MbNVm7
         DJlSk8P5WhoFM0gfU6pIf86HQQwXt3E73K/xQa3hEs8kr8FrlT0FALpkQv7DNYiRCe
         3WEV90K9ThrUwiMffWKT1gTa3pJ5ey3jnWEaThes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.133.192]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXhK-1mg9Xc20Yc-00MeFe; Fri, 27
 Aug 2021 11:29:46 +0200
Date:   Fri, 27 Aug 2021 11:28:14 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [PATCH] Fix prctl(PR_GET_NAME) to not leak random trailing bytes
Message-ID: <YSiwLuE17BwRlI/d@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:wnZzoBHhBThI+lg6ZoIrqspFEQq545CfQnIQUngduGkrbBFjB0n
 2knJ3X8+cgozHnRu9KiS6kwzkneEHbpht1MlCUF465bDVgIN1aXGtR+rx6WbRjY76DWDGmH
 T9cV40j+SNFdOdkX6D1i3rfiXt/NfCje/AMB6P4XpAGsLhVMpYdKrca03r3hFtvEXYtS0Gn
 OiObU+jP/1H2wsmZyiB9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9OdC9BD450Y=:Gjql85bK/7dBvf5UVqY2Hr
 zZnZ5x8XXlW1tmiOe0uQn8iMsU3OWeqZBcSs51t45AORzzYiQEckTYromCYmHE8NDreEoEG/C
 WOv3LtPrDt2R3SSNz+Xx14iSCQe57ZhO/7//wmV/o3XKYCFZ3NuJi1mX43K/EfIvhE7s8AlXE
 fJFO4AKBy5h8jzbe08ZMlW5SAO9xoNMOc3pVN7rFi2e7izWiyGK74uHsiNgRqnOY8D8baU8EN
 PSnpvdWO3qvz8nPAPWVrcTdYYsE+TyC6gsQOcybgF6gNH3NTA7scmz9MDUXhJY5BRdgMp4c57
 RgKmjZ27VjlRceeZXfUjKJktU2L8ozLj120AuVKID5f/rAmuZ2aNlyYmilOueuJUivAZdlv+t
 Wsris3NUt5OHWGL+VtsdnSNjTBEvF9n9yP1/zNr9h9K19h+L+d8hddtca3/uJ0WoRRwXpeXPA
 Ks/mPaCaiNi2qXgunOZYD62lW1pdyeP5Ltj+YlzdVyKerT1IADziQfd3ipsaR4LZeHMdkCT2G
 A15+T+Sp75maO3y2XeEtb/2Bkp8K84ebgdkK0Y2htdHgEZcsevUyvjj7AH+jRmxXbTc8d/d8A
 pVzmWsXMjKZDH6rWCP5kfmKz9HhfcScggW/GjNT9uTyX4Pj88wRLiivva2XwTDtvmFf0U+RqB
 t7xL2VKKjXRxRcAj0wKL0BKVjAlIzMEHcdWcXfKOZTbc7dypLIMp/NU+hUpigph06JmLNTNmc
 FjtpmFMRg9x4NK9pRm8k/+dnvM4XWwFB99cFc/OFbw6hT+gZTSjHKgjldV5lWIJwc3WhmfpHh
 R3ZClMy0+u8D8PWSRQFDnloRrB8Uvf8eU6sTx/1BvzRP44DeB6+GndB5tGfsUKcbrgD0Khprc
 jX0mY8Y3IRN29Fyb8EpS9zBJhqy19oQ+36CfVlgwZcZNsqxAuU1nKAQ4rYBmyI1Kghi7mTX6/
 luwfR73BFAAjmM7Bngwjw8x0lnN4nY2/2XuhRZ/2/niBKtd+wMLA51PRuVgo0GHwstP89HkC/
 JkPSCs09BKGgxZB/Oingr0gfx4VkllISIR8qp4hryL5/DE++R+YpPojlFTjNwsfA3mL70Qbb+
 gtBfG6tGDzuDFvdLqAyxuPl2gDXu136bv+o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prctl(PR_GET_NAME) and prctl(PR_SET_NAME) syscalls are used to set and
retrieve the process name. Those kernel functions are currently implemented to
always copy the full array of 16-bytes back and forth between kernel and
userspace instead of just copying the relevant bytes of the string.

This patch changes the prctl(PR_GET_NAME) to only copy back the null-terminated
string (with max. up to 16 chars including the trailing zero) to userspace and
thus avoids copying and leaking random trailing chars behind the process name.

Background:
The newest glibc testsuite includes a test which is implemented similiar to
this:
   prctl(PR_SET_NAME, "thread name", 0, 0, 0);
   char buffer[16] = { 0, };
   prctl(PR_GET_NAME, buffer, 0, 0, 0);
   char expected[16] = "thread name";
   fail if memcmp(buffer, expected, 16) != 0;

The compiler may put the "thread name" string given in the PR_SET_NAME call
somewhere into memory and it's not guaranteed that trailing (up to a total of
16) chars behind that string has zeroes.
As such on the parisc architecture I've seen that the buffer[] array gets
filled on return of prctl(PR_GET_NAME) with such additional random bytes, e.g.:
       "thread name\000@\032i\000"
       74 68 72 65 61 64 20 6E 61 6D 65 00 40 1A 69 00

Unfortunatly the glibc testuite tests the full memory block of 16 bytes
and fails because it expects zeroed characters behind the process name.

In addition to fix the glibc testsuite, I suggest to fix the kernel function of
prctl(PR_GET_NAME) to just return the null-terminated process name.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org

diff --git a/kernel/sys.c b/kernel/sys.c
index ef1a78f5d71c..af71412760be 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2367,7 +2367,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		break;
 	case PR_GET_NAME:
 		get_task_comm(comm, me);
-		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
+		if (copy_to_user((char __user *)arg2, comm, strlen(comm) + 1))
 			return -EFAULT;
 		break;
 	case PR_GET_ENDIAN:
