Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FD40C3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhIOKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhIOKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:41:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:40:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a4so5092902lfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a/GCtVpvhwVIk1SywYX5YYFVF3L25bb3Bu0j55SRB24=;
        b=F4X13sv85qlRDDGNT934A1gwgVq152F28CjwxEmHWp5QoNhFlLfGtaqRmrbtgwFI4g
         RcQmXbvtmgFuhw3kwUj511XOgpddIwKvyro1pjK6LdK1Wvt1CQqiwtE95uaewMmG4gjT
         CtYQUT7gTVilccItlvMr+/R4kkVzMMX62w7b13NNca2Wm5wx83Md4QNlU1CUXkPdI8Ha
         GUmk1lbIcUs/H6JEkz7Z5B1XrmqfJlMcxF8D+LqP0aTsafCY2WOmKZNXJ6/PpeJoRiQw
         kxc/mSdxkYFkx652FozpJZgkSFN2SqCP5zKQip4upN84qh6+u667sOBV8IIpRCvvUkfD
         DrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a/GCtVpvhwVIk1SywYX5YYFVF3L25bb3Bu0j55SRB24=;
        b=EKx9Kmy/Y6wD/mpVp4RV17xR8GMmV4GJFvbAOBGJthrBBcCk6UYWpGQ9FXJ+26gs/M
         yykEhU5wKiVWJvrwcYZL0ahT2MmbH/GYjdapAd9506Eq3MFTI45hd73dcmyIAUxsptSA
         NUTTSSfguIJcn239Co3Mox9GqUXtixFRIcvl77TkbYAtysJkYg2ZYAFDARoa8kbnigPv
         i7DUHqlQ5diedM8uWT/D87cOJn4Mw8Gcq9pF4sH2W8tC9pEawNg1vqpyMo2/XierR3Ir
         jX/WWM8rwEE9f6Qwi/lD8ntmeG0KyE/L4hALbUR5Gzi0/fBclJ2HpLoHE8+gBuYDb9oG
         dCew==
X-Gm-Message-State: AOAM531g7wqrLwAVnnW2RfbHHHwCHKEeDrDgKgBHgh/yUcOs0GEogsM7
        Ub7e0clJq56etUDKloWpIkHrhg==
X-Google-Smtp-Source: ABdhPJztrGap47YE/7uFZQfvJHSMuv017KdT8GnercdtDSz207RC8iHDJBIFlGXPIToLigf7pRWJTw==
X-Received: by 2002:ac2:5d71:: with SMTP id h17mr16352495lft.670.1631702426202;
        Wed, 15 Sep 2021 03:40:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q7sm1673012ljg.137.2021.09.15.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 03:40:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C2AFB102F4D; Wed, 15 Sep 2021 13:40:28 +0300 (+03)
Date:   Wed, 15 Sep 2021 13:40:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/memory: Avoid unnecessary kernel/user pointer
 conversion
Message-ID: <20210915104028.77qwldwnwpcbjds6@box.shutemov.name>
References: <20210914150820.19326-1-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914150820.19326-1-amit.kachhap@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:38:20PM +0530, Amit Daniel Kachhap wrote:
> Annotating a pointer from __user to kernel and then back again might
> confuse sparse. In copy_huge_page_from_user() it can be avoided by
> removing the intermediate variable since it is never used.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
