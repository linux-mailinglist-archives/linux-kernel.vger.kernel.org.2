Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F832F301
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCESoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCESnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:43:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF28C061574;
        Fri,  5 Mar 2021 10:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sIGgzA66tHNsHeYn52XPo7JeAyKpJREW3Whf9/UDz4Y=; b=OpnKc2NA/LxZwoGWyc+vlOOaWP
        yuxaV1NSzwOKD5oALjsHc5ar2eyGku1gpkXfZXWrJQeYg3GebuJggCh5voJFZ4m0PCupLcRcbj2wN
        8mjYj+4QhF7hAYPK6arrF80Z8qDrGC/FoOQHJPzhJjaCXAtdKoQAsaaZ5QXvENYd1noOiQJy6OwJC
        hS55Yxrv+91mmq3wFsmY3vi19i57u3bLwlJOLTL4abU/HxLphOPER7Nq0l7oBMFi8/fidBFwHPaHK
        qtKcUiRze1HSCaoM++0S/gNbDuaHzItcbTCaK+HWbToYFDuujgbsgT7NSos9Dbq0Hfx6q//9mNr2O
        C9N9k6VA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lIFQ2-00C85B-3R; Fri, 05 Mar 2021 18:43:23 +0000
Date:   Fri, 5 Mar 2021 18:43:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC] scripts: kernel-doc: fix attribute capture in function
 parsing
Message-ID: <20210305184322.GN2723601@casper.infradead.org>
References: <20210305182000.8363-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305182000.8363-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 11:50:00PM +0530, Aditya Srivastava wrote:
> Provide a simple fix by adding "__attribute_const__" in the corresponding
> regex expression.
> 
> A quick evaluation by running 'kernel-doc -none' on kernel-tree reveals
> that no additional warning or error has been added or removed by the fix.

I'm no perlmonger, but why isn't this simply:

+++ b/scripts/kernel-doc
@@ -1753,6 +1753,7 @@ sub dump_function($$) {
     $prototype =~ s/^__inline +//;
     $prototype =~ s/^__always_inline +//;
     $prototype =~ s/^noinline +//;
+    $prototype =~ s/__attribute_const__ +//;
     $prototype =~ s/__init +//;
     $prototype =~ s/__init_or_module +//;
     $prototype =~ s/__meminit +//;

(completely untested)

> +++ b/scripts/kernel-doc
> @@ -1753,6 +1753,7 @@ sub dump_function($$) {
>      my $prototype = shift;
>      my $file = shift;
>      my $noret = 0;
> +    my $attribute_const = qr{__attribute_const__};
>  
>      print_lineno($new_start_line);
>  
> @@ -1808,7 +1809,7 @@ sub dump_function($$) {
>  	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>  	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>  	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> +	$prototype =~ m/^(\w+\s+\w+\s*\*+$attribute_const?)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>  	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>  	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>  	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
