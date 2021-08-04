Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A5E3DFCC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhHDI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhHDI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:26:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F68C06179B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:26:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k4so685973wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wshwpEouxlj43w/LQBqY2ZUR+r5ng5wTSfjhEdV7ZQ8=;
        b=REbwzykdm7OHhYkHKTa4GjtmoAm/i/ozHj6HEKSDN2l8DI9yMhJjoD3frpiGcgtfuf
         B6k4/3bLIv/vNdP6tho5LYyF0rZUupRmPJCOued8whJH/JUG2rWSdfbelUmXEH/ZI/v+
         2SflUax0cVIuf5qFUmtGeSjNmD177hOaOC1u31X3/1MZEBQLCJRSwk6AwezncWp08aGl
         Rz6HuxNepkU8dv72WwgMjJnDtKHfA1zczbGIhz4JCvDjHDc/zxSFeRsjxGheGvW8bTGG
         jsYxYwMJy8H34keULSi4tRMVafjaS+eTGn93fl/EP8YVVkhsVZxL9hp4Hl8UgT+5kuWC
         DtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wshwpEouxlj43w/LQBqY2ZUR+r5ng5wTSfjhEdV7ZQ8=;
        b=XsSsN99Z9CIj3Pi+9pd01IF9CLsptPwxAGjwZcuHt28HS0qtRxxdLhDFPRfkq23/M8
         b2DPIBA65qJx8cftKtV78bixUijjaWeDsjKYcEPYOjik3y1Lfj299i2wmZC49kCyiE9V
         tUQw33LP9hQ9fu4MAmMTOdvaWSaZmnMh96gNy0UEuLiXChUi4KOGPD3VWPsx1PK1ZQea
         Wczh8VlEGo7IPyM+lU8jfrS6HlDDB+1ifYNliwO3Vuv4E7ZpfYhL3FJmabv9eEL+62f5
         abu5+HgTzCW25k8cVOvX0wMwq79hFJ+zr6Rjm6CtWFVVCRr3FJ2dXP4NBMUG8fwU22v7
         3dzg==
X-Gm-Message-State: AOAM531uVU0IIis+S9cmMMPTMRsGfFWJbkOSUmot7trLj5lN7qCTK+1P
        E/Qg8iBAsB1ngN3MGg7abow6tA==
X-Google-Smtp-Source: ABdhPJxSza4YTAHvrQmEe3o94FSosfOKLqFVTx3EseeNpvxzLFtyvsyQMNLyS8I4Tj4Yqe7BtrbYsA==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr26665661wmj.169.1628065578184;
        Wed, 04 Aug 2021 01:26:18 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id j6sm5060494wmq.29.2021.08.04.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:26:17 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:26:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v9 0/9] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YQpPJ8To7NN2AIuq@google.com>
References: <20210604210908.2105870-1-satyat@google.com>
 <CAF2Aj3h-Gt3bOxH4wXB7aeQ3jVzR3TEqd3uLsh4T9Q=e6W6iqQ@mail.gmail.com>
 <YPmFSw4JbWnIozSZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPmFSw4JbWnIozSZ@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021, Eric Biggers wrote:

> Hi Lee,
> 
> On Thu, Jul 22, 2021 at 12:23:47PM +0100, Lee Jones wrote:
> > 
> > No review after 7 weeks on the list.
> > 
> > Is there anything Satya can do to help expedite this please?
> > 
> 
> This series is basically ready, but I can't apply it because it depends on the
> other patch series
> "[PATCH v4 0/9] ensure bios aren't split in middle of crypto data unit"
> (https://lkml.kernel.org/linux-block/20210707052943.3960-1-satyaprateek2357@gmail.com/T/#u).
> I will be re-reviewing that other patch series soon, but it primary needs review
> by the people who work more regularly with the block layer, and it will have to
> go in through the block tree (I can't apply it to the fscrypt tree).
> 
> The original version of this series didn't require so many block layer changes,
> but it would have only allowed direct I/O with user buffer pointers aligned to
> the filesystem block size, which was too controversial with other filesystem
> developers; see the long discussion at
> https://lkml.kernel.org/linux-fscrypt/20200720233739.824943-1-satyat@google.com/T/#u.
> 
> In addition, it was requested that we not add features to the "legacy" direct
> I/O implementation (fs/direct-io.c), so I have a patch series in progress
> "[PATCH 0/9] f2fs: use iomap for direct I/O"
> (https://lkml.kernel.org/linux-f2fs-devel/20210716143919.44373-1-ebiggers@kernel.org/T/#u)
> which will change f2fs to use iomap.
> 
> Also please understand that Satya has left Google, so any further work from him
> on this is happening on a personal capacity in his free time.

Thanks for the update Eric.  I'll push this to the back of my queue
and check back with you at a later date.  Hopefully we see some
interest from the other maintainers sooner, rather than later.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
