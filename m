Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11923A89E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFOUDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:03:54 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48151 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhFOUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:03:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 01D77E09;
        Tue, 15 Jun 2021 16:01:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 15 Jun 2021 16:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=7ualycgfS9SsVG5r3CGGFNY9Ey
        g7pdelPCnID2r514o=; b=vbcXakdn0TjjxcVQ1c7qEky0OKHiGTaTm1ZahtfEpW
        QhEJfUZKw8orHFkp9XoZcy34X1loX1+z0e1QAbl1bz9vRGtq2pdPedehkQyzJGtx
        10vQW6SZase4LY22ek03udwyWMZ5D/fK50mzHOJ+z5pbFmJkmi7Wby26KBNp0dAH
        GCYGcuT0bElNkjS+21NwMeZnuVXJnluna/jdCLALZCEZOm1Npfcu+34GqoSubM4z
        NVQOP4PSfzeRRbLnl9KSudE0/F8N6yxjQmS6QoNHiaNl+XZzDz0TfL5YjoPDK0wR
        dwaOyVQkBaGA8sITh3u9ohNJywJPcTu8Q0gNL0sE9bOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7ualycgfS9SsVG5r3
        CGGFNY9Eyg7pdelPCnID2r514o=; b=HwX78l9xpHpZ2cBHBPutnvYuQay4FnfAg
        ctQksHFDhHyoYrPUHOFFd9rVS5HZ86SyhIZFjeHyWBTs1oJHPw7ua9lksU6Bu7Xl
        L7VMRJLAvKhzOPFGFw7QIEGb6w9euholQJor1OATxjGvRha4WCiEmHF7u9+muXpx
        ezMldHBNas3eaFlFzFrLjQkYjth0j1nuSgiN1Kg5kJX+LvJWHORbIRwjR/zaFWip
        pLzPZ5t1L2IEFcyXX36r28OcsQwDHOe1+IyDy9yEVmdQ9Fzse3Y8LuwcK8WwnCZl
        AZftHH5X/S1tc9QjAxwZBGjvD6XbHHBlCAyln/zmR+Po7mrDZaNiw==
X-ME-Sender: <xms:KgfJYEDsnM25oNwLWZe4Ijo6aHXveR0LyyVX6Jh83gP8WC-ifQ2pDA>
    <xme:KgfJYGgzCBsyMitqMq6ncXSTtkSjut56XX7Ioqmg9QqyiOeuIffmPdanDrNj3gZPm
    fZVs5ZaFoIzGDNG6jw>
X-ME-Received: <xmr:KgfJYHmr7Wv3DFTdrWaBZAzkIWDWS09w0O5o_2mGxBaxKfjtHEVmnvEs5NvREk2-eOT0Kk2jCVDtG7fwSvRHxW6YhBkrzBMGdBLSGngrONbs5S2lLhjHDIUPoB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvjedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epgfdvgeevgffhjedtkedtfeffteeftdejfeejveetveevtedtfeelieeuteekledtnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvh
X-ME-Proxy: <xmx:KgfJYKwksML5THonYj36EOMGuRVibLMJA48fGZLeuuU7Um4jjjiBig>
    <xmx:KgfJYJTpxVgmWGGiUUkpA4dRr8rTIroKmLuUvXGGEZzmJ8MABTXtmw>
    <xmx:KgfJYFYIdslelQsRL8gmO9OM99wWcSAYTxrymsgbZMlDfzYdgP6uCg>
    <xmx:KgfJYEcVxciSOfiusH1_yEWkMocYwdH8aw_G7740QulCOarNfOLleQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jun 2021 16:01:45 -0400 (EDT)
From:   Paul Barker <paul@pbarker.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Barker <paul@pbarker.dev>
Subject: [RFC PATCH] MAINTAINERS: Add note on patches to MAINTAINERS itself
Date:   Tue, 15 Jun 2021 21:01:41 +0100
Message-Id: <20210615200141.8573-1-paul@pbarker.dev>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; h=from:subject; bh=CQdGsYdn7Jszdx1S122LNT1PZKXWpsAGlZ2LHEujeLs=; b=owGbwMvMwCG2OjnkzdxdX/IYT6slMSScZFeyNtp3S51FvqegsfdlCeveNxKuSkxGvkU+kTzpjzNT WS93lLIwiHEwyIopsmzu+Xr/aa8jb0bILQWYOaxMIEMYuDgFYCIivxkZZljJP1AxMJFzUPM/XXzqMv t777kzhO/c+uWuwCH3bsPS84wM70X/Lbl2cIla9/Q1CV7qUc5b5e7F97XuXuwskalZW8/BBQA=
X-Developer-Key: i=paul@pbarker.dev; a=openpgp; fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no entry in the maintainers list for the MAINTAINERS file
itself, we should add a short note on how to handle patches to this
file.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---

I'm in the process of updating device tree files as part of $JOB and
would like to add relevant entries to the MAINTAINERS file. I've
searched through the maintainer list, read what I can find in the docs
and ran scripts/get_maintainer.pl but I can't see a clear statement of
where to send patches which modify MAINTAINERS. Looking at a couple of
examples of previous patches which modified MAINTAINERS and looking up
the relevant emails on lore.kernel.org I've made my best guess on how
these changes should be handled. This patch adds that best guess as a
note to the MAINTAINERS list so it's easy for folks to find in the
future.

This is an RFC as others probably know the correct way to handle patches
to the MAINTAINERS file. Even if this "best guess" is wrong I hope it
highlights that such a note would be useful. I've treated this patch as
a docs patch, please let me know if it should be sent to different
maintainers/lists.

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc0ceef87b73..b7873dad9997 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -143,6 +143,12 @@ Maintainers List
           first. When adding to this list, please keep the entries in
           alphabetical order.
 
+.. note:: There is no entry in this list for the MAINTAINERS file itself.
+          Patches which modify existing MAINTAINERS entries should be sent to
+          all other maintainers in the relevant entry. When adding new
+          MAINTAINERS entries please use ``scripts/get_maintainer.pl`` to find
+          other maintainers with overlapping entries in this list.
+
 3C59X NETWORK DRIVER
 M:	Steffen Klassert <klassert@kernel.org>
 L:	netdev@vger.kernel.org
-- 
2.32.0

