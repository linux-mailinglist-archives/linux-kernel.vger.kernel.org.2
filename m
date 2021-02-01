Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9207930B221
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhBAVci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBAVcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:32:35 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5AC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 13:31:55 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id e19so12505190pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Db9wzFspMKv2GZMUp3j8AjHx8VTQiM19HjB9nvBRaLU=;
        b=lt/Aa4uQ8poWCQc2Nz7076yxPFNeImt5BPs9gtS0QSIHvFmRQ+ed8VhKEkhOTsh1T9
         S3kmC7fgGI3pJK69d9qfuvaiHZmP1dCydmj3yEQwiP5yjC82Gu5DmVTuX+yu15nisv4I
         FyJnk6sVTW9MfHesCSPTwEGKfvyyHv6Vb1FFzBpJSxP2hoexC6K+Q59k/sYzfKqJV8et
         AxZUztLba78aHKyFyzQflBEkQUqCdWxcRP7wZ/ir5vBdJ21nDFuq0pQEiEp3OfCR5iWV
         I6ZO2EifAn+M9KgJikMJBGY1muYYTjOfwq72WyTGwYsvyoaa927iD8KkghKAd530GkH1
         pOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Db9wzFspMKv2GZMUp3j8AjHx8VTQiM19HjB9nvBRaLU=;
        b=B3iRfOaqS8Ce3y7fc8knZJ2OXUEYbW4FJY2c0FZrJZMJCmQ7rbOLGYiffulng1GWku
         Qvn1aezSXwTYDrsutROm4tk/5LA1e70hsx8ge/EAh9GV0Ijn9EG33kI4e+mYDyfebIlY
         s6JU54ZTaEDhOGr75SyNumCmxMsViLDrYMikKCUGQ+I4FhRzkhRC7xgFabOgOM0fkuN6
         CLIgLi265IPbvaL32PPB0ffpoJuqSlv25O/JUHhsRAryTqeCbxGsGZYsJ948lLCkmOXs
         oB2h9AAHAXkw1T5AMGf1xwRga+ZoRye8RWnIhstmpQCiD/gzQwnyZF3CaDnskP0Nv+9u
         SapQ==
X-Gm-Message-State: AOAM531RUMJq3kG2jHAfdSjQBM1BLuPvnpozAfoNR1BhukfsjZ0DroBM
        YOeaK4oW5yliYT/s6MGHn0HaTQ==
X-Google-Smtp-Source: ABdhPJwDtVQ/1GoQJP95AYbpB6XU4+QBaoUMIhtqYBJo9OpVXWoOnvzaXeQuY3/MRAGVyxXX1kPZBA==
X-Received: by 2002:a62:64c9:0:b029:1b9:6b48:7901 with SMTP id y192-20020a6264c90000b02901b96b487901mr18528679pfb.0.1612215115053;
        Mon, 01 Feb 2021 13:31:55 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b27sm19920266pgb.82.2021.02.01.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:31:54 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:31:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: show pagesize in unit of GB if possible
In-Reply-To: <24ab70d6-1d23-d118-f1e7-473f01615dcc@huawei.com>
Message-ID: <c755cad3-1020-46bc-2c4c-7e382ad366f5@google.com>
References: <20210130090339.4378-1-linmiaohe@huawei.com> <f5ac7d57-6653-aae-f119-b87d72acf192@google.com> <24ab70d6-1d23-d118-f1e7-473f01615dcc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021, Miaohe Lin wrote:

> >> Hugepage size in unit of GB is supported. We could show pagesize in unit of
> >> GB to make it more friendly to read. Also rework the calculation code of
> >> page size unit to make it more readable.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  fs/hugetlbfs/inode.c | 12 ++++++++----
> >>  1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> >> index 3a08fbae3b53..40a9795f250a 100644
> >> --- a/fs/hugetlbfs/inode.c
> >> +++ b/fs/hugetlbfs/inode.c
> >> @@ -1014,11 +1014,15 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
> >>  	if (sbinfo->max_inodes != -1)
> >>  		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
> >>  
> >> -	hpage_size /= 1024;
> >> -	mod = 'K';
> >> -	if (hpage_size >= 1024) {
> >> -		hpage_size /= 1024;
> >> +	if (hpage_size >= SZ_1G) {
> >> +		hpage_size /= SZ_1G;
> >> +		mod = 'G';
> >> +	} else if (hpage_size >= SZ_1M) {
> >> +		hpage_size /= SZ_1M;
> >>  		mod = 'M';
> >> +	} else {
> >> +		hpage_size /= SZ_1K;
> >> +		mod = 'K';
> >>  	}
> >>  	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
> >>  	if (spool) {
> > 
> > NACK, this can break existing userspace parsing.
> > .
> > 
> 
> I see. I should take care of this. Many thanks.
> 

Thanks.  It's an important point to emphasize because it shows how 
important user-facing interfaces are.  Once the hugetlbfs mount options 
are printed in the way they are, it becomes very difficult to change them 
because there can be userspace in the wild that would break as a result.  
This is why it's crucial to be very careful when specifying user-facing 
interfaces the first time so they are extensible.
