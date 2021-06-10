Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71A3A288B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:42:36 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46763 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:42:33 -0400
Received: by mail-lf1-f41.google.com with SMTP id m21so2168785lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LwQzoBJzDB7ezkzB47wtBVJSBP9D7oNJlBTqKJy0Tc4=;
        b=Uc0nRjaysL/UDVcykvRfntwjBxt9u6n8diuorlsTK+kGasvAduirEKydZbOHOKIC65
         EdWEbTCqU/RZ5WC+5ZvYz8WzaKWspWk0C6Di8qkWQQJzYa1RlNK0KWLc9iyQ2y0h6OdT
         3UFNYzGDuSagGDCXl6+7A1Yk4xLjwC/K4RlwUWV+HNMNtVGzNjgOZSQo/61T7uAT3KC9
         kCtp4FKZMuJNc0RvkYflS+1COFLTZWI5XtJKKBaimmoTLa4HFlDvOCtnu7txq5rYYRQy
         AOS2qFlkgiZjd997sszszHv/w8WouPaRu91GV/3F223xc7KZKKFsNqbr95+oAUqdC0q1
         i1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwQzoBJzDB7ezkzB47wtBVJSBP9D7oNJlBTqKJy0Tc4=;
        b=i2iGwqHo51cyIRH9ctgnzCu2MUM2JjLmNyw70wdMO6YyK8EzDdzXTqEzy+sLB5BaIZ
         xBjjVGgZHLaz8eVLFHWPQTjCoYyME4SuMSJUU+CyEDZYv3jl8xza6V9WLZjyZoAM4u0R
         mkBq/5jy2JmmHLJe9GeCo0V28R+Q5us2tlTHaLwt8e3ECT52HdI1rpHgeNBsEhBddN45
         LaeqVy20MipKoJpz5o8hkID0i8Qs09hSoepWPaC8Dq4JD7+yPcE4QYxu8ltXUb/QsC7r
         gxYEkvoRuLo/PgNYYY+ZXqU+RmfK+XrEFCn1iE1A0jY0+sppAmQYt74gaoxtXQU/x54P
         +FZA==
X-Gm-Message-State: AOAM533K4WqvYdFZoalrBJ+damcZ4Ib0YP08eR3ZaM59kEqWrp2ZfWfI
        W2xl5anDnr/tOZ9es6nUr/9wtw==
X-Google-Smtp-Source: ABdhPJxp3A4BePUFIW51O2Autq2Wa5ia3HuOhP2QwNSgXGaYQUPKvGaX0SW26IrzGU+DOqG6tRBCzA==
X-Received: by 2002:a05:6512:3244:: with SMTP id c4mr1346515lfr.340.1623317977064;
        Thu, 10 Jun 2021 02:39:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y26sm245842lfj.298.2021.06.10.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:39:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8F8751027EE; Thu, 10 Jun 2021 12:39:52 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:39:52 +0300
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
Subject: Re: [PATCH 08/11] mm: page_vma_mapped_walk(): use goto instead of
 while (1)
Message-ID: <20210610093952.kr5ixjmkl5ttdrrc@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <a52b234a-851-3616-2525-f42736e8934@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52b234a-851-3616-2525-f42736e8934@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:48:27PM -0700, Hugh Dickins wrote:
> page_vma_mapped_walk() cleanup: add a label this_pte, matching next_pte,
> and use "goto this_pte", in place of the "while (1)" loop at the end.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
