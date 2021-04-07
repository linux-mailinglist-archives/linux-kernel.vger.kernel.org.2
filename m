Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953A356738
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbhDGIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349634AbhDGIrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:47:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31385C06174A;
        Wed,  7 Apr 2021 01:47:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y2so8987171plg.5;
        Wed, 07 Apr 2021 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KeY95AeaW248Jdni2uKvtKqKIpZ35VMIWlXLR/IAGFU=;
        b=QlTa9aP6Od7FRmPn45rgC6QgvbyPeSaUqqGMgJI574hUAXI30YiCad8zR/vfRum8rn
         bhp59cc10nLLdv2XVktckU+8S7828tO16CSXjgbps66TMuDZFZ0LzxuRVPGbzuslec26
         +awDgEZR+lA0lrF0Lnga3QictO9eeiBzB1auWCF2sVD4DXbJR6vLI1z/CNINmHvPG6fL
         qfogY65ne/lrMSGhJW72ytN9SRtIRDCPzSxG+MIdSIiAk1bw/dDODSSlSaqFLodVPo9q
         DsyX3xViFtQwHSxtWgPQmeXY4dszboeWg2Ua2QdGmRSXfuIaI0IO8liu1qy6E2zbHH3H
         7uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KeY95AeaW248Jdni2uKvtKqKIpZ35VMIWlXLR/IAGFU=;
        b=hd0soErQ7VRdrqqRADNwejrVZSifdInyeyHUxjfN4pfBFz/HyISlk145SASc2Zqaw7
         faKL5LKZx47Vr4+ZI+7Ob8fODHOLwSH32KbJ330hpHwIMnkT0SiBmsd0xl9EXK5JQEda
         B3XkysFVmgedwa2vrHjbyizjG40rCLgkJpse/T86bp/vnYpvRjfKC1f6tOHPsGi6DzwI
         yjdKAz5dQ6/mnZAb8S1DlFMqKmPKB7GCz9dihC9T6hy1XjJrNFyoIVJne4L1T4g47l2B
         WTNTUTAsaA/md/GF8qCV1n8aqY5/AfEHrICrsAFtwgtwimm1geu94pJEgdghNNF37050
         59Ew==
X-Gm-Message-State: AOAM532Hym20Pp8gVg8id9TDe7opvSfVE33BYeR521puZkMVK7EiXW8q
        MNDdkdxzy7hFxiUJaOFBSzg=
X-Google-Smtp-Source: ABdhPJw44TtNfcCxo7ESQE1gXwUUjSfXVkGGGi1FC8066Y5uIGei+/cRtYs/4Qour1eengsFiwGJuQ==
X-Received: by 2002:a17:903:2306:b029:e7:1c8d:63fc with SMTP id d6-20020a1709032306b02900e71c8d63fcmr2033664plh.35.1617785221783;
        Wed, 07 Apr 2021 01:47:01 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id k13sm20464718pfc.50.2021.04.07.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:47:01 -0700 (PDT)
Date:   Wed, 7 Apr 2021 01:46:59 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <YG1xg+EXSWZWn+pE@localhost.localdomain>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <YG1aVx3UuXR2JrC+@kroah.com>
 <YG1cCtbvINJ52tGT@localhost.localdomain>
 <YG1gDV6vqnUtDnbT@kroah.com>
 <YG1uNX1ZaZ106iy8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1uNX1ZaZ106iy8@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:32:53AM +0200, Greg KH wrote:
> On Wed, Apr 07, 2021 at 09:32:29AM +0200, Greg KH wrote:
> > On Wed, Apr 07, 2021 at 12:15:22AM -0700, Pavle Rohalj wrote:
> > > On Wed, Apr 07, 2021 at 09:08:07AM +0200, Greg KH wrote:
> > > > On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> > > > > Changes in v2:
> > > > >     - Removed type information from variable names
> > > > >     - Broken up the changes into smaller patches
> > > > 
> > > > Your subject is very odd :(
> > > 
> > > Sorry about that, I overlooked the fact that I reran format-patch. The
> > > subject should be:
> > > 
> > > [PATCH] staging: sm750fb: Convert camel case to snake case
> > > 
> > > Should I resubmit?
> > 
> > Not yet, let me review these first, I think they might need some work...
> > 
> 
> Ok, now you can fix them up, I stopped after reviewing patch 02/49,
> these need some work.
> 
> thanks,
> 
> greg k-h

Will do. Thank you.

-Pavle
