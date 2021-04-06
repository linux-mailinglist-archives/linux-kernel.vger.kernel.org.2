Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC953552DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbhDFLys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbhDFLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:54:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427EDC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:54:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k8so8780778edn.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P/I/9NNIAgEX5lkRCmtPUDKKe3W6gL5/TflW7Rsi0Nw=;
        b=Pb4E2oWtOFWejlo0GZjBrnYjxLR2/OkVilXUolxI3XdsBuW3hBtm8+ZF2y97zX2Nv5
         NNlfk4teO2hMuu4Lkt02A6/RuG/gNMS2BCQ1jUPLR4Di65oAZfMd6tCVHGRhtHRXUdwi
         kSKxB7V/c1LU8YQEsb6oYs6ZCVj+k/HMKKdBEjy+wcIu1+fn17NHQ3PdaTQRteSSQ7UF
         96JZ84bkW3JurcLzuhNHKtdHh03Oz6x81uuxzjV2xXt5T1bt0mp3zJRZ7uaj+FqkJOqC
         Cf42qefg+VSQGMd74l3wEHwDQ0KF6viRK/EWPpFba2Cp78CCdJ1UfYWSf+5xU0LZ1dYA
         42Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P/I/9NNIAgEX5lkRCmtPUDKKe3W6gL5/TflW7Rsi0Nw=;
        b=R+Dt8h1h/cGW2BwxhylvypCmyJqjPimLaj/hkK320/nmVegcIjpavxcyZkv39//AFA
         wLUmIto3rr1r0zeosyQqgY5Eyvcan5gHtRjbcC7UKBuVXWw6QimCpNHthnjDj+SODFOX
         pGsoWkmdP2p3wfpwYdH8+Y6tX5axfXqs5qIUOHcBXcLFwkES5G2+akgbpeXQge8QeX6Z
         a8iaIgJuLkB2niBUsMsNVqR+1LL5FheJIhAJDfjylUWWFoFPiP8U7p/eCle4GX/Db0/J
         VPqxp7m208oZun/ENCLo5SNzDoaq4cs2rbqbDUI1MHJ6mG4XHfazLvksiOhC/LYIkXI8
         m4Jw==
X-Gm-Message-State: AOAM533fKr5VI5V2MCVoAOjG7EIOt8iJphFUZk05KiIFdVoVdG9mobc7
        yXvskPMvsqSlyGVI/yANt44AqA==
X-Google-Smtp-Source: ABdhPJwlz0v/o0dBfE+fx5/my+wmBnuj8s9AG2PFWxzJ7csKDnO6LPJGHCtvbTQ0rqW0OkRgQ/VHvA==
X-Received: by 2002:a05:6402:3125:: with SMTP id dd5mr8486514edb.9.1617710077020;
        Tue, 06 Apr 2021 04:54:37 -0700 (PDT)
Received: from dell ([91.110.221.193])
        by smtp.gmail.com with ESMTPSA id h17sm13432298eds.26.2021.04.06.04.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:54:36 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:54:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: Re: [PATCH 00/18] Rid W=1 warnings from GFS2
Message-ID: <20210406115434.GU2916463@dell>
References: <20210326091151.311647-1-lee.jones@linaro.org>
 <20210406091126.GT2916463@dell>
 <468723920.4255981.1617709446972.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <468723920.4255981.1617709446972.JavaMail.zimbra@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2021, Bob Peterson wrote:

> ----- Original Message -----
> > On Fri, 26 Mar 2021, Lee Jones wrote:
> > 
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > > 
> > > Lee Jones (18):
> > >   fs: gfs2: dir: Finish off mostly complete headers demote others
> > >   fs: gfs2: xattr: Help out some kernel-doc header demote non-conformant
> > >     ones
> > >   fs: gfs2: bmap: Demote half-complete kernel-doc headers fix others
> > >   fs: gfs2: glops: Fix a couple of kernel-doc misdemeanours demote
> > >     others
> > >   fs: gfs2: log: Fix a couple of param descriptions and demote
> > >     non-conformant headers
> > >   fs: gfs2: lops: Help out worthy kernel-doc headers and demote others
> > >   fs: gfs2: glock: Fix some deficient kernel-doc headers and demote
> > >     non-conformant ones
> > >   fs: gfs2: aops: Fix a little potential doc-rot
> > >   fs: gfs2: meta_io: Add missing description for 'rahead' param
> > >   fs: gfs2: inode: Fix worthy function headers demote others
> > >   fs: gfs2: file: Strip out superflouous param description and demote
> > >     kernel-doc abuse
> > >   fs: gfs2: ops_fstype: Fix a little doc-rot
> > >   fs: gfs2: quota: Fix incorrect param name in 'gfs2_quotad'
> > >   fs: gfs2: rgrp: Fix a few kernel-doc misdemeanours
> > >   fs: gfs2: recovery: Provide missing param descriptions and remove one
> > >     other
> > >   fs: gfs2: super: Fix kernel-doc issues where feasible demote one other
> > >   fs: gfs2: util: Fix one conformant kernel-doc header and demote a
> > >     bunch of abuses
> > >   fs: gfs2: lock_dlm: Demote incomplete kernel-doc header
> > 
> > These have been on the list for a couple of weeks now.
> >   
> > Is there anything I can do to help expedite their merge?
> >   
> > I'm concerned since -rc6 has just been released.
> 
> Hi Lee,
> 
> Thanks for your patches. Andreas and I have a slight disagreement about them.
> I wanted to merge them, but Andreas is concerned that there may be some
> cases in which we should get rid of parameter descriptions altogether.
> So I've been waiting for Andreas to review them all before we push them.
> Also, the dir.c patch might be out of date because of a patch I recently did that
> was recently added to for-next. I'll work with Andreas to expedite them so
> they can go into the next merge window.

Thanks for the update Bob.

My initial response to that would be; this patch-set ensures all of
the warnings are taken care of.  Removal of superfluous documentation
could be easily undertaken as part of a subsequent effort.

It would be good to have these warnings quashed for v5.13.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
