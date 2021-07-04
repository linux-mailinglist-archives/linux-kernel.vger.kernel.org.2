Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096D3BAF53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGDWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 18:24:41 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47867 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhGDWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 18:24:40 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1D2083200916;
        Sun,  4 Jul 2021 18:22:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 04 Jul 2021 18:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1hNB6T+0Ialzugd8z
        0lQ/Tva8umLGtrGXvvMQ6eqavM=; b=Y4VpfZNhxSDWm2iUsDX+y81X4TpVAaFCU
        aoCiJeIBM40g5YB+qZeXBmM47pSFHZqBOr8bTL98/uB+N46XezvHIJr1yPRyGT4z
        WFd74+A0NznMcn/47/Xs643JdeET9B8i1d7fqbdW3KSxBRTdAiCU9R5Re0ADv1rJ
        7+vX9x5+taP3E5C30aZdIE4PWJqSkhTaaWU0ZvrejdkVso2Mmf3ceQUIrnJ9v2vC
        HJzIe3yEELf2z1oj4yUVGZ7R7x1W3v/KHL8Da45KtRfp3k4kFs1q3GKlrjFIJM19
        ulaS3VxTzy7U7C1ZonGnEx4vHyeTZTCQmAUYXGrq7bLzyIUoGMeNA==
X-ME-Sender: <xms:ijTiYBty3ZAVpQrAW-7FpHWvGZN3MpijLbRrXwvXZTnSNK_Jypx4Uw>
    <xme:ijTiYKfzp4XzgAnVaq26AnGxFntVbhei6-7LpiMkFfZ4K-I0ikVk5IZOh9vbU6Pga
    O5VCx94DRkc-P7Apbo>
X-ME-Received: <xmr:ijTiYEwgvzQbl34fQdK5_F6Kziat8Iv_USZ2U2qT8fArR6uN2TE5LPA4TyNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:ijTiYIN0WB8OqzEIkA8u160dkfXd2PkM69cFgQNh5330c0MD8eGJ2A>
    <xmx:ijTiYB8SXxCBXynUvvg6IyTP3kxK4PGuL_GPT9zKmYcTYjkFbFoOMg>
    <xmx:ijTiYIUtPXrUSS-qIjlRMd2wgN3m_gAkbFMJGEo5qBdwmHPfcHNk2w>
    <xmx:izTiYEku2Pw2jX17VtmiuR6sEpOH9sK1eh_ZNd3r4aMpm52KmyjSnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jul 2021 18:21:59 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, mgross@linux.intel.com,
        jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/3] Support for ASUS egpu, dpgu disable, panel overdrive
Date:   Mon,  5 Jul 2021 10:21:45 +1200
Message-Id: <20210704222148.880848-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for some functions that are found on newer
ASUS gaming laptops:

- Panel overdrive: Some laptops can drive the LCD matrix slightly faster
  to eliminate or reduce ghosting artifacts

- dGPU disable: ASUS added a function in ACPI to disable or enable the dGPU
  which removes it from the PCI bus. Presumably this was to help prevent
  Windows apps from using the dGPU when the user didn't want them to but
  because of how it works it also means that when rebooted to Linux the dGPU
  no-longer exits. This patch enables a user to echo 0/1 to a WMI path to
  re-enable it (or disable, but the drivers *must* be unloaded first).

- eGPU enable: The ASUS x-flow lpatop has an iGPU, a dGPU, and an optional
  eGPU. This patch enables the user to echo 0/1 to a WMI path to enable or
  disable the eGPU. In ACPI this also appears to remove the dGPU from the
  PCI bus.

All of the above patches have been tested over the course of a few months.
There is a small possibility of user error perhaps, where the user tries to
enable or disable the dGPU/eGPU while drivers are loaded which would cause
a system hang, but it is expected that almost all users would be using the
`asusctl` daemon and dbus methods to manage the above which then eliminates
these issues.

Luke D. Jones (3):
  asus-wmi: Add panel overdrive functionality
  asus-wmi: Add dgpu disable method
  asus-wmi: Add egpu enable method

 drivers/platform/x86/asus-wmi.c            | 282 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   7 +
 2 files changed, 289 insertions(+)

--
2.31.1

