Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4046D357103
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353886AbhDGPvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:51:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54983 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241102AbhDGPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617810592; x=1649346592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZugdE2MSPgCWYyU5LqjY0o9IlEkCJTXH/EVdmfDbnm4=;
  b=QPTJj6fle+isbrtP5WuD6lzZkFDnSidcrQL4cUeFwbQO86Ehx63PGUQY
   GVPZ2l9JhaHMudemNRwTCs3le4PPLk3Xzu45ctyj49VrYmgfbqu2nwphY
   Mr66KM0V1IkpTxUDP06yTnc2kreg38pLu9IrjJw4lT1vq64WoIXjvyO1s
   qiWXHVLkgW2kA96wcbm09lTk3WUh4JOiuYx86GFjaPnIA37MtH25TJzj7
   bIZCjaCka9u68vD5YHktXt2WHKHERRzFthGPraogEPIwf0iykU38nHSV9
   tiOJWZMHkQLWpT7UTuuEwvgF2lAZr/UfFSVtk5pbmOXf+17JJEQtq6NQS
   A==;
IronPort-SDR: k6xyO1spZcx4XfbRKuVA29/AjTIEI36YsRIbAvyUWvF3eruBWQhHy2K+SM1dhclhIxSr0Uyz6u
 U8uiDAYFAy/gH+NOH4un0rxO8BtbZtgRHmmDyu2JRuBVAhpjtqHHKnmdyZ97xfE7JZbDWADGh8
 1yjfvSILQ7QMyhgwBRxG+KPtWSGq7qX9YtyKjDCs1TViV6CQQV8XnC7fyfRYCJlfPAZAgWLXge
 7fHUBUhU/ATbpPJLJhpLPt5BfzhmKz2l2I7WDjrN0unGQTSfbDmifHa8qYfviPDeNbsdPbzFyR
 u0I=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="165012666"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 23:49:39 +0800
IronPort-SDR: tp4cLUymkGxkQkEk6GcgoQL6g9K/Evzbgc6/dZYsDXsvAn6d3fu7YRRnOdlhWNKZM4nAhzetso
 Ilj1bWaRR02M+LdNb30rWoSPOcTi/RXTLITCtLQISY4Drm6X9UGEDsVpjy4AMekfCwilU9PmOK
 w7yt6H5wTyaFSUVt4Heh82BZ2MvWOemgoe3XXFPVNreqO9iuoDj4BPFfzc7sr1RJWvPOZDM8Ki
 0kDclzyMEGf7sgUo75AOQ9I66F/MFGiDgi7Xl/ekdT91gaeavi4QoHfSAI2m9tU6sdsjThFTF+
 Gm9BX6kz3Za9gnlmht7Krlq+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:30:50 -0700
IronPort-SDR: BVWSjMsVeCSoBX+ovKJ7GRzen6qtlyXyGD8snXYwuErsvhxRlumX1U2l33ECkVCpXo7f6Fxdau
 RSHbvBVnCVtZdhq5FNIYRjeCk+wIXvB0F27gNEq2rnZRvCKsUjpvqJpzOl1lKOUoPG6SM7evvT
 F522UxNn5ImuRLnDcpqOoUBzICVf8RWupiYSrYnHPcF8oC8oq5iHdZ2STzpQz4eh2aRH7crV/p
 D00cDmhwm2j1h4URZF2C+4eMhdCnCXOAfqQVf5afXBCbS0VwfC3HHg9t5qrFrfjH/jIqcFWtP+
 xqE=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2021 08:49:30 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/2] Fix binfmt_flat loader for RISC-V
Date:   Thu,  8 Apr 2021 00:49:22 +0900
Message-Id: <20210407154924.1557489-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V NOMMU flat binaries cannot tolerate a gap between the text and
data section as the toolchain fully resolves at compile time the PC
relative global pointer (__global_pointer$ value loaded in gp register).
Without a relocation entry provided, the flat bin loader cannot fix the
value if a gap is introduced and executables fail to run.

This series fixes this problem by allowing an architecture to request
the flat loader to suppress the gap between the text and data sections.
The first patch fixes binfmt_flat flat_load_file() using the new
configuration option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP. The second
patch enables this option for RISCV NOMMU builds.

These patches do not change the binfmt_flat loader behavior for other
architectures.

Changes from v1:
* Replace FLAT_TEXT_DATA_NO_GAP macro with
  CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP config option (patch 1).
* Remove the addition of riscv/include/asm/flat.h and set
  CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP for RISCV and !MMU

Damien Le Moal (2):
  binfmt_flat: allow not offsetting data start
  riscv: Disable text-data gap in flat binaries

 arch/riscv/Kconfig |  1 +
 fs/Kconfig.binfmt  |  3 +++
 fs/binfmt_flat.c   | 21 +++++++++++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.30.2

