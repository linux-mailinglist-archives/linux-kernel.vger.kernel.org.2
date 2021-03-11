Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5E337CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCKSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKSjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:39:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:39:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a24so10634197plm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYY6d9PSDzvIH02G62MWvpqx6n+qNTtjRVrsYtpc2sg=;
        b=GV8o93zD4C7bupA+RFkzig+B9IpHlk5Pu43LlC8v/UDHZoEVe9o5U2GZ/5tiiS3YwW
         bnmGcAWeFpJjFmizrc2t7MDgj9jDR/wXHkaokEF/rNrv3epnONlave3C2kTDvooRS279
         GEhDjDHHF7yqcV2j5iPZp3U+gcxSxB96gt56iPSo/F04TuIdeCO3Blt1CVB1bINuyZ97
         rfbfz+6AlxvLhojp8rLHYj/iJWB0Jj+H9vxEEK6Vm0dvOGv4KBffTAhd5y4Hs5CRhojI
         w7IXWvWkh9iJiGrDbZqefQdic+rQf4Ei0ee7+U+PHbn2Uz7ivxt4nLhQVxQJnxJHqLqb
         IRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nYY6d9PSDzvIH02G62MWvpqx6n+qNTtjRVrsYtpc2sg=;
        b=ODGNmBQcnDqnctAvstk/4Vt9tM807OPpGwcuN6Uc3qf0fiyjhllOTBRt5oY9SC7EmI
         oJyGxOZ77ZW2NDv9CwC2XE5nwOkFc2N1/E6KLBrOzhdaVw3o3FQpLvfCBiCdPXNgANiZ
         iPET9nShzgbzv0bJtC6aiy7L0KYm+tMYEgVAItVNWsNOnFm5JoQYTFUuuTLvL0+uYH+W
         PbFNxkKLVyTbLdHpmKRAIvrq/bOPtaHHaGKfzyNmMDpzz63r5vKCdYdQFyN3426oilcR
         yxRkLqtYZhow0XHkeOKqmFf6mbSrAnq6V78dD35ywRrzQHgv0AHH+TRWMyWU0Vu4zlYo
         ilYg==
X-Gm-Message-State: AOAM532qVWU5X4pu9QFd4t9uXI9eLpyCqw/5lbvKRFXO0iYMXBfPnkVz
        +qQ3sbmtunVM66NrALq+imf3GCHww30=
X-Google-Smtp-Source: ABdhPJz4M13YGr4sOW7pFt2j72+egGZ4VcAG0ex87KdovCtNJKExxggEd1xyJyUdswcnn4O9lH9r4Q==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id fr10mr10103075pjb.154.1615487947295;
        Thu, 11 Mar 2021 10:39:07 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id z27sm1890095pff.111.2021.03.11.10.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:39:06 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 11 Mar 2021 10:39:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cma: Use pr_err_ratelimited for CMA warning
Message-ID: <YEpjyBLJfdiOHnKf@google.com>
References: <ce2251ef49e1727a9a40531d1996660b05462bd2.1615279825.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2251ef49e1727a9a40531d1996660b05462bd2.1615279825.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 05:16:06PM +0800, Baolin Wang wrote:
> If we did not reserve extra CMA memory, the log buffer can be
> easily filled up by CMA failure warning when the devices calling
> dmam_alloc_coherent() to alloc DMA memory. Thus we can use
> pr_err_ratelimited() instead to reduce the duplicate CMA warning.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Minchan Kim <minchan@kernel.org>
