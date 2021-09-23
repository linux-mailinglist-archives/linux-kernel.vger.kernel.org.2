Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB44155AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhIWDAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 23:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbhIWDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 23:00:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21538C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vCwqPpKpFoYR/HoAFTSRyHPaX5Ao3ESn8CUqdRVhDvI=; b=QzAmFNTHk8HdZbrAU+/ncY6EHk
        wAAmBFMIz8SLK/jdMWcBm6fMtRxe/rQOt2pl6r5G/TEeYcJarskqDijuwiNQtUyJHEwcHLlAajwcH
        4mwn2vykag6FmKOblqiRiEqiGlekGxin8O+o4QLqp8Mcv0tssNUhKMLhf6EV1tYHTqGhcajVE2WCn
        jwwj7+GBSh1K75yyvJhObMZKuP7N3ZhIO6GOhm43hLaMJ23pij0pi8DGl2JpEHKPcaw78zAjH4u8g
        Ik8HkvUyy5fhlaJ1I9AqfrZyPhodww+6JUoFxGGuJdWspE8Hi46FzW/Wg38VJjcARR+nhQRSyhutv
        glCcU53g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTEx3-00A8fE-9P; Thu, 23 Sep 2021 02:59:09 +0000
Date:   Wed, 22 Sep 2021 19:59:09 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: fix invalid ELF structure error to print error
 code
Message-ID: <YUvtfUHb+8XjEtTf@bombadil.infradead.org>
References: <20210923001442.58278-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923001442.58278-1-skhan@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 06:14:42PM -0600, Shuah Khan wrote:
> When elf_validity_check() returns error, load_module() prints an
> error message without error code. It is hard to determine why the
> module ELF structure is invalid without this information. Fix the
> error message to print the error code.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  kernel/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 40ec9a030eec..a0d412d396d6 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3941,7 +3941,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	 */
>  	err = elf_validity_check(info);
>  	if (err) {
> -		pr_err("Module has invalid ELF structures\n");
> +		pr_err("Module has invalid ELF structures:errno(%ld)\n", err);
>  		goto free_copy;

The subject seems to indicate a fix is being made, and I think that the
bots that pick up fixes through language might find that this is a
candidate because of that. It is not, and so if you can change the
subject to indicate that this is just expanding the error print message
with the actual error code passed it would be better.

Now, if you look at elf_validity_check() and how it can fail, it would
seem tons of errors are due to -ENOEXEC. Even a function it calls,
validate_section_offset() also uses that return code. So on failure,
you likely won't still know exactly where this failed as you likely
will juse see the -ENOEXEC value, but that won't tell you much I think.

So, it would seem a bit more useful instead to add some pr_debug()s
on the elf_validity_check() and friends so that dynamic debug could
be used to debug and figure out where this did fail, when needed?
Thoughts?

  Luis
