Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D242FD49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhJOVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbhJOVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:16:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756D2C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q/oTrsPpaE1Rtcq8TOqDuEDg3qlnRAaq9t8odxoT1cA=; b=1GBhuy2rSsKcj+/nGXXGxIn8ii
        vlt2IUXR/uSRlPwf5YLWO8aqdFAF0hvFgn6dvEK1tZ1pXT4mDGsGWmpT8SHN5/wC8vhxGMP6VXl7i
        KOWatdnT6qRfLHBtr68USScIok6SPyBHatyiWbxlI1ZsyuM3sGj7jA58GbtEuuwwrBRqoeWPJmezk
        DCtyl96ZIOYw5GYu00ccfXRQtrHo9Bdwe5Z2zZJ6oEzpXl6ctBFpwkvPifnFZUgA4ed6R0osNL/OW
        b3WjD/fmBeyntYS2brBuw6pk3mZurB0DAOYD1ZcHCwVRbpIOk03QNrvEUdCPj+9mgnyPjBMtOv42n
        kmyPc0vw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbUX9-008nOm-7D; Fri, 15 Oct 2021 21:14:31 +0000
Date:   Fri, 15 Oct 2021 14:14:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: fix validate_section_offset() overflow bug on
 64-bit
Message-ID: <YWnvN7jHdWHl/05D@bombadil.infradead.org>
References: <20211015205741.38283-1-skhan@linuxfoundation.org>
 <20211015205741.38283-2-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015205741.38283-2-skhan@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:57:41PM -0600, Shuah Khan wrote:
> validate_section_offset() uses unsigned long local variable to
> add/store shdr->sh_offset and shdr->sh_size on all platforms.
> unsigned long is too short when sh_offset is Elf64_Off which
> would be the case on 64bit ELF headers.
> 
> Fix the overflow problem using the right size local variable when
> CONFIG_64BIT is defined.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for doing this! I put this through the 0-day grinder.

In the meantime, since this talks about a fix, can the commit log be a
bit more descriptive about the impact of not applying the fix? In what
situation would not having this patch applied create an issue? Is this
theoretical or can an issue really happen. Has an issue gone
undiscovered for a while, and if so what could the consequences
have been all along?

And it would seem this issue was found through code inspection, not
through a real bug, correct? If this can be clarified on the commit log
as well that would be great!

  Luis
