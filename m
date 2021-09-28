Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75A841B7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbhI1UGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbhI1UGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:06:49 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F9C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:05:09 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id o15so87810qvq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
        b=mXg4nC/0EIy5mcGZgRBdVGh4+PtQ/R7qKfJdIHvckLXvlCgA6RG20VZtoVAC7XwA0/
         1Q9jV1hRPeuiqNHTfiF2xEDf/GmdCrABm9VW4FZUzunFeWsbqWbu0OIpkB0K7pTzfgbd
         6AZsXvNDXNRBaOqQHwB6uloUHcpht9y8ZbZWcpcNkXzVJmyDxhAzyVOeTC4gm52ORmXN
         mB9dfyB6upC6rckPem/56kkVq6mMDb0monvwsJpjKud0G8lLORhrGaRbWZcJi7ULZ9Wj
         5fjO0VyJ8XxtZ4Gi+c3kBFto+M+PTYIof3BPLlQNFsws5BUO2HFuvQyKhOfpgnkZotGZ
         sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cW8g3RMiiX7YozMyBpzJQ3i0X8a1a6uo52SxjKINHuA=;
        b=qxo+qvIYqiUmAmdUI2JPI7pFiQhfu5U2ofC0eSnWKB25mCfU1yV+iaqEP5yLmtzLye
         keqkjvuUL3Vi9BxRlHuU62e8k2RXvxeR71O+vhVe8MrFbys46E18knQN6Fhv3oPTiWOK
         aizgMlGhNodeZMzdZxPLZ2fBOrfnILiRmZNy09GswyR8y8G2K0M0PiaD6t52TcdUfXM1
         JN4tYbqiWVrB4mZxmqyAqIYL78ozvirEuN19ojgXmFHt11qot46o5FixWenOf98JtfKi
         Dro1C3fD4+grRkDKt5iw5aN0Ad3YkVei+awKQh4OoPgTk7pfk4OQIzVnE3DQDjQAp9h7
         uq9g==
X-Gm-Message-State: AOAM533T86YaEEJQa8bLqmkN8hUQKWHuQbAHTvZQLIaSPrxEtbv/HTya
        2DVCKv+gAqUWsitCJLBrRrmb/w==
X-Google-Smtp-Source: ABdhPJzKbJYaBmt9+b2JfarRag3/wc7athe6CPjiFKF1JovwH1BSJxbPc5yOuJ/qnsZmJUt2zTx5pQ==
X-Received: by 2002:a0c:9043:: with SMTP id o61mr7850968qvo.54.1632859508704;
        Tue, 28 Sep 2021 13:05:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x125sm118440qkd.8.2021.09.28.13.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:05:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJLe-007GuE-T8; Tue, 28 Sep 2021 17:05:06 -0300
Date:   Tue, 28 Sep 2021 17:05:06 -0300
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210928200506.GX3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:

> +static void pci_p2pdma_unmap_mappings(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> +
> +	p2pdma->active = false;
> +	synchronize_rcu();
> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> +}

If this is going to rely on unmap_mapping_range then GUP should also
reject this memory for FOLL_LONGTERM..

What along this control flow:

> +       error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> +                                        pdev);

Waits for all the page refcounts to go to zero?

Jason
