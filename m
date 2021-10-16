Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C743034C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbhJPP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhJPP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:29:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C4C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:27:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so5518494wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1d8J0Orw/hk2ukRu7tKUFBvEuXpF7xwwE6uX/V+ILtU=;
        b=5jh2oic+IgJVmmhSYdguTK1DWEdkkhGOKGYWwNxC+m3+0xcjCmuVHvaN52Io94u8tk
         mG0+Fe2OEg6ms8/wKQkUuW6nLIvu4zugBI1WQMwinOZuwKrAXhVQMHZYghaqkBJQ2A/q
         7DWzlm7ZezTe/oXCAzGxYce48fO8xyWkPmEClXTEk58lY2TBCLSkjknrFjBU9gDTz+yv
         gzc4pAQ5Tf3/hokbMFtdAPwOQbv/KRvofgucgMXDC+CFqXOfiyzZWdCuSOZKwjoVPnXC
         T+NLhGiGauuHO/cQlwkzb2Vrp92ALTbMg8iUP+bXyqJqfFtDveI8dfmrcT6mQ+ID1r6b
         HkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1d8J0Orw/hk2ukRu7tKUFBvEuXpF7xwwE6uX/V+ILtU=;
        b=0PUx0WBAACv3WrgZILQ26luV+ovhozeQLq0CEMy+rrAiMIbyGX0t7xv2dGpHMaH6yS
         kyUdjIm1UIyb8QAHCxaQ/K13peEvVN2Mw2G0xYCX2DjeSo9daBQWhJy2JZe5NbPbcGRu
         WkowJKvGMGCO9SJkod93UCrW5lRxRnpj10sL447JB0jzuCsJczB6siR9n8/77+EQTt3N
         8JwoYmFvOeP4HrUmXiZk0VWvpsBWXHywq/0OnJNPGusqiHK9RJA/NVzmL3Uetfkm+4/T
         CzRqls5ALRuFE3nwtOBw7wY5RWEZI3UrFTwycyQsXwFsRN8aRsWuGNUMzshvLWQ6zQnp
         AvdA==
X-Gm-Message-State: AOAM530/6dpF3EQDvm8Q6c89Oj8jXC9iG35sLMEF3C2C19TQvCLot8Rg
        N1b+RUXn7cZAi3M4eyC2iCnZ8g==
X-Google-Smtp-Source: ABdhPJzgI1Y1ZxagsGxK7AqFA7XKRlD93cZM/p2/C6fvciCpi0Pe0UH0RiglOr6HOfP+77rDnOUkbg==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr33755674wmf.0.1634398063142;
        Sat, 16 Oct 2021 08:27:43 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id j1sm8988536wrb.56.2021.10.16.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 08:27:42 -0700 (PDT)
Date:   Sat, 16 Oct 2021 16:27:40 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: r8188eu: use completions and clean
 rtw_cmd_thread()
Message-ID: <YWrvbPkqer43C+Fk@equinox>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016091042.19614-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 11:10:39AM +0200, Fabio M. De Francesco wrote:
> This series replaces two semaphores with three completion variables
> in rtw_cmd_thread(). Completions variables are better suited for the
> purposes that are explained in detail in the commit messages of patches
> 1/3 and 2/3. Furthermore, patch 3/3 removes a redundant 'if' statement
> from that same rtw_cmd_thread().
> 
> Tested with ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]
> 
> Many thanks to Dan Carpenter <dan.carpenter@oracle.com> who helped with
> his review of the RFC Patch.
> 
> Fabio M. De Francesco (3):
>   staging: r8188eu: Use completions for signaling start and end of
>     kthread
>   staging: r8188eu: Use completions for signaling enqueueing of commands
>   staging: r8188eu: Remove redundant 'if' statement
> 
>  drivers/staging/r8188eu/core/rtw_cmd.c    | 19 +++++++------------
>  drivers/staging/r8188eu/include/rtw_cmd.h |  5 +++--
>  drivers/staging/r8188eu/os_dep/os_intfs.c |  8 +++++---
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 
> -- 
> 2.33.0
> 

Dear Fabio,

Built and tested on my USB-N10 Nano, working well. In terms of how
you've split the patches out, I have no problem with it personally,
given that one semaphore was there for kthread start/stop and the other
for queuing. Looks good to me anyway based on what I know of completion
variables :-) I assume you've not made the waits killable or
interruptible in patch 1 due to the fact they are specifically related
to kthread start/stop? Anyhow:

For whole series:
Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
