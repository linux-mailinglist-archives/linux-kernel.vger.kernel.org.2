Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110B94354FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhJTVKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhJTVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22F0C061768
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:08:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bfPBeunwpru57X4GPQOgQ50jUxXH5PUnC8k+Hj7Dc/w=;
        b=RtsURydA1FrpKgQyXgW0PIN2E2jbek14q2K5WMO0W0JmGaa3bcuXa4uOrOnkZHWLJD64nY
        YKvpn4r/9PNQnk/oAoIt9UWJnzWAdUe2kj2EUkGF1wsx1G4Wxdn8l8KzvjD3PEzvsWs3/8
        1gwyxj9zB3WmsJ5bGzUC5U46dTsKIUktVCWQdugGWA2fDs36mB7aRODWVgDwqV0E5aZA2V
        7hiCYLeNBs6vtE6GfH82R4UlLeFwfZ/lxzJYt15Zj6pXWSxBjKg0nZceZhSUOEtOmGNyQg
        mdoRLWFHQJ44D9NcRzQHBoAfJ/YxnaCXydEUInGeKlVrV/4VrxEIlD4PrwESHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bfPBeunwpru57X4GPQOgQ50jUxXH5PUnC8k+Hj7Dc/w=;
        b=da5yszb3wuWEq8ZgUrZME++t2a+ruP7AMro6d1iVgXiUYiMPOybobsCVKR8r7vvjEJRX9I
        6p/FR+yTh2VLF7Aw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: MAINTAINERS: Add Dave Hansen to the x86 maintainer team
Date:   Wed, 20 Oct 2021 23:08:16 +0200
Message-ID: <87zgr3flq7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave is already listed as x86/mm maintainer, has a profund knowledge of
the x86 architecture in general and a good taste in terms of kernel
programming in general.

Add him as a full x86 maintainer with all rights and duties.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20336,6 +20336,7 @@ X86 ARCHITECTURE (32-BIT AND 64-BIT)
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Borislav Petkov <bp@alien8.de>
+M:	Dave Hansen <dave.hansen@linux.intel.com>
 M:	x86@kernel.org
 R:	"H. Peter Anvin" <hpa@zytor.com>
 L:	linux-kernel@vger.kernel.org
