Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6C315C80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhBJBoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbhBIXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:52:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:51:38 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lw17so2067886pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ww3WG7wGNXnHLDBUPHgU3iU+auMzMlyEgz5R85XooqI=;
        b=Ek9zp4RHsuyRXrYBIyR2AI+I33bZ4gZTdHhueCfgnq/qRABfoP0cZ8SYecbpQWbxd2
         vXp2gE8S8hSivMjbDDpX7jlS2JuXZRz+KAFulVc6z5gEjzoHJLdI4SaFDBlDUqGD4nhX
         vsQs/zf6DOvtG0O1O2wpTqAYB2TAUxeLBOZxnIr3fWSjFL+77t+TyPg0BIWuKVDEZVHU
         FKbOXLQHJOBlEHxSueq0GPao8+U6B37sihZOut8f5qHAsrFd8QfuJYL5Fxj+T6zFAxLc
         nmFsjE5yoamBbqNSkNNWNhzECZhPKFXoSD5cTTA4FRPcmlTG8jj6FY+PIgmDWvV043fi
         rnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ww3WG7wGNXnHLDBUPHgU3iU+auMzMlyEgz5R85XooqI=;
        b=LDKqTmpSlwBmGtI3JdrvKVimnSmGBanbvnG/XdokLuKT5H/RcB8WoE6fCWXGoqtk3W
         enzgyppF7YLGYuRWCwRyaLiinJgkNTlg5m4TQcR5GeUujdu9u2B11/huNRUxAGVss4bR
         s15dDb1wVPdxJuAfnB/ZqSf6VLJjA1ONNa0fky67p05fHIKnKRuCIr5aJoIup9P/rBvC
         QK8m7hI9ruNf20wUu7F+z21VYzsx+evJNtQ//l8Z2b9MszDgKdjAXf9/QBfHkxODhTXR
         1NXbGYBGvrMkJFHcSxoRiMxq7YTD40EtyXgeJ4Md185SyFsY4fg/0f4qRs1EZtNbxPGS
         2J5Q==
X-Gm-Message-State: AOAM531cRgHyJuEsClSYoob8zWaeSfPTYi4vC9tVlQFKxUmvZsPesAud
        CtiHvY6WBTzyDyp2T/2qvQ==
X-Google-Smtp-Source: ABdhPJzGqOtsodwTLU8QvmfADVEXP63RP+tl5sRhyzRtvCK6V9p4h8jZDB9AYwn69mpRaq/MpGSErw==
X-Received: by 2002:a17:90a:cd06:: with SMTP id d6mr365066pju.86.1612914697593;
        Tue, 09 Feb 2021 15:51:37 -0800 (PST)
Received: from u2004 (h175-177-040-128.catv02.itscom.jp. [175.177.40.128])
        by smtp.gmail.com with ESMTPSA id q188sm62516pfb.8.2021.02.09.15.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:51:37 -0800 (PST)
Date:   Wed, 10 Feb 2021 08:51:33 +0900
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
Message-ID: <20210209235133.GA491550@u2004>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
 <20210209114640.73a68074f635852c2ce498e6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <20210209114640.73a68074f635852c2ce498e6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:46:40AM -0800, Andrew Morton wrote:
> On Tue,  9 Feb 2021 15:21:28 +0900 Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:
> 
> > Currently hwpoison code checks PageAnon() for thp and refuses to handle
> > errors on non-anonymous thps (just for historical reason).  We now
> > support non-anonymou thp like shmem one, so this patch suggests to enable
> > to handle shmem thps. Fortunately, we already have can_split_huge_page()
> > to check if a give thp is splittable, so this patch relies on it.
> 
> Thanks.  We're at -rc7 so I think I'll park this one for 5.12-rc1,
> unless it is more urgent than I believe it to be?

This patch is not so urgent, so I'm fine to make this targeted at 5.12-rc1.

Thanks,
Naoya Horiguchi
