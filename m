Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D61354AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhDFCdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243382AbhDFCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:32:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A039C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 19:32:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p10so1523473pld.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kc3RPHxu+J++goCeHYiszuO53o7w5S9ayyCjfILd0lM=;
        b=JRYHITpo6w4w07x9yRv9Y9YpxqOUkRdrcY7yhtNdP5rDzdROEP2WMn26aq0pTDHK1T
         ybmQVLS7toVRvKURVxYTDZc0ApGeOYbGJVoeq1vcSbp9gEffzjUTWmlDLjqTLv+SraPk
         GmZetivej+25TtENIpyBrjUBHl/Siq/9Bv68wmhqD9PKiNMmmi0GD6x3Fb1kB/wvJYGa
         wbuEn1uafdMLoIT29uETd8/6IvNGUig3tRIMgqb1up2jvShYxR8kZaOiZP4TdXacYVpL
         TCCcrjuanWl/IFfwJMwuzchhVBu3eZWAWygQ8oUy7FMLz/g9WhdUyF02omrB+T/byJGv
         aIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kc3RPHxu+J++goCeHYiszuO53o7w5S9ayyCjfILd0lM=;
        b=OfVJSvZg9PCuTeDKtpc232WL/3vG5PgBV0wyuBVXdp2xA4DgeHeaF0HajIXjW15KAa
         /eCShsaDHunjLjsmZPMO9T8jmA2SvMN0YItbJTWfGst6a/0qPomjjpOqs6Ar5OiCaoSC
         B/a04mOOYXqylwHPyTmyTw2QxUG8L9hkEFlts9915wcgRRSr1lc0m425sGov74V9Rvw5
         xhGtrhqVD6eWWn7jtJwsej5Ek+pa+jJMRBjflB+LTx/F/wogvmnw0A+1KtItIq9iBe/O
         +/Ctbu0KBINoxCxdk2QKISB1sdyaStb6pAHWvaZUvC893W1rHoG3o06msOyVXeWt6AyI
         4qsg==
X-Gm-Message-State: AOAM533IPDrXTgYGl6fzzx2swtWyD+D7gQkA5YtAbi7UK2I6oQQAz5IY
        kpOgO5+282HYahRFBr2f/wg=
X-Google-Smtp-Source: ABdhPJwzKtZy9r41zSCW0z4OszFZhjdGMtgly1rMyHybMJOS63uziIFDP6xwB2vi+QW+xAum79bpaQ==
X-Received: by 2002:a17:90a:4a8e:: with SMTP id f14mr2128684pjh.84.1617676371091;
        Mon, 05 Apr 2021 19:32:51 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id e7sm281196pfv.107.2021.04.05.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:32:50 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH 4/4] staging: rtl8712: add space before binary operator
Date:   Mon,  5 Apr 2021 19:32:20 -0700
Message-Id: <6db3ca92022376d162289174e201c79017b366db.1617674639.git.deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
In-Reply-To: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
References: <cover.1617674639.git.deborahbrouwer3563@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a space before the binary operator "|" to comply with kernel coding
style.  Identified by checkpatch.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index ad9ea05504db..116cb812dcb9 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -368,7 +368,7 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 							0xffff0000));
 
 	/* urb length in cmd_dw1 */
-	pcmd_hdr->cmd_dw1 = cpu_to_le32((pxmitbuf->aggr_nr & 0xff)|
+	pcmd_hdr->cmd_dw1 = cpu_to_le32((pxmitbuf->aggr_nr & 0xff) |
 					((total_length + TXDESC_SIZE) << 16));
 	pxmitframe->last[0] = 1;
 	pxmitframe->bpending[0] = false;
-- 
2.17.1

