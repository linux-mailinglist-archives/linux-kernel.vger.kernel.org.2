Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB33042652F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhJHHZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229693AbhJHHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633677821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YgEXZX5OxqWOsGwlpu4TMu4s2vcLohvhH6SrOFN2mIc=;
        b=BraYmuMeO/aJwcAFAPl/UpnMj2aZw6WZoVNg6/MiLhbrt6UJkf29LNKk22RAc+L67vXsul
        3BRj4qK/NJ3sTGFCn9wIhsnmYFz0aqXVykEYfMKfUHYQI5Cs4aJePqoeHwbCUQoDvBIOVf
        oZcYwbHA2IeCBd1PFTjqo+E5HTUrLYM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-oFiUNTbTOj-ihgG7MYPqxA-1; Fri, 08 Oct 2021 03:23:29 -0400
X-MC-Unique: oFiUNTbTOj-ihgG7MYPqxA-1
Received: by mail-qt1-f199.google.com with SMTP id x6-20020ac81206000000b002a6e46bbd0eso6993099qti.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YgEXZX5OxqWOsGwlpu4TMu4s2vcLohvhH6SrOFN2mIc=;
        b=u0iy5U1q2UQQ08x7qAtV62bJQWt3a09vT7UEneBZYOnw6gjWE3Mu+hopQpDBJHmd56
         4fXV64XhBD03J3dQm3nPkuxz1YVo+kUhVrQBb3XgHJW0+Ne8crVpWpbJN7u7nq3xBYG6
         E0fwLn11LOlJOx1RAEgzvCAqHllLFXY/soxC+o7GtPnzx2Ygz6WCPzHQlBrgCp89q7z3
         clYaLu2hNh75ryBwaRN34DnBogyYDZAArx6QTf38die8h7dDM3tg1EyjA251pQcJ8+Ux
         AYaRXnyQBegT47tN0AUj2JHegl2oLyMkzvfxyjaZECjE8Npg8ElIifIVqxuZrmvMPsIB
         Q1Bg==
X-Gm-Message-State: AOAM531BDfrSHH9I0wy0Kh7E8573BkPqrNoUddeSjsq9T50Za1qNqvQD
        QCcVdiAisLTdk4+VYREjjZjgKMuiPGgDm2XeG+BPuvO6RPWi5jBDDF1sFMTiLb7PSJ8k67PkJY3
        DEJSZUSZ/3lCKdxxCG8BcrPwg
X-Received: by 2002:ac8:6158:: with SMTP id d24mr10240507qtm.115.1633677809240;
        Fri, 08 Oct 2021 00:23:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq0DRDD526ahsmTrMLCChsSLkDiBeEuyd9fLN3A18iXx15Y/BzARdhD3VHPuugMn0sTZQjUA==
X-Received: by 2002:ac8:6158:: with SMTP id d24mr10240489qtm.115.1633677808998;
        Fri, 08 Oct 2021 00:23:28 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id s18sm1710546qta.10.2021.10.08.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:23:28 -0700 (PDT)
Date:   Fri, 8 Oct 2021 00:23:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] objtool: Optimize/fix retpoline alternative
 generation
Message-ID: <20211008072325.4qujedsjtjqbvzrd@treble>
References: <20211007212211.366874577@infradead.org>
 <20211007212627.008917519@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211007212627.008917519@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 11:22:13PM +0200, Peter Zijlstra wrote:
> When re-running objtool it will generate alterantives for all

"alternatives"

> retpoline hunks, even if they are already present.
> 
> Discard the retpoline alternatives later so we can mark the

Discard? or mark as ignored?

> +++ b/tools/objtool/check.c
> @@ -1468,6 +1468,14 @@ static int add_special_section_alts(stru
>  				ret = -1;
>  				goto out;
>  			}
> +			/*
> +			 * Skip (but mark) the retpoline alternatives so that we
> +			 * don't generate them again.
> +			 */

I'm having a lot of trouble following this comment.  In my half-sleeping
state I'm theorizing this serves two purposes:

  1) skip validating the alt (because why?)

     and

  2) if re-running objtool on the object, don't generate a duplicate
     alternative?  or maybe it also avoids duplicates for retpoline
     alternatives which were created in asm code?

Not sure if I'm right but either way the comment needs more content.

Also not sure about $SUBJECT, maybe it can be more specific.

BTW, this "re-running objtool" thing is probably a bigger problem that
can be handled more broadly.  When writing an object, we could write a
dummy discard section ".discard.objtool_wuz_here" which tells it not to
touch it a second time as weird things could happen.

-- 
Josh

