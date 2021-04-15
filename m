Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9E360232
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhDOGPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:15:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31328 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhDOGPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618467314; x=1650003314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZOmJ1HqCf9egE/XxHkdLJPfyCM24LA6jlc8zeJf9vT4=;
  b=nAvz0rjVfBx92jxdXzBl2qmvO1jlrKpNoaXM18aI/bNWcpC+UlE0IlL7
   SDUy9fdtBKZ0jpStek18sRLT6IMNkrQS7ZYIwBSfR/bHLIpspRwg6FM0+
   knmciDLibgtMcUUKgAhyrgWXbimEMKBG1uGydX1A+j3FYQ3AF5sLPTb0x
   55Q5dcyaAwrzinr1aI19kn0aWCPFAbX3tGVIatIBXD7d8TsKftj84L8xw
   +4mwgRW3EXjS1L9HuhB52Z4ckLDDToRly6wYXzQUbsLalkgVm969DrRok
   jw8h7QTLxdQphC362NYo/BIpta+apXAXBoM+WXTW5VleBdK7631FAN3xm
   Q==;
IronPort-SDR: HviiM626xZj1qoj8tlxfM4U50cb7poV+JPpbgOxTZeWIGWjWTyBqHClA/7i1EPiTrcgY6ZpUhL
 KkZbj/JK/+SpZfBb+sG9L2N0jUChb5YMHBmq6/tEQSJGyRLjuDEnsvkAf807f8IZsTeYr2MfHV
 Yi8fnzTSlEb65HOeiXFZLwSiHRBI24ZMpHnR/1bh1fQJXXkmifINnPvGRmDzQXhXhH7TOeLPG0
 BU3GODlNOljft2A9WiWDjW6EqxXUUuET9Dh0XtVvSII4VMDZ5uI9isWup+bevr2M5ESvYcv8iO
 mt8=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; 
   d="scan'208";a="164846899"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 14:15:10 +0800
IronPort-SDR: LTA/uAK+tpf6MrGxIfY319AhiiNctmCJsJEAASpQiVktX5/EiD8lHkWwQpXm8O0qk5c6fUuyE2
 K6iMZZNZh/9sz8FTU5tkPrcKGl7wSwOCU4bqIgwGzMcPPJ+muyOEGJGNFD/qY1ALXG6zi3QkPv
 06YQgEhQr/9DDbAfmTlHfQtWScnQYA3ka8QEosWIrw6hbG+HRnxYqsi+mra6mCsKEKHoKmBd1z
 RAW9ylg6owu+LT9IQDzKlEPyiFWKLwOJcTs8WG+7qkChrj06upplvoQL82H77B+5PSM5chWd0p
 yDEv6cEsh+iBz9E/hWcB7JrN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 22:56:07 -0700
IronPort-SDR: Csvnbia9pjF09SDOg/oS/8DooyPcMedsr9AbUQ3utxVRxlKWGhkFVhoL6e7YdQIr/JJlu73RH1
 LPAxw5IeZiLdJMrtp7W/qMAIT/HpgXy1HOmI/Vb5+h94Q/nHAlAkYiBI7OupdtQAS9Ts/dAzm0
 9vp/3ptZmgTeObIs1JTThvE2QE8ZUA5x1KHrQpqMxaDuFLdxXlqtK2iRLUfkzFKmdnSdykVHCT
 WVW58HNTBUu4TLac1kBuY4+TTlydrfRN/OhOLxv/XL6CQz2V/IY4rs/YOS5+SYxMJC5uelqzvP
 1zA=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.118])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Apr 2021 23:15:09 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     uclinux-dev@uclinux.org, ugerg@linux-m68k.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 0/2] Fix binfmt_flat loader for RISC-V
Date:   Thu, 15 Apr 2021 15:15:00 +0900
Message-Id: <20210415061502.7248-1-damien.lemoal@wdc.com>
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

Changes from v2:
* Updated distribution list
* Added Palmer ack-by tag

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

