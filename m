Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C242736CB79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhD0TIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0TIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:08:35 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0109EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:07:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 291932C1;
        Tue, 27 Apr 2021 19:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 291932C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619550471; bh=1Eu6jn0+Hdlv1AiUhj8Uu++pzaym7+5MDJ6U7bYjHqs=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=HoZDMgyPL4Ob7jyk/Eoq1oYGy61CIfM/vb0Yq4GqK5b/J7eZhA5hID5yISUUyi4cS
         fDAKEdsegXTdoErIZykGXihLZQNJdvso6mNQLiLp2lHVNg9fejf1AioviGGOWUU6zI
         XnGD2iCApvZKqZHPRcT0euw0dZtzyS+LBBt1n3cuLpbrgP59VaBTEq0xu9Ao2K19nt
         EO2i/6+1Hw8KU4om1sQYlwjm62CoymHwf6OlN+sOEPQUusBR0HOM9And67T7LemBk+
         lBWok1zOK6opFDmJ/LTA/7IMTYWa5VuRVkY3w3Kdm1bHZErLuYAP3sAknH+BPKm81W
         hPjbzkbci/1KA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     bilbao@vt.edu, Carlos Bilbao <bilbao@vt.edu>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typo in Documentation/x86/x86_64/5level-paging.rst
In-Reply-To: <2599991.mvXUDI8C0e@iron-maiden>
References: <CACbHsvSta2hogK0E4AKCxsUF3bFrdQTAA-mp2MvO6Q7+rQuKCg@mail.gmail.com>
 <871raveno6.fsf@meer.lwn.net> <2599991.mvXUDI8C0e@iron-maiden>
Date:   Tue, 27 Apr 2021 13:07:50 -0600
Message-ID: <87bl9zczqx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bilbao@vt.edu writes:

OK, we're getting closer...

> Hello Jon, thanks a lot for your feedback, it was instructive. I attach changelog and the patch as plain text below. 

A comment like this should go below the "---" line; otherwise it has to
be edited out when the patch is applied.

> I fix two typos in the documentation (Documentation/x86/x86_64/5level-paging.rst), changing 'paing' for 
> 'paging' and using the right verbal form for plural on 'some vendors offer'. 

Please keep changelogs below the 80-column limit.  Some maintainers will
also get grumpy with you for not using the imperative form ("Fix two
typos") here.

> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> ---
>  Documentation/x86/x86_64/5level-paging.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/x86/x86_64/5level-paging.rst b/Documentation/x86/x86_64/5level-paging.rst
> index 44856417e6a5..b792bbdc0b01 100644
> --- a/Documentation/x86/x86_64/5level-paging.rst
> +++ b/Documentation/x86/x86_64/5level-paging.rst
> @@ -6,9 +6,9 @@
>  
>  Overview
>  ========
> -Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
> +Original x86-64 was limited by 4-level paging to 256 TiB of virtual address
>  space and 64 TiB of physical address space. We are already bumping into
> -this limit: some vendors offers servers with 64 TiB of memory today.
> +this limit: some vendors offer servers with 64 TiB of memory today.
>  
>  To overcome the limitation upcoming hardware will introduce support for
>  5-level paging. It is a straight-forward extension of the current page
> -- 
> 2.25.1
>
> On Tuesday, April 27, 2021 11:45:45 AM EDT Jonathan Corbet wrote:
>> Carlos Bilbao <bilbao@vt.edu> writes:
>> > Signed-off-by: Carlos Bilbao <bilbao@vt.edu>

Just about *all* maintainers will get grumpy with you for top posting;
never do that.  Especially not for patches, but just don't do it ever.

I've fixed these things up and applied (what appears to be) your first
kernel patch.  Thanks,

jon
