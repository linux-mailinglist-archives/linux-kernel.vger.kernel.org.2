Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A6378DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349487AbhEJMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241888AbhEJLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:38:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0EC08C5C7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:34:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b21so9018952plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o+f9a7HMFJ55y8AIpWcrvNsNM39Ng0BmUmgrvoaJzqI=;
        b=u+fxpze6Mo+rwHgO6FpHT6Ozg8BpEK82dGDkkGsOjT34/+pVpso2jhVutq0eIAYKGc
         qO2HR7Hcc8TQf45skxq7MUTVL/w0w/CEp23C9N/ogGiv6/AS6aUrDQlaR9wfClGiED6p
         PE80225UH2tU62r88DlQU7jLE3rwgvDKUbaKcu36iBXxmKSnQOZ1oUd5n0nJJJDm61q7
         L7H29GgrdB9SOVJSJb7G3orO8svqWrFRWc8DGipq29mede7QfPBbL/Ny9JVYLyFrr6Ux
         +xtEk0FHdwZLFAi39jdjG3SdtXLT673/Dq3bsWzNscENrpc1rIxNlwrwDK29ySO3ygZA
         yOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+f9a7HMFJ55y8AIpWcrvNsNM39Ng0BmUmgrvoaJzqI=;
        b=t7v9HNEMCPP9eJxCXyaRzIqQKeYdYezjz/m+pKYmkHIqvxWZ/j574tmUh5vMkwazfV
         ChOqE7cUt9Or7b+tdz7BREVtC22/5sS9eTJSO/sZl6WQNoJBqu3CtsaGQ3BH7LtF/Fnj
         ldHJL9L1LHcIxOeWSeKUHuxN08y92zcwRo21tKxowrFK/pgotwg9hJcWxVJjUf1JxwOD
         QZLt5nhWZH9af8RaxqQBJc4ERiwDn073y00UwtB1PrFI/pzPtG9OREwHLkF7K21gLHr7
         itLsAHgZFASbblJ091MWPsCtsxohWZoPjwtTaCFALvXoXZFg+b+SYbgqaN/HtGIbUg/o
         lZ6A==
X-Gm-Message-State: AOAM532C1mnNfQYh56Zv5XREBlPdaCwHA2RiRimiF5R4zIrVUVrCxSKQ
        dOlTMklyp7EY6ZEpL1LBxyo=
X-Google-Smtp-Source: ABdhPJyynfSy3A2UGv8hhpgb3u+jqjdyxw74mGW7DHNI+z0/nukUChDs2vZF6FV21whq6e6MoexYVQ==
X-Received: by 2002:a17:90a:5511:: with SMTP id b17mr39531374pji.41.1620646466399;
        Mon, 10 May 2021 04:34:26 -0700 (PDT)
Received: from ojas ([122.177.206.92])
        by smtp.gmail.com with ESMTPSA id f187sm7533726pgc.94.2021.05.10.04.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:34:26 -0700 (PDT)
Date:   Mon, 10 May 2021 17:04:17 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, ojaswin98@gmail.com,
        gregkh@linuxfoundation.org, atulgopinathan@gmail.com,
        yashsri421@gmail.com
Subject: [PATCH 2/3] staging: rtl8192e: Add identifier name to function
 definition
Message-ID: <d856d9f22777524f5c10bddb7f7930d97e58c20b.1620642396.git.ojaswin98@gmail.com>
References: <cover.1620642396.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620642396.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following checkpatch.pl warnings:

- WARNING: function definition argument 'struct net_device *' should also
    have an identifier name
  FILE: ./rtl8192e/rtl8192e/rtl_core.h:572:

- WARNING: function definition argument 'struct net_device *' should also
    have an identifier name
  FILE: ./rtl8192e/rtl8192e/rtl_core.h:573:

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 736f1a824cd2..698552a92100 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -569,8 +569,8 @@ void rtl92e_writel(struct net_device *dev, int x, u32 y);
 
 void force_pci_posting(struct net_device *dev);
 
-void rtl92e_rx_enable(struct net_device *);
-void rtl92e_tx_enable(struct net_device *);
+void rtl92e_rx_enable(struct net_device *dev);
+void rtl92e_tx_enable(struct net_device *dev);
 
 void rtl92e_hw_sleep_wq(void *data);
 void rtl92e_commit(struct net_device *dev);
-- 
2.25.1

