Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C113B8053
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhF3Jtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhF3Jti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14DC061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:47:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1071724wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
        b=zLTi5aCbnypPB5E3aUA0ZTW2QZ9ElWO1rUMChAnrYkbnv5R1HppvSR83sz83GmhmUA
         UMxwvrtyn70Zd9AoLodBjAgPxIMvZ1UB4cERbwNt9h4ezFzozjlRXTJceovl8itCNtkO
         ZHpCXotz6yp1b1LU/oBZfpMMbHJ9z37zfQLOhI93YEXu77Z1hvbdB1hXccB0ErO3BuRM
         2v2H3xdjL56voJXkKEkXOJouofN6tE6pWAPsziIGqT+x1uxsqXS8aHT7JlV4vp9xlNdX
         RRmNLJxKm6216ZAGJ10+La1loxmhKlUG8r/gC+MQIkg6soAQE9aR2vguk2YO28brVd4+
         UeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
        b=G18OoVBRkP5AX0zIYTU6cYgDoX8/u7MExPGhaka4ixNYKlBm/0Jy0mcvvOz9hZ1wMp
         +OdJGU8fHGdWEpfJXL9xbl6j6sHTQW5U6HgU+4lUlEhEsxR7/EBqyY5GdWYUwQYT0/Dt
         WhNls2lehjy0FUNyFPalUzV2+DCG+dpAEdf/Ju49Efogupp17CIVkEn4EkT5/yNIQw3N
         VlMW/Iju3w/t0MzTDUo3rswTxdptl8Tk4vtQ+pBSSUkYh4I8Q1Otc0ukfAq0nuZqt74p
         1UplmH9RieEyC7kGbRfn3sG46IYkMnlBR3rftSu8qaHaCa1tKfXfxYe8DyPrEidvLlHj
         iE5Q==
X-Gm-Message-State: AOAM531qDdUOO7vRr+7ZFaOkSebQEzofd8qNLFBJnQ7QX62o2qR1L05I
        Juq11YO4jqScYZzTtphic4M/BQ==
X-Google-Smtp-Source: ABdhPJysgaWNsxoQ1Ekn5yIfyUpjV6tLOTWrZta/4RIlCjFmHAXWqbWe870FTEuNbqmWvtd9IqJeZQ==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr3558850wmd.33.1625046428092;
        Wed, 30 Jun 2021 02:47:08 -0700 (PDT)
Received: from dell ([95.144.13.171])
        by smtp.gmail.com with ESMTPSA id p7sm8990839wrr.68.2021.06.30.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:47:07 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:47:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     Satya Tangirala <satyat@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 0/8] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YNw9me1Fd6Siy18A@dell>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
 <YK09eG0xm9dphL/1@google.com>
 <20210526080224.GI4005783@dell>
 <20210609024556.GA11153@fractal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609024556.GA11153@fractal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jun 2021, Satya Tangirala wrote:

> On Wed, May 26, 2021 at 09:02:24AM +0100, Lee Jones wrote:
> > On Tue, 25 May 2021, Satya Tangirala wrote:
> > 65;6200;1c
> > > On Tue, May 25, 2021 at 01:57:28PM +0100, Lee Jones wrote:
> > > > On Thu, 21 Jan 2021 at 23:06, Satya Tangirala <satyat@google.com> wrote:
> > > > 
> > > > > This patch series adds support for direct I/O with fscrypt using
> > > > > blk-crypto.
> > > > >
> > > > 
> > > > Is there an update on this set please?
> > > > 
> > > > I can't seem to find any reviews or follow-up since v8 was posted back in
> > > > January.
> > > > 
> > > This patchset relies on the block layer fixes patchset here
> > > https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/
> > > That said, I haven't been able to actively work on both the patchsets
> > > for a while, but I'll send out updates for both patchsets over the
> > > next week or so.
> > 
> > Thanks Satya, I'd appreciate that.
> FYI I sent out an updated patch series last week at
> https://lore.kernel.org/linux-fscrypt/20210604210908.2105870-1-satyat@google.com/

If you end up [RESEND]ing this or submitting another version, would
you mind adding me on Cc please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
