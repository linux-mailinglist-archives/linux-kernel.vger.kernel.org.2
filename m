Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9FC3D0A13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhGUHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbhGUHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:08:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD99FC061762
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:49:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c12so1106257wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dX8TY150sPP288O7a5d8IPUCpKmaaGuNxNtlOJ+ZVSk=;
        b=xLLIO3yuolKlm7Z+nBYUayixvHCbQKQLacSAIi3kdGsbXUyQdCEJCdeXDB3lHNc4tm
         LY/3QlLyetbELioGJW0zhBAF7qlalmy/7pOYbF/VVhgh11ZBONXbIXXbgME1rxsDAXK7
         lId6mxACdfA5ptoJPhTxzHgTXEuhXxbZdPvddpUq2WLnUTCUR3UdVxgNp/edWXdsFkx0
         1wjYNiJ9zkDIUIv0crsVWdbgCnYcGQ/R6eXJIKZLiO35EUoDMs6pSglSaBS1QLlkelgE
         obg5qFH8Wv0P3cEvJaouBR/nAzHGLqd0PngmqyGYR1u3zPjSfwBFZ3XBKK2qAr9Utahv
         C+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dX8TY150sPP288O7a5d8IPUCpKmaaGuNxNtlOJ+ZVSk=;
        b=BGjQdbH4tLhRZlephH7uzTAcNtm126DzqW928D9jrKCZakZVnV/FZRb8F4f8EfJzBN
         RPa/WDFETbO6s/CwyWmHylEB+uDf/Ht+81Fga1d23d9bcwQK4eGhsljnwWrHs7MBRTYr
         lGcqKng8p06ujta6aaNMJIcPgTaDpOlOVoAP9PYPW4laTnvwAUNtZ5GF0CpP9WSFaflt
         pfhbad8UR3HwCLSqo1v04HyD0l8oRavuCRSYkvy53MIeALxCHn9+k/Fqm77WNPtQWyn0
         DBtbehdtwWMVssYR/6wqxwz4aN/NLpYWDqIejzdZrxszilUFtqpCAxJVYYIU/r+QkLOd
         8ITw==
X-Gm-Message-State: AOAM530YUD3SjNdcFahle5fV57+B98VASkpyAMvmib1+RkqTTt42cGl3
        m6sg5kG1V0JTMjvThNdRgia8sA==
X-Google-Smtp-Source: ABdhPJwsQ0YmJJpXJd9qiiQ0NIdydxNW9DObrYKA4Ux6eBABoIZ+aQgUIeIzvZ+7IMy/XVZLqVgbkw==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr41199381wro.252.1626853761382;
        Wed, 21 Jul 2021 00:49:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id o14sm26462614wrj.66.2021.07.21.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:49:20 -0700 (PDT)
Date:   Wed, 21 Jul 2021 08:49:19 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
Message-ID: <YPfRf8dgFd+u5hzm@equinox>
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 07:22:26PM -0500, Larry Finger wrote:
> On 7/20/21 4:00 AM, Fabio Aiuto wrote:
> > maybe the information we will need one day is:
> > 
> > will the core/-os_dep/-hal/-include/-directory-structure be
> > welcomed in mainline wireless subsystem, when an rtl* driver
> > will be perfectly tuned?
> > 
> > At the moment I can't see such a directory organization
> > in any of the realtek wireless driver.
> > 
> > Sure there's time for that;),
> 
> The question is how much lipstick do you want to put on that pig? The
> current version does not use cfg80211, and it does not work with
> NetworkManager or a modern hostapd to create an AP.
> 
> If you want to get the rtl8188eu driver in shape to be added to the regular
> drivers section, then I suggest you start with the v5.2.2.4 branch of
> https://github.com/lwfinger/rtl8188eu.git. Many users of the RTL8188EU chip
> use that driver. At least that version fixes the two problems listed above.
> If you want to flatten the directory structure, you can do it there and
> offline.
> 
> I want to caution you that following this path will take a lot of time, but
> once you get it into kernel shape, it will at least be useful. I have never
> had the time, nor the ambition to undertake this effort.
> 
> Larry
> 
Dear Larry,

Whilst I (and no doubt others) are happy to look into what you've
suggested, I do have a few questions:
(1) Why is the version from github not the one in staging?
(2) On a related note, working on it offline is difficult in terms of
proving contributions, particularly for a kernel mentee such as myself.

Might I suggest replacing this driver with the one you suggested
entirely, so work on it can continue in public? I am happy to submit
this and continue work if you think it would be viable. Many thanks and
I appreciate your thoughts on this.

Regards,
Phil
