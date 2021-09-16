Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5040EA92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbhIPTEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbhIPTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:04:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6157BC0C6CA3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:36:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w19so6670540pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eF3yoGSWauBjlP/PEtThaGKhCaV9nfWn2WtwyHMH5NA=;
        b=fQ61flgpbxr+3ScvmslX6Y6UYzBrHyw+jxLOpGznkQ26CXbogaME6z2xm8KhJSqTnn
         77lgkkMT6qVpSVnIMa9CA4IUAN0kgb27nXujFw1dSciBp8EZicTCozWpovAxRZAevT+M
         3PJgfF7BblG4eAokXOWjQ1ObtUEq1NA0DMPduSUtk/8Z6AptRA77vHC+lN+6CI0dZ7iS
         TlrJPbz77xVRa9MxLxts1RuG0yon5hKXJbxU7TTYE0S0roeX8RCMGqTTcoRHQiEheJWR
         ZtJBPpysHanNjaKBKtSZ1ZOhPjcngD+VZRRKp1jNeA1evJj3KV7+WwMeqZhIbT+A+5CN
         d3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eF3yoGSWauBjlP/PEtThaGKhCaV9nfWn2WtwyHMH5NA=;
        b=qUm8a8NVm/9v9P/b9M4vJhcNY+m5qf/gCAVtUaoppSFxAwMz0VWID3flM8Vqpi4cGO
         i3P8CcH+6HGeWKfgSnQ/jEfhRAS5ShOOznEiW/Q7Vt10ebHBoF9D2ScSNQTQwoSe37Zm
         4bqYb6ndO/pDQ8PFf08vnhWj5VtBLb8R0nRuvmHFI+LfC39t9y9zZ8hlGjKfrcQdlu7K
         d7d/6VXX25RjpjvsHUGTGGBtcRkUs4ohBLXQqnIT10CeJ2QguKbft2E9s5xDcMz65acB
         ICExduMow9fnIvI3CUQTyvuTpdLNx0bAVgdprPkBtW5QR2+LjeYpOqmNXxfPteLpkIzM
         rB2g==
X-Gm-Message-State: AOAM531cIMJn06SOENAtV6kjjeaYFK9MY1IZuSND60gNiCIN9PKofmC0
        QNpFpSHYY0Vu0ULfNyHHi+f0yJRuvHEbOw==
X-Google-Smtp-Source: ABdhPJwLJjgKEcXSC9TA+AobePDdZy/P1mekisB/+SUfd6z0VLYVgxBHgOvJIavtKHhdqdSbJdImwA==
X-Received: by 2002:a65:5643:: with SMTP id m3mr6176916pgs.224.1631817418780;
        Thu, 16 Sep 2021 11:36:58 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t14sm3895421pga.62.2021.09.16.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:36:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQwFk-001qrZ-OF; Thu, 16 Sep 2021 15:36:56 -0300
Date:   Thu, 16 Sep 2021 15:36:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: INFO: task hung in _destroy_id
Message-ID: <20210916183656.GS3544071@ziepe.ca>
References: <CACkBjsYvt46E2WqeJwEuemUr7pST_uk3=wvEBmdtdiAPmG40vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsYvt46E2WqeJwEuemUr7pST_uk3=wvEBmdtdiAPmG40vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 03:44:54PM +0800, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 9e9fb7655ed58-Merge tag 'net-next-5.15'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/19ZvzEBJnFYlQJIn-TklSjE9ZWsxoEF7X/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1zgxbwaYkrM26KEmJ-5sUZX57gfXtRrwA/view?usp=sharing
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>

I think this is probably fixed by this:

https://lore.kernel.org/r/20210913093344.17230-1-thomas.liu@ucloud.cn

Jason
