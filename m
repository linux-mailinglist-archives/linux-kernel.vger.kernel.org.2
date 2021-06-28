Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0103B65FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhF1Pqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbhF1Pp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:45:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D1C08E6E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ECS93oVACGoW2Djx/trGDMcvaVrMlZKu4JBZCoodPpI=; b=UTtsFjfEV2zrd+pLBQ9VWbkgbT
        HBFnw4PV3Rda4NrTAwQ6ZWdWnoGgMSd5D+r+6D/IBlFN9EtI4lZKN9JYM1W1Vi8uSjBz2ww9uQowN
        ErYr3WKITCxZOqKefulghoQNYMz6oF7aHI9lc6F6S28m+xFZIupsgIuYBsDzDsna2P07EQ8kzBd/Y
        sSQMOWhhpJowPbtEpegFGtOCplIzcH9vMNYSmIhhTD4pJpyvVnv3f51K7ZmcrW0EjMmwpCEsABGyv
        zTJurYdTcC7bMJeCLOhcX+O9JcyR58Y0j8gvMBbDXCFmVgCqJOhWFISiMYQDKWBmxMSW1GeR5RFsq
        k502zBJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxsrp-00CaVa-WE; Mon, 28 Jun 2021 15:08:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C3F23005C9;
        Mon, 28 Jun 2021 17:08:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E25B2041E874; Mon, 28 Jun 2021 17:08:09 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:08:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: selftest/ftrace: Add test results to "-h" help text to ftracetest
Message-ID: <YNnl2YQcW05RR7kN@hirez.programming.kicks-ass.net>
References: <20210628095015.4b8b1cb9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628095015.4b8b1cb9@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 09:50:15AM -0400, Steven Rostedt wrote:
> +echo "	UNRESOLVED	The test produced indeterminate results. (e.g. interrupted)"
> +echo "	UNSUPPORTED	The test failed because of lack of feature."

So in my case I've seen both these as a result of .config fails.

Specifically test.d/kprobe/kprobe_module.tc returns exit_unresolved when
it can't load the module (because it doesn't exist).

Also, would it be at all possible to, for both these options, always
print the missing CONFIG_symbol ? The above test actually has an echo
for it, but I've never seen the result of that appear.
