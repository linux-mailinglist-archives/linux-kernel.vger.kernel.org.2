Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB442C462
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhJMPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:05:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43003 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236109AbhJMPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:05:23 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AEA0B5C01D8;
        Wed, 13 Oct 2021 11:03:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Oct 2021 11:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=CRTHliIzlKzHRJxZWsmw0T84Nf
        9SuFDwOmViut15E5o=; b=OSCGCFyFNmloqZC91XLR4avGM4lsuMpjv6eOKEUXM3
        9A5q4blGsWarB9R36jIJnVwRShWgih6boJvf24zvB2WMr8+k2g95mPn+VqCmMpwE
        nNo6ijWohb7mNChSMexJWMyd5mGWEVTIxzkQNq37lJNRgYhuWg3EK2fY4AseBy++
        Rxw64iBniJN97uEXoGbOrCW9692VTq0Qn0esSNA2PaawS9dqV+VVDwYekxbRC6T6
        d5sJfDJK/ziGBweSQgOmFqtmdX0ownoOeeHJLbJzrXXj5ziZb07XkjgShkTVjlJJ
        1cyNLEmgoyx6A6DHEzUBM+ybN+JfPesnvvqGyZR5P11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CRTHliIzlKzHRJxZW
        smw0T84Nf9SuFDwOmViut15E5o=; b=Oswbh90PmC7MilTi8bHRypP6vLVLJDWER
        gZ2+pY/UsYGtvKLk+SLGMW/wk4RX3rw9/U7TgN8119ANAOMRNH9+bybXyy6iTcx+
        k539oUnmgSMI8Q+ecLv61sch8JrJY2mF426t1GhSIsfSuzGAbXZcA0yN0dxATgCt
        AbwIVuWXje9wWFkYDV4XnKg5OJq5iCCswUPYMEgkrIzBUXg4Xm5TRgeDFIDzXfhR
        OMkDXnUwjmVSfnbjmSadNRcRqhr6THPyJOcAePTUn19SAbIMULnyBBKQ/XMHqAxn
        zXUK4xSg12zsNO8U0Z7LKumMAheU02Uy3rRScIRmB7f4VnjZ26UBg==
X-ME-Sender: <xms:N_VmYdsIPDZ_gIx31vlkzl6l86olTzjfF-J8OwoZ7r5MFzypy9U1xQ>
    <xme:N_VmYWejXmOWLzHK5XP6g-hz4gWKsde0pwtEMDwu7EOtEhCZygrklNhzGj3zimLOd
    KVA5As4fTeRl-kraw>
X-ME-Received: <xmr:N_VmYQx1bkLCaaX3nxOEBAqIdmLpPvuj8dYJ8GL379wYIaS-mQlc_wd1FQ9R21TJGy1FSF-Vj0rqZGhxcs_0lPQRJ0lRH353>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddutddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehvdffgf
    fhteeijefgteeftdfghfdvheeuhedvjedugfeggfeljefgleefvefgfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqhihlihhsshesgidvvd
    dtrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:N_VmYUMKJBreaIHJfWw9782P1uY78ESzO1ZD4bTlIH0N_fhnhfLiJQ>
    <xmx:N_VmYd9UmE46FoLtqL5KLIxK9Wf1ihk7qLuf3eQXFSdSjmD4C2Dp7A>
    <xmx:N_VmYUUZl3N5xQd6XjDA3ut75UGzP8gp6nPgbSZ0QGKOeT-Xl6aBiQ>
    <xmx:N_VmYYaCzSYe0o2OvdtSC6DDrsv_j3wVQhnh12cBzq6wbyPuw_3jXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Oct 2021 11:03:19 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 107FC180E; Wed, 13 Oct 2021 15:03:16 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Dominik Paulus <dominik.paulus@fau.de>, Alyssa Ross <hi@alyssa.is>,
        linux-usb@vger.kernel.org (open list:USB OVER IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] usbip: tools: usbipd: fix duplicate option definition
Date:   Wed, 13 Oct 2021 14:57:37 +0000
Message-Id: <20211013145741.2597290-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have been introduced by mistake in
f49ad35cd124 ("staging: usbip: Fix IPv6 support in usbipd").

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 tools/usb/usbip/src/usbipd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index 48398a78e88a..33e8512de7c4 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -589,7 +589,6 @@ int main(int argc, char *argv[])
 		{ "ipv4",     no_argument,       NULL, '4' },
 		{ "ipv6",     no_argument,       NULL, '6' },
 		{ "daemon",   no_argument,       NULL, 'D' },
-		{ "daemon",   no_argument,       NULL, 'D' },
 		{ "debug",    no_argument,       NULL, 'd' },
 		{ "device",   no_argument,       NULL, 'e' },
 		{ "pid",      optional_argument, NULL, 'P' },
-- 
2.33.0

