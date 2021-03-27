Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2934B9CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhC0WSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhC0WST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:18:19 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA8C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 15:18:19 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQHFs-000JlC-J3; Sat, 27 Mar 2021 22:18:04 +0000
Date:   Sat, 27 Mar 2021 22:18:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] kernel.h: Drop inclusion in bitmap.h
Message-ID: <YF+vHHxYQ1hnnNBm@zeniv-ca.linux.org.uk>
References: <20210326170347.37441-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326170347.37441-1-andriy.shevchenko@linux.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 07:03:47PM +0200, Andy Shevchenko wrote:
> The bitmap.h header is used in a lot of code around the kernel.
> Besides that it includes kernel.h which sometimes makes a loop.

How much of the kernel does *not* end up pulling kernel.h anyway,
making all subsequent includes fast no-ops?

Realistically, any C compiler is going to recognize the case when
included file has contents of form

#ifndef <pp-id>
#define <pp-id> <possibly empty sequence of preprocessor tokens>
<lines>
#endif

where <lines> contain no exposed #else, #elif or #endif and
remember that subsequent includes of that file should be ignored
unless <pp-id> becomes undefined.

AFAICS, on e.g. allmodconfig amd64 build it's (at most - there
might've been false positives) 131 files out of ~30000; on
defconfig it's 55 out of ~2300.  How much does your patch
change that?
