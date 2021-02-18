Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896F831E843
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBRJgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhBRIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:25:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F57C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:25:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id f8so842539plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZXmJoWMTsUrH2ZYtYp6YioWvsZMFTlZD5M/gphHqrR0=;
        b=Hc4WfW2OwdvOfAd4uK/tsJFBw9Y3KnhIHI15RQioABsLIYYJ/F0keIOX4rFXdiTdPA
         3oF6krSEpCdiFEoF+R6hRv6c10f0Kh77dxSGhGkVvAmNWNnSDsRhtpTX27g6SUtHMZ1D
         9AEyQTMzteT2PtGkgLjLV9v49y316FbgxGlQzyfRJu+b9PBsYucAf2fIHMBjOZ/G9EbC
         CGFUXXJ6Lc7VnIG5CDYG+TSwQCi6gS33E+k2WEwpodQP/FyPSC2N/Com0PD5W8xd1003
         8bjep+nikHR8OdnsB1NdNmPGDMr+B97t3gnaARMA6P7jCmrSRLOrp/7jqSO78BWGq/YN
         xZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXmJoWMTsUrH2ZYtYp6YioWvsZMFTlZD5M/gphHqrR0=;
        b=grG5j0ZnqLBYUILgmf26/cw+RkdyfJ5LCwAHrvgRYjrLo2B8Go0qxL3RupldZKZlji
         BWhPyIVTjyJpfJia2g/vzonMFXH+MrRRyLYLw0rDBA9l1vU0qq9jAgQYvAxELwweHQBF
         QkFdtCw6N3R5rF2zDnaeWc4Rtgv2NzEZxlN5B5vmw/xk6eZJipOXuYji3XkjSxLKl0Zl
         2EmUyfuzPRrQzmK5Jj5NRbQnjNHAHyiuvv6OPWYPiM+4e7ERN7bAJVzQfK7dLc8B5d4z
         weh2cY3k7uQfHLNvZ38qsEgoPQy07YWXZ04stLDWERj2iLSlKoDSSxojxrFT9Xr916wx
         NNOA==
X-Gm-Message-State: AOAM530aOAVgZ7cygx6+TKAKtTGKMWuQYtwjW37fzB4h5lI7frn4IKYo
        CQCdEQmDHcGSZ+eAexJnUj4=
X-Google-Smtp-Source: ABdhPJyhhnf+/pc2nHrJk1TK1bIScUijp1RLFu+59a3U8HAj4ag5pQwqLlGugrMlUa9+kap5neQc+Q==
X-Received: by 2002:a17:90a:de97:: with SMTP id n23mr2973053pjv.165.1613636708080;
        Thu, 18 Feb 2021 00:25:08 -0800 (PST)
Received: from atulu-ubuntu ([27.61.13.238])
        by smtp.gmail.com with ESMTPSA id l11sm4602059pfd.194.2021.02.18.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 00:25:07 -0800 (PST)
Date:   Thu, 18 Feb 2021 13:55:02 +0530
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: cast to (void __user *)
Message-ID: <20210218082502.GA2257@atulu-ubuntu>
References: <20210218062839.32650-1-atulgopinathan@gmail.com>
 <YC4S5Pxw341zw9DL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC4S5Pxw341zw9DL@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:10:28AM +0100, Greg KH wrote:
> On Thu, Feb 18, 2021 at 11:58:40AM +0530, Atul Gopinathan wrote:
> > Resolve the following sparse warning:
> > drivers/staging//comedi/comedi_fops.c:2983:41: warning: incorrect type in argument 1 (different address spaces)
> > drivers/staging//comedi/comedi_fops.c:2983:41:    expected void [noderef] <asn:1> *uptr
> > drivers/staging//comedi/comedi_fops.c:2983:41:    got unsigned int *chanlist
> > 
> > cmd->chanlist is of type (unsigned int *) as defined in
> > "struct comedi_cmd" in file drivers/staging/comedi/comedi.h
> > 
> > The function "ptr_to_compat()" expects argument of type
> > (void __user *) as defined in include/linux/compat.h
> > 
> > Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
> > ---
> >  drivers/staging/comedi/comedi_fops.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Is this different from your previous patch:
> 	https://lore.kernel.org/r/20210217165907.9777-1-atulgopinathan@gmail.com
> 
> if so, you might need a better subject line here, and for that one, as
> they look alike at a quick glance.
> 
> Which one goes first?
> 
> Can you resend both of these as a patch series with better subjects as a
> v2 patch set?

Sure! That subject line was a terrible result of me trying really hard
to make it concise and fit within git's recommended 50 character limit
for commit headings. I will make sure to prioritize on quality more. :D

Thanks for the feedback!
Atul
