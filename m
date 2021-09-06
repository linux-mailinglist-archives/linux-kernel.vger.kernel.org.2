Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D4401512
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 04:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhIFCrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 22:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbhIFCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 22:47:37 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA95FC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 19:46:33 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id f6so4389578vsr.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MgUySBovIyB1X0E7FpCE6nnUAjF6Qp4KmJCfh6F+1W4=;
        b=OZneJFvD8hWgmscKheorMMIU5k3cOKO9vdEHa70vC5dDLJcCthO/3j/5SAxu5FHYzE
         HaFcJSxXy8wuNggVGN4mITSBrlf0rT5e0MLkoIyd8lBt3LepUQvXaWKp6Ki/71AcdIBC
         7SldepKmbj4cGs/b8Vj/GtqMgMiRp40ThJw0b+Do/8rK3Q1OtcQS72Oza9dTSW3ARuVF
         Po8o/dNgF99Z5v1QmOY/+Ve7PLnLJo16LYCf/ilAE402xRjD3guABqbRilVQug3c3O+g
         P9q3/0rfmCcTbY1cKTppZh75TKgr0j17ftV6ysGc8LJmLsN/M32rflqzrLhYwLClpS6B
         tmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MgUySBovIyB1X0E7FpCE6nnUAjF6Qp4KmJCfh6F+1W4=;
        b=iTfDGWidKakbPUNAYQwiW/84GCzITCcb9xgxj5qd701GWQ0whxZKvgP42UkF1NZp4C
         Q41TZ/4TNewUq0G911nDCAYfTviVKCqQxjZNZe8wcWCYfXbbELU4JEYs9KYCv5AOILrn
         N821FXPPBH5Qu7w3x5o6LOszirSlv+nH8LPXS7d1GPYcu1o28aHYe1lGDMYUhOyl/Cj7
         TNksk22TtdUHVoo9KESz7kS5UBuwaI69e1uC/72O9WjoaJufzKYPOXubFDUh+SaDXHwC
         tZVOtFX6wt2H57ADr2FPm8VcIsAbS4ta9QAc0JQb2V6kfHbBXeHpCdQaTFo9QGLPn7RP
         DG/A==
X-Gm-Message-State: AOAM532PA5k7Jr5gHQX+LOcwpdbMCmlty5LvaLihh1jx5cTtchVn4a/J
        nlSklQ5OfQE+1weky/xsFi5KYn0ai4LjdN8DlfwgWP4FcCMm6w==
X-Google-Smtp-Source: ABdhPJxjWLGluoFqC3xAk5Fq/yGOqk9OaHtF6ROAQDbzDR5pymYFYRequM3w/2+tDPjigHfymicjZ4eh/11h/NU/1eE=
X-Received: by 2002:a67:cb83:: with SMTP id h3mr4583283vsl.8.1630896392471;
 Sun, 05 Sep 2021 19:46:32 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Mon, 6 Sep 2021 10:46:05 +0800
Message-ID: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
Subject: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not supported
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
RTM and HLE features, it will affect TAA mitigation.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kernel/cpu/tsx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 9c7a5f049292..5e852c14fef2 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -122,6 +122,13 @@ void __init tsx_init(void)

        if (!tsx_ctrl_is_supported()) {
                tsx_ctrl_state =3D TSX_CTRL_NOT_SUPPORTED;
+
+               /* If hypervisor does not support MSR_IA32_TSX_CTRL emulati=
on,
+                * but guest supports RTM and HLE features, it will affect =
TAA
+                * =EF=BC=88tsx_async_abort=EF=BC=89mitigation.
+                */
+               setup_clear_cpu_cap(X86_FEATURE_RTM);
+               setup_clear_cpu_cap(X86_FEATURE_HLE);
                return;
        }

--
2.27.0
