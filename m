Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24D380E70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhENQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhENQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:52:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9274BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:51:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gv8-20020a17090b11c8b029015d47d8ecbbso144490pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e6Gzp7eGnrG8H4GauPeUuR3AzbUI2wVGSNiIGMsXoFU=;
        b=GH0EWCQaUxR/QeQAEPLbOylF9Bcdez/FFPuOmqAi2aEG/llNf/B0Fi8bEBIgN3275q
         uXuDimJLkvAy2NFFbjsKxae8yXspDNhILL2OnqwJ6noFr1y/sP55fu8F+ILvNKPSaQTV
         SLg33vzD62ZxBbOPCsRWAs8U9EOy74QQUnpXY6MBmeD27dZT4gOl2Lr6KINPTT6sVe/3
         aAQ8xC/y3XP7IMmgRqBuwgYcNfZUHVJKiANrlehEFrbaOkgtcEQxtv8Fps6O+pIfImLJ
         EA7OMRAGoNo+Zz1mPlxz35G0GmPAA/nB/a25gY5LhjoYEo6DJHBdTgNcYfI9Xz1G6Wzn
         18tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6Gzp7eGnrG8H4GauPeUuR3AzbUI2wVGSNiIGMsXoFU=;
        b=BZQXuQBOUjmPlHEkZgkKJEriF/o95MH9+yY8BEMjUsxpWLz+t8ZxsV2Y6pdYavFrOb
         6cBSc85WbvqponPTnSh7bO+qwbbzYMirtOR50dlxCvvK2C1DE6qoeMOwdZft6zgcxwep
         PT1cX0Esc7YczGOlczkhDR2ooeVvbnbAVKo53hU+vW0x1N+xKJ8SHMoBJXyXimcfbewU
         ob237jSN0y61kjcIwOhpcTpo9SdTyA4zC/YDOBdpynH4E0nhOVURNvoSsatRF1ypNsdf
         VypYOZ4zJG9YJM/m5Ad2inc/jKPNFD9rUHG1bEQT42TRRNjf29B2VwYEDAMDlfwUKact
         xrgw==
X-Gm-Message-State: AOAM531+MHvnSqRlUOt8WKpKLaV5R2Qi+AxsgRtdJwOD/uCPSAiGbe6I
        ESpWwCZIGiABChFQhwD64kk=
X-Google-Smtp-Source: ABdhPJxfH9/KEBTNpAakNtxHhA7kdVgkqaIiThe/gzc/GWTqqMQI9DMhjPmy8EUk2OMfabKIhWIfuQ==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr12417540pjq.55.1621011089100;
        Fri, 14 May 2021 09:51:29 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id z20sm4864951pjq.47.2021.05.14.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:51:28 -0700 (PDT)
Date:   Fri, 14 May 2021 22:21:22 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ6qii1myQbv3cK2@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
 <YJ6Jf+Z1ReVgDt64@kroah.com>
 <YJ6TUAowTI75h/sl@fedora>
 <YJ6XpUMliWQOS8MB@kroah.com>
 <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 08:56:10AM -0700, Joe Perches wrote:
> On Fri, 2021-05-14 at 17:30 +0200, Greg KH wrote:
> > On Fri, May 14, 2021 at 08:42:16PM +0530, Shreyansh Chouhan wrote:
> []
> > > I didn't look at how/where was the macro called and missed a very
> > > obvious error. Now that I have looked at it, the only way I can think of
> > > fixing this is changing the macro to a (inline?) function. Will
> > > that be a desirable change?
> > 
> > No, it can't be a function, the code is fine as-is, checkpatch is just a
> > perl script and does not always know what needs to be done.
> 
> true.
> 
> perhaps better though to rename these declaring macros to start with declare_
> 
> Something like this:

Thanks! I can definitely help with this. I'll send the patch in a bit.

Since it seemed as if the original patch wasn't really required, I canceled
the moderator approval request for the greybus-dev mailing list. I
thought I'd rather not bother the moderator and the rest of the list
with these patches. I thought I should mention this since it could cause
some confusion. I will start a new thread for the other patch.

Regards,
Shreyansh Chouhan
