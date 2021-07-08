Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A213C1603
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhGHPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:33:42 -0400
Received: from da1vs04.rockwellcollins.com ([205.175.227.52]:31102 "EHLO
        da1vs04.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231932AbhGHPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:33:41 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 11:33:41 EDT
IronPort-SDR: sVBj2hguHH4RHwuK3x/99GL+dtkuWgeiyP5Yi6nSlIexJqow++FEIFTqkvF95sPWcPbfJqmbGG
 rfmhVvIOlJNq6zkHo2oxt0SUXBm8cxKsTZhCmn8+z57QuQJAXrufDvHsOrJXWRw7uSFJ1nyTmT
 j9KPlltHfQrpqZOeSk6uACehou/yMdGMJaQko7/7T5fkVp1BxZRrFBbva9z+/umBv5JT5SA708
 ZdEDgr7oYTtZ81NWmZwEox/hV5PJ4+sVt1+iLJOC6a4/WKkXZWydBymxXZcElnkhyKOx00RjYC
 D84=
Received: from ofwda1n02.rockwellcollins.com (HELO ciulimr01.rockwellcollins.com) ([205.175.227.14])
  by da1vs04.rockwellcollins.com with ESMTP; 08 Jul 2021 10:23:53 -0500
X-Received: from biscuits.rockwellcollins.com (biscuits.rockwellcollins.lab [10.148.119.137])
        by ciulimr01.rockwellcollins.com (Postfix) with ESMTP id A5C0B60089;
        Thu,  8 Jul 2021 10:23:52 -0500 (CDT)
From:   Matthew Weber <matthew.weber@collins.com>
To:     sashal@kernel.org
Cc:     gregkh@linuxfoundation.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Matthew Weber <matthew.weber@collins.com>,
        Stefani Seibold <stefani@seibold.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kfifo: DECLARE_KIFO_PTR(fifo, u64) does not work on arm 32 bit
Date:   Thu,  8 Jul 2021 10:23:41 -0500
Message-Id: <20210708152342.59635-1-matthew.weber@collins.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

If you try to store u64 in a kfifo (or a struct with u64 members),
then the buf member of __STRUCT_KFIFO_PTR will cause 4 bytes
padding due to alignment (note that struct __kfifo is 20 bytes
on 32 bit).

That in turn causes the __is_kfifo_ptr() to fail, which is caught
by kfifo_alloc(), which now returns EINVAL.

So, ensure that __is_kfifo_ptr() compares to the right structure.

Signed-off-by: Sean Young <sean@mess.org>
Acked-by: Stefani Seibold <stefani@seibold.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Matthew Weber <matthew.weber@collins.com>
---

This patch originally made it into 4.16 as 
8a866fee3909c49738e1c4429a8d2b9bf27e015d but is a bug on at least 4.14
for any 32bit system(PPC/ARM/...) using kfifo with u64 datatypes.

Please add to linux-4.14.y for the next LTS tag.
(Below patch is a cherry-pick of the commit onto linux-4.14.y and was
 verified on 32bit hardware.)

---
 include/linux/kfifo.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 41eb6fdf87a8..86b5fb08e96c 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -113,7 +113,8 @@ struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
  * array is a part of the structure and the fifo type where the array is
  * outside of the fifo structure.
  */
-#define	__is_kfifo_ptr(fifo)	(sizeof(*fifo) == sizeof(struct __kfifo))
+#define	__is_kfifo_ptr(fifo) \
+	(sizeof(*fifo) == sizeof(STRUCT_KFIFO_PTR(typeof(*(fifo)->type))))
 
 /**
  * DECLARE_KFIFO_PTR - macro to declare a fifo pointer object
-- 
2.17.1

