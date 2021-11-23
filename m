Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32F8459ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKWJGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhKWJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:06:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TE7iabAn9RUCbez/HtjQ+FxmDKnAFXa31uyeVbae/OY=; b=LrS8umb6CEb8fJaKv153x6OdCp
        ARWjqn4irpXlSgAr47n7AcIwU2XZQZU7eV1uDn+6WzzliVOuVbpN5vquisfoRyQ1yrTQWWzbtisDF
        yq3L1iWaOLTFVpG3DJjsYXuFe3/7RXV1z0vKnG4trMulu0S1VGFQSx7wJYL4aZZ/WkIhuRNqHnkgx
        y93DCbnWXf5dG4JS+qSq7yQKIvEmZiPA3WGNu855Lwy67kmG6OUnhF7I83I/Qyj1/xiTzkkjSMN3X
        BNO4uT0rF47mukSDWVqApP8VNQIr9wExhf8uJYa7GzIsZ/HBta5z6Qg/lxcmjZal8sHjShIhM80X0
        1FCmyYMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpRhW-00E5Fj-BT; Tue, 23 Nov 2021 09:02:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B034300230;
        Tue, 23 Nov 2021 10:02:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A60D203DC8AE; Tue, 23 Nov 2021 10:02:53 +0100 (CET)
Date:   Tue, 23 Nov 2021 10:02:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com
Subject: Re: [RFC][PATCH 0/6] x86: Kernel IBT beginnings
Message-ID: <YZyuPffZU5bOjzBQ@hirez.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <YZyfM/gUoPV6p+30@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZyfM/gUoPV6p+30@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:58:43PM -0800, Christoph Hellwig wrote:
> What is "IBT"?

Fair enough; it's Indirect Branch Tracking, it's a hardware feature that
ensures any indirect JMP/CALL can only ever land on an ENDBR
instruction. It's a form of Control Flow Integrity, albeit a weak one.
(FineIBT is a software improvement that combines this with a hash value
to further narrow the allowed branches. People are working on that, but
basics first etc..)

More practical, by stripping ENDBR instruction from functions that are
never called indirectly, we insta kill the tried and true method of:

	func = kallsym_lookup_name("unexported_function");
	(*func)(args);

favoured by pretty much every out of tree piece-of-cra^Wmodule.
