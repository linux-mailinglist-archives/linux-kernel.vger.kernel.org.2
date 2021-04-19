Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0779A363CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhDSHuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:50:03 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:32867 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231637AbhDSHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:50:02 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id CAC6C1D63;
        Mon, 19 Apr 2021 03:49:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 19 Apr 2021 03:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zXVG49ThYEHPecMdH
        M29sLSj0lBoAGhaMt02sLXKQLE=; b=D0PPgGM/hzNKtbxALsOrHo6anfWmLsASv
        6UsOn7VQLsuxGaTrj+xJLtq8sTPtNW/TLbVhpeedKNh+v9agQrh+Q2D18z1aIn4f
        bC/b59BU4rOEVxu/Oxdqvops+LvwA9FPTc/MFXgOPhsJS5xFoPYa6B9b6VM/qoOK
        neXRa9PEmufZe2dxYTCKRn/nZY6lyO4suv1xW+XTTiGQVjmanXSeHr+/lF/mcXo0
        9oJyrolgohBbSnoDVzMBUZPvduNfXbRVQIVDNLnorpaukn6caqVfQFyArHS4XAWj
        t6lCldjQd5YvoMOMtotLBaVfiD+gJk8oyQfAnYyBb/5w7fgxu2q3A==
X-ME-Sender: <xms:DDZ9YJDM-ZrwsRCUip-oQ7vZVr91sLl2f_kknmnwV7mHxDQ7s18KCw>
    <xme:DDZ9YL1kfXxP13vVG3rLvsDM_iTPkJNpW0S1zxZ74F6DrXEtPw8PHnRFfrvydLOUt
    bD6rKv1DH1gWfTjdxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtfedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhjohhn
    vghsrdguvghvqeenucggtffrrghtthgvrhhnpeelffelhfeltdfhtdevuefgveeuueekge
    etiefgiefhgfejvdetvdeuvedthfdvkeenucfkphepudduiedrvdehuddrudelfedrudel
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:DDZ9YDtltkkad_aE695OkIggTTdoZXrt1--aY0ddxloCsvCsOAwSEg>
    <xmx:DDZ9YL4T0m-OYeq8pVuhF2rRwm-TVy9BqdIGc7DLq-RqCskO_0cvCw>
    <xmx:DDZ9YEIk1YXt67q5NMLa9xqTl3IbJeMhkiZvsBhjRwlVcSzgeqcrGg>
    <xmx:DDZ9YOV74ezo3L6yKExwL7yrKenaycvNRA057mgGHMjptOjPbkQjrQ>
Received: from fedora.. (unknown [116.251.193.196])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0692240065;
        Mon, 19 Apr 2021 03:49:28 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/2] Remove GA14/15 quirks to acpi/video_detect
Date:   Mon, 19 Apr 2021 19:49:13 +1200
Message-Id: <20210419074915.393433-1-luke@ljones.dev>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert two commits to allow a patch to acpi/video_detect to correctly
set the backlight control as native.

Luke D. Jones (2):
  Revert "platform/x86: asus-nb-wmi: Drop duplicate DMI quirk
    structures"
  Revert "platform/x86: asus-nb-wmi: add support for ASUS ROG Zephyrus
    G14 and G15"

 drivers/platform/x86/asus-nb-wmi.c | 77 ------------------------------
 1 file changed, 77 deletions(-)

--
2.31.1

