Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5C3BAE3C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhGDSON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 14:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhGDSOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 14:14:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97719613CB;
        Sun,  4 Jul 2021 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625422295;
        bh=VOfQh1IAnf9lkHRPD5nrDEq70fmmx8OmQspqn9nVb2w=;
        h=From:To:Cc:Subject:Date:From;
        b=ZkcNQT/d2kI2VK5+YoZ/4FytQXxuihGjhnz+rucpvIJjb2tcIIaYO4/SUjaJYegEJ
         VVY9l0jERfLL5SL37HdKonC9+8a446NtMlNe644qQ34aAtAJ2r+2G2lZ81JWGUZcrZ
         xrJntZ8uw2WsMwCpgp7zz5r5OvrHLQAYLpPGfmdi8Q9H0FXKrU/8DaAIzLKv0rfQ+T
         8Hp6HiZDkKT5z16HSauQ94c9/54ufH4/YwHs0N+cIBNF2+NKnj4G3PhyuyhzmQdxv/
         sjHn3TyOWTBzp2Xbnk4MTAEz54zzcJU4wqDU+dfnqhQJhw0Xz6X3wMuQjekJGFMkln
         K0/M+ekpHvJZA==
Received: by pali.im (Postfix)
        id 23DA29CA; Sun,  4 Jul 2021 20:11:33 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Add link to Orion Functional Errata document
Date:   Sun,  4 Jul 2021 20:11:10 +0200
Message-Id: <20210704181110.9254-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index db2246493d18..753a422d3bb1 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -21,6 +21,7 @@ Orion family
                - Datasheet: https://web.archive.org/web/20210124231420/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
                - Programmer's User Guide: https://web.archive.org/web/20210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manual.pdf
                - User Manual: https://web.archive.org/web/20210124231631/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
+               - Functional Errata: https://web.archive.org/web/20210704165540/https://www.digriz.org.uk/ts78xx/88F5182_Functional_Errata.pdf
         - 88F5281
 
                - Datasheet: https://web.archive.org/web/20131028144728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
-- 
2.20.1

