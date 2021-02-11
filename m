Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8423D319627
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBKW7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhBKW7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:59:22 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE12C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:58:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so4656131pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amreorW5Wp+rgEfeKxxFdgVmmwkgOKq0HeoNDJfuGV4=;
        b=fTdADRcOOLN4WHK2Zt6UP3ji0Zp3Utp9E9xyVb7aSxKdyCDUFDXgECBkyWNT+nwRn8
         rHNZFEobZ0FVNNcZSJ2c1O7yDS3iXY9Rras9gFtz5URWhATRqQWGskClTm1KPBZy3m0b
         4KTw9JUNTiBisgotkHv7R/Tqbo7lrUYGCdWGcDYhfK1TT7HrkNEtqfmSyVJk20ClVQyR
         IICwGksNJvFntlbkNjSM3qGZyXSaEkI+27gcm8oFnfILOKt3bGXg2f+K1rMIsGx8e9xn
         t0fcrD/sNFjQGeCzHqBruUxo/f3ASwpX3jEAAnvRfyDcEmwan6o1MedRlLRq4aYIjbFJ
         ME0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amreorW5Wp+rgEfeKxxFdgVmmwkgOKq0HeoNDJfuGV4=;
        b=C+gZBYZrIarzzFhvt0f+7MB1GdCX0LHvIyfCG9k7R9shAWByWDo2ZBVytS3nQld7vp
         ngtiDoiav8lA1ZjWZNAZUwWq5tJ1sBHoOE77tDJ9k2PBP0nyPPTVFEgvHJmK6s5eluDE
         TotDolhY2WdK4CuALQITVYYd36EbRJXGPqLgdr7es8LkbPWaDV8k0vYx8K4HgVxpSXgO
         RUj8bW/AQcp/Nx/bwrASitRwe2dHcUxmuHfkhYXQhMVYNap8gzzwVcfl2c0qyRRK2lyT
         rYLtZkouLCVr4c463yz7pEbQA1wExyIDlujLMvVSkXTFRctU/G5gJqZhZxjmvKQxCcdI
         wT5w==
X-Gm-Message-State: AOAM530LyjHXqGnI8wHG0eSq2ubTQD7ssaSGwz/QcEoI+WEhlr6sUCS/
        rmApjwN1HVlcsoAZ4nHwHpILOg==
X-Google-Smtp-Source: ABdhPJyoyyDeZHN2igF/Aa4CBWlQghor7IDCot2l7wTM7pQVHEvTAoANtTfktIz6cSZNPRruC+6nHQ==
X-Received: by 2002:a63:fe13:: with SMTP id p19mr370840pgh.119.1613084321254;
        Thu, 11 Feb 2021 14:58:41 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id o14sm7499206pgr.44.2021.02.11.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:58:40 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:58:37 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 3/5] dm: add support for passing through inline crypto
 support
Message-ID: <YCW2nWmHCunU1DwV@google.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-4-satyat@google.com>
 <YCQ/WjAsVA2gdb7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQ/WjAsVA2gdb7d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:17:30PM -0800, Eric Biggers wrote:
> On Mon, Feb 01, 2021 at 05:10:17AM +0000, Satya Tangirala wrote:
> > Update the device-mapper core to support exposing the inline crypto
> > support of the underlying device(s) through the device-mapper device.
> > 
> > This works by creating a "passthrough keyslot manager" for the dm
> > device, which declares support for encryption settings which all
> > underlying devices support.  When a supported setting is used, the bio
> > cloning code handles cloning the crypto context to the bios for all the
> > underlying devices.  When an unsupported setting is used, the blk-crypto
> > fallback is used as usual.
> > 
> > Crypto support on each underlying device is ignored unless the
> > corresponding dm target opts into exposing it.  This is needed because
> > for inline crypto to semantically operate on the original bio, the data
> > must not be transformed by the dm target.  Thus, targets like dm-linear
> > can expose crypto support of the underlying device, but targets like
> > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > 
> > A DM device's table can only be changed if the "new" inline encryption
> > capabilities are a (*not* necessarily strict) superset of the "old" inline
> > encryption capabilities.  Attempts to make changes to the table that result
> > in some inline encryption capability becoming no longer supported will be
> > rejected.
> > 
> > For the sake of clarity, key eviction from underlying devices will be
> > handled in a future patch.
> > 
> > Co-developed-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> 
> I don't see any obvious issues with this latest version.  I assume you've tested
> it on real hardware?
> 
> If it's needed despite my Co-developed-by, feel free to add:
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> A few nits about comments, in case you resend:
> 
Thanks! I addressed the nits, added acked/reviewed-bys and resent v5.
