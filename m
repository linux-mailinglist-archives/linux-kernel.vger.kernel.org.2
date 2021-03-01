Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD89329BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379809AbhCBBbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236036AbhCATSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:18:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B57A652A6;
        Mon,  1 Mar 2021 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614619996;
        bh=Qfn0aUat3ceZQ1ghd+EeB4wkAMI8sShpeAtkKyiVw5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRvY42uopWfRl3Ru+fwglD0A5MbRlQxnUXM3UhsI/PEzMeXgJc+hU7LpKCDMsPrS8
         jTY5tGUxqsEdZdE3JCMdc/jjZ10z439/h+yaxYYmUX+BltPFPNZntI07vkTovw2A30
         yyR3HmDAvXGwiNrRW7Wm70sAw90pa7/3Vn/D6VCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.10 626/663] s390/vtime: fix inline assembly clobber list
Date:   Mon,  1 Mar 2021 17:14:34 +0100
Message-Id: <20210301161212.823201417@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
References: <20210301161141.760350206@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

commit b29c5093820d333eef22f58cd04ec0d089059c39 upstream.

The stck/stckf instruction used within the inline assembly within
do_account_vtime() changes the condition code. This is not reflected
with the clobber list, and therefore might result in incorrect code
generation.

It seems unlikely that the compiler could generate incorrect code
considering the surrounding C code, but it must still be fixed.

Cc: <stable@vger.kernel.org>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/vtime.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -136,7 +136,8 @@ static int do_account_vtime(struct task_
 		"	stck	%1"	/* Store current tod clock value */
 #endif
 		: "=Q" (S390_lowcore.last_update_timer),
-		  "=Q" (S390_lowcore.last_update_clock));
+		  "=Q" (S390_lowcore.last_update_clock)
+		: : "cc");
 	clock = S390_lowcore.last_update_clock - clock;
 	timer -= S390_lowcore.last_update_timer;
 


