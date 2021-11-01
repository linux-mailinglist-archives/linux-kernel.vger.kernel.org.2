Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC344195C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhKAKG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhKAKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:06:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA6C0431A1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 02:38:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v20so11165672plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBWzc0+NeQrbSJTD0O+NF+bRzjwkf+Is1EvNPBX7xt8=;
        b=RwzEvxArdInduzZ6igkyKQ/QBTZwwyGw7XuiLzSe40gMmLLxHUdJGH/jCTleTIrY1S
         bMpq7HCwmcANkwRkyVBn1E9WpsAhRuJXiLoo8mmfYUc0iXGz5lwie1ggBZnex8HOV7eo
         vZdX+gDsd2wX7Wavvn9gpwK/ZohTm/ECMYGv83i9dRn5CgYwMNhNU0k7QoKqkh6A4ksI
         BpvRS1TN/uWF6KG0X1ZVmo0D0nWDKUdwkZcbhKJtuB+7fVY0PpnEMfMU0CHCJVk37z/P
         m+Ol9odxQ43Z/3D6jvvqsaufk9mbHTBSdXhDzXTVM2zDkWCmm1qaDbyZYlrbuDQFEQmk
         0UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBWzc0+NeQrbSJTD0O+NF+bRzjwkf+Is1EvNPBX7xt8=;
        b=CoQGCjaS96WjjhFt06VWzFWd4nblaJ2rRXcOZA419iRIMoAoMtwVISilSsTQ3blgq2
         Psw4EFoEir60XzR4cknD1jp2/FVieCspYB4PA1a39ca+zPa7eJ1kuYaG8Mxo9Bnf1t/n
         G1k3sQZITBaVylA8zJg3cBg+/QmzHufJZPxb+GB7oBeLkV+WGnOQ5/ytviwIN5u2Axys
         xOWVm7wgZScQ49HESICtoLQtvEpegxTxmvFDEUPDINmzNa0mwDL29V6UXhc40uHyOQE2
         MvR3VK7AT+yBfhzjM67C0CLV+84U/1A6UtDwzwYL1mV/cgXSodVr3jAR7x5c97kk1k8y
         WK5Q==
X-Gm-Message-State: AOAM531mUrLCr3inYIeVJbZPa4mJnF3oJQUcYj7sIhzsOBeTZAL+1ktt
        blQZijZm+xJA3ciu+QFaEFlw+V339j+1CWw/
X-Google-Smtp-Source: ABdhPJwTAwrmnnDj1l0O33Z6nCqsusIv0u3rVHJPs8TeMvnO7edJm01vLTyKbQJgdLdeCQeGuEn49Q==
X-Received: by 2002:a17:902:a60f:b0:141:8996:3fe with SMTP id u15-20020a170902a60f00b00141899603femr23287198plq.71.1635759482972;
        Mon, 01 Nov 2021 02:38:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id p16sm15738259pfh.97.2021.11.01.02.38.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 02:38:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] fs: proc: store PDE()->data into inode->i_private
Date:   Mon,  1 Nov 2021 17:35:15 +0800
Message-Id: <20211101093518.86845-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211101093518.86845-1-songmuchun@bytedance.com>
References: <20211101093518.86845-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDE_DATA(inode) is introduced to get user private data and hide the
layout of struct proc_dir_entry. The inode->i_private is used to do
the same thing as well. Save a copy of user private data to inode->
i_private when proc inode is allocated. This means the user also can
get their private data by inode->i_private.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/proc/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 599eb724ff2d..f84355c5a36d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -650,6 +650,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 		return NULL;
 	}
 
+	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	PROC_I(inode)->pde = de;
-- 
2.11.0

