Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB55342904
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCSXCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:02:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9606 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCSXBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616194891; x=1647730891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XocJ1hDuH4ex8QRC/y2Fe2jp6AaWu+jTV16swTNZi6g=;
  b=C9xtPoYpIxjttTpjsh9ZO3MaGwZ1z6+K5+TE/Q3BP5bTohqVepUg1jyy
   Jl1L2OBB/zAbNHehHZ+36ReOZgjMjK7UlHst0lJNso/GN83ryq1T8pJAm
   x5KM9iBZ376UKNfWgOKO3zaGFdX1mEjWyXoXt8TrHrafz4D9luqHgmQWk
   ImeLywvJZQenKDcMDZPhWsbxN+e1LVVudtb6lAqXNBUJ9wT/UyyUhqQHD
   s861Zh73OHB/+wAiNrshkxZTfw3yquL/tabk8YdF2AJW4vQY2Otq5cBqX
   WE2BmT6NOKZtoUipICdW9FKJ1LGWFtqCfBZBN0kYWvufyko3MmOeaBv2+
   w==;
IronPort-SDR: BYgsq7RUFHwt+UPW+fBWsPApI1IpnQOUVT1w9hurSX4IHOCofe130VTo1xTCFdZX/vYqsF0QHP
 RFE5smusqPHf4/aMaWALBZotsxJA+39C5A4GmccZtEdyQkGDWMjWnsRi4gFhoLut4o0Dux4ugj
 yXxDShgFWJAtTGTYyxNp2y2w9KDufaJhu2SMtfNhpvMLfqbWxsy1hVZtFirAtsog1jb1fDIgYO
 gJjqbxsrJu/LrNrQ6o95yyoPHsy5lL2dah52STwWy+Gr0arDe6587BfQllJuDtAQ/RRcKMTzIX
 TcQ=
X-IronPort-AV: E=Sophos;i="5.81,263,1610380800"; 
   d="scan'208";a="162584057"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2021 07:01:31 +0800
IronPort-SDR: vbZfmBSRB/xcLn3fPBjkfGhkljQkFsW7o+qe69/2gDR78MpoHDqyt6gwL6Vn4XJ2GFXNGKsHUv
 zj7osWLzrgysLPSgIdxeNnEN9jamZsPk/G80Acgy29f29ADXGUrMoNaOPTZAphPhZ+yQbAMqYe
 u8tUb1QhyIPbQasJiHPtEorhd25R1DvEvEP0dWp4LtauXOoyt2s9QNT3wANNBdRL6SpeffVfu8
 ikY4xWlTr/XchRHFdzqWrBau0yXw3/EiPC3c30HbWAy0fVp9BkIRSNrVyfIIeVVr1zmcab+QgQ
 ChQgZIMgepxeKu4eRn9+YNtu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 15:43:43 -0700
IronPort-SDR: VZy+zW7u+yifg45JsZ6vxe+eE6tbJIoMUoL7OOUF6h1FTweBuLIHAyMgeRDNwMEgMC8pg+fECo
 1bBlPa1RQ5AMlckzn+olvIDNrfWa96fLZJj8gdlKZzwuNbuc0I1vnt3s2ifh4OUf2tdJAMkljd
 0mm2+DPSkv8Do/m9b1hZDoDCHib6cW4eEpIbwTZT1jJhVt79wA+ZrMjzvg/DMo7P+TQA1Q/1PA
 klkBbnNqLEzee1FythgdbCGODjFS0mjeZEWj19P1+qoIhd0ZKlXmeiJenJ3ux/hZ4QDUqHK8UO
 UeU=
WDCIronportException: Internal
Received: from ind002560.ad.shared (HELO jedi-01.hgst.com) ([10.86.48.105])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2021 16:01:31 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 2/6] RISC-V: Add CSR encodings for all HPMCOUNTERS
Date:   Fri, 19 Mar 2021 16:01:02 -0700
Message-Id: <20210319230106.2186694-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319230106.2186694-1-atish.patra@wdc.com>
References: <20210319230106.2186694-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/csr.h | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index caadfc1d7487..7ce8df8f1683 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -89,9 +89,67 @@
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
 #define CSR_INSTRET		0xc02
