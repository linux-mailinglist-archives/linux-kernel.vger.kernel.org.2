Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1464017C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhIFIWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhIFIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:22:08 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211EAC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:21:04 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id x6so3382351uai.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HQpB3agz0MFoV5PIGIR14gu4uspFT+NsAFAVtciBlrI=;
        b=YaQ21JAGu0unzSBVMM0U3DyfuTs/JjO5Y+d0ExOsEK2+bi8jtaV8bCja5J1j18HvAD
         PmPu09PpwgG64JLRZDqMyDnRZc21bpebH/vK9OTYZ5ei53qToSOkyzcDh9yb2NpefpQ1
         8DllovCRhGqeMFPscabFSeH4LlfyOuBL/TuphabxxCufWENeh/h96zMPaNXigTNfSQiL
         oLgdKcXM2GBySF4D+y86kIz9khOBzdR2W8m2na8df91iLqlaKt5/U4CL5ybE4hUjJvFz
         8x10kgVeJ3QVvoUIEko8ENod2Y1ZZW9fZIEl5xpwTC3ah5RDyvlP2a+I9CTYlPe7uinu
         cVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HQpB3agz0MFoV5PIGIR14gu4uspFT+NsAFAVtciBlrI=;
        b=byeIoaACxMAAouzT2fa0kJuHpAgIVmfpyRk1TqM9mdFsCf45Gp3avloOvpzPOdkGIC
         n3LPtJCeio3bmJH0Yy83fLc8LeERqVg6gUc9eQuDtBdrCA+x23xPB6FrmWFnbOeBKBcw
         Y9J+ye8d9+/OiK56NPPohNzI+ugtrYGlOffNQKgS79nB/Fuic0dFv4UejF8CKWjs7EuM
         boXoU6fMnIYB2Aw9HSk5YXlxCJ14jqKbLsRE6Sl7fG7nDFe+YQn+LgcvoXoAFtM2JHoM
         owLrYAkPvIoCWSlXlcXQ6ahDfSpTEPMlvhXLufcL8A2X7Ma4hShw87FZdw3lWn2j8JEb
         qwqg==
X-Gm-Message-State: AOAM533v/LxSz4G5SnO5BU1CvadNMgUU/5qtOrB/yE0sqerjjERJOpq5
        pCQ7jQrT9HP6oKqWCZcDmbOmjw4Y4ZjFegc8QMy6wsNpR8FBOw==
X-Google-Smtp-Source: ABdhPJy8VIxSg856xT2N+ryelffdePW9ZHpELvHF5KVEP0BaU7g33UD8Rn+KGiLO6UkGUch6ujtRlnq+qP+vMDgILTM=
X-Received: by 2002:a9f:2427:: with SMTP id 36mr4703629uaq.35.1630916463338;
 Mon, 06 Sep 2021 01:21:03 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Mon, 6 Sep 2021 16:20:36 +0800
Message-ID: <CAPm50aL9trE88p59KFj-UfEKMji5Ouyjtk=eq55JnSzGZ12WsQ@mail.gmail.com>
Subject: [PATCH] kernel/irq: Make irq_set_affinity_hint return the real return value
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_set_affinity_hint does not return the return value of
__irq_set_affinity, which makes the state of functions dependent
on the return value of irq_set_affinity_hint inconsistent.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 kernel/irq/manage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ef30b4762947..86196fb826d6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -490,6 +490,7 @@ EXPORT_SYMBOL_GPL(irq_force_affinity);
 int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 {
        unsigned long flags;
+       int ret = 0;
        struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
IRQ_GET_DESC_CHECK_GLOBAL);

        if (!desc)
@@ -498,8 +499,8 @@ int irq_set_affinity_hint(unsigned int irq, const
struct cpumask *m)
        irq_put_desc_unlock(desc, flags);
        /* set the initial affinity to prevent every interrupt being on CPU0 */
        if (m)
-               __irq_set_affinity(irq, m, false);
-       return 0;
+               ret = __irq_set_affinity(irq, m, false);
+       return ret;
 }
 EXPORT_SYMBOL_GPL(irq_set_affinity_hint);

--
2.27.0
