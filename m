Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60BE314C12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBIJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbhBIJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:46:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406EC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 01:45:30 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e17so914345ljl.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZp1dVLkIeux9Nv08C/jazpBGe6lhi4xYwkYq47447U=;
        b=EvzwZr+sLMLPkvb6CWFa5w2TZ3BbtM0M0/BlIO+oWsOUVBnERLh4Np18tIhHHhxr16
         sNFJvrj7jA+1TNchkK6+zHw49mnVKu36vPhkGZLbbQ8uWrPg+V3i8QVpDYOfV1dgwuoM
         OfioAjNHgIUd3ImfI1YTChhbZj6tgk5tT0ywyqWtVpw6fwI06WVPmj7gdhwnXeszW+o4
         f/dq+HAPAHZ3kxhKHFOhvbBEFSmX1Mw8QHikYoH8ViPEyno1BykWGq1D5eZBFiVDn8ej
         bDyNCw/wA4JEEO8L4da+SxMD71F46SI468JLtA1PKhRleZ5kDourIaDBS/uGPBoameGa
         BW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZp1dVLkIeux9Nv08C/jazpBGe6lhi4xYwkYq47447U=;
        b=ropD1jqIIad38jM66SD0q3vJUo+wS7dUaJB02skNaqHzPmaLW2LKefvQOo85dvsKgg
         L53iXkga1gOTmlMvrH1S/DUNqAdRUDEeJj4keYStzgK6aHbddwNxICiU2eRBUdCWrJ5S
         TYdDptH7ykP9ZDtYyQ4NIyI3wKcKvI8lgMxmynMvVZQC3A+OMSE+krDnum5b5bfBOyp4
         pn2J3i/SEhSpfkGt94lo0sfPT/P2yVG2J6e8awXTbkEG0M9r+W2m4jis49L7qgl9Bm0D
         mDnoJUQ38WeifLjfQe5BnVPEuP58ijc4V+2LMI7uVsw97jl48cngEkk+X04PKWREBsN/
         6zGw==
X-Gm-Message-State: AOAM531zpqHtZ75d3vQaKZ78Be7P8uBHzivRELMvaeqQ/yEGayuvPiLE
        W1Iy1OFo1y8Njwcesqh3DxU=
X-Google-Smtp-Source: ABdhPJx3dFHb+DM+yb90TIvB0Czh41yS1Ze9oe81WvjX3S036uTI1qIpxRL4iqRXd6pMjmFarI1aCg==
X-Received: by 2002:a2e:9c93:: with SMTP id x19mr14362091lji.351.1612863928939;
        Tue, 09 Feb 2021 01:45:28 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.228])
        by smtp.googlemail.com with ESMTPSA id m9sm2448604lfl.63.2021.02.09.01.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 01:45:28 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     alex.dewar90@gmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: [PATCH v3] drivers/misc/vmw_vmci: restrict too big queue size in
Date:   Tue,  9 Feb 2021 15:45:25 +0600
Message-Id: <20210209094525.2099687-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a10296cf-4545-c7f3-1d3c-31fbd05c3f6c@gmail.com>
References: <a10296cf-4545-c7f3-1d3c-31fbd05c3f6c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
> when num_pages is 0x100001, giving queue_size + queue_page_size
> bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
> condition.
>
> queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.
>
Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>>> As this is controllable by userspace, you just provided a way to flood
>>> the kernel logs.
>>>
>>> Please make this a dev_dbg() call instead, if you really want to see it.
>>> Otherwise just return NULL, no need to report anything, right?
>> Thanks, removed pr_warn().

>Looks like you forgot to take out the opening brace.

Cringe moment. Sorry, should've checked it properly first.

v3: Removed opening brace.
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index ea16df73cde0..024dcdbd9d01 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -537,7 +537,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
 
 	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
 
-	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
+	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE)
 		return NULL;
 
 	queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
-- 
2.25.1

