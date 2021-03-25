Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18083349436
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCYOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhCYOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:34:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:34:21 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l13so1756365qtu.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBYoeSyDCelHfJ08uskYOli02Uf/rlFwmOTlzuC7hgI=;
        b=N+fdDxgVQQYMaT/p6QFW+V+ir33fgy01dD+fxi2S7KZNbrlN0AKe9IlL/J1vJWeJnz
         hDQZQOIunjFFjO8/Jo+aGOaXBeoSrUgkbdCqiGfXW7noLO5+gnskrV0qxQbbRE40LJkk
         ziNgqfdxF7bKl35iD7YXDKSgmva/aIGNM+q1myQy5V9FMBTxaL17ESoplXA7WfzuR5pU
         TnaNXA2Ff4Gn7s8apv0fssxRfjCBVhYRqE21LX+Ef/XjQlA11SY/LFfjgVU+1vZ/eHZ9
         /fgdB/rMEifTJ16pYmqArjc3KG7IFBW7u6A7EEZEn8cGeucy5yC0ULc0S1+papQW7uC0
         yGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBYoeSyDCelHfJ08uskYOli02Uf/rlFwmOTlzuC7hgI=;
        b=FE6W1fvodFCPpOxzyVpccnGrRJM3pdYXwqq2jSxLCo0QUyHt0524IXUTLbfOiOOtOm
         uVBRDQnbNAP/u2WoSotGPBifQwDFK/pbUBhZdK+Zf52Pi2pQ5/yTAF8k7mexuJaLGETi
         kvXUnst6S/fteCc5PlurZAdIDf9e7O/ikC4/Ihby5LHK7dr4Q1P/gRivKInm/PC+rM5i
         WIKRrHc2NzSv6Z0ujJGPJctl7ooaSHWiEC9Na8Hy7ynlDwMcfU2jugffgqrP1InwRkd+
         ggIsG9ZeqpJhtS+bmOuXUfRn3erVfadkASRvjP5ldR874iWbsKQjLxTkUamqy+RSeYIV
         50Bw==
X-Gm-Message-State: AOAM53323RUUpxkScAvdLCfB/ySaiHVmP1mDp8N45ZArQOxUlaGz00Cz
        K0qXH5UqX9GexPy1FX5A9lw/9A==
X-Google-Smtp-Source: ABdhPJyvtuKX2zV8mCdrg2NYsULLUlLCccMHLxDM/TG/XquL4LiIlTucJUYDBbZjw339FUqKik+Tow==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr8003677qtn.387.1616682860918;
        Thu, 25 Mar 2021 07:34:20 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 73sm4206300qkk.131.2021.03.25.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:34:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lPR3z-002fmd-5a; Thu, 25 Mar 2021 11:34:19 -0300
Date:   Thu, 25 Mar 2021 11:34:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
Message-ID: <20210325143419.GK2710221@ziepe.ca>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
 <66514812-6a24-8e2e-7be5-c61e188fecc4@oracle.com>
 <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g8=kGoQiY14CDEZryb-7T1_tePnC_-21w-wTfA7fQcDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:03:06AM -0700, Dan Williams wrote:
> Yes. I still need to answer the question of whether mapping
> invalidation triggers longterm pin holders to relinquish their hold,
> but that's a problem regardless of whether gup-fast is supported or
> not.

It does not, GUP users do not interact with addres_space or mmu
notifiers

Jason
