Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3831B321
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 00:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhBNXAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 18:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBNXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 18:00:41 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 15:00:01 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBQMp-00E2jt-1p; Sun, 14 Feb 2021 22:59:51 +0000
Date:   Sun, 14 Feb 2021 22:59:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/alpha/lib/csum_partial_copy.c:328:1: error: no previous
 prototype for 'csum_and_copy_from_user'
Message-ID: <YCmrZ7i2TXZZXjLy@zeniv-ca.linux.org.uk>
References: <202102120715.fQ8OSFnI-lkp@intel.com>
 <8b064ade-ccc2-909f-5ef9-ca8287212049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b064ade-ccc2-909f-5ef9-ca8287212049@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 06:52:36PM -0800, Randy Dunlap wrote:
> >>> arch/alpha/lib/csum_partial_copy.c:328:1: error: no previous prototype for 'csum_and_copy_from_user' [-Werror=missing-prototypes]
> >      328 | csum_and_copy_from_user(const void __user *src, void *dst, int len,
> >          | ^~~~~~~~~~~~~~~~~~~~~~~
> >    arch/alpha/lib/csum_partial_copy.c:375:1: error: no previous prototype for 'csum_partial_copy_nocheck' [-Werror=missing-prototypes]
> >      375 | csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
> >          | ^~~~~~~~~~~~~~~~~~~~~~~~~
> >    cc1: all warnings being treated as errors
> 
> I can't reproduce this (wrong version of gcc) but it looks like adding
> #include <asm/checksum.h>
> to arch/alpha/lib/csum_partial_copy.c should fix the warnings.

I'd rather go with net/checksum.h; converting all includes outside of
net/checksum.h itself would have to wait, but let's not breed more of
those without a good reason...
