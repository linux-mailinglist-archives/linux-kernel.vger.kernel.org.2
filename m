Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481394566A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhKRX6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhKRX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:58:19 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81645C061748
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:55:18 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n26so7681195pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aZe+nT3gJmAC1jBewUM/ahviGBfCpmTFfLqD9KH/ck=;
        b=ODNp1bfHSnlsNs4aE3Jo2hVoO4h+olSPt+4c4FgQ1SVDL+ZkbZi2D+bTCjTuovQdOm
         f8/xCKVbbxCTWNMHX3Wf1lgTspvoo1zCiIQGcvz5fgN0lScKcFgVmUSX8V4VHqMrIMjk
         z4OI1Fqv8D9YIsyHtbrjoZQ1hfTcVGOFRETpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aZe+nT3gJmAC1jBewUM/ahviGBfCpmTFfLqD9KH/ck=;
        b=FJl8DSsZFiRZtedVksHWr4gQUdz0pFdi/KVbsOPhgVupN8VouusNOx660+ACuAMfmn
         JIpH/NpoDmpeU0gkTFPSU3e6RMJVsUdUwWrhrTcjXsIp4x1B84hIF2ExF4j4CyQYFvAT
         BeHZbU2tz/7P1fpNm7B+4+8V3DBn6jemcjWKPLlS/64E2miDpBOK0QgUe4iZVyi7Tdzk
         jn2erDpQzYeQMCb6OMkYi19m+oBpu+OVQoHIhaslmkCBpyHHVlhN5hRvaXdyrQZw2okg
         boKHpQVbBPDd2MclJ5VkQJR1Y3H0ULfxy01FQu3AWBL3W2Wa3eVcYNKjnechc7cn05q1
         WsrQ==
X-Gm-Message-State: AOAM531Lvlrb39G3sRdGHEz0IibigoeLI2WqwfRStJd20BZisaR72ihj
        J/nR/lRnL2FHux2oZyJfjGhCpQ==
X-Google-Smtp-Source: ABdhPJytTdFbloemAnx23OX3o4NSVhTyucBZ3SrY/fPVRBcZxzayGjAz5Ho0l1TuX8iYlzEIO3IakQ==
X-Received: by 2002:a63:e40a:: with SMTP id a10mr14042482pgi.299.1637279717990;
        Thu, 18 Nov 2021 15:55:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm700633pfc.182.2021.11.18.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:55:17 -0800 (PST)
Date:   Thu, 18 Nov 2021 15:55:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sata_fsl: Use struct_group() for memcpy() region
Message-ID: <202111181554.8C4F58860D@keescook>
References: <20211118183807.1283332-1-keescook@chromium.org>
 <0dd24142-a5e6-b146-9315-d2680ef4ed35@opensource.wdc.com>
 <202111181533.2D90E391@keescook>
 <701e73f0-cc75-0e9a-de4e-1b949eb11fda@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701e73f0-cc75-0e9a-de4e-1b949eb11fda@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:52:36AM +0900, Damien Le Moal wrote:
> On 2021/11/19 8:39, Kees Cook wrote:
> > On Fri, Nov 19, 2021 at 08:17:14AM +0900, Damien Le Moal wrote:
> >> On 2021/11/19 3:38, Kees Cook wrote:
> >>> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >>> field bounds checking for memcpy(), memmove(), and memset(), avoid
> >>> intentionally writing across neighboring fields.
> >>>
> >>> Use struct_group() in struct command_desc around members acmd and fill,
> >>> so they can be referenced together. This will allow memset(), memcpy(),
> >>> and sizeof() to more easily reason about sizes, improve readability,
> >>> and avoid future warnings about writing beyond the end of acmd:
> >>>
> >>> In function 'fortify_memset_chk',
> >>>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> >>> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
> >>>   199 |    __write_overflow_field();
> >>>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> >>>
> >>> Signed-off-by: Kees Cook <keescook@chromium.org>
> >>
> >> This lacks some context with regard to FORTIFY_SOURCE and struct_group(). Is
> >> that already in 5.16 ? It sounds like it is not. Do you want a ack ? Or do you
> >> want me to queue this up for 5.17 ?
> > 
> > Ah yes, some details are here in the earlier "big" series cover letter
> > here:
> > https://lore.kernel.org/linux-hardening/20210818060533.3569517-1-keescook@chromium.org/
> > 
> > One of the requests from earlier review was to split it up for separate
> > trees for the maintainers that wanted to take stuff via their trees
> > directly.
> > 
> > The new helpers are landed as of v5.16-rc1, so it can go either way, but
> > given that the merge window is closed, I would expect this to be for
> > v5.17.
> > 
> > I am happy to to carry it in my fortify topic branch that I'm expecting
> > to send for 5.17, but totally up to you. Some folks like to take these
> > changes via their trees, others would rather not be bothered with it. :)
> 
> OK. Since it looks like the compilation warning will trigger only when your big
> series land in 5.17, I will queue this in for-5.17 (still need to create than
> one). Is it ok with you ?

Yup, that works for me.

Thanks!

-Kees

-- 
Kees Cook
