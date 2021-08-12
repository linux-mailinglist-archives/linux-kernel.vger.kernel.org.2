Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C783EABEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhHLUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232796AbhHLUlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC46C610A8;
        Thu, 12 Aug 2021 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628800847;
        bh=lTyo3EMRGZxkzDJQPlmoJfNWRHnKmZw70dp59KMeCIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+m6IC7F8tJFTgYWxuPfYaf5qn7EcwvIVJsTrQDsZO+TdvvtLxLtjyPhkMd8aOO56
         qkjI+oBu4sCnFDc/QXPo5n3eWOEOA0ckEuW1Lzh/+RESjTc3mvssTAocMQPrifEdgq
         SrCjYFw+D4FvamI/m39Sg2WYPQbkOrsifSzTtHRCwpuQWRqQgZal0ZZj2hfzteB2QS
         6UvFEaEkpIaMBtO17OzceyOhVP3f5+I+3tAPeua0ncvkOmtaquaZtHcD8ZTVmeShwJ
         cy/JuKCrPCNq/jrUZaiJu16iOvu8jXGykRhcfJqr+a85QyYkQ+i6wVxH3A+YTeMJ3u
         +Pr40Uz42YMDg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/3] staging: r8188eu: Remove uninitialized use of ether_type in portctrl()
Date:   Thu, 12 Aug 2021 13:40:26 -0700
Message-Id: <20210812204027.338872-3-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
In-Reply-To: <20210812204027.338872-1-nathan@kernel.org>
References: <20210812204027.338872-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 987219ad34a6 ("staging: r8188eu: remove lines from Makefile
that silence build warnings"), clang warns:

drivers/staging/r8188eu/core/rtw_recv.c:499:8: warning: variable
'ether_type' is uninitialized when used here [-Wuninitialized]
                        if (ether_type == eapol_type)
                            ^~~~~~~~~~
drivers/staging/r8188eu/core/rtw_recv.c:458:16: note: initialize the
variable 'ether_type' to silence this warning
        u16     ether_type;
                          ^
                           = 0
1 warning generated.

This if statement sets the exact same assignment as above so just remove
it.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 9b3637e49052..8df38db9572c 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -495,10 +495,6 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 			/* allowed */
 			/* check decryption status, and decrypt the frame if needed */
 			prtnframe = precv_frame;
-			/* check is the EAPOL frame or not (Rekey) */
-			if (ether_type == eapol_type)
-				/* check Rekey */
-				prtnframe = precv_frame;
 		}
 	} else {
 		prtnframe = precv_frame;
-- 
2.33.0.rc2

