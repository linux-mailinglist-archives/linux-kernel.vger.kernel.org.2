Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E603292F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbhCAU4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbhCARLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:11:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8BC06178C;
        Mon,  1 Mar 2021 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=AzpNt39AFo/zFqTeQtEuxgVZwQBuuvW7GOPciez3kew=; b=w4/uov0eFOQxmK3pB5PzL2hON0
        Pq7OCZUFkyg4XpDXC60PcWhbpVN7Ye1CYqQy4LyJlPZA6DsexZEQO3KVxTuwbrDgYzhbSpZItQdGO
        6lcLIBToBjLXTRuqJj1YJiqJ7RGsYG3TmSZ/B545cEM3TJj8RgGICZ2RpITDEHisPa23NWx4YsEgC
        so7v3obP9JBAtuF74xrzuZArKyusF1T88MQQSVR4TNFuXy/CDhWX+syYg4nAXGb8Oj3TaXJcoGoo5
        N/D0YvdCkO6SQSHWP+9K5KmX4kxPdhohPFQcLBR14Uk6sDoC9F2bIT5+R5E8yVqNQ5P0j0/Lz1RFn
        HuIJzbeA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGltw-0005FN-B3; Mon, 01 Mar 2021 17:00:08 +0000
Subject: Re: [PATCH] docs: sphinx: Fix couple of spellings in the file
 rstFlatTable.py
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210301124136.11602-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <15d1c699-28bb-38ca-0e2b-1b7a3c92024b@infradead.org>
Date:   Mon, 1 Mar 2021 09:00:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301124136.11602-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 4:41 AM, Bhaskar Chowdhury wrote:
> 
> 
> s/automaticly/automatically/
> s/buidler/builder/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/sphinx/rstFlatTable.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
> index 2019a55f6b18..386c435e479c 100755
> --- a/Documentation/sphinx/rstFlatTable.py
> +++ b/Documentation/sphinx/rstFlatTable.py
> @@ -22,7 +22,7 @@ u"""
> 
>      * *auto span* rightmost cell of a table row over the missing cells on the
>        right side of that table-row.  With Option ``:fill-cells:`` this behavior
> -      can changed from *auto span* to *auto fill*, which automaticly inserts
> +      can changed from *auto span* to *auto fill*, which automatically inserts

	 can be changed

>        (empty) cells instead of spanning the last cell.
> 
>      Options:
> @@ -171,7 +171,7 @@ class ListTableBuilder(object):
>          for colwidth in colwidths:
>              colspec = nodes.colspec(colwidth=colwidth)
>              # FIXME: It seems, that the stub method only works well in the
> -            # absence of rowspan (observed by the html buidler, the docutils-xml
> +            # absence of rowspan (observed by the html builder, the docutils-xml
>              # build seems OK).  This is not extraordinary, because there exists
>              # no table directive (except *this* flat-table) which allows to
>              # define coexistent of rowspan and stubs (there was no use-case
> --
> 2.26.2
> 


-- 
~Randy

