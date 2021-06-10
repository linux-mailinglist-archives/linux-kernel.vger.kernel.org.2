Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD133A27DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFJJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:12:44 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44652 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhFJJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:12:43 -0400
Received: by mail-lf1-f54.google.com with SMTP id r198so2053347lff.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RioqOdzdRiLsc62ht2G8+44sOJidvgbpfl8gprWW3as=;
        b=Uo0N65qx8MhaEKrrRkjcPKeXi7/fw07uTt89i+jf3zUHDlLLx+Nt8onjDOTMMc9mD9
         8IN7kVb9V5KSRFfYdF4fST77xelWZtJRonVk9vpDBrEQB5Q2bY6rNRLNlZbDFqAgLTsx
         8P6dCRzVD8+gHQq7YaIlcc0JIbOVTvVGP05jAftAlAnqCXV2uPZhb52nHMmb6d1cZRmh
         qFvUSL5ecV4aRtTfDXMzu/6JyEghU+qQx8+Z9EPt77bc8zW5Q0sAAyYegzA9YdAKjzUX
         VVgRHL/m/eeOSj1zjkZV0XUwcnZ2/H6pFQx//cw+fcmWe11oBEOpRCYAXXQgCmAF7b07
         E8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RioqOdzdRiLsc62ht2G8+44sOJidvgbpfl8gprWW3as=;
        b=XS7+wNj8LZihcylDvBFGCEFRZwlLGnxzuzwlic4PyI/5Kx4n5fD9PE7um/q6F0XcQa
         bX3HRvLy0wK9dMUrZJT0Nmdne7r83bFtHBeI93O+FP0FHg1ZW0JlEMiD/966JwkJvI9F
         3OPTSJGhCoB2LIfEGNMk1/k7Wvr5HF6l3MMqn9corXrRdH30InJj1ydyOQS4nI3zLyEF
         XdNxzKyklHjAhI3yp+ChYO0smuXiaYwdAdmQvq5Ln7u7iQ2R0AGy++62x+xjF7HPAera
         aUeRWJCiP5aq0GfodAGGKOnsmkqypyKfLL3NCwDcGR0okodszhDCFYiZ5ZKhwr8u+06b
         v02A==
X-Gm-Message-State: AOAM531poz8VskWC5pPgvdoH7tNhZd9ldZhMU4CPVN+J4s6DjpAYbniy
        fbHYE26ljVC47JxUNAQLgR5WyvsU6Wa8YA==
X-Google-Smtp-Source: ABdhPJyC1PrGEvvLqGrNBku7nlmRbDcEmp8p+n1RvzmX/dPGnBC4VPLnvPcd41jK3jQ+m36vQ15SFQ==
X-Received: by 2002:ac2:4f92:: with SMTP id z18mr1234396lfs.343.1623316186435;
        Thu, 10 Jun 2021 02:09:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v10sm238581lfg.224.2021.06.10.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:09:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AC8221027EE; Thu, 10 Jun 2021 12:10:01 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:10:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
Message-ID: <20210610091001.mbkj7wu3qww474nt@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <53fbc9d-891e-46b2-cb4b-468c3b19238e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53fbc9d-891e-46b2-cb4b-468c3b19238e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:40:08PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: re-evaluate pmde after taking lock, then
> use it in subsequent tests, instead of repeatedly dereferencing pointer.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
