Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF753870E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbhEREcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 00:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbhEREcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 00:32:01 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5155C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:30:43 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v22so8594860oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=edTAC+VberfNzmpERBE9GVjs5mtrV8JaHhvqsq7uIFU=;
        b=dLuJJej8/uEvpBeGhA1/Y5GsGsMFYUb/0EpYi6VrxMEsPJDrwau71hC9S9lRuH1IOk
         dFhwzmE9tIkNpO72l4uL612FG4Zug54KwbTPgz1iX5iwvzU0aaPwt8xo8yuvf8IlA+pi
         tk1mxusnY/enJDT9/0PutctBU475awvAap+Q8hW6ondtgnBnBc/mVEwnGersCBtZUol7
         Bo9od8yNmsNzVmQka6iDvM8tXqB+RdmSMgiUBloAzxZyj3ccCXO7tLny+Hxb07+7Cjuc
         iH8rOphOk6OhoEoeRCXqHtiQndHa9BEtelnN/ZUinVzuJZ7P3hF9mEY7zXteIQ6OqUnu
         RnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=edTAC+VberfNzmpERBE9GVjs5mtrV8JaHhvqsq7uIFU=;
        b=o4XXOZukmRsUHBykFJhnNcKKmlIWRPqKzP7/fcxRXW5sZHIAbq113qG9ThBrzhXifC
         neI0x0dZ04a9990aAiUQrBbEQd6+34R4LvEIy2i2AlVvSOvHMoFP2JGpWKSo6Z7w0V/d
         inY16aBPsQhuCHgUnZpaJ16V0YxE9Erwc4dcLUND3bS4wQ0+hSozzZMHWyBYdQs+icb1
         yzu68ZUdDaoDDPZaF/vDbtkYuf9NzTtoWGS4b+csmu2dQOfQpLBjgCfjBpxq0diYORvM
         YPWW44YqyxDE2kqjjQJEiqvvwMLwmjurrDg7hHgplQ68cNZ2ELsStCO6YcBv1k8OkWPQ
         8i0w==
X-Gm-Message-State: AOAM530jpss+pLiONv42dSXdv68HdF32i2fV4XJunJtMA2QWRtyACOeO
        K+B895ykwaOcBkuCn5ZuVLmA+BmdXxigdso4
X-Google-Smtp-Source: ABdhPJw3rg34jdvRBg7UfZMvjZh9ZVnoXPaRDW7+ClvXOuEC35VQdlhboR/aOy6EX77F75BWPpCMWw==
X-Received: by 2002:aca:c685:: with SMTP id w127mr1961677oif.89.1621312242855;
        Mon, 17 May 2021 21:30:42 -0700 (PDT)
Received: from [192.168.86.127] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id w66sm3492578ooa.37.2021.05.17.21.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 21:30:42 -0700 (PDT)
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Replace use of perl with sed and tr in s390x build.
Message-ID: <a48c51f8-5fe4-87e7-284e-c96e2381801a@landley.net>
Date:   Mon, 17 May 2021 23:46:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>

Commit 246218962e21 in November added a perl dependency to the s390x vmlinux
build, complicating the "countering trusting trust" build approach ala
http://lists.landley.net/pipermail/toybox-landley.net/2020-July/011898.html

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/s390/boot/compressed/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index de18dab518bb..e941b165bd4f 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -33,7 +33,7 @@ $(obj)/vmlinux.syms: $(obj)/vmlinux.lds $(objtree)/arch/s390/boot/startup.a $(OB
 
 quiet_cmd_dumpsyms = DUMPSYMS $<
 define cmd_dumpsyms
-	$(NM) -n -S --format=bsd "$<" | $(PERL) -ne '/(\w+)\s+(\w+)\s+[tT]\s+(\w+)/ and printf "%x %x %s\0",hex $$1,hex $$2,$$3' > "$@"
+	$(NM) -n -S --format=bsd "$<" | sed -nE 's/^0*([0-9a-fA-F]+) 0*([0-9a-fA-F]+) [tT] ([^ ]*)$$/\1 \2 \3/p' | tr '\n' '\0' > "$@"
 endef
 
 $(obj)/syms.bin: $(obj)/vmlinux.syms FORCE
