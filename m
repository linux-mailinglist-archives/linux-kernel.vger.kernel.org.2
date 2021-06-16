Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB03A997F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhFPLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhFPLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:47:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61312C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:45:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 131so3412756ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtd/r4kQdNTFgMzEtuMDxRln8AeazBFMNuFE+IwxLQ0=;
        b=tM9YyD9dbmrU6QAIak9v1L1Hze3NeFQPPNBEtD4omgZjEyhQcUg1q3wkLUmDpwXXOT
         6u+FMb976YVcaypY+NkjNsra9tUi2NzMsuaXdS253tuTX+l569fNkUgrvOzggDbWTp8W
         ENky2qq1vTSb11/DZgVTmvzbf9N+SWxrHqqLmE895cQUdLDT00v5gJHuqst+RLC6DELx
         AZubyEXZLMybvYei/eZAvnHzFQnU3mWT2NbfPe9zTz+GpRTN5egfyB5q61LhPml0mNjt
         9xsP8j3AJPQS9llNh712rLD/eGmKOg1uNQpb4kiRypPtttLcmaoFcMAzMHxwwR+iDCTV
         h9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtd/r4kQdNTFgMzEtuMDxRln8AeazBFMNuFE+IwxLQ0=;
        b=KuDWhtTGygAQITnY24uA8y4P/W58N3fhLWzsWIPjHmS58RSF76yKLixHtxsNCHGyLm
         2Ei1KEhKE+Clfiq28ioNifpSFAd9ukbGlCCCq5L10UgBKHWTmWZaXnCmrZuA4/W0kcks
         W+MI2E3XIEzpBV3XAalw4Okcnho2FO1sXry+8usLS7DKDtDlFiOxwbnKOkgTwXn4jEoS
         UXHGw+7egyYiChcnXyAGCDqqFEm12SVoexqy0RiCjEAK83n8IkjYUXFOST5IB+rnewPd
         Neq8D/e6ONGBnlFR5b+JQsoj8Csbvsh4BI+5YA7vb306FdJ2OM3D7s0FyvLCtH9hETyC
         HhVQ==
X-Gm-Message-State: AOAM5300BHpjS3n50kNjqRvXLyi4R4MjQ9/YVknMEPiCUvUYl+PWCQQv
        HvQoWVJW4tun3qX0SRRuznO81L/OUCio74uXtwU=
X-Google-Smtp-Source: ABdhPJzI40Mx409ixL6A8VaGSABYZuuy5E1EPuBErhnFhAQBqUvi8LwmZwSBohmrfaadIq0f8nBwGp02vfH8jjD6rDc=
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr2735729ljo.497.1623843942771;
 Wed, 16 Jun 2021 04:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210611095528.9230-1-roman_skakun@epam.com> <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <CADu_u-MqALJkG8RJHrr65vC_sHu-UyvCGwwUfaBong0eir5+hQ@mail.gmail.com> <fbaeaad5-ea8a-ff2d-2e62-d27b4d234e8e@oracle.com>
In-Reply-To: <fbaeaad5-ea8a-ff2d-2e62-d27b4d234e8e@oracle.com>
From:   Roman Skakun <rm.skakun@gmail.com>
Date:   Wed, 16 Jun 2021 14:45:32 +0300
Message-ID: <CADu_u-MgdJYH-sf57AL_Fg3AnjpHoZ1Bk1nxytmoupJc=hJDfw@mail.gmail.com>
Subject: Re: [PATCH] swiotlb-xen: override common mmap and get_sgtable dma ops
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We make sure that we allocate contiguous memory in xen_swiotlb_alloc_coherent().

I understood.
Thanks!

-- 
Best Regards, Roman.
