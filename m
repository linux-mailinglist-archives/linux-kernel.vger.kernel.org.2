Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B395C33DCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhCPSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbhCPSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:52:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8E8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:52:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n16so64101578lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhWyRq+OToNSnhrg5OoFeTMYJ+2XonhBSVkXP0Xaljg=;
        b=A7KlKmiIQoVTt4r+LmiZ4fRDbLbwF7yq3FZyWg6AZ/drPSuQzxnfi4y2YuTnVIDxdw
         AEEbGcxiI1Lva1KRNcIfT4v3EmlZhDCrMsIIkrGuaSDNFGSqJPy/okZsX2LjMfCjPBu/
         +LeoIgk0uIrrABuwT77Johv0AvQ/yR4aXk6wECHqytVvWwi1L1xYE82zeZJVZcxxbHDB
         gTWT3X7I85taemL+UorPuvMe+wt9ddK+zmXEhA0ALyhu+QiMqCaL1AIpGlbI2iHzE1T3
         akJGBdtZIIIcw/QkkM/mAhc9dqn3VWZNDKKKFnywJJzqNMstVRe7HDvwPowND9mIL06g
         jznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhWyRq+OToNSnhrg5OoFeTMYJ+2XonhBSVkXP0Xaljg=;
        b=ET+24xm35RM3RR9JIgRboTIUk/BeWUcCsp3t/uLkyVxp3u76ifLDM5JjVd1M6UunWG
         yuPWM1aRYbEVSnNa5LtZ+/y5XdS9f2x0/dMmQozUdNWPhcT1VRif4xRYkscX/lCNaVan
         0kbsIvC7rM1UOh7cTRQCENVpoxEltDv8JC9b/ZT5WBs9fri0O2zsrBQ345xosbbUFp7p
         805j+DXjf4Rnzn/NGVPJyebAYYCDEH5NUHF75MfZSbK5+nkG5aKe8BTacI5uHj/AZiJZ
         vH6YiMknqzmM2gCz5VQ6WfdcDXEMllNnr+qjRa9AaM78nLoms/n0zqljHQRUECiRMr2+
         GXrQ==
X-Gm-Message-State: AOAM533wEYNZKGUDLsSgdxQ2oLPrU4fUu9S3AUf1KTthKQVcH0ECVk7L
        gBVqBDEJeSFQnLOTFHGMxrw=
X-Google-Smtp-Source: ABdhPJyrrIExeTp1CjuwqGxdIAKPUva37fwtFkAElp2FsmsAwnbW+/E6LfV7nLXkNCEGEMcxJCAgWg==
X-Received: by 2002:a19:6751:: with SMTP id e17mr129592lfj.20.1615920720225;
        Tue, 16 Mar 2021 11:52:00 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id y24sm3119161lfj.54.2021.03.16.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:51:59 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id E7F385601CE; Tue, 16 Mar 2021 21:51:57 +0300 (MSK)
Date:   Tue, 16 Mar 2021 21:51:57 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: auxv stuff (Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack
 leak)
Message-ID: <YFD+TZyMioO00n5i@grain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
 <YE734MgE40jTv9zJ@localhost.localdomain>
 <YE8B52ET790Y/6WO@grain>
 <YFD9+0BEvMtwMqVi@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFD9+0BEvMtwMqVi@localhost.localdomain>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:50:35PM +0300, Alexey Dobriyan wrote:
> > > 
> > > There is another (non-security) one. Compat 32-bit process will report
> > > 2 longs too many:
> > 
> > Good catch! Alexey, should I address it? Or you have fixed it already?
> 
> I didn't and I don't know how frankly.
> Something I've noticed during more important auxv rewrite.

OK. I will then. Thanks!
