Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB13A2853
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJJhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:37:02 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40517 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:37:01 -0400
Received: by mail-lf1-f54.google.com with SMTP id k40so2175565lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qbD3+1Q8Ke6/O0GcSPSpFBkNRJImLhwGUIQax3DMlKc=;
        b=O57jSPErjSmtBleNf0c1xy56oq3A4JCYvCY1pyPhhhIinWI4/9FUUZV0lg+7yfnqeN
         89ArOyR1S6MxbYdVsau1TID/k0orJaAyEIaBxx2DbZrm7KqRj2TNSUwTE3V5qcviPigF
         zE6IkmVPesl1LwzmoU/id3DdTfFtXh7j9kCl4/llT0OIqmrOJnvH0jc7DZ/x0Z0VfYsR
         fG3Twl7hmmsxsKtoQOVmp7L5TYX9ZD4qwXa7pzSgV3j6qZv/awtiz+z/4pD+mbMxis9H
         vWjG6icQEULdrLJUVHfMFnmeXmknhRXFFrbPb0bOrNFR8Pmbyso1w840lwaW7Bd9y8iM
         CUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbD3+1Q8Ke6/O0GcSPSpFBkNRJImLhwGUIQax3DMlKc=;
        b=DLFf+H7UeQv5n0uq0kzp4QIrPuv0sgyWHkUN3Vuxu/MZgjt8enszzBU1o/fXHnk/mE
         b65WJeydKS2xkdTXzf3f5recQForz0Y5oi+awR3FEl3eOI3Gzw17k7Iok+IRwb0bO2oY
         lhFlRvkrjNQJWHu6BZIh3DBfooVlQOIzrgGq4ayIxptcSgVtX2Zs+AlebrXUdbAAurMH
         uEeShG5B5gZY9qOrmPpfKPOOE+qhh4fVB5/NvIqNfmi49xoiIxGbXnBT0+KlKb6QG/cw
         9KXPQ6jm4x7IYwhQa1GtRIbhBJYHMSo1VxrRjCZBUkshpbqLx2k7nIupU3p9qbaFr17O
         BZOA==
X-Gm-Message-State: AOAM531BNM41pq+rVOJEtBOAvF7Ej+iZXapHaWHLvjfh669zlkr8lOgY
        Kd39dA3uh2gR+udAP/WR/oyY6Q==
X-Google-Smtp-Source: ABdhPJz7bQPYO7bUiLmcaydnjQ7xA4Sz2/yChbiIKfeMgkJVfW0kPnOuF9PbhGH0TZiptRj6pdou+w==
X-Received: by 2002:a05:6512:2186:: with SMTP id b6mr1322607lft.490.1623317627940;
        Thu, 10 Jun 2021 02:33:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n3sm264679lji.65.2021.06.10.02.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:33:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 792E31027EE; Thu, 10 Jun 2021 12:34:03 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:34:03 +0300
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
Subject: Re: [PATCH 07/11] mm: page_vma_mapped_walk(): add a level of
 indentation
Message-ID: <20210610093403.cvne2xf57yivjw4m@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <efde211-f3e2-fe54-977-ef481419e7f3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efde211-f3e2-fe54-977-ef481419e7f3@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:46:30PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: add a level of indentation to much of
> the body, making no functional change in this commit, but reducing the
> later diff when this is all converted to a loop.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Thanks, it helps a lot.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
