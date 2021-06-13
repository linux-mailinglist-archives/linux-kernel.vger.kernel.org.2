Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8033A5184
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 02:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhFMAu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 20:50:58 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:33530 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhFMAu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 20:50:56 -0400
Received: by mail-pl1-f175.google.com with SMTP id u18so4087009plc.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 17:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=M1E/KqCrqBw8na7d8YIMW+xmxN0lavHYzwrAJ6gdNyE=;
        b=aJ4vaMntnYLgO+AgqInAT3oip05GQ9+gNzo1FF0RO3y0ROVmsEO59Kf6M9WRmKNexd
         Im3aqEwp2V9tWPw5sEBgAubEpA3Ugl/hA9ynMewPB7KygbAOo+im7/kZdwReYgA3EiO1
         pxfp9s5vuQAFDvv1Hm5XHiqmTrof5qiMxTFuln8RzviTRkDT8oqAiwMawXo4xej5eqdH
         aH4u9/o27P4ylT3Rd2/lmmeTIIyryMt/sTtCCk64WQa8kIFc1BUR9ATxnxxxhXMNegLQ
         E3K+D+4GZjAyoMdufCAj4/KdgoPEFGhciRSWg79FPFUUPfwnCaLXiJQYEXQKahBoWMVl
         sIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=M1E/KqCrqBw8na7d8YIMW+xmxN0lavHYzwrAJ6gdNyE=;
        b=PxbxQaf0aKp/PmalhrQaXxruv0VqdEnDAI6XuOcU2A5hUn1o5PRabEXThPacfzL+Wd
         O+Wyns7ItMekogQu4XG7PcA6n/bsRxxmdSe0rY3sIS7ZmSICLvjX/UxlmzCDo4xcKTCv
         IMzI5teqpPmD6/A3VQF55zaTcaw3Ge9PVoXXVQ5wFYF6KesVEbgFZ8D/LNy/g/kRW/8B
         zl5shiiGjk/jBgJFUlkAlkofShF/QbBSvVBIT3IoGOhig8YjeHZFNtk97ZkYjrz0Vp4Z
         W9NmhkegYauJMOvt5l20cfsWIqVyoemmdaxPrf3irh7iA5w5UV88Qup/0ZaFEIiyEgkm
         9ITg==
X-Gm-Message-State: AOAM531jMHfwkjHQogNAum9LzNxE8kh+eoECrtTSuKt1F9owYQRQijLW
        uWeaH9XafScvVBwt7KjO3M+AzA==
X-Google-Smtp-Source: ABdhPJxIgIF6EZ1OZi/YZBMXsbuk9BT5FZqb5enbN/qDJXSDgc7aIaGWEWdDmWC73fybobAJGHJ9Dw==
X-Received: by 2002:a17:902:c78a:b029:109:edbb:44de with SMTP id w10-20020a170902c78ab0290109edbb44demr10408698pla.6.1623545263470;
        Sat, 12 Jun 2021 17:47:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q18sm8900032pfj.5.2021.06.12.17.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 17:47:42 -0700 (PDT)
Subject: [PATCH] riscv: dts: fu740: fix cache-controller interrupts
Date:   Sat, 12 Jun 2021 17:43:57 -0700
Message-Id: <20210613004356.3503995-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     robh+dt@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        lorenzo.pieralisi@arm.com, yash.shah@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     david.abdurachmanov@sifive.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Abdurachmanov <david.abdurachmanov@sifive.com>

The order of interrupt numbers is incorrect.

The order for FU740 is: DirError, DataError, DataFail, DirFail

From SiFive FU740-C000 Manual:
19 - L2 Cache DirError
20 - L2 Cache DirFail
21 - L2 Cache DataError
22 - L2 Cache DataFail

Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
Olof pointed me to
https://raw.githubusercontent.com/sifive/meta-sifive/2021.03/recipes-kernel/linux/files/unmatched/0009-riscv-dts-fu740-fix-cache-controller-interrupts.patch

This appears necessary to make the FU740 function properly, but hasn't been
posted on the mailing lists.  Given the age I'm hoping it's just slipped
through the cracks somewhere, but I figured I'd send it out to give David a
chance to comment if there's a different plan.
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 8eef82e4199f..abbb960f90a0 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -273,7 +273,7 @@ ccache: cache-controller@2010000 {
 			cache-size = <2097152>;
 			cache-unified;
 			interrupt-parent = <&plic0>;
-			interrupts = <19 20 21 22>;
+			interrupts = <19 21 22 20>;
 			reg = <0x0 0x2010000 0x0 0x1000>;
 		};
 		gpio: gpio@10060000 {
-- 
2.32.0.272.g935e593368-goog

