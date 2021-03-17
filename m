Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3B333F816
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhCQS0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhCQSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:25:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB6C06174A;
        Wed, 17 Mar 2021 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=aDZn5rNh0GqHfB1yuCs8X0m+j7nLaKVvb0epvExRz+M=; b=jU9EYb+1cbwMocgwOiYLNL+IDA
        psyboQayQ78lm3V5Aro8zP9P5Xbn4DWjPs0AmumNw3cSYTRKAg61myGXtZCDL8bqIHaBjpgc2Q4jg
        EZrKWGuexiz5ta14bFzIzR7+PD9sUnsv4SsixX08XEJH6yrSIEQ30SXbT+xUatYQ7ho04kajWRC9/
        IDtqPARui1hQ/XRUZZ5yhc6QxQSFldYJ2bNq5Hcn9JiC/6lYqejwZt20/3NM9WRT7JhFjUM2YMKY4
        xkgXf0XjD0SQxQUmbwpM1NXXLzEnXxkpgmI3WXKlbAeNi8RIVr/rDNgCb5BWEGqr7WNQKekUNg7xU
        DBvlfGKg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMard-001fsD-Vt; Wed, 17 Mar 2021 18:25:50 +0000
Subject: Re: [PATCH] docs: sphinx: Trivial fix of a typo in the file
 rstFlatTable.py
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317102056.3003768-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <442664ee-7cae-9b26-ca66-31827c448fcc@infradead.org>
Date:   Wed, 17 Mar 2021 11:25:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317102056.3003768-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 3:20 AM, Bhaskar Chowdhury wrote:
> 
> s/buidler/builder/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/sphinx/rstFlatTable.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/sphinx/rstFlatTable.py b/Documentation/sphinx/rstFlatTable.py
> index a3eea0bbe6ba..1d2b9be6b6c5 100755
> --- a/Documentation/sphinx/rstFlatTable.py
> +++ b/Documentation/sphinx/rstFlatTable.py
> @@ -161,7 +161,7 @@ class ListTableBuilder(object):
>          for colwidth in colwidths:
>              colspec = nodes.colspec(colwidth=colwidth)
>              # FIXME: It seems, that the stub method only works well in the
> -            # absence of rowspan (observed by the html buidler, the docutils-xml
> +            # absence of rowspan (observed by the html builder, the docutils-xml
>              # build seems OK).  This is not extraordinary, because there exists
>              # no table directive (except *this* flat-table) which allows to
>              # define coexistent of rowspan and stubs (there was no use-case
> --


-- 
~Randy

