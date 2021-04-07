Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82321356B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351923AbhDGL5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:57:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26386 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbhDGL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617796619; x=1649332619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dCTK3fR91t7mZQuO1o3kMUaNqRvYQqW87j36v/abmuk=;
  b=Q8g63h52OgGymKqjLKbaPzW/ZJeZAscTYyjSDlysCrLEQGPiake3YDIm
   aRjIiKT6Fq9LRlrM366klFoKNzrCF0Pv/GDIsPDGYyW6/NjqP0WtnN+2/
   b279jviaAwYwT7LyElEqGPeHFvh4FHjXAmNx8K4y2BzM1YR7LRnQj9dTa
   ul7e3a9e9dYMealivrlxEy6ZzZI4n7bzMOd9ZZI/uYp5JH17j/qH58Rn2
   w0EBG5o9gNv1Wkz9K21PJvPbuU5nRc2UNLfSlDYQACRW4xBhfQvZeVltp
   UVMyoGXLWXerbPtW+aotk3S1e7sZEhZvzY5dbFMUw0lBbOyeYnkE29tBQ
   g==;
IronPort-SDR: l6l9tHsQzgFEmg17ogzeyXHPFYdXpGCUwFbsDB5YOOmekyCEPNrSEyc6o/5dUus7orMpbS448a
 DGOriLxKIAAWTAPgVtVGgHYcv629xMmhT5rcgxktpakwxEtpUI159hUqc3mUU2KNT5eILb2GKQ
 OTUloM/yLnh9Pi2RSt53AhHnSIl0p9VyoMl9SN2i5WZ7CLj15XSLJ5z+vizuvs9IMYOZT7LAjm
 ogrxPUtOZtDtpi7cYJ9TQV4XJkqs+3WIN/UAw2SCmW7f7BpGn6Ba0T3PNrIQcephxtoQ+JbLf3
 J5M=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="164998592"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 19:56:52 +0800
IronPort-SDR: pq6jjW3dz1NtxxVix91irvpaAxjG3054ukQr/LLxTfQL9YdnNfHb7PCq08QmO46qaAtCSVvr+s
 nO6B+8gE1F1K4eTHoMj5c+Qru1k5l2JYdT26FwwESUw2rw3gKWGgccHBtvK7bI9wqy6QLAapUC
 XIEDLwoNjyr14FrJTK8f8+OLtNE60dWFHUnSvT1kcBnAqnedRn34QwFQ0R/0brJvEjHWleqku0
 tEe0AqpTQU5JE6Juvt3MQXSSxFDAQvoSYSYcyNyc9lMD7l4665TokDkX3NU7Bedwte5R8mErO+
 jqAJWCr/QnQdtZZnHfR5/ok5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 04:36:29 -0700
IronPort-SDR: i4B1dXMGzh/3H8+rlLNqKe77kYfE4Zz4GCAE2pznh4ujxO7GE4dOPtJq19zwjoxe8+SGnHJOUu
 PmYud0lCziiWOfawOLgkaYPj/1FCVMMzI/JbVHg9PxM1tMa9FrdZtEpgeBXHmT3gejMEy/80Xc
 SzqxyhKT5cuzHEDFl3Ni7cvo72RVNHmHfnWCxl3IQr3iZ1PI/rrxOyS14xiEc+cZCLDU7GeRLL
 rxSCkFVRIXjHacYRk1P4OjzCwmjLRLdfQgDkIlBNSt3w8ONXAH1utGErDw83/QVg8OEDqLoYwH
 KCQ=
WDCIronportException: Internal
Received: from unknown (HELO twashi.fujisawa.hgst.com) ([10.225.163.90])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Apr 2021 04:56:43 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] Fix binfmt_flat loader for RISC-V
Date:   Wed,  7 Apr 2021 20:56:36 +0900
Message-Id: <20210407115638.1055824-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V NOMMU flat binaries cannot tolerate a gap between the text and
data section as the toolchain fully resolve at compile time the PC
relative global pointer (__global_pointer$ value loaded in gp register).
Without a relocation entry provided, the flat bin loader cannot fix the
value if a gap is introduced and executables fail to run.

This series fixes this problem by allowing an architecture to request
the flat loader to suppress the gap between the text and data sections.
The first patch fixes binfmt_flat flat_load_file(). The second patch
adds the asm/flat.h file to riscv arch to request the gap suppression
using the newly introduced macro FLAT_TEXT_DATA_NO_GAP.

These patches do not change the binfmt_flat loader behavior for other
architectures.

Damien Le Moal (2):
  binfmt_flat: allow not offsetting data start
  riscv: introduce asm/flat.h

 arch/riscv/include/asm/Kbuild |  1 -
 arch/riscv/include/asm/flat.h | 29 +++++++++++++++++++++++++++++
 fs/binfmt_flat.c              | 25 +++++++++++++++++++------
 3 files changed, 48 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/include/asm/flat.h

-- 
2.30.2

