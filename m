Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73C41A409
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhI1AJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhI1AJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:09:00 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F2CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:07:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 133so1131364pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4c+8E3LNnj+fGPh7i46JnKrtOF4Hqb4QVetAaHa0UJQ=;
        b=SXOchIURzjlclAP7lC+wkoMtOSItNYqrU3uprnIURpJDITJKHCSEBZI6F2SD5+RuvR
         H+lg13otN8iK4lRPA2mEa8il5MuhvWHSGh8gw8xDto2uOvAg4JySxQyofXAEPyDnA+pB
         MJLcU1/1QOjpxISxC4yCbdQEHiO7R4tyXJb06ALfH02qGI5IzofxTq3Ct61clshLNqbf
         0FLjUo4E1bXt+pKAVv9o+9Y43GS6A0N0mDFRX2GiFw6C/QlYlVRrpL4CgjQ0GtXpCg6T
         CHnFoqRS9jilhHmKFePYd1feu0CD6y80gVAe3MbeIF8mXfAbFj5zJuO9kKCnAkJW6Txi
         ETWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c+8E3LNnj+fGPh7i46JnKrtOF4Hqb4QVetAaHa0UJQ=;
        b=xk7JLjzkz5UU3Vq4DmVlscpzBnqNHJrcBGKeNeuH8LoelLR3jQh7d17+efbHz9IGqf
         acp3ezRXdmLI87HO0d+7MOSCGy9e68fQgLId3pzjDp+4RVc3Q/kqAx0jl6ulyONSWwXd
         W+QoUjMU7p0T2UvKyETb1NHh8dFPbnIoUSrze48/tEeMdQObJQCO5Diu5FMjzQvRndOC
         ikHxbW2+elZHQefRqKQ+onQwMhWvMJYMMXFMx7HK2n6jc9mcu+EYMWeYPW9YOOe2yrpX
         Za6dvJdU9hArRDEgzjUL03xSdmry4to07/i6I1Rhe9yLLNWC01k+la0AFyp5mlooDUeD
         T3Vg==
X-Gm-Message-State: AOAM5319BaYy67WMlpCwJ/h9z7CrYNECTW5k48JdPynLvu92Xfh97Qi9
        p0WDb+8sf7TFyproJRTssaUaXsFDrbsmlt6r3XaDw+aD
X-Google-Smtp-Source: ABdhPJye7YMVRRutSyVlj+AQWwWyXw849PayoVF3DKcBnCgpn7RuLBHEUOyV9fqt/vLuWpEUjaPoi2wg4GrFXTltMsI=
X-Received: by 2002:a63:5911:: with SMTP id n17mr1971527pgb.177.1632787641133;
 Mon, 27 Sep 2021 17:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <e2b142ad4a44535d5aa81b0c00c5f05f312f9097.1632738876.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e2b142ad4a44535d5aa81b0c00c5f05f312f9097.1632738876.git.christophe.leroy@csgroup.eu>
From:   cp <carlojpisani@gmail.com>
Date:   Tue, 28 Sep 2021 02:07:10 +0200
Message-ID: <CA+QBN9Cfd2MKyQ3_0jNzVzPbwZsSAA_XB5kvOe4Tad2_QmB-Sw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Map 32Mbytes of memory at startup
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this is my second patch-test report.

Today I have successfully tested Christophe Leroy's patch.

Attached a cleaned patch. With the previous one the kernel booted, but
there was a line missing.

I have also tested two different kernels with success

both kernel sizes were ~9.4MB
the Entry Point was always 0x00901b00

used toolchain:
- powerpc-unknown-linux-gnu-binutiles-v2.34
- powerpc-unknown-linux-gnu-gcc-v9.3.0

host:
- macmini-intel, Gentoo cross-compiler, 32bit userland

target:
- AMCC PPC405GP

wrapper:
- cuboot

Applied to
- kernel-v5.2.1-vanilla
- kernel-v5.7.19-vanilla

Attached I report here is the difference between the original file and mine.

Thanks guys!
Carlo

-----------------------
map 32MB of ram rather than 16MB
--- arch/powerpc/kernel/head_40x.S.original     2021-09-28
00:07:27.768000000 -0000
+++ arch/powerpc/kernel/head_40x.S      2021-09-28 00:07:27.760000000 -0000
@@ -25,6 +25,7 @@
  *      Kernel execution entry point code.
  */

+
 #include <linux/init.h>
 #include <asm/processor.h>
 #include <asm/page.h>
@@ -842,17 +843,33 @@
        mtspr   SPRN_PID,r0
        sync

-       /* Configure and load one entry into TLB slots 63 */
-       clrrwi  r4,r4,10                /* Mask off the real page number */
-       ori     r4,r4,(TLB_WR | TLB_EX) /* Set the write and execute bits */
-
-       clrrwi  r3,r3,10                /* Mask off the effective page number */
-       ori     r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))
-
-        li      r0,63                    /* TLB slot 63 */
-
-       tlbwe   r4,r0,TLB_DATA          /* Load the data portion of the entry */
-       tlbwe   r3,r0,TLB_TAG           /* Load the tag portion of the entry */
+        /*
+         * Configure and load two entries into TLB slots 62 and 63.
+         *     TLB 62 is used for first 16M page
+         *     TLB 63 is for the second 16M page
+         * In case we are pinning TLBs, these are reserved in by
+         * the other TLB functions.
+         * If not reserved, then it doesn't matter where they are loaded.
+         */
+        clrrwi r4,r4,10                 /* Mask off the real page number */
+        ori    r4,r4,(TLB_WR | TLB_EX)  /* Set the write and execute bits */
+
+        clrrwi r3,r3,10                 /* Mask off the effective
page number */
+        ori    r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))
+
+        li     r0,62                    /* TLB slot 62 */
+
+        tlbwe  r4,r0,TLB_DATA           /* Load the data portion of
the entry */
+        tlbwe  r3,r0,TLB_TAG            /* Load the tag portion of the entry */
+
+        addis  r4, r4, 0x0100           /* Map next 16 Mentries */
+        addis  r3, r3, 0x0100
+
+        li      r0,63                   /* TLB slot 63 */
+
+        /* Load up the kernel context */
+        tlbwe   r4,r0,TLB_DATA          /* Load the data portion of
the entry */
+        tlbwe   r3,r0,TLB_TAG           /* Load the tag portion of the entry */

        isync




On Mon, 27 Sept 2021 at 12:35, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> As reported by Carlo, 16Mbytes is not enough with modern kernels
> that tend to be a bit big, so map another 16M page at boot.
