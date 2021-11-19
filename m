Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0C45764A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhKSSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234002AbhKSSXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637346010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdcrdYD9xvWbUGPWMX7bjgUSsVwyTNyxmOGq1Ztij9c=;
        b=FyAomhjH5ldOJMkSaTpEyTMhVD/D1+NFS8wsfcgF3SQzcfXOdSv706gidDcuIDa6lYt0+/
        TvCbDXxr+ou3F6ShbYRMUHG7b/+G4s2q76lDwwuzMdDBnocJwzm9ZlK8M2dMVD0UH4Js0B
        2eta2e4bJA5L7a4qH6MoM7w8cFqjBLE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-fIOPC90vMAOganEEzz1rWA-1; Fri, 19 Nov 2021 13:20:09 -0500
X-MC-Unique: fIOPC90vMAOganEEzz1rWA-1
Received: by mail-ot1-f70.google.com with SMTP id v13-20020a056830140d00b0055c8421bd62so6349439otp.15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 10:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdcrdYD9xvWbUGPWMX7bjgUSsVwyTNyxmOGq1Ztij9c=;
        b=VNTeoduaDwnfJwB2/PDJR0UzhYMKDH7GOZWbDmYGlXWvgVYUNJ1DhMftj2hhbdKPpI
         pwkBMzUh2iPVY5YFn1F+fJMQMlYrRZO4Jvmmg8pAEExv2ODezUuQAVF+8uGHa9JpZTB+
         3f1NmH5QIo8FMvV6GTiY1jA76qQMtNCYoR7/MgvLrhdtON3wmshSJtS7c3LinxrIv8LZ
         HM1jJPhFiQZcMd7s9id/TCzcGHRu6qsl8sX1pS6Rzbv98BeEiTCFuHxENcVC26WGuXt/
         reMB9osdWm12luDUIZoq6v7oeHXd8GFVUW2CDr2/A8Sg9YBn4kGVDgjIImDlFdakuoOE
         kwgQ==
X-Gm-Message-State: AOAM5325nMpeSDX45KTDpYg0RV4yo0ByAWZKZKKIUmq1G89pEFmNQqrB
        Tu2Hw4Ro3Ys9JTLtuNvLtySVDHJjCBtPNHH1K0cTNrE+WGjb/FztMCqJj389QGB7b4miMIpZO5o
        lpkOpsl8++WbCZsmDKpcc1IWm
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr6494033otq.306.1637346008854;
        Fri, 19 Nov 2021 10:20:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXWrvXCyVmmPw41zaXwMQvDoNIZwprsge5LSnVZv3n13O9g0G8kwLR62belVexqxGn1q5CKg==
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr6494000otq.306.1637346008634;
        Fri, 19 Nov 2021 10:20:08 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id l27sm118214ota.26.2021.11.19.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:20:08 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:20:05 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Allow user to specify functions to search
 for on a stack
Message-ID: <20211119182005.t3p5iyxyibzktrbj@treble>
References: <20211119090327.12811-1-mbenes@suse.cz>
 <20211119090327.12811-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211119090327.12811-3-mbenes@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for doing this!  And at peterz-esque speed no less :-)

On Fri, Nov 19, 2021 at 10:03:26AM +0100, Miroslav Benes wrote:
> livepatch's consistency model requires that no live patched function
> must be found on any task's stack during a transition process after a
> live patch is applied. It is achieved by walking through stacks of all
> blocked tasks.
> 
> The user might also want to define more functions to search for without
> them being patched at all. It may either help with preparing a live
> patch, which would otherwise require additional touches to achieve the
> consistency

Do we have any examples of this situation we can add to the commit log?

> or it can be used to overcome deficiencies the stack
> checking inherently has. For example, GCC may optimize a function so
> that a part of it is moved to a different section and the function would
> jump to it. This child function would not be found on a stack in this
> case, but it may be important to search for it so that, again, the
> consistency is achieved.
> 
> Allow the user to specify such functions on klp_object level.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
>  include/linux/livepatch.h     | 11 +++++++++++
>  kernel/livepatch/core.c       | 16 ++++++++++++++++
>  kernel/livepatch/transition.c | 21 ++++++++++++++++-----
>  3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 2614247a9781..89df578af8c3 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -106,9 +106,11 @@ struct klp_callbacks {
>   * struct klp_object - kernel object structure for live patching
>   * @name:	module name (or NULL for vmlinux)
>   * @funcs:	function entries for functions to be patched in the object
> + * @funcs_stack:	function entries for functions to be stack checked

So there are two arrays/lists of 'klp_func', and two implied meanings of
what a 'klp_func' is and how it's initialized.

Might it be simpler and more explicit to just add a new external field
to 'klp_func' and continue to have a single 'funcs' array?  Similar to
what we already do with the special-casing of 'nop', except it would be
an external field, e.g. 'no_patch' or 'stack_only'.

Then instead of all the extra klp_for_each_func_stack_static()
incantations, and the special cases in higher-level callers like
klp_init_object() and klp_init_patch_early(), the lower-level functions
like klp_init_func() and klp_init_func_early() can check the field to
determine which initializations need to be made.  Which is kind of nice
IMO as it pushes that detail down more where it belongs.  And makes the
different types of 'klp_func' more explicit.

-- 
Josh

