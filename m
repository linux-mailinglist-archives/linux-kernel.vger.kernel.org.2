Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E873A88E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFOSyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:54:21 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45567 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230130AbhFOSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:54:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 17C5816C1;
        Tue, 15 Jun 2021 14:52:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 15 Jun 2021 14:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=No2oPqsZrvr6CiRabUxNkxWZak
        +tZm7HbUK9/oBsRyk=; b=K9lIIelszi8a/hegsYuPPKK0HlCQT8ULuR+lRSAYLq
        UJ0+U/dmUBfm8QInuwyvjmdmAu8xm6Jq45UA+b2OBD/STLLH9F3owz8HRAV+qq0s
        kiT6V4d29pUy1WuVqlcJabIQWy8LlI9UuV9fxRrutEf80vB+XXOrTJ12hycfB2pJ
        TRcsJG01EScpCfcF1a1l2lCGSBF9c+yhwVGJ8K5ZtJoaqdzsqBrGX4e6lzBv/bR5
        qKM1tIqNlkgByC0Q1OrUJT8RJZwUpzjeIzxBjtgTb0U+Rh+QJWV4pIjlZRFDVmMV
        B7aBCkoXxKpQGFM5XLIIvD3czHVi4bkxrhquYi6NAuCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=No2oPqsZrvr6CiRab
        UxNkxWZak+tZm7HbUK9/oBsRyk=; b=Nho+0Qjk4BjBEGDFxiMuIsO9Z+2Rxc/R+
        0aGchN7kQdggf8Z1Cf0fdR3T3c5vJ7aa53g9HiKAwU9nQKSZ/Ftrw9fb+G0Z60iS
        jw5LBFSxrGq8SU/iguTvXi8Tv2QI/i7iYatTxWpt6nQlKtOESp5Lv9UaomyiFQQl
        Id7JXkCVbi16xw/+fK63ZugRbICBCfxAHxIVbgu3LJEGRyFSYYSh04DhV3IsOWrQ
        9jGTR0rBP+qO70uD/NChuizkGRKO7qXL60iLm7m0DIt+kfII4LD6ixWflcAgSCN7
        ztpGzlOKGQN89RwyE/fhibX8XvgP2+c2TWF9049f/LeZ/hXnRcezQ==
X-ME-Sender: <xms:3vbIYKLL8ZVxhRgzz6FJe_i0fu9r_2mu-7YkJ7Bsy_IibZMvvkxT8A>
    <xme:3vbIYCJcNZJ-1DjvLl5AsjSJtOu3kN5i6ETlUNcUL88l3pCeq917Hr8UHjtEY_0cA
    9c8an1rTnT37uCzb0A>
X-ME-Received: <xmr:3vbIYKseN5Qnoi8QMzWsxrorQf3itzWIvInZmht4tf686_idryykf8o1jcKZ-tvVjdXr0A0P503vUWsP0PbTAMhsJKYfqO8afBeGeTmj9Uwqw5s4NpgsTMMWah8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epteefleelheeugeejudegiedttddvffdvleefgfdvudegkeduleegudeihfeijedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlse
    hpsggrrhhkvghrrdguvghv
X-ME-Proxy: <xmx:3vbIYPYcjXUCS-Vv6QRSAhNjxHrWno94t_sGX523ARGvsSJZive8rw>
    <xmx:3vbIYBYdJhi_5TvjqVylbCqqzMAJikRhu6LzkHSGntfjX7_WxjLcPg>
    <xmx:3vbIYLDCiuv28oQLiQ3KO-mCXR_2FYDWvIAJeYNNEge90Y5g6b5cPQ>
    <xmx:3vbIYAU-4hy9F0fol1JNVx_MNjXYGhZP_nwAWIV6PqR92fctn8vu4g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 14:52:13 -0400 (EDT)
From:   Paul Barker <paul@pbarker.dev>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Paul Barker <paul@pbarker.dev>
Subject: [PATCH] checkpatch: Use python3 to run spdxcheck.py
Date:   Tue, 15 Jun 2021 19:52:06 +0100
Message-Id: <20210615185206.7701-1-paul@pbarker.dev>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d0259c42abff ("spdxcheck.py: Use Python 3"), the shebang
line in scripts/spdxcheck.py says the script should run with `python3`.
However, checkpatch has been explicitly running this script with
`python` so it needs updating to ensure that Python 3 is used on all
distros.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23697a6b1eaa..5e5e3a53461b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1084,10 +1084,10 @@ sub is_maintained_obsolete {
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
-	return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
+	return 1 if (!$tree || which("python3") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
 
 	my $root_path = abs_path($root);
-	my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
+	my $status = `cd "$root_path"; echo "$license" | python3 scripts/spdxcheck.py -`;
 	return 0 if ($status ne "");
 	return 1;
 }
-- 
2.32.0

