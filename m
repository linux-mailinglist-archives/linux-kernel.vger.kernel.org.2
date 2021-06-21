Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F863AEF63
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhFUQiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhFUQeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:34:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6689961410;
        Mon, 21 Jun 2021 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624292813;
        bh=zbAT/kX5Ee7YMu5zr+rIkouwoULEylJPP58Uk+Fz4Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crf2V4KxRPIHS5+9J7/6I/U3XuFAwGfpnp0G3Snjrb4hRt1rZtQ3R5r0ikzSBRxqI
         2vkvRjjPDHHo4E03aIciUMMvrrydAYJ+iA50QCTfBOvLUKPRI7vc15YsyV/7Sbi0Ad
         2k1A1XSZASgllCSASsqKHoCrKV8c3SP9BN2qQgSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, vannguye@cisco.com,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.10 140/146] mm/slub.c: include swab.h
Date:   Mon, 21 Jun 2021 18:16:10 +0200
Message-Id: <20210621154920.493336162@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621154911.244649123@linuxfoundation.org>
References: <20210621154911.244649123@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

commit 1b3865d016815cbd69a1879ca1c8a8901fda1072 upstream.

Fixes build with CONFIG_SLAB_FREELIST_HARDENED=y.

Hopefully.  But it's the right thing to do anwyay.

Fixes: 1ad53d9fa3f61 ("slub: improve bit diffusion for freelist ptr obfuscation")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213417
Reported-by: <vannguye@cisco.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/bit_spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/swab.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include "slab.h"


