Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331AA36D258
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhD1GmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbhD1GmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:42:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E6C061763
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:41:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so56430pjd.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kImME5iIeF2ku552Ogx5gcM67tAerfzPBPxvLhd8mak=;
        b=CfMqLMcYNo44BeSwgqtGFzUdJePtmsZD1wL5ol348PnvSg5iCVb+PkkT0paOoZaJfB
         w8jPXJwXzG8+bXVHnjFKTZdFKe42K6ZAJ+98H7YrtgdmXFOl8kxixnkOxj7rs72LTfad
         RzWy3Ai2rrl9KOhmlg5hicwQsElwCtD13dbf+Zk7KFp4zxgmgYs0BAsB+RZ2mhX91Chp
         ERL0ahLx+XV9Yx9e+qQYXxtrblzhyxw1fzYoEREuMUcTV3S2ot/+5mlkGJXybFL3nSAM
         J18Opio0/gXJ9ykD/+Wvl7WUC3pqBdg7+zF+CgIXz8KjByZ0F4vZ/9LXOBoYZ4jinTMR
         smGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kImME5iIeF2ku552Ogx5gcM67tAerfzPBPxvLhd8mak=;
        b=Ub/1hFjqRoVSeH6TQVYJgJyqIATOUOUMGkzziDAyce41kEvcI9RjYVeOSYQ1Eow7O9
         LeJF40vt4pQromUYfq5OXy4pOzOOo9SymoxegXwVdzezgIWw+BbBP9pgSb4XCrtSSVpV
         nwnER349rQ5zfiT9oWGEA7u1TK7QXt/yw95pdi1UWDJP547b5NsGnbEQvj8ObnFC9fSR
         GXMvUsn1KD2IoVU/+jqmSD2Zjk8/mDvNR/W7DvkyeKMiZ1ugSqxVg8E6AHdiXjk1HKPX
         vxi9qc3Uc0y9DQsLMN6mfgLdFBfVsXATpjg1drCwGLgI2hOBCbruPUggOBTNrL9vsSLZ
         x7tQ==
X-Gm-Message-State: AOAM533QGl5HJzg26/mcCha5iwvvijVI3rAxHj1FSWtsKnWCvUBry6+G
        D3dnbqfLumwF1hw4lxRkhyU=
X-Google-Smtp-Source: ABdhPJzX9qEoiBScoUVof9fcdElcKhFLLOEgwXKhJIZnzzTIqJW9f7rbN01QdC4waBt/TTjyQfLX+w==
X-Received: by 2002:a17:90a:aa11:: with SMTP id k17mr2317606pjq.211.1619592078631;
        Tue, 27 Apr 2021 23:41:18 -0700 (PDT)
Received: from ashish ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id m20sm3748357pjq.40.2021.04.27.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:41:18 -0700 (PDT)
From:   ashish <eashishkalra@gmail.com>
X-Google-Original-From: ashish <ashish@ashish>
Date:   Tue, 27 Apr 2021 18:04:36 +0000
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ashish Kalra <eashishkalra@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: silence incorrect type in argument
 1 (different address spaces)
Message-ID: <20210427180436.GA37280@ashish>
References: <20210427165844.GA35857@ashish>
 <YIj6dw5afJ1bBYWK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIj6dw5afJ1bBYWK@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 08:02:31AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 27, 2021 at 04:58:44PM +0000, Ashish Kalra wrote:
> > Corrected data type for variable data adding __user to make it cleaner and silence the Sparse warning. This is version 2 of patch, version 1 can be found at https://lore.kernel.org/linux-staging/20210420090142.GA4086@ashish-NUC8i5BEH/
> > 
> > Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
> > ---
> > 
> > Changes from v1: removed type casting of (void __user *) for req->data and corrected type for data to include __user
> 
> Did you send this twice?
> 
> And please wrap your changelog text and put proper information in it,
> not references to previous patches.
> 
> thanks,
> 
> greg k-h
Thanks Greg
Sorry for sending twice due to some issue in To list
I have corrected and send again as per your inputs
hopefully it will be ok now
