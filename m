Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0133E949
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCQFwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:52:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:7155 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCQFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615960330; x=1647496330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m2eD7CRdke6u8hS/2ch3I0JuW3C0eH1p9KrKUbzM70E=;
  b=gljwdyflhW/0N5g2WqbuB+Eu/uBOhkvqlEjohQ/EXmWCB0nnd8JsZccL
   RhUciGu8lwbioHRvZZVAFf/wfNISxLzs6kBMW8k6rYFPNjSJTGK/HUjeK
   g/JBAUQg4XbQSfB54ymzAcdOhbKZjMoI3Ipk8ZvjflrQyHVwy2lAgluw2
   8dMOCxiepn9izMdm9BqsJcnGualJCo0elnoU+r6iFJueKbmFxWdkz7uo+
   UtCOSd2U7DvvUqyYg/zyeGVW18ww9I14iU23W3mHNWHpoVkSg9txfrtpM
   tNi6dbM3PElazOqIGFVZfzd2AkUTIUcttfwCFsawk77gI10Lzgg8BwZrr
   g==;
IronPort-SDR: G31ZsEulACHCLC2CehSTUlpNAQZ4uni1Osv2SGopHm5S2wD3AwSQduggQ5hd0I+0dkBW9epeoT
 Aq1kShzOYC1F6c8n6BU/XQxulsd/dJLBSKP0FPXoGwh3Xfrhh4cdgYpKO1ZiN3zjLuB+bpBO2N
 3/FPyscmFO+vclCSD+zJu8IHVjb31TsWQsxim+Ros9Copewr94R+PF8P4C++HNAKd4hUbIRP7y
 3neP7a8iMhp/ex68fq47GhfG+qRvbHpH0Thd9p1M2ZdWqsXoRYHN3d5GcMFhw5oLZ3XLg/cc6O
 9TI=
X-IronPort-AV: E=Sophos;i="5.81,254,1610434800"; 
   d="scan'208";a="47820219"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 22:52:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 22:52:07 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 22:52:05 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>, <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: Update comment about the default flash parameters
Date:   Wed, 17 Mar 2021 07:52:03 +0200
Message-ID: <161596027983.9417.17580791148510891300.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315055634.17332-1-tudor.ambarus@microchip.com>
References: <20210315055634.17332-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 07:56:34 +0200, Tudor Ambarus wrote:
> s/legacy/default. spi_nor_info_init_params initializes some default
> flash parameters and settings that can be overwritten when parsing
> SFDP, or by fixup hooks. There's nothing legacy about them, they are
> just some default settings, if not otherwise discovered or specified.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: Update comment about the default flash parameters
      https://git.kernel.org/mtd/c/79321e752aff

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
