Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5123A4590
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFKPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:38:46 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:39016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231906AbhFKPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:38:44 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3C92F8798;
        Fri, 11 Jun 2021 15:36:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id BE082C4196;
        Fri, 11 Jun 2021 15:36:43 +0000 (UTC)
Message-ID: <f8e5efe388de9cfc78e1aa163d66096b09eb8a9e.camel@perches.com>
Subject: Re: [PATCH 1/3] scripts: add spelling_sanitizer.sh script
From:   Joe Perches <joe@perches.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Jun 2021 08:36:42 -0700
In-Reply-To: <20210611071241.16728-2-thunder.leizhen@huawei.com>
References: <20210611071241.16728-1-thunder.leizhen@huawei.com>
         <20210611071241.16728-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.88
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BE082C4196
X-Stat-Signature: yp7tnyk356kj9jp8k7gth4mgj3ycad7j
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18deidlvItLkiWDVPyQTbz/G+O/z2VxkX8=
X-HE-Tag: 1623425803-171009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-11 at 15:12 +0800, Zhen Lei wrote:
> The file scripts/spelling.txt recorded a large number of
> "mistake||correction" pairs. These entries are currently maintained in
> order, but the results are not strict. In addition, when someone wants to
> add some new pairs, he either sort them manually or write a script, which
> is clearly a waste of labor.

Try using lintian's make sort

https://salsa.debian.org/lintian/lintian


