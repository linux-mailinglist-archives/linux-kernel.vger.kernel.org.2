Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A524199B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhI0Qyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhI0Qyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:54:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B79C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:53:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y35so20750045ede.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMa3M1bs6F4XDDZsVandl5JemeFlfQBynfNRsq6BDAQ=;
        b=j/wKp7D6FSZhZSwNHaN+/7yrcCHyNCLHO9LiQ7AItO19rTT3AEdAGjAO4PLFuEI43x
         5WzAce1yY+R2sh/LE/m2qTq/KatnhCqhE5cuHJUM6H7N/sDcagUivWuH5yiD9qPai2jH
         RHDG1SjnfKnuy3BB1Z3djAap+7QTMSwSxuMvfP51+P/JhAXlyFcxeCJN37aQW15vQD+y
         kFnx6Ct42Kb/uf0NMX9N8IWUt88EE3QgnoIzjwOiSmjS30gre4WFS2JJBuE5dWlyFxxZ
         LoPb5SljuSZDXeJkydsSvAneiqyjohnxAmAnMg4INzoRoTAYa6l1qN14/OmGG+rnY5t6
         oFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMa3M1bs6F4XDDZsVandl5JemeFlfQBynfNRsq6BDAQ=;
        b=TqSy1UN6mgizUfniMTOwGFiUVvAaskWje7HVl0i1NZdheIdapxO5rXO7JbRvT3q9SK
         uDj57NNwv1Rf1Yirl8/Cxpnm7NJDFQXPEXDbollYIm9dzmK2xOtfJotllREZlto+2Ck/
         c3PcBxucNi8dpDEGziKBNos/gSniz+HxTxPEKoW/JvzhiQ6ndYdUPz3u4mYxE3/mqdkO
         ljhgCf/wPl1UpUMCr0dRJTKv+QWRNuLnNA592n1eIVbJVEHQdXhOdxw2cRAg/3FmNBNM
         lpb3EKgIAvNJo8stvRJUx4lY4wM/VluGoD9TzY8l5Mh9faEg7fjKY8JxJbL6bXgvQotG
         qcCA==
X-Gm-Message-State: AOAM532WGhA9PAJXzZMbTdR0fj5djwGecJPndTo5LYr9An7YYq+AWtrD
        mSM1pYouftMmWF1IUXCP+Ds=
X-Google-Smtp-Source: ABdhPJysvTphbDucZcDQxa0AnvAbpnjIbT24c+ysEFd9fsbh7unovF7upOwbsRV3h34ERGp5YSJx0g==
X-Received: by 2002:a17:906:3a4d:: with SMTP id a13mr1199259ejf.220.1632761585538;
        Mon, 27 Sep 2021 09:53:05 -0700 (PDT)
Received: from localhost.localdomain (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id p24sm10733641edq.27.2021.09.27.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:53:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v9 10/16] staging: r8188eu: shorten and simplify calls chains
Date:   Mon, 27 Sep 2021 18:45:49 +0200
Message-ID: <2224179.S7mhbqmIgH@localhost.localdomain>
In-Reply-To: <YVHlRf7C6m+2Si+3@kroah.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com> <1836626.W0nMHyKdkH@localhost.localdomain> <YVHlRf7C6m+2Si+3@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 27, 2021 5:37:41 PM CEST Greg Kroah-Hartman wrote:
> On Fri, Sep 24, 2021 at 02:37:52PM +0200, Fabio M. De Francesco wrote:
> > On Friday, September 24, 2021 2:26:49 PM CEST Fabio M. De Francesco 
wrote:
> > > --- Preface ---
> > > 
> > > This is v10 of "shorten and simplify calls chain". 
> > > [...]
> > [...]
> 
> Nah, I can figure it out, looks good, let's queue it up and see what
> breaks :)

"[and] see what breaks :)". Interesting...

This is the second or third time you have written me these words (I cannot 
speak for Pavel). I guess I'll have to work on it :)

All kidding aside, we seriously appreciate that you have decided to accept 
the patches.

Regards,

Fabio

> thanks,
> 
> greg k-h
> 




