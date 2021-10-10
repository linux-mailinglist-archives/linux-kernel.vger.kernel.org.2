Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B464283CF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhJJVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232353AbhJJVeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CA5060FBF;
        Sun, 10 Oct 2021 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633901537;
        bh=zjy3R1MRHvh/dkVHDeEdi/cGiweG0b5pfdrgoCBELzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AViIxpKle0TJbAeKrLFAqo0OThzh+X4UdhiT4JIscES0EoA8s25+dLvLt6rSOfKbA
         YRG5tW79trrjgLHBhUNwtWg1a5SCotUSjn5UpSCPI2Rw5ucF2ctBaYUPHNNy55M2+t
         iXqgiKW1gCA9YQLgrmgrUH/C12hDVzLix8QHGvVzGL9r0wDMDMj+pj1KkxM4hYJ/d0
         gDzbK5FaPY1wBLv7h5bN15Ki7tLdaHcNRIRG4hehpjpB96L9Zm7fpHiEN/2vNDbFbn
         TLICYzbyz0zwGCzGw6uTyNexGct5RCoNhHKf7y3dFqyFlWUSnMBmZj+uJOykWOlG1I
         n3fqJB85l4gTw==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/7] lib/xz: Move s->lzma.len = 0 initialization to lzma_reset()
Date:   Mon, 11 Oct 2021 05:31:41 +0800
Message-Id: <20211010213145.17462-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lasse Collin <lasse.collin@tukaani.org>

It's a more logical place even if the resetting needs to be done
only once per LZMA2 stream (if lzma_reset() called in the middle
of an LZMA2 stream, .len will already be 0).

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xz/xz_dec_lzma2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index d548cf0e59fe..22b789645ce5 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -791,6 +791,7 @@ static void lzma_reset(struct xz_dec_lzma2 *s)
 	s->lzma.rep1 = 0;
 	s->lzma.rep2 = 0;
 	s->lzma.rep3 = 0;
+	s->lzma.len = 0;
 
 	/*
 	 * All probabilities are initialized to the same value. This hack
@@ -1174,8 +1175,6 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_reset(struct xz_dec_lzma2 *s, uint8_t props)
 		}
 	}
 
-	s->lzma.len = 0;
-
 	s->lzma2.sequence = SEQ_CONTROL;
 	s->lzma2.need_dict_reset = true;
 
-- 
2.20.1

