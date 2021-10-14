Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383E342E233
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhJNTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhJNTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:53:30 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D7C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SgZrd2Dl7DkxDw3kJKusXJ/WFzczBgnPXkjSStE9MhA=; b=sl7UHSNrpFSAto/vMuhknybO1j
        wkhvRJGC4kRVz0riuSsTMMzfFg/IdyacPfo0mz2NinA1lQFKyCwzaPFJq/iv+jdBtOWp0tv8Mm+Sr
        U3NCMuIjAkCTytNQVGOlilCDm/JjHDWCFqUEJ2tCX9NX/bNrgJz7RgMuHEUCUK1yw+l89OEXjJJuJ
        8iofNT01z+mK+i39CmrJUOSslQ3hMzRgaRm5EYzg83VwTFL8dkJUl7Ew9zGDllcERg+O1ZDtvYMKM
        xz+msUELgesyk4a/HrKrCf7DDaphRYygw22AyVDtAL2LfGqZx3nNTcIgKhPhnZLBm7p9byWBniLUE
        VzNZFUmw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb6lA-004GWE-8S; Thu, 14 Oct 2021 19:51:24 +0000
Date:   Thu, 14 Oct 2021 12:51:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] module: fix elf_validity_check() warns seen on 32-bit
 platforms
Message-ID: <YWiKPMKh6025c6dW@bombadil.infradead.org>
References: <20211014181044.24365-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014181044.24365-1-skhan@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:10:44PM -0600, Shuah Khan wrote:
> Fix the following warnings introduced by
> 
> commit: 8b1185a4427b ("module: change to print useful messages from elf_validity_check()")
> 
> warning: format '%llu' expects argument of type 'long long unsigned int',
> but argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
> 
> Fix it by tweaking messages to not print ELF64* fields.
> 
> Fixes: 8b1185a4427b ("module: change to print useful messages from elf_validity_check()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Actually can I trouble you just fold this in with your older patch, I can just
drop your old patch and merge this one. No point in merging two patches
if we can just have one.

  Luis
