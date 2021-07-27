Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663593D8428
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhG0XlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhG0XlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:41:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E23C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:41:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id go31so1493605ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+b2W1GeH1OYn8Y9D4pMmFOGxzPzk0NT/+2kUYkJYBY=;
        b=qkriSegi629XBPIN1e7nREqlL/5v0tQnbF0hLVJtjvk1ZCq30PeDibR0tIyKPC957U
         2cDiRQsf7Xs4ZmWhHfLvwsvjW2KRjpgSfvQRRBBc6Li50UhRkBm7rqiWszCVu6iBsLlm
         DB2sP9KSE9kgLopgz/+1GbkCEF1rdpJdCrIdqebvyHbdCks2WRPwcEaD+IYo+evDXp18
         EZdgczVNR74CyXMIgeD3pjb/z0++VM0AsviXaElXPVHEVQvmPAUjPIH6nD/pwnrHop+G
         ssYh7g40n643UztSBoND2xZpbozNLJ4JP64kEYaQnah8XBB7lyp/rFklZqdUiwm2swGW
         hfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+b2W1GeH1OYn8Y9D4pMmFOGxzPzk0NT/+2kUYkJYBY=;
        b=cOaBqdcTtjDVrmu4xIqFoozKvK2J5OMnYt5XHxQCTcj+mqWBhEGXMZ1nyx5cWeBKr3
         A7GGUDBjmEcZFfKaIlJKNWXmum+Z53+vaPPe79myejVcnODo8u1vdsdPg2ysaceQrbGd
         nb4cTFNTqFwbFV54a1MTYzpNFVvZ2fcq7UmRfdXyGSJ3A8cbqGL9dB9qkfL3+4Y5Jpd9
         A5qloT/3eL9q4XDJNYRa1rPBTaboqP8HA03gXKTqAuQ8mAcygsU41Sl8ek+Bnc8Ut19W
         tSClk1EfXlFqBrjtAgYjTvIv5viDG4pN3kYIt7s0HB5/Q9peB3ZJQ/7HkrCWsErf3PT7
         cecw==
X-Gm-Message-State: AOAM531iFEAwG+J+WArlw3ou7vTIycVDNUkpZe9yPRUHnIEpNZUCjRv8
        NjpiIT/JlQtktNxedEFVo3E=
X-Google-Smtp-Source: ABdhPJyAhw3wkBU5d8bXQJ+Hxw7nU0D1AbAphz/Cn8WY8LDB3vpBI318r2Yt/HnVjjbyvSNIXJ2NeA==
X-Received: by 2002:a17:906:2d51:: with SMTP id e17mr23624773eji.500.1627429277429;
        Tue, 27 Jul 2021 16:41:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-26-32-124.retail.telecomitalia.it. [79.26.32.124])
        by smtp.gmail.com with ESMTPSA id kk18sm1353910ejc.114.2021.07.27.16.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:41:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v4 0/2] staging: rtl8188eu: Replace a custom function with crc32_le()
Date:   Wed, 28 Jul 2021 01:41:15 +0200
Message-ID: <3193794.0t0WolU9RQ@localhost.localdomain>
In-Reply-To: <YQAHcbOeh2ohAmTg@kroah.com>
References: <20210723192620.10669-1-fmdefrancesco@gmail.com> <YQAHcbOeh2ohAmTg@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 27, 2021 3:17:37 PM CEST Greg Kroah-Hartman wrote:
> On Fri, Jul 23, 2021 at 09:26:18PM +0200, Fabio M. De Francesco wrote:
> > Use kernel API crc32_le() in place of the custom getcrc32(). Remove no
> > more used functions and variables after the changes made by patch 1/2.
> > 
> > Fabio M. De Francesco (2):
> >   staging: rtl8188eu: Replace a custom function with crc32_le()
> >   staging: rtl8188eu: Remove no more used functions and variables
> >  
> >  drivers/staging/rtl8188eu/core/rtw_security.c | 81 +++++--------------
> >  1 file changed, 19 insertions(+), 62 deletions(-)
> 
> Much nicer, thanks!

Glad you appreciated my solution to this problem. There is another driver 
(rtl8723bs) that needs a change like this. I will post a similar patch by 
tomorrow.

Thanks very much,

Fabio




