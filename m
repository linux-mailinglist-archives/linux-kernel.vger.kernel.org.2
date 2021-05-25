Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4F390898
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEYSLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhEYSLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:11:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32710C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:10:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so2235518pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WoDug4+CXTtAZ7sweqscjf9FzzuoYDrpzUh3duNxd0M=;
        b=Oi4ypauTpMTlbTHsjemSt/xTEJ/+9zAG69V7Bhfz4Ayw6ClXRcKNt44XVMLGCbhqsX
         XbEbUlylWlOhH8C0b40HQ5uKQmrzfduQmKMgiYMHbzM504zzscb2JaCHcyTBnyU3etmn
         iK2tkyAGMRu6Ux85N9WS/eFtPulNm/AU3nSXJb1E594u4tROoPYT1oRbC1doBf4ZsY0Z
         Esp0o73MzIi9i5OY8+7UeNmm1mu0SrW4gyq9NOR09EUQHs/T3ZhxKLmLXCw91X/jZ/W4
         GoDWITmSMH8TEfYoZWp6aOJ6hKSuUwJDSSRal+LvcixOXl22h4cDq9MTV1HBuyEnw10V
         4/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WoDug4+CXTtAZ7sweqscjf9FzzuoYDrpzUh3duNxd0M=;
        b=maVLz/yXOJv4s/ZDtS82mMOy1PKdPnAa9Rj2yKZjuitvJj6Hvo96U+N9EQ1fjd7OsM
         uVYXntgpvluNVtcUDr6Se5wksq0LGP6d44Ixzw3J7GWazJWVfdpzU9/grLrxpGF6gRFU
         rDlGDKYq91XxkTmC0ZjstpCqLYd7LJCvsNXo5iEsqoJWk2R9uUgY5rOIib7wKFz2uYob
         jg3FX2CgXm/6O2G64gE7mpOGgZmNlvqCKlPhe0zS/Cgjmhs6p9D3ay7q2sPt1tu/3DMp
         MQBL9KZJbChQQ2SlVItUKF+L3GVBTSdbM9I3SVRSINcVB0Et+2RWv0QgokDJOhATRAuL
         r+EA==
X-Gm-Message-State: AOAM530FAPcqR+MNoVZQI8NXmLfym43HBv983QgjJ6eKdLYUJt7MotqT
        oM++0O6jvcZGbRRvRNbZSrEnlw==
X-Google-Smtp-Source: ABdhPJwZUZIrJ4p4qUHQ1CeHU6I/SbwijQWPeFZemxrafZqwOWR1QtCnvwxuT4le2otbNgRg2XMojw==
X-Received: by 2002:a17:90a:8a07:: with SMTP id w7mr31786769pjn.192.1621966204387;
        Tue, 25 May 2021 11:10:04 -0700 (PDT)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id n30sm15154975pgd.8.2021.05.25.11.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:10:04 -0700 (PDT)
Date:   Tue, 25 May 2021 18:10:00 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
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
Message-ID: <YK09eG0xm9dphL/1@google.com>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:57:28PM +0100, Lee Jones wrote:
> On Thu, 21 Jan 2021 at 23:06, Satya Tangirala <satyat@google.com> wrote:
> 
> > This patch series adds support for direct I/O with fscrypt using
> > blk-crypto.
> >
> 
> Is there an update on this set please?
> 
> I can't seem to find any reviews or follow-up since v8 was posted back in
> January.
> 
This patchset relies on the block layer fixes patchset here
https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/
That said, I haven't been able to actively work on both the patchsets
for a while, but I'll send out updates for both patchsets over the
next week or so.
> -- 
> Lee Jones [李琼斯]
> Linaro Services Senior Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
