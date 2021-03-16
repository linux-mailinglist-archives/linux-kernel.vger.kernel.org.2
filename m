Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD75333D791
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbhCPPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbhCPPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:32:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8EAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4030548wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fbhvIGnCMuZh+oOiKyd2X4ban09eYtOYnrdH/9nbbZM=;
        b=Tbk40TlS62DwaE6EvfTOODLCAnNH49T9slNVOQxvRDvGvApoGIbgjZ7M650QTrJK8y
         IiFtWB6P1bu9c8e1spndMlE782kkHW293Huci1PYvxFBA0kHk3j8LP8CdJBlGrrodf30
         WIKk+S4kHU9l0tdB3bzHURTQ62lq5PPirsQGTFlgR5OATcrV+NpjtnLzMOTf6xT7WweT
         MIUwuiBolvTQRl+/uKVqYQdDpc61PyR0vqWi6Nm4gvP6TTlYme7oyzktnh2wh0aP94Nq
         1L0lB7eONEG+b947LOizaYGXMZ1RD9WqhFmTMlPDz8p6EVhQSBBTsBuKbnuLjQ98YbBd
         Aj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fbhvIGnCMuZh+oOiKyd2X4ban09eYtOYnrdH/9nbbZM=;
        b=A/ZBvkLIlXXxgqXw6FwcgU0ZM6BBxur7t8W5JbJ/Ifcr2VrFP8eA8h6KgEJgwo7bT9
         1nskFp0epSiyAK0wCtZ4RTYcm8kWyhzdsCa8lKgICVFKKCMb+6ZishzbFevqGVdxasGC
         PVyg7IeLUNlLRluPND+n6i85zI8mOQXzJn87G4yNoW+N11g3zioI/xiqu4YfOKyxyv14
         aq/1fw1v15wU2oOCZeVF/2glGoeI0BhR0EfgqfLbU74I0e5+fghH3sGLR1OOMiV1S9BL
         Va3Y4MCQui23Gk1SlA2JL0ZcYI3H5fmJkBLvvUYmAKlhK2RXXNRwrRwzLuOZS1OxIDW1
         pjJQ==
X-Gm-Message-State: AOAM530JXahd0JCdj55gLDdhiiEyQBBw2tsQ3VCM141jk5TAYvgxx6im
        1wpdS5iEDjvKumUuiKkcF+Y=
X-Google-Smtp-Source: ABdhPJwZmUPnBi5HzR+A0RTMjPFOue1Y6/YS+fXQ8XiNZdOQjY4npSYWinh3DmjX80+G8SWnzXFa8Q==
X-Received: by 2002:a1c:195:: with SMTP id 143mr192505wmb.147.1615908753138;
        Tue, 16 Mar 2021 08:32:33 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id j136sm3525932wmj.35.2021.03.16.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:32:32 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:32:30 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_RX_INDICATE_QUEUE
Message-ID: <0f677a975f92b38f6ad1ff21c1006855a075692b.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_RX_INDICATE_QUEUE

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_recv.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index acd7a7714740..3443cb7d0467 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -226,10 +226,6 @@ struct recv_priv {
 	struct tasklet_struct recv_tasklet;
 	struct sk_buff_head free_recv_skb_queue;
 	struct sk_buff_head rx_skb_queue;
-#ifdef CONFIG_RX_INDICATE_QUEUE
-	struct task rx_indicate_tasklet;
-	struct ifqueue rx_indicate_queue;
-#endif	/*  CONFIG_RX_INDICATE_QUEUE */
 
 	u8 *pallocated_recv_buf;
 	u8 *precv_buf;    /*  4 alignment */
-- 
2.20.1

