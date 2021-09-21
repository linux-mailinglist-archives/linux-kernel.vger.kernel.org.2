Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76D6413E07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhIUXc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIUXc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:32:26 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:30:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u22so1659656oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4qChEl1sgA5DGAUFkJiPbV2Qy64fRtkylb8jYRAJqTM=;
        b=ksKuH+iTmEobV/bnWPS3WEekoC2PaWqW8ekaWW25+P2usAgAW7ojUEZwXd5PaxjYzT
         CTNuZg8mfTqACGrglVNAXTxBauFBMHHQPpV8O250dbqA+oDkJGGB+nu5k5JDWW/5pGEZ
         ulX6DAEDLme6qHKUpJ8uZr8wSZ8QrZz3lrPmgHeypDCwWVanNMaqAV/4yxh4rVi2HsYI
         5GJ+96gMxBgk3Gs9lUGwsD4usD2WH2UdqHXiZwq9HSFyPwv4+43QFe3hwj5DdjAls9h0
         py5ymApC7GVDhwIzToJaVtJaTehEGp7IGC+5nNamdI1AnWEWD0HSgc+e3wttpC4KzA63
         8IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4qChEl1sgA5DGAUFkJiPbV2Qy64fRtkylb8jYRAJqTM=;
        b=zsdbdqSPvDkFEBOFfjG3Kv9JxzlJWiqieWzt3k+y4zPsKAvhQxzWZzBWqFh1d3ZGOa
         cLyKDx6kCYQJvQDLR2kkXPgBfM9URB+c4dmDZbpJsRpzIcchtjZj55ieKPiqaik6M4Uj
         RuI0V0TY/UUJ457RaEzAc5uNQugOYq6L9TANFUDVuqL1an/Xz2kQJtoYSV2eZyO/kQNE
         0NiTJ5RwwHZ2ycvljh54cdsjL7ab0ZI8+AtiTyou9aPP7OKMZFyP/F4UckerjF96OPjN
         0taLtJmFF45eLTOAIlrg9NYc3pREESTI7PvKUGn4MYeEluEfcUSIcjHwmITPZ3H4a2XV
         hjJg==
X-Gm-Message-State: AOAM530Yjp1DrV+PS1TM5ZAC9F0MjMYw97+u3GY2otfu25EyPztYllVL
        rWnr6bDfuvCoPbksNbxGESBAfw==
X-Google-Smtp-Source: ABdhPJyjldyg2TGfw9nWFgy6YQOjSLILWjIR0gFyDn+NQN4SVY2S3orp5IUw4GhS3mkVrKYVp58Dmg==
X-Received: by 2002:a05:6808:2099:: with SMTP id s25mr5902116oiw.97.1632267056767;
        Tue, 21 Sep 2021 16:30:56 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 65sm104853otc.32.2021.09.21.16.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:30:56 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:31:38 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <YUprWiZNgPt2YEUl@ripper>
References: <20210921082438.26550938@canb.auug.org.au>
 <20210922090235.2a626af6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922090235.2a626af6@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Sep 16:02 PDT 2021, Stephen Rothwell wrote:

> Hi all,
> 
> On Tue, 21 Sep 2021 08:24:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > In commit
> > 
> >   33c4296d99ef ("arm64: dts: qcom: sc7280: fix display port phy reg property")
> 
> This is now commit 1a5968e5b7de.
> 
> > Fixes tag
> > 
> >   Fixes: 9886e8fd8438 ("arm64: dts: qcom: sc7280: Add USB related nodes")
> > 
> > has these problem(s):
> > 
> >   - Target SHA1 does not exist
> > 
> > Maybe you meant
> > 
> > Fixes: bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
> 
> Surely if you are going to rebase the tree anyway, you can fix this up
> :-(
> 

Yes of course!

I had made a git merge snafu earlier in the branch, fixed the fixes and
then fixed the snafu, which broke the fixes...

I should have double checked this before pushing out the rebased branch,
but it looks okay to me (and checkpatch) now.

Thanks,
Bjorn
