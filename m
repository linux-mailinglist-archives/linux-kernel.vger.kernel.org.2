Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1906E32F891
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCFFtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 00:49:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:57469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhCFFs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 00:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615009705;
        bh=XkgRczxN8Lu2cKgohs/4mQt4fS01rpwtWg9QmMNmGjk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hnpANIK+dTYGXem+v9bNWcUyjlZ6H753azMe+jWYPXSIx9lZgD1Lx5vpetsc+KPie
         JE3N9sgge0HD0OJSQPfP6JzZgqLoTV9KBl+IBL1OxK7kVp4LDYnL3NQ2wvwaQvL/18
         RsnLjykFyaGlAAY3A95piN+rhjQZ0iaQAcA1w10Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.246.89]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O6e-1lLAQB2jpG-003rp6; Sat, 06
 Mar 2021 06:48:25 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/1] RISC-V: correct enum sbi_ext_rfence_fid
Date:   Sat,  6 Mar 2021 06:48:01 +0100
Message-Id: <20210306054801.18263-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Kj6MuvqVd2A/9vCK8eZOjS02y5+ixmu93ibhNy+GDch1jOILrx
 dj9cbp3fRtMaQhmzQ5TRm21Ej43oyGDfmeYwnh8/CtyIuNFIiYBsxBPqnJVxS69KHJeMOPb
 lFWO1Gp3oKF4PhRLsgLQHRMC9zgdJ/u31L0wXkIefIjlEfb7PjXYjqcBJL1lmtZexABkZPy
 9/Iem+BbFLo1jXAzLrEog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KENFoSQWyZ4=:3mdzYqadC6+C1mK/js6NBT
 rhedwlBz5g9tXYe6J25wO77W9PYqZ35frCz5yjHja1bn5nwEuqMGJMckz3ent5Bd5TxaNJ0Ew
 iahNN0EmULj7+2dp8IhsUCWRqtGOQ2iHc4RWA02bSlZFKZL00yUrYY9sYtxChyHg2uUt0rpOt
 47QhtBPK69cPIQ4KnTo+sN0Cp4Kxi5eb7HL7gXDpE0H5bJXQxrjeNAxyThhrjlIPnRn/tr5Hw
 oAo2j0QLbTLbK0Y05RmY0PruaYaFic4OCtYQK8f6uY5JRAOqcDwlfFarKvHMAhze021TeN79j
 23u0n3w0o7k4tQ9Gr1dP63zYI2fhre8jvsFndXmZK08fwkszVtaQg3utCVimFKBSuvKkrsxUc
 x1jswNJglHLmP5beDO+eQBGloAhkhIMJNyd7/CEGpl/P8Rqu5BiZCglROyaDWuWOsg1T0QQom
 wb5pGzsgaSwW1rvWlZo3aPySHY85HZXGCgzv/4iv90UFq6cQV4w9uU+jEmoV5nAIzC2RJ7j9l
 5+H0awd6aBolSucbj99oUjw5XcSzpwt2CeT51go+t+Zfh7GNSBegtMt+2RYoXqiYC85/XlwWf
 NnCsyVUlm/HBqjnzRJylAMJdPokExIOB3RBHlCsgwrTbmMaRS/feMgfoFkpmaZCQhFfwBrf2A
 X6MVT6sGSIuFbcjPVCfcmmqWG+htsaPwJYnXBQdknC4ppB0zwQ26dlKBD4Qi7/fG9Tq+Farvy
 w+KXXhKlo+Ia8swe4r3uNgBIUpXZ1ngsimT02tKuF6dMb/Abbh0LHjKBq1squ+jSAm+U3yr5K
 LlKAdHRh79IC8jhDl5DWWg8sjdmp9mmxFZhb1/v8bEa+NBNS+NKlsqsV/jarFymFmCcPhMs59
 x5tknQEAOzJ8siHkhr5Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants in enum sbi_ext_rfence_fid should match the SBI
specification. See
https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-funct=
ion-listing

| Function Name               | FID | EID
| sbi_remote_fence_i          |   0 | 0x52464E43
| sbi_remote_sfence_vma       |   1 | 0x52464E43
| sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
| sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
| sbi_remote_hfence_gvma      |   4 | 0x52464E43
| sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
| sbi_remote_hfence_vvma      |   6 | 0x52464E43

Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
Reported-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 99895d9c3bdd..d7027411dde8 100644
=2D-- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
 	SBI_EXT_RFENCE_REMOTE_FENCE_I =3D 0,
 	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
 	SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
-	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
 	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
-	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
 	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
+	SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
 };

 enum sbi_ext_hsm_fid {
=2D-
2.30.1

