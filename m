Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7599332F838
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 05:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhCFEg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 23:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFEgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 23:36:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44F2C06175F;
        Fri,  5 Mar 2021 20:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RWCxwMP7E0t1Cv2Sce54HAeoQwsG0UeKFOUNYGps2a0=; b=FHDdTH+xd4AJVLLCat2soNRIW/
        afPBVSefStZEWrGZBzy9LLpZp+HLsH9lpOsZDMBX7g1VBvY5Aawb8ayJTW4LkeCoOvJK4wKm6Pthg
        RxVVy3GJHCwj7yDzIedVWEkVfdxJvGJ/Oi34NFnQ0aJsVn/gD3KYZXjgDomOzZL5ZSpMiyZgwW1sb
        GtDCXXKx1sNRmXpDgtYypGujeRAaqgcYDYrYxyMTCeTuTYWrIRcTGZNcun+0tpZB0eG73Dx1l+bLf
        Ozzz7hrV9UhfxRRUk3PQrdyCLptcEbp1FWCkZXKushPBMCTg8Up2v6ItkoNkB2vcVrY3V5JWhFZPG
        xtItxtww==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lIOfM-00Cc4o-31; Sat, 06 Mar 2021 04:35:51 +0000
Date:   Sat, 6 Mar 2021 04:35:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC v3] scripts: kernel-doc: fix typedef support for
 struct/union parsing
Message-ID: <20210306043548.GO2723601@casper.infradead.org>
References: <CAKXUXMzHPnM=ie06ZGuFXyJ7RcRjYomjyASbp3ND9-Mb2Es+2w@mail.gmail.com>
 <20210225145033.11431-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225145033.11431-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:20:33PM +0530, Aditya Srivastava wrote:
> +++ b/scripts/kernel-doc
> @@ -1201,12 +1201,23 @@ sub dump_union($$) {
>  sub dump_struct($$) {
>      my $x = shift;
>      my $file = shift;
> +    my $decl_type;
> +    my $members;
> +    my $type = qr{struct|union};
> +    # For capturing struct/union definition body, i.e. "{members*}qualifiers*"
> +    my $definition_body = qr{\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*};
> -    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
> -	my $decl_type = $1;
> +    if ($x =~ /($type)\s+(\w+)\s*$definition_body/) {
> +	$decl_type = $1;
>  	$declaration_name = $2;
> -	my $members = $3;
> +	$members = $3;
> +    } elsif ($x =~ /typedef\s+($type)\s*$definition_body\s*(\w+)\s*;/) {
> +	$decl_type = $1;
> +	$declaration_name = $3;
> +	$members = $2;
> +    }

In the same spirit as dump_function, would something like this work?

-    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
+    $x =~ s/__packed +//;
+    $x =~ s/__aligned +//;
+    $x =~ s/____cacheline_aligned_in_smp +//;
+    $x =~ s/____cacheline_aligned +//;
+    $x =~ s/__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)//;
+
+    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*)*/) {

