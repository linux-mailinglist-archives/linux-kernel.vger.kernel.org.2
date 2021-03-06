Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61832FB7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCFPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 10:49:11 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37355 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhCFPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 10:48:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D97825C00CB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 10:48:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 06 Mar 2021 10:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        from:to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=ZNVzCeUQ/9cLP7BSVqVfDL2Wy0
        Av5E2NkuTW/6iV13o=; b=dLdCEXXN/jewcBFgotrC5k93wi12fBBkoRZVdZbnm0
        NyQvFdgzHCum1cqxtG97GG8sd75sWKtcyH/5xr29nUL6XrmophVxXL+D82XnqJRQ
        6MGusjIMFvMTczYfTlzAMJNpgodu90SfzKnrslefYZKPUUA9SlTe3hAvVwFyakBk
        dQ/GmnQ0zkp1GKffqNcSM/tdURlgOBn7uk/L1dnfxFRjrd8+iKaZ6a0GDa6CKYlP
        VlQ6dP+l6qdOrwF6WMWyW6sky9lsLjGglAtbLI7QF81yeP9JsPSAsWcKaNAh94Q/
        FCKtBnLhhmzbSz3lA64fKOycI8CTg4o9pefI4QB+PMtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZNVzCe
        UQ/9cLP7BSVqVfDL2Wy0Av5E2NkuTW/6iV13o=; b=lFw8ogx5T/crNWvkNjdGaN
        BJ1wPuIwasOo4QSsyRka2Gg6wuwZL4Qkb0RGSzhmDjtRxT1CTvZQ3Zc+tCyH4RIm
        IKhjdg52FP1ib8jzsXM7sNCDjgvNPfHrc5zCkM0tigx2cel0Lh5c97DW0KL8ngnV
        yCfBVk1HS9TucKPG01GroHb6hzsL+TE5JcspOjuWKiNy4EmM1xF6/EzKE2kkgqdh
        sMpTT9CpzXfEMT5BHc2uVrwjgco68BPnCw1RW0jZ/r1XdOz8RC3HqKIzVnoiMXw7
        iP4xgFJ/S13vZC3QljDUMirKYp4DOL/LjPiKmEtsqnJeooMPRUXrwEaoYrSqwCKw
        ==
X-ME-Sender: <xms:WqRDYIN7XpKJN2Ife6jr_yQPmlJLzjSFPBsemUUXW-bPvT4HqbmLQA>
    <xme:WqRDYO9k7PNgn92hlXdWhLiL-pYVSFkFHLPb2LUYSI_OZna_SMw38QSvdRcG673g_
    dEEQsa6nX1VgvFED1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpeftrghmkhhumhgrrhcutfgrmhgrtghhrghnughrrgcuoehrsegr
    rhhtrghgnhhonhdrtghomheqnecuggftrfgrthhtvghrnhepudfggfdtvdeuhedugeefve
    duffehledthfdvleeuteehueeihfdtvedtkeffgeefnecukfhppeefjedrudejvddrudej
    uddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:WqRDYPQLCoSod7VQ7RcO_0SipqjbChTT9sLQH5A3O5rLPA-Nfb_4WA>
    <xmx:WqRDYAu71yCCMj_ns_CPdmKIi79tf83mKlzXaEIOQ7Tf13VNEyMZFQ>
    <xmx:WqRDYAdKTgIDWIDxbNcmLJwV7_rAN-cwUclvZwFm4wWni1VYxL7BGQ>
    <xmx:WqRDYKqzI1DyNgzpvtrsRJaj-OePBzjLCx8gg7nlu9Tr2MSKnI4aiw>
Received: from localhost.localdomain (unknown [37.172.171.105])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43DEB240054
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 10:48:42 -0500 (EST)
From:   Ramkumar Ramachandra <r@artagnon.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] [.mailmap] Add entry for Ramkumar Ramachandra
Date:   Sat,  6 Mar 2021 16:48:27 +0100
Message-Id: <20210306154827.10820-1-r@artagnon.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ramkumar Ramachandra <r@artagnon.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 85b93cdefc87..78bff5f1e881 100644
--- a/.mailmap
+++ b/.mailmap
@@ -282,6 +282,7 @@ Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajesh Shah <rajesh.shah@intel.com>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
+Ramkumar Ramachandra <r@artagnon.com> <artagnon@gmail.com>
 Randy Dunlap <rdunlap@infradead.org> <rdunlap@xenotime.net>
 Rémi Denis-Courmont <rdenis@simphalempin.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
-- 
2.30.1

