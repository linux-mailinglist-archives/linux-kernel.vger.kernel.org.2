Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA84142FA90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbhJORyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbhJORyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:54:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD30C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:52:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a196so3130161wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=69D47JKZCJzd4fJalK2pIJeL71wXd61l6Zo16GfBekM=;
        b=UMUDBWVpMnlx+e2qEF6Lo/mVAuCrBb7tbueuwCWSqIzH63UWuYDgsUWFfnaqKypTc7
         TYyKnddkpf7NCBA806iZojukjOnQA5ElYyDWj+6mPpYzUDjoBbOPRGeRotprBjoKm6sJ
         b/wX7tQ5NFXG3T4g2tZTC6CKf7ErWs6dlVZg18yIoAQqoDqT2aKS+SQbq/Ui5jX8npr/
         gOXVbOGpCO7TQwBllanCM8Bekk8N7ulV8ZjFrx3dp49aLQwpWk+j2wTyZrMFyGVCEqMw
         yYFymuXwDJmHUEeE0grAlFKUgMOBaDc+3q7YnOLibMSotPUaGQGGzkTYlGl6KlMQJx4e
         hzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69D47JKZCJzd4fJalK2pIJeL71wXd61l6Zo16GfBekM=;
        b=rUOg/kOwsjH3X48iyNcC2crl+6eG1oYc5Q7dx5JdymPPoJhnOXA3j5TvE3U54LZmZw
         NxFCB2mG3cWndaniFYb3A0cj98rfWfFGKRpi6ocfRSxHozfzeOM3yWGuy8ij7ziZGI8r
         UpH0k5jJnPs2tj+NJ27Hc3Sbzp5wF6gHMHCUDPrw4vJlPO+8msCO5FJ7udEDHHIheDEP
         7xJLuqJJCgneMgckSRqysHE7KaAFaXqRWft6HhXaUnzC9wUXukS1n0kG3dTekJd0YAUh
         ZtJnT/2bGv7qUDCNw06zo2bEIEW9bzpWLsgP1cawX5hhec3NRIiatNOYZCUTdA7Xr0Z7
         YPOw==
X-Gm-Message-State: AOAM530d5qdgQCdUcbVJzCsvfPhtXG8tmIdN3elPDdZL7x1KHQ+Mvv0P
        qceVrW1S0sVPk396005dsp2nzN857jkekg==
X-Google-Smtp-Source: ABdhPJwKDCup64rBIGp1ks4g3Q91CzXAIh7N/UAET8EPgukaSCTaEF8e81gP0mD+z29cYpuANEfKXw==
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr27900507wmc.95.1634320330154;
        Fri, 15 Oct 2021 10:52:10 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h8sm6109747wrm.27.2021.10.15.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:52:09 -0700 (PDT)
Date:   Fri, 15 Oct 2021 18:52:07 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of
 semaphores
Message-ID: <YWm/x56aX+rNOlE0@equinox>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015110238.1819-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:02:38PM +0200, Fabio M. De Francesco wrote:
> rtw_cmd_thread() "up(s)" a semaphore twice, first to notify callers when
> its execution is started and then to notify when it is about to end.
> 
> It makes the same semaphore go "up" twice in the same thread. This
> construct makes Smatch to warn of duplicate "up(s)".
> 
> This thread uses interruptible semaphores where instead completions are
> more suitable. For this purpose it calls an helper (_rtw_down_sema())
> that returns values that are never checked. It may lead to bugs.
> 
> To address the above-mentioned issues, use two completions variables
> instead of semaphores. Use the uninterruptible versions of
> wake_for_completion*() because the interruptible / killable versions are
> not necessary.
> 
> Tested with "ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano]".
> 
> This is an RFC patch because I'm not sure that changing this code
> from using semaphores to using completions variables is actually required.
> After all, the code was working properly with semaphores and, at the same
> time, I'm not sure if the Smatch warning about duplicate "up(s)" should
> actually be addressed.
> 
> I'm waiting for Maintainers and other Reviewers to say if this patch is
> actually needed and, if so, also for suggestions about how to improve
> it. In particular I'm interested to know what they think of using the
> uninterruptible version of wait_for_completion*().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 

Dear Fabio,

Sounds like a good approach to me, nice work. I agree with Dan's
feedback also - will wait for the final patchset then give it a test for
you :-) Apologies I've been a little on the quiet side as of late.

Regards,
Phil
