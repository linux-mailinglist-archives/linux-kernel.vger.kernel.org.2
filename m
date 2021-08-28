Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3473FA4EA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhH1KDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhH1KDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:03:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5840C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:02:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n11so13638486edv.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8MRyd2KdM0I5iiFpn55i/nDQSTgczndUfsjMuc21j3s=;
        b=IJjV4OpVGC6L3J3Y43uUEEjqcqcNf0XJyD9GN/hWfLYp+wqDJ+0kDuEmHd9uujufgb
         ekUhXyCDP63DWyWZ4aqupTDybAgUDFoCxMD2CkcJJaLsAOfxf13rRnPCxjaWsNjDR0Vv
         gN8DQxYXD/B/WPx0rW2TqnYgsuLz1W1pXn2snpzx+OS4AtvyAU4nnX6+p+ounPMeYUi7
         SdBphbV5CasyeAJhs1AI6+k9rkdUMQSYP2k4HZDXNdtJXAzGrrcOGQnhpYlmpKWxU7Dn
         ULjU4f0Wn3iO0YETNNGMwFPsdrs5QBrwwz2QdQgc5sLFms0vtxdzxs9N3LX+dNTcSraQ
         XnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MRyd2KdM0I5iiFpn55i/nDQSTgczndUfsjMuc21j3s=;
        b=nc3AntMvTzHfvOL6bFKO70CfQ2DmQTeXFYoB0oW527nQjKENoYl7IBEllIXKApFigp
         BGCtf5yfrHaT8gPyvv13zHfia4VMiArh6Dl5Hk9+TI35IxuLcCGJ0VdO3xvKRYU38lTH
         UGQFLa4MCkghqG5Z/062olP+nYglpDW3NjCymBWAXw38lpeaXMPqGPhf+iBg86vqZmcY
         knQYhjmr/RCfGbvU77wcjTpCItAGyTZbiaqD++MN6oWO99vBCU1WKWpSzZySaF6VDAct
         KoF44g4I1wlMxyosBTVF2GclEL9HRbyIbY+8Rg74gkWknV9K2BK/CUnNmesAvN7+wKpT
         aVLg==
X-Gm-Message-State: AOAM533115l83K4Kg139DKBkHSRHU5p3dJJPkjvZ/XoN6y7/4/cxEjw1
        DWk3OM9IWN92nRRcY4YLKFM=
X-Google-Smtp-Source: ABdhPJzkSPRLzls4oP6qjwAWyjflymQbFrLiAWUyLTSAf+OohcDHxj29Ah4srJRe/a9a7DZl+BvPLQ==
X-Received: by 2002:a05:6402:1248:: with SMTP id l8mr14137115edw.94.1630144973480;
        Sat, 28 Aug 2021 03:02:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id i6sm4660621edt.28.2021.08.28.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:02:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v3] staging: r8188eu: Provide a TODO file for this driver
Date:   Sat, 28 Aug 2021 12:02:48 +0200
Message-ID: <52588151.DjUuN5SxYT@localhost.localdomain>
In-Reply-To: <a6265f77-cc21-878e-4980-272202fa5415@lwfinger.net>
References: <20210827100813.18610-1-fmdefrancesco@gmail.com> <a6265f77-cc21-878e-4980-272202fa5415@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 27, 2021 5:00:16 PM CEST Larry Finger wrote:
> On 8/27/21 5:08 AM, Fabio M. De Francesco wrote:
> > +* Switch to use LIB80211.
> > +* Switch to use MAC80211.
> 
> You totally ignored my comment of yesterday!!!!! The driver will be converted to 
> use CFG80211 - not eirher of those you quote, unless you are planning to convert 
> to use mac80211. I am not.
> 
> Larry

Hi Larry,

To the contrary, I didn't mean to ignore your comment! At least, not voluntarily.

My confusion arises from the fact that, as far as 802.11 concerns, I know only
that it is a family of standards that have to do with the lower two of the seven 
layers of the OSI protocol. I really don't know more than this: I cannot tell the 
difference between CFG/LIB/MAC80211. 

I simply thought that they are complementary (each to the others) and that I should
have removed "This work is currently..." without mentioning the cfg80211 task to not 
have someone to duplicate your work in progress.

Fabio Aiuto is right in guessing that I took those tasks from another TODO file. 

Finally, I want to remember to you that (ahead of v1) I had asked Maintainers to
do or help with doing this list and I clearly wrote that I didn't know what those
tasks are and whether or not they are required.

I hope this message clarifies what I did and why.

Thanks,

Fabio



