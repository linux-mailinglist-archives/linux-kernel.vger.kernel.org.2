Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330613B5E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhF1Mhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhF1Mhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:37:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BA7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:35:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q4so17070761ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4cWCmiDmq2f7gAA0xos0gUPIaEGtZleOLH3TntBbjU=;
        b=hNXeh7nZH0tYje8UHbWOl9pCANcbvnisVkD3HC3/SSju9adfXxY09laZVxCXe2rBer
         woHbUYrAB5t48FfkqlO5flfTsYpteDH58VduuLVfKAFdVnQoGhT794hGVvEXuicmBu4H
         HgR7BMC5ULaF3RdDM0YoC1gG8ESOJba1pvcNKZoI0KczsoZFqQDAOxZ5NaP7QgQRSNfB
         LDVBTZpKO6o8TDPow9pPSYxxXqHtjjBmc+OJ5SLF2LVunV5GDw5kCoL1gUgBK3XMyKcA
         rShKFeL+hWfr0t7M0+BoSjzFh5At11CoOUBpn5SWgXL4L5AfuhBTzWyAzfu9xSHBuWCA
         8EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b4cWCmiDmq2f7gAA0xos0gUPIaEGtZleOLH3TntBbjU=;
        b=fVmFrUK+qG8dOcwR5Y669x0R2jsmR1qfTcrXGNEVgpi5UrRA4F1w5XxCQB5Hdsi/xw
         Vwg3+A/6WN89W9rNLprYY5eYtITqGfQ3TbTclutmJYuCZMMfx3YfC3likLeReHRlgWSK
         3EkleY0Sgxv6+dRim9CdGyrIvo1DuTzj6aS77gvpDe+YGCmWznN2t/tDeVtrXpCO9p6q
         JvtTUfujQKj26jLlUhCgI5v3g3dgi185OsvM762LQWZ3cKl7P+kMwsB6Fh4+DFPJ45NA
         cicdEogkFPOyt5Bbjp+H3Lswd/0m1UkO2JE91DDPKORjJ1WKZIxhwkg6SD7eYQvY7IBz
         MNuw==
X-Gm-Message-State: AOAM531GfvnMjH8cehG0YrAkf4+XRlDNVwTghvTdeGQ2IH1POUB1sod6
        kWMHJFjUEtBUxXhPCXx4rmq2bQ==
X-Google-Smtp-Source: ABdhPJyGtljRlnH949VrIi90DObhw8FvDOwb37VkxKqAmbo2VV7b/5j6NJ3N9DkrAUy1cQrcKrs1HQ==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr19944241lji.327.1624883709620;
        Mon, 28 Jun 2021 05:35:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n20sm1302356lfu.206.2021.06.28.05.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:35:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 69CA910280E; Mon, 28 Jun 2021 15:35:08 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:35:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 01/33] mm: Convert get_page_unless_zero() to return
 bool
Message-ID: <20210628123508.bckqc72hrnpuyip4@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:40:46PM +0100, Matthew Wilcox (Oracle) wrote:
> atomic_add_unless() returns bool, so remove the widening casts to int
> in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
> to produce slightly larger code in isolate_migratepages_block(), but
> it's not clear that it's worse code.  Net +19 bytes of text.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
