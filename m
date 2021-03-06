Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3DD32F7FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCFDQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCFDP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:15:59 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C961C061761
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:15:56 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e2so3897289ilu.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 19:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siv8ALjvw5nAWM5oVnlAOXA/08MIyz7olXglWGx22ko=;
        b=VaG23pAj8JOs+CT9cgwwHYOa0+JEos2V4LSaNc5NiboFIMDa6NIW9Njr6Tic3vZQj+
         ud1QGV7C0CUFhgk02O9V5sxvLl/z0WlZTFmlf3XSZSWP1al4lrQ19CtsK+hSNUQt9TwH
         wbLpSKexzyuafiBtRYNJ56LIR0XrwTjVoi0hL4h0rJBV47Tl/T5j9J4FLq6uRy/+tfv1
         krPb9Tq36Ab2hg+kvq8h0gYWZlr2NibtRnil57rpD3fGeeZxDlqJNAYQ54NWFPiVKfe/
         frZjcpfTVaga8Inw+np2mr/ngDYqMS4I+lT2MUxb3r/xtu8TA0M+s7rOXOFDzk/1AjJ0
         bcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siv8ALjvw5nAWM5oVnlAOXA/08MIyz7olXglWGx22ko=;
        b=Y9WqTPWDPt/OTnHjk4m/tRkWTx36fAUWxw67coylQ4ot03pMAjLrnTISg3Y+xVtYmc
         2n4NIbvs97eWYzXc0MJ8m72IpwbdABaL9C9YmI8J5BKYucmk7n6EN/vg7WHuaQ5YzPOk
         g8T4Rm3iJDwj/rlaM29d4fha+QomTJ+ub5gBnfUZCC86Dtg3ZrR/GMVaBZDUmj8AEW7Q
         hSqj/cuUE6xnHDs9J1bHURgf8Dm5uDvaP4n6oCmeC/e6jOMvko8mattpupk4b3+sHcvU
         JtSUNsATDyqmcaGNut5l9do4gpuWgfgZEnzlc/Jsw6+gsKQ0mMJcabCxayIHBkq2R2Z5
         gJHw==
X-Gm-Message-State: AOAM53277qIbQJzAL7MBdRZ4r6JjdUq1QhObRDRADyoROY0UlrUz//90
        Uah+9r8MuG53NWbgGHA9S6GAqQ==
X-Google-Smtp-Source: ABdhPJxMzN0vbK6J5eK3Cwe+/FK1dnkQHHyTMC2tDezE3WTyipmZ4eIno0DFINaIds83nvoMQxNwFg==
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr11802891ilk.209.1615000555738;
        Fri, 05 Mar 2021 19:15:55 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id i67sm2278693ioa.3.2021.03.05.19.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 19:15:55 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/6] net: qualcomm: rmnet: mark trailer field endianness
Date:   Fri,  5 Mar 2021 21:15:45 -0600
Message-Id: <20210306031550.26530-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210306031550.26530-1-elder@linaro.org>
References: <20210306031550.26530-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields in the checksum trailer structure used for QMAP protocol
RX packets are all big-endian format, so define them that way.

It turns out these fields are never actually used by the RMNet code.
The start offset is always assumed to be zero, and the length is
taken from the other packet headers.  So making these fields
explicitly big endian has no effect on the behavior of the code.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 include/linux/if_rmnet.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 9661416a9bb47..8c7845baf3837 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -32,8 +32,8 @@ struct rmnet_map_dl_csum_trailer {
 #else
 #error	"Please fix <asm/byteorder.h>"
 #endif
-	u16 csum_start_offset;
-	u16 csum_length;
+	__be16 csum_start_offset;
+	__be16 csum_length;
 	__be16 csum_value;
 } __aligned(1);
 
-- 
2.27.0

