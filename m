Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B53995C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 18:14:12 -0400
Received: from server.lespinasse.org ([63.205.204.226]:40361 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBWOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:14:10 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-18-ed;
 t=1622671945; h=from : to : cc : subject : date : message-id :
 mime-version : content-type : content-transfer-encoding : from;
 bh=mx+M9BeOUJpX9hipCtnMSK8oEYs4fX0xoLmlIbvz2lE=;
 b=h1M3NzEn3imdefhDrnb1f26TiYTdn9s2UHl94w9lcaUuC8r67DhtHeGCKvH2qZfdDR5DY
 +AGVKQ5h+9nhrfjCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-18-rsa; t=1622671945; h=from : to
 : cc : subject : date : message-id : mime-version : content-type :
 content-transfer-encoding : from;
 bh=mx+M9BeOUJpX9hipCtnMSK8oEYs4fX0xoLmlIbvz2lE=;
 b=vL5bZzY0NGfm/JeFXERjKF4lw8OUsIFhnwmv/4XRR/BA6Y+d7hqtFVNu4o1ax9rxAyZhT
 nTEiis21aDymSp3AMxAPWrJxmuPDU7aArXNtgHQyy9cCURgFOSfluCjuwKkAJMn2aCJ97Ga
 E4uphKAUfA9xqH0OcDHYVWD6LeL3ZZARTD65qTx4G/xLZR9vhGNKOmwbgExh1p2KLA6Q/PV
 pFY5t4BrrRqyM+7baBmEEILAk5/BUESGxkiJN+MS89kD4m4jzj224UR6+ej1O3ZSGxcNpgL
 ZdqRR+NXpMtiVYCN7A2uzY+eg4TS8eSS3dc7DWy8kzSz9dgIGiNqYY+X5Gvw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id B427D16078D;
        Wed,  2 Jun 2021 15:12:25 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id A4B222120E; Wed,  2 Jun 2021 15:12:25 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailmap: use private address for Michel Lespinasse
Date:   Wed,  2 Jun 2021 15:12:25 -0700
Message-Id: <20210602221225.49446-1-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Could you please push this mailmap update into the next kernel release ?
I am now using my private address for kernel correspondance.

P.S. Hope this is the correct procedure for updates - I couldn't find
much mention of this in kernel docs :)

-------------------------------- 8< ---------------------------
mailmap: use private address for Michel Lespinasse

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index ce6c497767e2..c79a78766c07 100644
--- a/.mailmap
+++ b/.mailmap
@@ -243,6 +243,9 @@ Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
 Mayuresh Janorkar <mayur@ti.com>
 Michael Buesch <m@bues.ch>
 Michel Dänzer <michel@tungstengraphics.com>
+Michel Lespinasse <michel@lespinasse.org>
+Michel Lespinasse <michel@lespinasse.org> <walken@google.com>
+Michel Lespinasse <michel@lespinasse.org> <walken@zoy.org>
 Miguel Ojeda <ojeda@kernel.org> <miguel.ojeda.sandonis@gmail.com>
 Mike Rapoport <rppt@kernel.org> <mike@compulab.co.il>
 Mike Rapoport <rppt@kernel.org> <mike.rapoport@gmail.com>
-- 
2.20.1