+#define CSR_HPMCOUNTER3		0xc03
+#define CSR_HPMCOUNTER4		0xc04
+#define CSR_HPMCOUNTER5		0xc05
+#define CSR_HPMCOUNTER6		0xc06
+#define CSR_HPMCOUNTER7		0xc07
+#define CSR_HPMCOUNTER8		0xc08
+#define CSR_HPMCOUNTER9		0xc09
+#define CSR_HPMCOUNTER10	0xc0a
+#define CSR_HPMCOUNTER11	0xc0b
+#define CSR_HPMCOUNTER12	0xc0c
+#define CSR_HPMCOUNTER13	0xc0d
+#define CSR_HPMCOUNTER14	0xc0e
+#define CSR_HPMCOUNTER15	0xc0f
+#define CSR_HPMCOUNTER16	0xc10
+#define CSR_HPMCOUNTER17	0xc11
+#define CSR_HPMCOUNTER18	0xc12
+#define CSR_HPMCOUNTER19	0xc13
+#define CSR_HPMCOUNTER20	0xc14
+#define CSR_HPMCOUNTER21	0xc15
+#define CSR_HPMCOUNTER22	0xc16
+#define CSR_HPMCOUNTER23	0xc17
+#define CSR_HPMCOUNTER24	0xc18
+#define CSR_HPMCOUNTER25	0xc19
+#define CSR_HPMCOUNTER26	0xc1a
+#define CSR_HPMCOUNTER27	0xc1b
+#define CSR_HPMCOUNTER28	0xc1c
+#define CSR_HPMCOUNTER29	0xc1d
+#define CSR_HPMCOUNTER30	0xc1e
+#define CSR_HPMCOUNTER31	0xc1f
 #define CSR_CYCLEH		0xc80
 #define CSR_TIMEH		0xc81
 #define CSR_INSTRETH		0xc82
+#define CSR_HPMCOUNTER3H	0xc83
+#define CSR_HPMCOUNTER4H	0xc84
+#define CSR_HPMCOUNTER5H	0xc85
+#define CSR_HPMCOUNTER6H	0xc86
+#define CSR_HPMCOUNTER7H	0xc87
+#define CSR_HPMCOUNTER8H	0xc88
+#define CSR_HPMCOUNTER9H	0xc89
+#define CSR_HPMCOUNTER10H	0xc8a
+#define CSR_HPMCOUNTER11H	0xc8b
+#define CSR_HPMCOUNTER12H	0xc8c
+#define CSR_HPMCOUNTER13H	0xc8d
+#define CSR_HPMCOUNTER14H	0xc8e
+#define CSR_HPMCOUNTER15H	0xc8f
+#define CSR_HPMCOUNTER16H	0xc90
+#define CSR_HPMCOUNTER17H	0xc91
+#define CSR_HPMCOUNTER18H	0xc92
+#define CSR_HPMCOUNTER19H	0xc93
+#define CSR_HPMCOUNTER20H	0xc94
+#define CSR_HPMCOUNTER21H	0xc95
+#define CSR_HPMCOUNTER22H	0xc96
+#define CSR_HPMCOUNTER23H	0xc97
+#define CSR_HPMCOUNTER24H	0xc98
+#define CSR_HPMCOUNTER25H	0xc99
+#define CSR_HPMCOUNTER26H	0xc9a
+#define CSR_HPMCOUNTER27H	0xc9b
+#define CSR_HPMCOUNTER28H	0xc9c
+#define CSR_HPMCOUNTER29H	0xc9d
+#define CSR_HPMCOUNTER30H	0xc9e
+#define CSR_HPMCOUNTER31H	0xc9f
 
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
-- 
2.25.1

