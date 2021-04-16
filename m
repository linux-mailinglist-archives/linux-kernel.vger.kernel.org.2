Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380313628D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhDPToB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhDPTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:43:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:43:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e9so7319114ybq.22
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=RZqwj6m8TBP3bx39/d80KNH3lL63gm95f3IfpC2WPAw=;
        b=c7iplFB1GYP8zl0qF5ZJbIy0g7CyeuUK6pMZ9j7jTApuIHxp41ePtEFAA2RDPgkd44
         FmXQpL1rFLTJR0K0T6qXRXAmSl87dmpYXN4lCs4DZlQNe3ASK9Mm5Sl4NTGRD+RB3wYK
         Z/zQKuokU+o8phRbjteymFf3rzbtaui4M1+AYlT4QRpapDRlyoPAF5fM6IWlyFz8/Daf
         L88+J8XDFt9junqaR5uJ+Wv78FSdV6nVSw2tvLnWK/Jvy92xjA2P7Ye8uUWcV4bQiidY
         PVydvqdfGe6uL/r5+btGmzmFAuUQ39pUNrq9Df2OOV6moA9bxGnayKOOSxCJNgOHZnWr
         9wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=RZqwj6m8TBP3bx39/d80KNH3lL63gm95f3IfpC2WPAw=;
        b=aTl037PUhStZewA2wPCP9Nd/4ZrGcK+NHUhw8/gVt99tVbQR81RaphEQJHVdMQ/IFk
         VylrbLuBW9sJDixxycK0W7wxERDGbdiTJI7dOXpNRzwHjZhik1fft6OX7BpvA5AJFuNG
         i+/ryTgqzTtCaUU7g8Q8tR7TCVVgxKd+r2SeWY/3PGY58tm9Irf+ZCmC7apGlbo//Ijz
         DK+ftsx3ICPE8Hb7aQcF15VMpDJUPgaWVKXc2z5cvMLaqze+P+PZ8P7JfmjhF1xBIvA1
         +8Tkzu4LmSOAmEGZ+DB62rIQ9xV993oo2vNXoGj/hDuWFGX3GLS3SDUtWpozrLZ9YqO7
         LDoA==
X-Gm-Message-State: AOAM531XdXY8YZ94/FWkZlg1aDPoSLZkjNF70zS8zBwpBDNT+cMZETPp
        4JF5SosfyZ+8vA3D7jUFeXKaEMB/ue88wg==
X-Google-Smtp-Source: ABdhPJw6bh9r/3+iERNcYifb81vX3bTJJ+y6fBIUoYoidPMOWxm9qdiRlgwiDkOcbeWuaxjiV2Kk+zrlQUnZSA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:a25:c3c5:: with SMTP id
 t188mr1083037ybf.36.1618602213999; Fri, 16 Apr 2021 12:43:33 -0700 (PDT)
Date:   Fri, 16 Apr 2021 19:43:00 +0000
Message-Id: <20210416194300.3952208-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] static_call: fix unused variable warning
From:   Carlos Llamas <cmllamas@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Carlos Llamas <cmllamas@google.com>,
        "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'mod' is not used when !CONFIG_MODULES. Mark as __maybe_unused to
fix the following warning:

kernel/static_call.c: In function =E2=80=98__static_call_update=E2=80=99:
kernel/static_call.c:153:18: warning: unused variable =E2=80=98mod=E2=80=99=
 [-Wunused-variable]
  153 |   struct module *mod =3D site_mod->mod;
      |                  ^~~

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 kernel/static_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 2c5950b0b90e..8211a34251f8 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -150,7 +150,7 @@ void __static_call_update(struct static_call_key *key, =
void *tramp, void *func)
=20
 	for (site_mod =3D &first; site_mod; site_mod =3D site_mod->next) {
 		bool init =3D system_state < SYSTEM_RUNNING;
-		struct module *mod =3D site_mod->mod;
+		struct module __maybe_unused *mod =3D site_mod->mod;
=20
 		if (!site_mod->sites) {
 			/*
--=20
2.31.1.368.gbe11c130af-goog

