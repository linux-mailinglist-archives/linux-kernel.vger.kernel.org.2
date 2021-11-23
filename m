Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D934599F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhKWCIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:08:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56400 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhKWCH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:07:58 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN24hNO049389;
        Mon, 22 Nov 2021 20:04:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637633083;
        bh=ooYm6oRYPgkDWWdCeVD/rCmFIh2Q82jpU8+sV/v/phM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zRgbYvDLxAAMeoRS44z1I5lanja9TO32dPnqJZWAjo0Zi+B/jjk8AN21MXj18kUG0
         6K2HC/vVVdnxhYBX2dp14TKul+j39P0lcZ0xlaXF8dkzVJnyGBH+yN1k6kKoHjqEJ6
         1erbtQlYYV4o+qWiwCMkl2Lw3xCLfbUmeClEiEzM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN24hHE004946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 20:04:43 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 20:04:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 20:04:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN24gwT075208;
        Mon, 22 Nov 2021 20:04:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jason Wang <wangborong@cdjrlc.com>, <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ssantosh@kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: rm: remove unneeded semicolon
Date:   Mon, 22 Nov 2021 20:04:42 -0600
Message-ID: <163763306723.31449.18400224300621746344.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211114055333.217919-1-wangborong@cdjrlc.com>
References: <20211114055333.217919-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason Wang,

On Sun, 14 Nov 2021 13:53:33 +0800, Jason Wang wrote:
> The semicolon after `}' is unneeded. So, just remove it.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: rm: remove unneeded semicolon
      commit: 7c1c1d36e83073aab18d3dd596b735bcc6ea7984

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

