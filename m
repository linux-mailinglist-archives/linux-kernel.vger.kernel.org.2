Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80685345BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCWKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCWKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:20:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 03:20:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b14so12555502lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BB6iDk9UpBGmPGbu+ghUyjEA1Kda/UN3SpCDghH0B5c=;
        b=WomPoPdoW5GOsKYyT430+r/mSiWfj945nqa4iqLouEQsrrU7Xh/F0zEJ0HIJ7wIooh
         YKIO/jEX8O0nfWYdpkxm43FNb86d4vK5g63L5KOjF1RoN/sP9Mh9GDrmj/iYzm6fhU2V
         fmvjkfvz+qmB6Gdl565Xl08zyQ48GXFvrI4d4djUejBFDB6+3wF5j7kJTUwe8ickvnN6
         3U/mpp3u4uc/jBtGCueTEAsJLt3GKdqd5yJzRtJIZOG+iHzQbnMS0002HEnhNtgKq/fu
         DYGzpuU+H37Ak0v8QeIyjg0MmzPh14c2aIebaRHryMViUdE7dqd6CQ0xMSVXCkiVF9jP
         6kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BB6iDk9UpBGmPGbu+ghUyjEA1Kda/UN3SpCDghH0B5c=;
        b=bfIwSxB7lIIylbI5TtvKE9ctvhl4Z+iLllJMmuIxU5qC0MwRhEnEkEntDZAJIaU9VK
         JTB+y6wnAx/9SxVMEwNf18B2ua/p6Np6f+3RdNuASQG6uz/YvLMqIf80AymAYRoeaio2
         Ha8wGteUGl2oDUFexQT3WQnwh4tUiMWLS0qNaNEaBsH3WmqhpLGCfS+/DltH/Syyj492
         dXjzxEcs4wqggCko5AB68bU4VHFfDMZlOPwOssQ6KlBE2eUpOwAhBP0aage+Q8rzRqWY
         I1tu4yY8kQ0FiOW5WZ4I2h7S2oQ/dTxeEwVP19utcT1iJylMp66XefApH8C4Ye9CnvZ9
         M5Wg==
X-Gm-Message-State: AOAM5329CLfcSrjesdViy1egPcYXASjAKt5bChaf16cB2+lGO6gtwunp
        5XVf/kgV0cTZmi9Lj2yzHHdm2Yq/C1+u+w==
X-Google-Smtp-Source: ABdhPJzgdFUDyokcBKwzML4HMu8jaFZVB8pi1e3dYerLEXLqSrQQr03ps8Vrsal3Ci0SWIcQ5svd/A==
X-Received: by 2002:a19:23c7:: with SMTP id j190mr2200690lfj.148.1616494854448;
        Tue, 23 Mar 2021 03:20:54 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z1sm2253926ljh.29.2021.03.23.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 03:20:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D1B6F101A1C; Tue, 23 Mar 2021 13:21:01 +0300 (+03)
Date:   Tue, 23 Mar 2021 13:21:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     yanfei.xu@windriver.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] khugepaged: Raplace barrier() with READ_ONCE() for a
 selective variable
Message-ID: <20210323102101.tvlgbijpy37hclgj@box>
References: <20210323092730.247583-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323092730.247583-1-yanfei.xu@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 05:27:30PM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> READ_ONCE() is more selective and lightweight. It is more appropriate that
> using a READ_ONCE() for the certain variable to prevent the compiler from
> reordering.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
