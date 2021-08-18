Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9F3EFFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhHRI5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHRI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:57:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BECC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:56:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d4so3076118lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpVCA+HiLct3rjHe6ucM4AvKd8lS1LzE0nTcYyla1JY=;
        b=cPiyNL+7q1dClbwJ+Le6I8CEPAnTMT4V3BmBnqGPpj7r8UjlBX5iV0YSRvzjp+dg4M
         C7JuggpeEuLPrTwBN76kAyR0NoMFn4ZKsnjHlonHyk1v1BjG1wnQQHlm0SteFgZ9bySS
         nGC3qOFWt3Q4NuwEbiPao4pdi4qBJNEwphTs+pnhCr28p6vD5BGkj/dUCCY4isvkf+rj
         01OJv/dtcyCUniQ8QTj4kjrylGOyV4iaXqaLouVJ3/l38uTFAmlTh1VOTIcXaEdMpJcd
         OwqJEB7+ZRsOFlbrT7yMHE8vMdUZthz/+PCUoLsWH3vqio88k1AdC+zBDr07eikcyBYS
         XAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpVCA+HiLct3rjHe6ucM4AvKd8lS1LzE0nTcYyla1JY=;
        b=HAwmEGz2pRcBZd7CW/Lq6NL0qnHFPhz1BP6qWbGJ2kEwzJ9MtQh8J09Ryv2qyv3hyc
         g2rFYDOEwITbkfO+3h5BUAE3rqj/MEa1ZwDvaRG+szAzNX4EKLcjBobFBpoBxpWyn2WT
         Ju56nownAMmgY40QmOXZF3XS7c4mO1GPgBNV/U4pwBTTnX+p4OUFWIEa2+FOoI07FIsi
         K+I1xTfjwNGZjWt1Bwk28bkp8M4vb5+Fs6UiKkyX1vGc83GyKXItsm7JQ8tUr4hV9/rc
         QAm34emvAlsUYzckCKj/mbwTY/w96Dqlve0ShuzFXCy51E+NtgfeqHGN/P+dH5pXesXL
         XqFg==
X-Gm-Message-State: AOAM533iAPY7EM2rAqJzUTN/htRkszCahvn2/wPhtjFOOXw+RlRspe4U
        OJ/NZgiTsUTNvEbyU49vV3E2+smLA4xgFd5K
X-Google-Smtp-Source: ABdhPJwtLrN+Z+wJe7Xq9ADe9v6hoMKOnuILVBbTokrcKt8v3ogCQvfLWzfSBS/4RK91P983kWaCsw==
X-Received: by 2002:a05:6512:3f08:: with SMTP id y8mr5264543lfa.221.1629276986567;
        Wed, 18 Aug 2021 01:56:26 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u20sm200857ljl.76.2021.08.18.01.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 01:56:26 -0700 (PDT)
Date:   Wed, 18 Aug 2021 11:56:23 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/3] fs/ntfs3: Fix one none utf8 char in source file
Message-ID: <20210818085623.quzdiekdg2y2vj7n@kari-VirtualBox>
References: <20210818010649.412912-1-kari.argillander@gmail.com>
 <20210818010649.412912-2-kari.argillander@gmail.com>
 <20210818053300.GA9165@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818053300.GA9165@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 07:33:00AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 18, 2021 at 04:06:47AM +0300, Kari Argillander wrote:
> > In one source file there is for some reason non utf8 char. But hey this
> > is fs development so this kind of thing might happen.
> 
> Pleaese also refomat these comments while you're at it.  While going
> over 80 characters is ok in exceptions for readability that is per
> definition never the case for a block comment.

Yeah. Totally good option. I already did it and looks lot better.

On Wed, Aug 18, 2021 at 07:23:40AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 18, 2021 at 04:06:46AM +0300, Kari Argillander wrote:
> > In ntfs3 driver there is allocation made like this ntfs_malloc().
> > Patch 2/3 will converter these to kernel ones like kmalloc(). After I
> > did this then checkpatch raise warnings about array allocations so I
> > fix these in patch 3/3.
> > 
> > I also notice when I made patch that there is broken utf8 char so I
> > wanted first fix that because it raised some warning in my editor and
> > did not want to "break" patch 2/3. So patch 1/3 address that. I did
> > try to apply this and it seem to work without issues.
> 
> So this mostly looks sensible, but I still haven't actually seen
> the codebase this applies to posted anywhere as far as I can tell.

Yeah that's true. Only place for mention this is here (link). I have
asked that Konstantin will send patch series v28 to mailing lists. I
will resist resending v4 before Konstantin has sended.
https://lore.kernel.org/ntfs3/a9114805f777461eac6fbb0e8e5c46f6@paragon-software.com/
