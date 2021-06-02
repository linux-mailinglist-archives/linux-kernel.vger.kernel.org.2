Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF67398D77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFBOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:52:57 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41639 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhFBOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:52:56 -0400
Received: by mail-pg1-f171.google.com with SMTP id r1so2423501pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i9rBUFdn0o45VyNYIoUSPAP6TWQNEYGbweMgl8R3j2k=;
        b=ewELyXn1oVOkpjmFF9isG0jWeHDotlUmFjk677kzmx9NkvN6CJODmk4ABhKGE7SShm
         BmAkoAF5sNQCdyCX2QtuQqzBJhtO/wNKe13dCXLpIEG8QSMgIVMRofZO3APfD/HBwkpx
         jVboz7cyuf/sGTDv5pP8T6awFTi2Xv/udo8MkgGZ1LstSJ4b+tL3awBU5A7pqkMK/o/C
         HTrPZWpf+5ivS1nBpJZJurCwSoi9bY+9wfMNZLj2ysaIfdETm63bmkQuGLntKR6XGNNK
         xPFzjbRqxGCroRFZnCauLtKIdBUma0hvO0afqBTpGidL9vVfsQQaStyQS2tcWyjAJC5v
         mgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i9rBUFdn0o45VyNYIoUSPAP6TWQNEYGbweMgl8R3j2k=;
        b=uL1WXSIRwr1+imOOrTx5rk6bmd0G89N2aXQKorSvAhnH2G52281p707KpoEfBrx7P0
         OzeT0sLnW8aDpGmlLWniut6RhEelNy+SjjgvSfl5LfqDtU3zgDzCCubomFX+5AOk+ak4
         Mie+VDRZ2lTUcWHoddpsjguAge2ljJzSpBl46PKhNnRFLgckTyJ2nTKXTO1PAw1zwBOt
         5O5bHK/UBoxXEYgNgZbDskVI9vIxQ3vm4IIKmjJhtokCd2RbR3vMkYuMjimlQ6Ox/KvR
         iHp525jXD+Op+ItFkffL6H2CZuv5zBAcZ4/tqdYst/SyrLYu3Zc7080wD95tYabAO9kV
         dozw==
X-Gm-Message-State: AOAM532HwBVLee/33bmnGGT9X9cTObA37bju5kW9qK53Nuku3I5DFEtU
        HCRbdDwPCPIKIEu5uZPm5qI=
X-Google-Smtp-Source: ABdhPJyQjfmM+BCH1t7EJtFi0BLeF+t4bpsdWs2mSRcIjnc/D7jebkn4YHLTIVMp4REy5jZbC2o+EA==
X-Received: by 2002:a05:6a00:16cd:b029:2d0:d876:4707 with SMTP id l13-20020a056a0016cdb02902d0d8764707mr28187601pfc.64.1622645413401;
        Wed, 02 Jun 2021 07:50:13 -0700 (PDT)
Received: from ojas ([122.177.142.129])
        by smtp.gmail.com with ESMTPSA id u8sm65892pgg.51.2021.06.02.07.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:50:13 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:20:00 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: vc04_services: Need suggestions on trying to fix sparse
 warning in vchiq_arm.c
Message-ID: <20210602145000.GA3999@ojas>
References: <20210601200513.GA10204@ojas>
 <20210601202307.GC1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601202307.GC1955@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 11:23:07PM +0300, Dan Carpenter wrote:
> The problem is not the Sparse warning, the problem is that this code is
> a mess.  It used to very clearly buggy and I reported the bug.  I think
> Arnd found the bug again independently and fixed it.
> 
> A couple weeks ago Al Viro looked at this code.  Here is his write up:
> 
> https://www.spinics.net/lists/kernel/msg3952745.html
> 
> It shouldn't take Al Viro dozens of pages of detailed analysis to try
> figure out if the code is safe or not.  Your idea silences the warning
> but would make the code even more subtle and complicated.
> 
> The right thing to do is to re-write the code to be simpler.
> 
> regards,
> dan carpenter
> 

Thank you for the prompt reply and the link, it was very insightful. You
are right, I was definitely going about this the wrong way and missing
the larger picture. I'll spend some time trying to understand this
codebase as I think that'd be a good start to understand how stuff works in
the kernel (even though some of the things in this driver are anti patterns)
and hopefully get some ideas on ways to clean this up.

Anyways, thanks again for the help, cheers!

Ojaswin
