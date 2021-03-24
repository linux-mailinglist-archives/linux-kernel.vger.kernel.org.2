Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B772346E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 01:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhCXAyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 20:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhCXAyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:54:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F723C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:54:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c17so9219231pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EfbPWafZHV8B+cMZtnKVDYJFNv040tyCmUoTNPfkBmM=;
        b=RMzd0YqTs0PKqc2JKz713ff7M4RphjrpA3SNfYRl6XifFatQwEZ2x4Entv4C2sDK9O
         /L0vqnoeYD4vKlLJyUEFrp0TP12NBXr8dxoccLxqMZpU0LhaEP3/ilzR2Tq8V2PLNYOX
         3Vp9GegzqnT+56//st+gjB/TUYRhkSPVPTV64PBdw7w/Jl7YUaIuTSw1Qvx0oPZW2hw4
         qKOXyygJP1O5VDfyE0F/S9vLscgesCjfr6bkINMxnxXPHI3cXWMklf3Anp9fvoPViXDp
         egMoVGD0BIyRPVvgj6A3Nvz36krv65OEOuF/9HBClKR4exhnbm6nr9qkvb0b0J77Si6c
         sp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=EfbPWafZHV8B+cMZtnKVDYJFNv040tyCmUoTNPfkBmM=;
        b=RRPXWET+IHIgpcUmZpN9/YZXIBdHi7Y8U13lZVzqB3rxR21h/G4lvKL6OgBQd5zF7I
         4HTxnBMqbbR/do4jfHRwa7lziy1grup5mVsG/eqFJ3a7ZS8FuHRAVYwQJnfon4XoUce6
         3cREyaNWO0iyLJOT3cqrWWwDUoAqIbqg8+LBE2kKx2j0Ubei6r3Rtbd8Skt3mRanmX2K
         kwALhhTOMOa/9v0FgqqFOwhaduMZpD1boZ7xwj2OFdENTN1B4Sv6QKRVjnl2Vpb8/Q8E
         VmwK9a+rKNPoBd2LO7JtOFDOH7SdGcvpsrkJeB/x4/MP7Hp9MzCA6P7mMTWEqtO+x1AS
         SI2A==
X-Gm-Message-State: AOAM530Xl+dlFyj4GVXBHrKWUJUTeJplXVpSKh80dJSkJw+0ZTdPwJE0
        Th4//a2qxnSqQnkedxTtgHE=
X-Google-Smtp-Source: ABdhPJxvjqENNNydmKnOpx8JBk92Te4AIDn06xzGtQChfXuD7JF2FDPsHTYB2mNihOhEycR6DQJoLg==
X-Received: by 2002:a62:928f:0:b029:1ef:2370:2600 with SMTP id o137-20020a62928f0000b02901ef23702600mr535310pfd.9.1616547272862;
        Tue, 23 Mar 2021 17:54:32 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id mr5sm315830pjb.53.2021.03.23.17.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 17:54:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 23 Mar 2021 17:54:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v5] mm: cma: support sysfs
Message-ID: <YFqNxkTXxjxjRdBt@google.com>
References: <20210323195050.2577017-1-minchan@kernel.org>
 <abe6c403-232c-aa43-5294-2b01bb4c1190@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abe6c403-232c-aa43-5294-2b01bb4c1190@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:44:06AM +0300, Dmitry Osipenko wrote:
> 23.03.2021 22:50, Minchan Kim пишет:
> > +#ifdef CONFIG_CMA_SYSFS
> > +void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count);
> > +void cma_sysfs_fail_pages_count(struct cma *cma, size_t count);
> 
> I'd also rename cma_sysfs_alloc_pages_count to
> cma_sysfs_account_success_pages and cma_sysfs_fail_pages_count to
> cma_sysfs_account_fail_pages.

Every comment makes sense. Will revise and resend.

Thanks for the review.


