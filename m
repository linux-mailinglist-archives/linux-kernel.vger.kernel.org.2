Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B243FACB3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 17:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhH2PkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 11:40:02 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46439 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234237AbhH2Pj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 11:39:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9573F3200907
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:39:05 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Sun, 29 Aug 2021 11:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samip.fi; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm1; bh=czAd6ZZdR+RIUb+2EG2Eqv7ZYJ
        JyzxdZfAMJGdCvlqE=; b=YNxo9iG1uQJSuMGe7MbInInUaQnU8yp+cUH4XNJFto
        YxZYFJRntjyeBScm/kuaR1BVa8C2haMLeQ1Lwq7e0crxlm7eheiT1WyZUEHzFbSo
        P+gLcOPi1Gnn06YQfMGLxXt5cjNpKJSsczgeBsiPoFG3whlErk2hUcRvMfvxu7La
        LOzN4Tu2sYWgWFmdasxLIPzu61CMF1H5psSPMG71s7zejuYstXmWipqUbuK20Tlb
        L7TvfHXYVKcFyFFVSzca/AWccsHYa32Db5Jr1j868vMHel5DGZONLymyEpD2ZG5z
        v+dygRIAyb3fEbPPxi8A2BmeCRT4Ul15f5rTeP0K8A0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=czAd6Z
        ZdR+RIUb+2EG2Eqv7ZYJJyzxdZfAMJGdCvlqE=; b=CwocZnXf1KHKOs5xXvVUg7
        RjgHAWPmVV2Xvn9X6aJ6Hb9NlZh+Yeq+lfopoM0anY9ZZmba4RlHL+gRqdF+NUuQ
        DGz7ZLC1WnXVKHQ1eUvc1MBsdJUsT6dBZP45ktAMvS+YJP7FK+LOg5BbjWwBxkCJ
        3etylAwcZnU746ZxxfFV++tDXHd1uWq8612frxBYbVMfGvfbR8mvQtouKQBRyoVm
        vZVXR4u2cUlJVhLlIK33CCAWTwh3K7PTQ56Poz1yDPKBrl8eZRrzXnsKFvA2z4ie
        EzB+kSKLFWVJwHp9zfmn+7hQVol2PDgBB2rG+3FwRdzitycrzW0hYlc7u97aJJoA
        ==
X-ME-Sender: <xms:GKorYYtjgGNVRICnoJb2nNnQjYjZTHskztFzF8NhjXVJJbGTbFUjzQ>
    <xme:GKorYVdgM02z6QRkOtaQKstXG0pPvD7oERpHnceWOkOv30pAw9hGY1G1mXcYjdI6z
    3kaN1k7FRaty3EeZCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddujedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepufhkhihlvghrpgfomohnthihshgrrghrihcuoehlihhsthhs
    sehsrghmihhprdhfiheqnecuggftrfgrthhtvghrnhepueffhfeiveefueetfeevgfdule
    fgvdeigffgtdelkedvhfdukeelveejgfehhfeinecuffhomhgrihhnpehfrhgvvgguvghs
    khhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshesshgrmhhiphdrfhhi
X-ME-Proxy: <xmx:GKorYTyHAkFb4Ip8YTAo0QsTJ4dQZ5CYxjESv1tc_KDXx_78JHmVhg>
    <xmx:GKorYbPoxutSSd_hBuUsqVI0ZhteoZ6oIwJvH-v3srbNxQG7OnFSFA>
    <xmx:GKorYY-qCRS3qwf7vIJqyadrO_pL58CGMPs0F1aK4YdSri9egfjNnA>
    <xmx:GaorYdHPSus5POWMJh_1fxkDkXUWBviMS7k4_lr6QCgLgIV0-xGENQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8DF0DFA0AA4; Sun, 29 Aug 2021 11:39:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
Date:   Sun, 29 Aug 2021 18:38:39 +0300
From:   =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <lists@samip.fi>
To:     linux-kernel@vger.kernel.org
Subject: [drm/amdgpu] Driver crashes on 5.13.9 kernel
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone on the list,

I thought that this should probably be discussed here,  so I came across=
 weird issue to me which is driver crashing while trying to get one of m=
y monitors working on Gentoo.  I would like to ask here how that would h=
appen that the Display appears to jump from DisplayPort-6 (physical port=
) to DisplayPort-7 (which doesn't exist physically)? Has anyone else exp=
erienced this?

It seems that the driver sees a rather large amount of inputs for the GP=
U, even though I only have 4, 3 of which are DisplayPort, and the issue =
monitor is also on DisplayPort.=20

Hardware:
CPU: AMD Ryzen 5800X
GPU: AMD Radeon RX 6800
System Memory: 32GB of DDR4 3200Mhz
Display(s): BenQ Zowie XL2430 (1080p), DELL U2414H (1080p), DELL U2415 (=
1920x1200)
Type of Diplay Connection: All are connected via Display-Port

Related DRM issue: https://gitlab.freedesktop.org/drm/amd/-/issues/1621 =
which includes logs too.


Best regards,
Skyler M=C3=A4ntysaari
