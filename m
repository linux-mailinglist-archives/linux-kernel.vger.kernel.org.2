Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D231A362C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhDQBKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:10:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36051 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQBKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618621816; x=1650157816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Zm5rXOuoxnhCqnsnX85LqLLaCeZAEf+Eqn2CbNRDuc=;
  b=A1XQhA3lVYyU8xltD/djirYs2QVGtvAiuc3OAio6AMXqbau2vstQXvTy
   zYWn3dqtkeUVROzfKGYLVkLcZf2zb2mrdbe57UtlvBGiS7RujPe23Td5y
   99X3ojH5pHLAtqf8ZBKuY5I9BrlFxB1pBig7zLImJuu642OQ+oiJQHFXD
   weL6jYFj/d+/C/UUUB0+7gCfDbnui6reebVhHfjE41Ub9uFwBFXTNqPHY
   YrJSXSJeESj38JatnTO2XYK2rCSTmZywXetcgZohpN1Glt+lBAEeF4dfk
   W60dJJUvQAnPU+wntE3n+OlLokIbJqNZ4hlyHNQseltXcIxfrGFJY+ehC
   Q==;
IronPort-SDR: pfSLzycSd4eYhq7Z+r6HV3KYc/wuk8KXWPgfjf795Zk7BUIO2yvwAN+QSnNKKHxmEQHyI7UabD
 YTnJ2AdyB/ZHJuj8aZqOUNILUI4TLqBycTxeg0Z/WLwXOgEdB+EGbWBNElYhf+yEFXdvptlwZD
 wSVoGXksJnYV4+3xMzTTdreiqcYWwxKbsLEFmB0zejteSzRe+V05rZO1Mtpud1VfoRtojh8CJ4
 dtCLhzxStMZCtFDN5HvSF2gTANoWwjs4I06Q1u/Z7MLunHQLdRgVTZfnHwS9nsvcfuXt5t3LZv
 L8o=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165185053"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 09:10:16 +0800
IronPort-SDR: Dv4vY6oj33z+DI87UDpTtFkzqYzR99VqDnnzTnNFqPXajnoThnDGeo+6UsHNs6zhBNRZSI4Is4
 Sehe22PdKkSSGTJRcgjsaCP+LNySHiBh9D+HvPp4l4kODT6FdhoFH6Lh/81R53AcWwEZD+FrS7
 EpEMQIEWWRaxi01mFpxEVFp7XZsBaZji+AaQLau8XQATtesZ7JLL1HRs0wfnlrTV9ae70BShTA
 iLbFqjy6ekFDF4zk3V59cFj9ggLIyfxWXTii7AQRHQGBxLNZdqH5Rd09twjX2shsp4EI90VATs
 NYLTSnElrM2m/dS4lGh9vzsD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:51:04 -0700
IronPort-SDR: t/sQcqGKZClTo/liT6bedqOZlkIQPGkBtzN2/WbRRe2vUlcY9ZHoZMOZLwXbIgd/2SDbG4tHo1
 iSDTFz+nNMIFpB1s8nOHUzxeRITbtsURGCI6j87L1OFXDbr04Hdblv0jr4uUKlKrxblyO7U71V
 +jU3mRTnTff8Jw0tKFmhZdMH7rq6O0oCKCveVXXpl2yHpLptMBUii+sQYao9fUWYF2suObZFNy
 TbYFS5A9dkNW/f74Fv/klbz6GfKhC2HkuLJOyUHDe1E5FHuM6yucNr9+C7BRkq9bS3awW6DxVU
 F10=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.5])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2021 18:10:15 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     uclinux-dev@uclinux.org, Greg Ungerer <gerg@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 0/2] Fix binfmt_flat loader for RISC-V
Date:   Sat, 17 Apr 2021 10:10:07 +0900
Message-Id: <20210417011009.54569-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V NOMMU flat binaries cannot tolerate a gap between the text and
data section as the toolchain fully resolves at compile time the PC
relative global pointer (__global_pointer$ value loaded in the gp
register). Without a relocation entry provided, the flat bin loader
cannot fix the value if a gap is introduced and user executables fail
to run.

This series fixes this problem by allowing an architecture to request
the flat loader to suppress the offset of the data start section.
Combined with the use of elf2flt "-r" option to mark the flat
executables with the FLAT_FLAG_RAM flag, the text and data sections are
loaded contiguously in memory, without a change in their relative
position from compile time.

The first patch fixes binfmt_flat flat_load_file() using the new
configuration option CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET. The
second patch enables this new option for RISCV NOMMU builds.

These patches do not change the binfmt_flat loader behavior for other
architectures.

Changes from v3:
* Renamed the configuration option from
  CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP to
  CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET to clarify that only the
  offseting of the data section start is suppressed.
* Do not force loding to RAM (contiguously) if the flat binary does not
  have the FLAT_FLAG_RAM flag set.
* Updated commit messages to reflect above changes.

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
  riscv: Disable data start offset in flat binaries

 arch/riscv/Kconfig |  1 +
 fs/Kconfig.binfmt  |  3 +++
 fs/binfmt_flat.c   | 19 ++++++++++++++-----
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.30.2

