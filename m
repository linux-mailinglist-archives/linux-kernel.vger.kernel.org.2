Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053D0366FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbhDUQOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbhDUQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:14:05 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D948DC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:13:31 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so9313983oop.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dCppSngyI++R//hQtGOZYMjDksq9g6l4Q9fcelz4yaY=;
        b=O6Yfy8bT2mH2ilujglIpiSDEsP7kGBPn01CI5QoOeX4XGk4m0PVS5j36CwlNDTaIBU
         E0uz5+Lg8+tMVs+vTC4j0KiPhdT9wsPly/lz2Ec4mqm5cYUtWNrS/AWSML83suohFrn6
         UEZG/XW+7I4AyQo3n1a2Xkv0TLF1SjM2YLDJhKH9MB1rHMeLPNCyVx64chPJT1v1+ILN
         sfrmMvfsmZuGhQvn5zUVzF+brb6mBP9COc42sQ7OSYmGIIRC8sWimL/2ZQYrDrh2OGjE
         TzcZqYcpa3m4l7pgQC5o2aDxsdk1hDirqNVP7hGmGqBroQ6FdZUfqXKVLOCsyOT4Rc1v
         iHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCppSngyI++R//hQtGOZYMjDksq9g6l4Q9fcelz4yaY=;
        b=X2j6xE+mgImE2eseq8ryBmQyuOTfUdJwB7Z6jyuL/bdxWKxsIw6VF/Ituxl6sVrH/8
         +K+czKpYGZP+WeBszHg/1YIWvLT7F8JFJIdqpfBXtZKPLZYH+vYARhBaeDbUyj5zhKVM
         pEtpH1SDpsDMFt96A6yxv/xyo0CIX3IIUThZh83xThW2Lcq7oPd5VdjiDZUdPRFximxt
         89LLDxj98OqPc7jeXQsVD6C+f9vgmZsKbnn8VthleC3wxQ2wNzZLek71X/szh9oNNgSu
         XsYU+cp9gCeJX9I5NXpJb1VWqc4OprzT3n6GeX7E0idgtZyg0WzMNAY9UMF6yXrML9k9
         Ib4g==
X-Gm-Message-State: AOAM531iEGvf4TUdoSzJSj/AfDMSgn+Upzjne03galUVesy+rWaJSRD1
        H/p+Bp3g1G7crwLyzEeXf/gwkA==
X-Google-Smtp-Source: ABdhPJz2Zok3UsSRQdIl8y+gGqgTY+MAqeJzMIoVctrGtsMgbZKRQcF/ub0IlLllo6f+HseOqqh/5Q==
X-Received: by 2002:a4a:db7d:: with SMTP id o29mr10521666ood.45.1619021611140;
        Wed, 21 Apr 2021 09:13:31 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id y11sm556605oiv.19.2021.04.21.09.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:13:30 -0700 (PDT)
Date:   Wed, 21 Apr 2021 11:13:29 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 053/190] Revert "ecryptfs: replace BUG_ON with error
 handling code"
Message-ID: <20210421161329.GD4991@sequoia>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-54-gregkh@linuxfoundation.org>
 <YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIBM8hiBLFO+JJr/@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-21 16:04:02, Al Viro wrote:
> On Wed, Apr 21, 2021 at 02:58:48PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 2c2a7552dd6465e8fde6bc9cccf8d66ed1c1eb72.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> 
> FWIW, commit message on the original (
> ecryptfs: replace BUG_ON with error handling code
> 
> In crypt_scatterlist, if the crypt_stat argument is not set up
> correctly, the kernel crashes. Instead, by returning an error code
> upstream, the error is handled safely.
> 
> The issue is detected via a static analysis tool written by us.
> 
> Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> Signed-off-by: Tyler Hicks <code@tyhicks.com>
> )
> really stinks.  First, the analysis: condition being tested is
> (!crypt_stat || !crypt_stat->tfm
>                || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
> and their patch replaces BUG_ON() with return of -EINVAL.  So the
> only thing their tool had detected the presence of BUG_ON().
> Was it grep, by any chance?  
> 
> IOW, the commit message is "we'd found BUG_ON(); let's replace it
> with returning some error value and hope everything works.  Whaddya
> mean, how do we know?  Our tool [git grep BUG_ON, that is] says
> it's there and look, it *is* there, so if it's ever reached there'll
> be trouble.  What, assertion that returning an error will be handled
> safely?   'Cuz we saiz so, that's why"
> 
> 
> It *is* functionally harmless, AFAICS, but only because the condition
> is really impossible.  However,
> 	* it refers to vague (s)tool they'd produced, nevermind that
> all they really do is "find BUG_ON(), replace with returning an error".
> 	* unlike BUG_ON(), the replacement does *NOT* document the
> fact that condition should be impossible.
> IMO either should be sufficient for rejecting the patch.

I agree that it was not a malicious change. There are other places
within the same function that return -EINVAL and the expectation is that
errors from this function should be handled safely.

That said, I can find no real-world reports of this BUG_ON() ever being
a problem and I don't think that there's any actual need for this
change. So, I'm alright with it being reverted considering the
circumstances.

 Acked-by: Tyler Hicks <code@tyhicks.com>

Tyler
