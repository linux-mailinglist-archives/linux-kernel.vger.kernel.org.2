Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C473D31468C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBIChy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBIChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:37:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797EC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 18:36:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id m2so4791736pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 18:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3QXGdYBY4GlaQjWRP3AW5oVocz08MQfpEQJa46lCHW4=;
        b=TibI077wK5BoFL+D16v0ATZT2K15vnWdkA7lAPagP9SvPLXshPfC8RfEfTQEshqj26
         MjWiqpkoaiRkz/RG2GZ/R19LJ1rS+KzYf5UFwmZ/r3eUgYlJRB1+LysTYC2/Msk08tkE
         TaJ5U5riA8qILa/prHnY2a765knNriZA7zZ4vYTu98cL7L7eZ1OnIOIS3TSMCTJOTBRx
         PEbPXjOBhcHuXIue0yq8RjEtZTC1QE2eRuzBWlXRtc7jRnki+WZ/0DBplRshX3IqgoTi
         D09T9UiuK+iSfq7FhOdISj+tMfEPoqcY4VVaEwdlx7f3wcbl18mS+ehf9ebS14uK+ROc
         mbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3QXGdYBY4GlaQjWRP3AW5oVocz08MQfpEQJa46lCHW4=;
        b=l2RxOD1bOiqy4UGJPKFMxdkfQs2wDmosRdoQSqjv10nS1yc81CCIfAxErx779qm6kP
         8laDt89oGQqI0CTzBUnTSJSF1gHgji4rbhTEQBIRP2Z86Agv3WL0B/4JPyXwTAxHpgf/
         C08+oNENHZH6BIxWK9cXkxAKE015XN1zY/kq1RHD66eE/DXEBVMqIfu4T9/evV2CpI2H
         I/TUEJUwyWORe5vBcw9B9IukDWtugRhMU2CRO7MCg4TM4NQ4Kc6eIcueksWfuBDTfq7T
         ZehWwh+3PGVpBY+IJS/EhOwcWu7oclhhkljb8LpH4fUVEGG13MtYj1S/jqzGJGosThLQ
         renw==
X-Gm-Message-State: AOAM533Cizg3MXYKpxDMo6EP/jTX0fa3z13n8ZHdi9aJvHciC7hNepc7
        sbolrJm41B6upWEmdCztcCY=
X-Google-Smtp-Source: ABdhPJzPMPSomATF2ZyD4YSYOSlDzTQHBwvjPuxeoN6W3R/OWYq87nM9LvDS8uYPAZg7XCUdbR0vMQ==
X-Received: by 2002:a62:cd:0:b029:1d5:da40:abf8 with SMTP id 196-20020a6200cd0000b02901d5da40abf8mr20272668pfa.60.1612838187168;
        Mon, 08 Feb 2021 18:36:27 -0800 (PST)
Received: from localhost ([220.240.226.199])
        by smtp.gmail.com with ESMTPSA id 71sm6599001pgh.55.2021.02.08.18.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:36:26 -0800 (PST)
Date:   Tue, 09 Feb 2021 12:36:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in
 another pointer
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612838134.rvncv9kzls.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> By saving the pointer pointing to thread_info.flags, gcc copies r2
> in a non-volatile register.
>=20
> We know 'current' doesn't change, so avoid that intermediaite pointer.
>=20
> Reduces null_syscall benchmark by 2 cycles (322 =3D> 320 cycles)
>=20
> On PPC64, gcc seems to know that 'current' is not changing, and it keeps
> it in a non volatile register to avoid multiple read of 'current' in paca=
.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

What if you did this?

---
 arch/powerpc/include/asm/current.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/=
current.h
index bbfb94800415..59ab327972a5 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -23,16 +23,19 @@ static inline struct task_struct *get_current(void)
=20
 	return task;
 }
-#define current	get_current()
=20
 #else
=20
-/*
- * We keep `current' in r2 for speed.
- */
-register struct task_struct *current asm ("r2");
+static inline struct task_struct *get_current(void)
+{
+	register struct task_struct *task asm ("r2");
+
+	return task;
+}
=20
 #endif
=20
+#define current	get_current()
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CURRENT_H */
--=20
