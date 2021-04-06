Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD633557B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhDFP1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbhDFP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:27:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:27:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so1467257pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=teujLeIT57PU4D6WHjfymxQZCq3L6iGxMlAJKaKbG+0=;
        b=yf22qUb+YRX9s4PLuKSN5MkcxpKtBgmhFGO0UFROZkFxAS4R7A0N7BysESW4YImDUy
         VxZjvIPIYgFn1JQCy/ShbhxBuNnxSSlWz8Khr9aOQJvNv8m+dCiHPwSagAa06L+hNHas
         8hT17gGxqn8J5/TBTRKYJL7n5vFqwwgcgVqPLEhih9+Aft1Hi7X7uftbp1RyVzKRVYjw
         e82GKjf8rRy0nN/JMzYkm/ro4Sji5iErHiWJeSpe1D7nF1lNOj3+/04d5aUcsCVm5Nsl
         ESYj0uzgV9oyOdP1Oc7xvQ1V4jirXtv3SHCXmXJULHFfn7fNLecldLnfFhKptoo446JC
         CtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=teujLeIT57PU4D6WHjfymxQZCq3L6iGxMlAJKaKbG+0=;
        b=B2PDPH3/9n/d7spSB+PmTKLBWrn4FR5NyGVaWRwR6U12CrAX96GhKmI4UiSHWVvLjC
         fs9zjo3hOhFOXBAWcu+YyZZkiGqjf+bOfaV6/DtkNJFYtq6p4ks0ELliCvyY12sXaISI
         XBXwx1N78wbGyii66WCO6GD2rU95Q0gpklatnvK4SMXIo5JlWjJgpvTXNOnmyzKv4K8N
         +Y8upX1sVfWXMxDaacGyCqGI2CATLt86erpUKjUNqkKaYiX81pOG7mZcD3ZwoQ64Jx5v
         3Mp/hV/9/YfO06u2oSiEdrWFJcY+nmP3tdOcK+c9UdQdnJBhRonuG9NxpSTV1NG2BBwd
         Fvyg==
X-Gm-Message-State: AOAM531YAdR7KA7CWnjD/EkPfdVgqptk/idDtH9OQDSuri4u+EUojo2t
        C+oZ0W58nUd/GqFmBp6ju55lbw==
X-Google-Smtp-Source: ABdhPJx5cwlVZ4C8U2nzBNJarhHwx7Cyi7BG9Ti2l4K+YRAAq0eVpHgxfNnEl0oXq1AYcCxoOy5x0A==
X-Received: by 2002:a17:902:b188:b029:e8:bd90:3f99 with SMTP id s8-20020a170902b188b02900e8bd903f99mr19788771plr.6.1617722860475;
        Tue, 06 Apr 2021 08:27:40 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id m1sm2813532pjk.24.2021.04.06.08.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:27:39 -0700 (PDT)
Subject: Re: [PATCH 0/3] ata: Module parameter clean-ups for pata_legacy and
 pata_platform
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d8c309b-a4b5-c152-7edb-3c74278b2d90@kernel.dk>
Date:   Tue, 6 Apr 2021 09:27:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 1:55 PM, Maciej W. Rozycki wrote:
> Hi,
> 
>  In the course of looking into Christoph's recent proposal to drop legacy 
> IDE drivers I have come across a number of issues with module parameters 
> of the pata_legacy and pata_platform drivers: errors in documentation 
> present in the comment form, missing user-visible documentation, and 
> unconditional poking at ISA I/O ports in pata_legacy that isn't there with 
> the old ide-generic driver (the lack of `probe_mask' parameter).
> 
>  Here's a small patch series that addresses these issues.  Overall I 
> find the design of the pata_legacy driver's options a bit messy, e.g. the 
> `all' vs the `probe_all' parameter, and the interpretation of masks where 
> bits correspond to probed PATA locations in a particular system (rather 
> than either all known or all existing), but it's been there long enough I 
> think we have to keep it, so I merely tried to describe the current 
> semantics.  See the individual change descriptions for details.
> 
>  The changes have been run-time verified with an EISA system and a single 
> ISA PATA adapter at the usual primary I/O location.  They have also been 
> verified (mainly for the correctness of MODULE_PARM_DESC use) with an 
> x86/PC build (for pata_legacy) and a MIPS/SWARM build (for pata_platform).

Applied, thanks.

-- 
Jens Axboe

