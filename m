Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556DE4550FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbhKQXU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:20:28 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:45594 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233853AbhKQXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:20:20 -0500
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5E0CA837F253;
        Wed, 17 Nov 2021 23:17:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 49AB3900065E;
        Wed, 17 Nov 2021 23:17:16 +0000 (UTC)
Message-ID: <dd3b7e0a1b71ab669fc1c0df434bf49eb3dce976.camel@perches.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Sort sections with
 parse-maintainers.pl help
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 15:17:18 -0800
In-Reply-To: <20211117190553.36144-1-andriy.shevchenko@linux.intel.com>
References: <20211117190553.36144-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 49AB3900065E
X-Spam-Status: No, score=-3.13
X-Stat-Signature: n9bupe7doqj5hygd79w1p9qt1qrjrf6s
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+rro6zIGaj4O46vOHsG7C1p1dc+9K9qn0=
X-HE-Tag: 1637191036-854386
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-17 at 21:05 +0200, Andy Shevchenko wrote:
> Sort sections with parse-maintainers.pl help since quite a few
> got unsorted from the previous run.

If this is done, I think adding --order to the command line would be better.

For next-20211117 this gives

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order
$ git diff --stat MAINTAINERS
 MAINTAINERS | 826 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 1 file changed, 413 insertions(+), 413 deletions(-)


