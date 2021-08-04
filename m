Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51D73E002C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbhHDL3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbhHDL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:29:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C437C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 04:29:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k9so3039109edr.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IjBPgUQiBzbKNMi/FqQflOksi54xC4hLPMuwWM9yuc=;
        b=Hi4y/RvWTwSkdoxFsy+D8hFllLfBttHMByIe0A+ZzHr1MI/bW1Wpwb/pvj/WX97q4m
         zvBHSHQpXBGWVFhoh9wC1WC0JZejktthiHb5p6DuKAW9lbZBhZ/ofpMeDP+MEYcqH0/m
         P+AKSMJzg6a6mYHdMbx7BUeTBWzh1bYh4ix3MUBC6hJUuZZ/1C0PFB55/seEQCo0i3Gq
         D82ueVcGMChaezq5Vdm6+dMADmNtQxBzkb+YC4ThTt9D5cMWfsyYXEnc4THrW9M0GO+Z
         3Z1W8F9bfkIO28/KDi6+KTFw9vo3cQW3yZNuLMA22RKRPLre2aSZOnHsfJg6uJ6zvpSA
         ph6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IjBPgUQiBzbKNMi/FqQflOksi54xC4hLPMuwWM9yuc=;
        b=c7oYY/R2dCMvG7oDMs0KB6v2MVypzda34xV/XOjKQyG70D6rnwbeGvoMVfjYNAj7ET
         rPPkA5gDzgyAqXDsPg8ZklD8a3mbI1qqMeihe7Cr6ftNllzPWPc9GkXsAGmynMT55X++
         FRNdjOVCJChhtWMJSeyIrGba79Xoja9+6faojT+EWyv5dEx53wsft/NbT+u25mFYoKyD
         el0lseiYdjjwqU1QL7919nBHXiw+k1pZT3xScl6AZQIPuGfSn3IIDlxdNHqA+kfOGMEM
         +IabQY+lixdTIjqIW5D4sr1hT9ziH/u/Ctrd71wPQ3nvDJFIMUpeKCXwHj5jwKDYManv
         wwig==
X-Gm-Message-State: AOAM530TUeFGdYpMXhhKaya5uJAFZehvm74BbECrE0JAivnopmx3RPfy
        GIR+ZV0oQGXt8pZtfTdS9a4=
X-Google-Smtp-Source: ABdhPJyH52ECuoMPPc7gIRHzfao4GCsT7/i1HKTewFXp+KFg9gF4auaOMGtJHRxJQTTWYoYNDVgm4w==
X-Received: by 2002:a05:6402:2073:: with SMTP id bd19mr2831702edb.262.1628076573017;
        Wed, 04 Aug 2021 04:29:33 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id c6sm579413eje.105.2021.08.04.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:29:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in assignments and parameters
Date:   Wed, 04 Aug 2021 13:29:31 +0200
Message-ID: <6010274.OVh6iHOyDd@localhost.localdomain>
In-Reply-To: <20210804095839.GC22532@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com> <4550286.edLFIWPnRF@localhost.localdomain> <20210804095839.GC22532@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2021 11:58:39 AM CEST Dan Carpenter wrote:
> The patch was based on the faulty premise that the original code was
> buggy so I don't think it can be fixed.  It just needs to be reverted.
> 
> regards,
> dan carpenter

With the original code, GCC + sparse emit a dozen of warnings like the 
following ones:

drivers/staging/r8188eu/core/rtw_br_ext.c:693:101: warning: incorrect type in 
argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_br_ext.c:693:101:    expected unsigned int 
*ipxNetAddr
drivers/staging/r8188eu/core/rtw_br_ext.c:693:101:    got restricted __be32 *
drivers/staging/r8188eu/core/rtw_br_ext.c:693:123: warning: incorrect type in 
argument 3 (different base types)
drivers/staging/r8188eu/core/rtw_br_ext.c:693:123:    expected unsigned short 
*ipxSocketAddr
drivers/staging/r8188eu/core/rtw_br_ext.c:693:123:    got restricted __be16 *
drivers/staging/r8188eu/core/rtw_br_ext.c:698:99: warning: incorrect type in 
argument 2 (different base types)

Do we want the above pasted warnings and leave the code as-is?

Regards,

Fabio






