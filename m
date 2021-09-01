Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67803FD978
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbhIAMYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243995AbhIAMYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EAF260BD3;
        Wed,  1 Sep 2021 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630499024;
        bh=G2s+L2gxjQHgn9LpicalGiKnrlKAnV81yTKIyiolwAM=;
        h=From:To:Cc:Subject:Date:From;
        b=gY0JU7C7pa90vQZprIBDDVuhwW1by5xC7s4UP8UgC3kTucyiorEt8QnpHXAO9RAdu
         CWkApxSIeTeKCb+fHiT+7fRy1ag/91aBg0c83ms9cnXnXPGRKPZlaLOD9WpenJfFpZ
         Vc0Yb84fKWmBe84Ni6vP9iW3gK8b8HbSB+9AWg9f2gKdDFeFGcLkMyDtQEFgLszQSy
         w/4gtTLjtCLD0cuLy2WIZPHCsyvOHYnJIaYtB83HXXGH1zLYYORQRu7gCmjBq3cggc
         X9TPHgtTp6QEgKUghvqxpwKVRRDE/6Q+mN8r5S687u/z8H6hYsuEboV+HvlD86yDZJ
         t8VM0kMeQbnzg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mLPHJ-00H8Yy-1e; Wed, 01 Sep 2021 14:23:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Make USB ports to work on HiKey960/970
Date:   Wed,  1 Sep 2021 14:23:36 +0200
Message-Id: <cover.1630498020.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

It follows a second version for the patch adding a DT schema needed to
power on and to use the integrated USB HUB found on HiKey 960 and
Hikey 970 boards.

The entire series, which contains the remaining patches to support
PCI and USB on HiKey970, and USB on HiKey960 is at:
    https://github.com/mchehab/linux/commits/linux-next

John,

The primary reason why I added the HiKey960/970 bindings on
this series is because the Hikey960 one came from your tree:
 https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-mainline-WIP&id=fac6d20f0fee01eaaca36a8c52a44c741c6cbe78

Yet, you forgot to add your SoB there. Could you please reply to
such patch with your SoB ?

Thanks!
Mauro

---

v2:
 - changed the compatible strings to better reflect the names;
 - dropped the GPIO pin for Hikey960 power supply. It should
   use, instead, a regulator;
 - changed the names of the two gpio properties to better
   reflect that they're gpio;
 - use "-" instead of "_" at the DT property names;
 - Added DTS patches.
	
John Stultz (1):
  arm64: dts: hisilicon: Add usb mux hub for hikey960

Mauro Carvalho Chehab (1):
  arm64: dts: hisilicon: Add usb mux hub for hikey970

Yu Chen (1):
  dt-bindings: misc: add schema for USB hub on Kirin devices

 .../bindings/misc/hisilicon,hikey-usb.yaml    | 108 ++++++++++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    |  35 +++++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |  24 ++++
 3 files changed, 165 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

-- 
2.31.1


