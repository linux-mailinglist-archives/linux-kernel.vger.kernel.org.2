Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32A439BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhJYQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:37:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18272 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhJYQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635179683; x=1666715683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HtlEET3sshwSu3d9oyto6pYaMpqazwviYxoxvTQEnUo=;
  b=NUzT/S3gnXsqkZhvTVnh9o3tr6RQJFg8/zxIBikaZNcM8L9eGUQiN0Nz
   VnCv/0qb2ajwWHokSUg7TePYsDkL1evgCDQzWXpKVm76Pt3O/mWp0zcT1
   gQCr19fIPj7zR+9/Vd7WGz4dwW4DWjnD6yTSUcYpQa/3sUywQqUO5in8T
   CaFCpgPgalipI3TwGh7271lmEZXExPfh93HWRB9mvPF0VEKVr0BTL2O/o
   cdfHS15nwt5wpz5GjEGuvjkXpktFsH0juO/AmBYiKNYnCuIhGYN3aIshd
   zH8rWHCIelIHMm/18CtGnH0xUSUxVQrykSjMCAO/7Wxlzcifx+d3fVR/1
   A==;
IronPort-SDR: NO1D6j8D/bwDSF62n9QxiKRX2BAcgsPw4rYw+Bk44fMyBEFHE7VcsGNjgRSxq+b7LKr4EpI10D
 Byyu3bE3VHUgmAwPrxD4KUogl1lsR8qJh/paxjWEQES2dxPPJyjF8CCf3wHiTV59lygmryovBF
 35UXXcmwk3cKeBeGwC0U5LHAG7nnt+Q+WOPVmlSXCe8KvWocTv2frm24wLXf0YQDczZNGZQO6V
 FrV8terSDfs/cAUcLuYskZR4/lcQke2FPut/81jj1Qh96lirpf7jflG1t4kXpRmUW03C/bTp1L
 EO31rMipyiAwnUrnJynDNmbE
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="74197464"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2021 09:34:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 09:34:33 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 25 Oct 2021 09:34:31 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.16 #2
Date:   Mon, 25 Oct 2021 18:34:28 +0200
Message-ID: <20211025163428.26285-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are a couple more dt changes for 5.16. As we are late in the
development cycle, you can surely postpone their inclusion for 5.17.
They are in linux-next for a handful of days.

Thanks, best regards,
  Nicolas

The following changes since commit 4c46b991bab640ee91f16967be2b0d00b7d5f992:

  ARM: at91: dts: sama5d29: Add dtsi file for sama5d29 (2021-09-21 12:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.16-2

for you to fetch changes up to f3c0366411d6893360be21a7544595bf275bc9b2:

  ARM: dts: at91: sama7g5-ek: use blocks 0 and 1 of TCB0 as cs and ce (2021-10-21 13:45:16 +0200)

----------------------------------------------------------------
AT91 DT #2 for 5.16:

- Add DT nodes for TCB and RTC blocks on SAMA7G5
- Add TCB0 for clocksource and clockevent functionality fallback only in
  case PIT64B will fail to probe and as a testbed for this feature on
  the Evaluation Kit.

----------------------------------------------------------------
Claudiu Beznea (2):
      ARM: dts: at91: sama7g5: add tcb nodes
      ARM: dts: at91: sama7g5-ek: use blocks 0 and 1 of TCB0 as cs and ce

Eugen Hristev (1):
      ARM: dts: at91: sama7g5: add rtc node

 arch/arm/boot/dts/at91-sama7g5ek.dts | 12 ++++++++++++
 arch/arm/boot/dts/sama7g5.dtsi       | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
Nicolas Ferre
