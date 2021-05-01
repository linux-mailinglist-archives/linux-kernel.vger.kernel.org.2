Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459653707C2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEAPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhEAPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 11:44:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B79C06174A;
        Sat,  1 May 2021 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZZhukaabMwhJaioIS34CyIDiXMBC3VOAahF1TCfxWX4=; b=frrztHdbGuIO8+KQ2rDoaxbb5m
        ryap20MO+uUGBEiNmbi7azgpwpDy8qWbH9fduTdK5/i8tjOm+ninaiSF0D263wB2sAgHWqnFTs+Tw
        QSk3ZERiIE3yFOmhMXrIH2fCUG+knoC2Ef98iiuch3VhuFJfIAnNWbF2HzPXEWsYihau/+HSw0gRs
        qG99pNbVSwWpVstV/nqEi9RhdNMDFLNZeqX+zq+f7gYlaJm1f1HnrqY6tl7NtdAzP6gawknsrWSu6
        66lCud+6bZg7JAXRb76yh1RWFA0WrWTwXNscSKSuXZGJzeUgiiVOOnCdrVF1vWO60CAJsHalMCvJo
        xRjMN9+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcrmK-00CX5G-HU; Sat, 01 May 2021 15:43:42 +0000
Date:   Sat, 1 May 2021 16:43:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3] scripts: kernel-doc: reduce repeated regex expressions
 into variables
Message-ID: <20210501154336.GS1847222@casper.infradead.org>
References: <20210427165633.GA235567@casper.infradead.org>
 <20210429063729.8144-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429063729.8144-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:07:29PM +0530, Aditya Srivastava wrote:
> +    my $name = qr{[a-zA-Z0-9_~:]+};
> +    my $prototype_end1 = qr{[^\(]*};
> +    my $prototype_end2 = qr{[^\{]*};
> +    my $prototype_end = qr{\(($prototype_end1|$prototype_end2)\)};

Would this be better written as:

	my $prototype_end = qr{\([^\(\{]*\)}

And now that I look at the whole thing, doesn't this fail to parse
a function declared as:

int f(void (*g)(long));

(that is, f takes a single argument, which is a pointer to a function
which takes a long argument and returns void)

Still, I don't think this was parsed correctly before, so it's not an
argument against this patch, just something to take care of later.

> +    my $type1 = qr{[\w\s]+};
> +    my $type2 = qr{$type1\*+};
> +
> +    if ($define && $prototype =~ m/^()($name)\s+/) {
>          # This is an object-like macro, it has no return type and no parameter
>          # list.
>          # Function-like macros are not allowed to have spaces between
> @@ -1817,23 +1828,9 @@ sub dump_function($$) {
>          $return_type = $1;
>          $declaration_name = $2;
>          $noret = 1;
> -    } elsif ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+\s*\w+\s*\*+\s*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
> +    } elsif ($prototype =~ m/^()($name)\s*$prototype_end/ ||
> +	$prototype =~ m/^($type1)\s+($name)\s*$prototype_end/ ||
> +	$prototype =~ m/^($type2)+\s*($name)\s*$prototype_end/)  {
>  	$return_type = $1;
>  	$declaration_name = $2;
>  	my $args = $3;
