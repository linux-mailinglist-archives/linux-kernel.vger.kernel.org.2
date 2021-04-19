Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22B53648A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhDSQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:57:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:57:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so2409496plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LFLAtSvytla0zTYcsW46mWeyZlofOCWa3x8xY0lnO7M=;
        b=H8hCSiqQKIDKul/wf025S/2I8kyN/iAfc/+Te8+ygVBtigfjKvw+qcK3fdE/uG6iQb
         dbo/uRWNeF3x7j2Ybb0bk6EPtOkJrtvLoJeR3QT7hzwpWPgQw5mP0ZoEyIQB3r0shGzt
         wKqGYK5TtI0KlBz2LxjgiBdIb49oM5EMtcCBwnLWTW5iJCNyFZI2qomf2/2LUFJNrm5T
         YhevHK1tVhAF4F7A8tJ0bBoPfCl/taHnQhARBUQngM9VIm7yksjXNhLidnxpuIz4Gg2Z
         7gbZi5sTtzhRsoSrRraHSqZDOpE0/fXl30rmtV/exhogkg6G5tkLuoGCR9s3g3bhLCyg
         BuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LFLAtSvytla0zTYcsW46mWeyZlofOCWa3x8xY0lnO7M=;
        b=rUfoUk2yVaXq06drBx9v9QwbGTVp9w+FB8lMJlDwp5fwN370Rmc+fIVP60coIYm1Gj
         yiCyybfqpnDZqfEN+cC1vKjFPO8GKjQrlbAQ6Y9184lUxKQIaPewWBpcnpUIhOpTLKl4
         V2adTo0kdm/yL6/ZSBzWF687ksM8grXXJE6cseJunkIoBIcUY2ONr1qeYb9ZR5+Zx2+G
         e45lQgz3Pfog4J8Z7QS/PG+Tku4DEYM1GwDg2YcmULGtXhd2tq9AZ02SXqPDU7z9Ek/d
         W6ycKrx0oOUbzEYvqM65BhFunywlGn5K3DuZwQZ29HrNJXuVsYLDZi5j7v1kAwUsZwVH
         i6QA==
X-Gm-Message-State: AOAM531dH7XmeDz7bw4HM0I52FkzqCgeteyhEMU854GtDnzLNBBU0QH5
        nIxe3EcyZGrN1P7sGywUnbc=
X-Google-Smtp-Source: ABdhPJwOKSCP2ZLHExvU1pSIpwpfsfPxKIPeYhQTx5XgAqjO98qey0O9Czry9a/reFAOjmKswt1tZA==
X-Received: by 2002:a17:902:b483:b029:e9:eef4:4f16 with SMTP id y3-20020a170902b483b02900e9eef44f16mr24796074plr.38.1618851424942;
        Mon, 19 Apr 2021 09:57:04 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id 76sm7498096pfw.25.2021.04.19.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:57:04 -0700 (PDT)
From:   Ashish Kalra <eashishkalra@gmail.com>
X-Google-Original-From: Ashish Kalra <ashish@ashish-NUC8i5BEH>
Date:   Mon, 19 Apr 2021 22:26:59 +0530
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ashish Kalra <eashishkalra@gmail.com>
Subject: Re: [PATCH] staging: wfx: silence symbol 'wfx_get_ps_timeout' was
 not declared warning
Message-ID: <20210419165659.GA2363@ashish-NUC8i5BEH>
References: <20210419153348.GA22782@ashish-NUC8i5BEH>
 <3163466.7bx4QQXRp1@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3163466.7bx4QQXRp1@pc-42>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 05:55:34PM +0200, Jérôme Pouiller wrote:
> On Monday 19 April 2021 17:33:48 CEST Ashish Kalra wrote:
> > 
> > Upon running sparse, "warning: symbol 'wfx_get_ps_timeout' was not declared.
> > Should it be static?" and "warning: symbol 'wfx_update_pm' was not declared.
> > Should it be static?" is brought to notice for this file.  static keyword
> > should be added to prevent this warning. let's add it to make it cleaner and
> > silence the Sparse warning.
> 
> Hi Ashish,
> 
> Thank you for your contribution.
> 
> It seems that this issue is already fixed by commit ce59858bbc10 "staging:
> wfx: make methods 'wfx_get_ps_timeout' and 'wfx_update_pm' static" (merged
> in master in version 5.8). Can you check you are working on the last tree?
> 
> 
> -- 
> Jérôme Pouiller
> 
> 
Thanks Jerome
It seems some sync issue with my source code.I will update to 
latest and correct
