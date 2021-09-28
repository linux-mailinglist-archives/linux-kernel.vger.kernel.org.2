Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67A741B7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbhI1Tsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242529AbhI1Tst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:48:49 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6341BC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:47:09 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i132so42115355qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
        b=EO1kDwzeZuMv1jUFt2pmKX8GvyZQAUMBJiLy1x1SVytxwcplVnv2ywT1ffuJvbGzDe
         SqreChLnqXdZ3bmpOGx1lq6jv+yPr/cOeERvwxCekQ+2pAL/hPpshqhIf/ZGdT33EAIM
         lOon8sIgHYjE/rwWroGijsvQ3Sfl16uYtuTJKv69ByO+2IJKaQCkRs4E+itlOn/VuGnJ
         ObcFwFaFhFQuJrFju9q8374g29cj0NSSZZgWhx88Ckt7Rqd+521BC3qoxSNjSsHzeMSW
         tdbGfXJrW/lc1jL/isk876EABn7Hc3z0lVBV5inoZjNRJpGnlQE9c49iUQf8C8yixnTL
         5Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
        b=EX7gjz3VzkNrRPnVf/nFQN61Icl67WV5LsGj3renixyZbkuFmxAq0aT8xv/xsV4Mq7
         m0OCqqgXBBsRdgL4LoWbsmuIAD1FHMkrMjIQuCp/M6yVhNNWLP3oS+sN07weRgmZHzHj
         VFVCx8NyKXBeygk6gAoPQHa/wi8R7vSZZyvL+Z1nFcuXzKzkPzeVa2VBQGNcjPtIYAfC
         YMMcSlMz/mg/vR/InRKIUvW1lwhyegCuDg1L1sdnzFizM/cG9gYAl1JIEjnWYUNfYxV4
         MO0/iJ33fpGyzjqL5bbrAJVLay5+bwTWouyvAu7ZC2BKxSoqsP0iyR8Ho56oyhEO7xZF
         KwoQ==
X-Gm-Message-State: AOAM5324JGHugzwb55w4UvKYOG7e4gw63yxGqOVGgmPYgqRlDb4bZ4r2
        GroS1bQJKzB2act4lgQ7dbsMdg==
X-Google-Smtp-Source: ABdhPJxxZpC5AepjHCbAmIQaz4Zogx1HRof8bzNZRXH/My30paIzwcLwvreCcb7Df5Gio9BelRE2TQ==
X-Received: by 2002:a37:8242:: with SMTP id e63mr1886625qkd.294.1632858428465;
        Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d14sm79297qkg.49.2021.09.28.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJ4F-007GbK-31; Tue, 28 Sep 2021 16:47:07 -0300
Date:   Tue, 28 Sep 2021 16:47:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210928194707.GU3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-15-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If a caller does not set this flag
> and tries to map P2PDMA pages it will fail.
> 
> This is implemented by adding a flag and a check to get_dev_pagemap().

I would like to see the get_dev_pagemap() deleted from GUP in the
first place.

Why isn't this just a simple check of the page->pgmap type after
acquiring a valid page reference? See my prior note

Jason
