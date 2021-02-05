Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A33102B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBECVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBECVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:21:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A8C0613D6;
        Thu,  4 Feb 2021 18:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3lohI5c9nSmUvsnakvbrLjpJYjMPQvZMFc35vmVQT40=; b=nNCvOJ2D0+OPwoPTxr4XwYaxwv
        L/wN63jtarMeq4wZ2Kd26Vc9vI6ns5SvLKnQP4QIfDcAANN1mj4bCGkkAaG6wh4JMFu6y2+RlZAvS
        8Wo6Fckvs6t4f6eE+yN7RFmaZqaxlG6/73lSljKRQBwGiQLAXd/rmbZvrf9MGD6vfgvIspvyEALYq
        cRk9jxGokpl4zhbIX77+WgG5hxtcwyttzbfOG+OEynXXlumCR8fq5iD4dU2TY/o31h1qOxC1x6lbk
        Xp0fxzrEDMuag+4R7dfYc45BYgb1DPykHHQIGBmSkxOS4IrfjzZehf07D+XGiZvrMW2XG4Ld1icAY
        2czOE59g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7qjQ-001hbq-DA; Fri, 05 Feb 2021 02:20:25 +0000
Date:   Fri, 5 Feb 2021 02:20:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Xin Long <lucien.xin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] seq_file: document how per-entry resources are
 managed.
Message-ID: <20210205022024.GF308988@casper.infradead.org>
References: <161248518659.21478.2484341937387294998.stgit@noble1>
 <161248539020.21478.3147971477400875336.stgit@noble1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161248539020.21478.3147971477400875336.stgit@noble1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:36:30AM +1100, NeilBrown wrote:
> +passed to a subsequenct next() or stop() call.  This allows resources

s/quenct/quent/

