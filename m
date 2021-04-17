Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEDF362C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhDQBKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:10:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36051 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhDQBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618621819; x=1650157819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4DgKpWxB0XLKsv65kA39h+j5FEcPc1pXnik7l1I2KYc=;
  b=H1loPJCd3F41k3Ow2Gin4bC0VAoXWNfLQJxJjmvNO6Y3BmBXUTMdTWsx
   YCL3i0ei86zg7kPa/yyaDU+ZM+8qisT5YR5EGszAF6i5sssZixjc+5jQo
   JFCXBznfBHsvziMZQL5w4Z8h0ppYnkW5bvMZxTNHeOrztSgPpSARasudE
   775MM1jWI4jOB5Ets/nTMC9lCGocfMDhYQFnsWb3UDR2R6siV71Z45eAS
   jqR9PTrTyC7NsceqvlCI2W4X4vckbwgW5teGxq9BPcuAHJdzqBgq8AiXQ
   xgZ+bPU7v47+7n474t8gyKWJHOS9bBLTNn2kcgkWqW+fbIQQIft4tHSLe
   w==;
IronPort-SDR: 2ji2sd3hPn/z5JmLUtzVdRO6d6MnNtXwxonJaDdiHgbPdyzkuX4PO9KKWhUN89HvpfDInpHCmt
 jMh0mq0HyNWMQcHDPXvwBw9RwLP2K+43rjy66n5Zdx4gncJxPfFknnTotoRmVhIIrp+8rygzkI
 RcmK1c6D2ORYZvpKXJDbK2zE7a+hxwtxnraT62SImCxvQOpIesM/k5deUnN2gLscX0TypX8hrd
 +K0RkPd4TKlCfjx4y7Js+B4Rfhii1Wqp9J8JORh8DZvRAIyX9+BFsdLKzDogCSX61aBnkykCvH
 EcE=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165185063"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 09:10:19 +0800
IronPort-SDR: jFg8ZE9+a7RnCtKJBTDKPDH0YQFiiYc+RLe2/ggtktSLzGuW0l+JkHEi53dYP+aw07dknhIVx/
 Nstud1eYgA0yQrQUT2PKgRpB8az4JrJ3mJzXJIbPNG98dmTr+8xZPhCf6ztEQXeD1lGwx/sc/j
 StVhBPwXHyPvDpH8qFSMhUHOPnaypY8tGTZ1DkZE3KR78Yri76n+HVwDrluFa/tdu11JQg6dLS
 cyElu2wKDZYx3Zzd53PsYMHJ4Z3BvSBDK7ffFu4iV+hSPJgqevNFRilwJbi+CPQDKoLCzYhGqZ
 7D8VePHUrt8afPohCGbYNQyC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:51:08 -0700
IronPort-SDR: YHPDjhLsFx+LE0qZcYne9xelQgeX9OMP5X2ZphNVvunYaGLHeFJ1mCFHZFOA/iQiLF2zhhcXtU
 MEAGtd/1IXUQhhFZGoLVY2ThXNO1MzxOiMJScd5bDoDEfzVMxvvrVaNrWmIdMhP3yLGwzOaSOh
 JjUOY2qcSvRBSUP0dNuwngB8KtonYjb3AgqCKor6so+znxZFYwrDssokH9eqmSVqCnraHD0Tp1
 S5MQizOFLgkC6Xt5jU+v1SpBuftnhWhyTAsq0iwzjBdeCH+jUh9mVfA89HbeqlscP9/x+zmNiw
 JxQ=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.5])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2021 18:10:19 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     uclinux-dev@uclinux.org, Greg Ungerer <gerg@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 2/2] riscv: Disable data start offset in flat binaries
Date:   Sat, 17 Apr 2021 10:10:09 +0900
Message-Id: <20210417011009.54569-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417011009.54569-1-damien.lemoal@wdc.com>
References: <20210417011009.54569-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uclibc/gcc combined with elf2flt riscv linker file fully resolve the
PC relative __global_pointer$ value at compile time and do not generate
a relocation entry to set a correct value of the gp register at runtime.
As a result, if the flatbin loader offsets the start of the data
section, the relative position change between the text and data sections
compared to the compile time positions results in an incorrect gp value
being used. This causes flatbin executables to crash.

Avoid this problem by enabling CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
automatically when CONFIG_RISCV is enabled and CONFIG_MMU is disabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4515a10c5d22..add528eb9235 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -33,6 +33,7 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select CLONE_BACKWARDS
 	select CLINT_TIMER if !MMU
 	select COMMON_CLK
-- 
2.30.2

