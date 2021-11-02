Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC674437D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhKBVcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKBVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:32:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86448C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 14:29:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r8so540693wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qML9KgHR0khgdZTW1uosHaPAKnNgvxttSEAuQMX0GEQ=;
        b=vvVatfd1BQrLsFszhbRYkm03+gKZsCb+X9t5O7w8wkTWJ1SOloE5mONfoWyytrAADh
         h87rtq2oiZ/ohJbtE+aH6wuAirzuHvaHxoriSWzcya5IUTGDGTXFRVb+N50PXr+GY1s3
         K79dLJtqpgFab4kixIoAJydh7RTkL8Bv148RCchOYtM3EhicTwpRcguphSF+XmkH1mqY
         xfZ+yrRJeeWWbuobbxvM6Hie9qDkbI7fL8zcocg7ZL1uJskWZHw6K6lWZvWrDsK0R6Ye
         jhjk/FLqrNc/bvfQJ/+bGOYHBXothQDwfWt+GHaA/UL6OHMN8eqK/NwbJq5bYRfvINmP
         Z1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qML9KgHR0khgdZTW1uosHaPAKnNgvxttSEAuQMX0GEQ=;
        b=bav2oX2l6fuaBV/xT5QYSTaYxvHRzMXVo6bWmL9oGaODTz9YiylRO+iu+CoPYlmAim
         6fb5Me9jhVXIPphEMn1y7h/Z3n4jXiq8telJZfzokuFvx+3XosGU7Ic9+hHOoY4y+X8M
         uUyUrnu67ekSjCSgAT7itXOB7UkxGxHEOuRjNh73/bJQVxTy6RGtfC2k5x8ZPeirpESJ
         0kLJci1oQjLMJB33B+yp78sg2IzFev34g538MZWQmLhxoH56cUVumXghAoiOtJH2vlee
         5jz8IMmh8k0t76TuXaPlJwamsZyvweOzGXiftP4fND3PNSn5DhFVYuDLYkgwdn5GoXhl
         9o8A==
X-Gm-Message-State: AOAM532xXYNPaWbeaYN5iUowjoGMA4DaESuq79KfgN4ShH3D0SWCHd59
        esg6jTxEVzwABS8AQITE5tVywQ==
X-Google-Smtp-Source: ABdhPJx78m9gTB88Hr7ZpsykWna+1GSTTiWETWNwDFSIrgNVpYJJJATd62v8KH9zCjR2Me0qd2l8dw==
X-Received: by 2002:adf:e810:: with SMTP id o16mr43165440wrm.359.1635888564154;
        Tue, 02 Nov 2021 14:29:24 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z1sm172984wre.21.2021.11.02.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 14:29:23 -0700 (PDT)
Date:   Tue, 2 Nov 2021 22:29:22 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net
Subject: Re: [PATCH v2 04/10] staging: media: zoran: add debugfs
Message-ID: <YYGtso8/Uym+9Jwb@Red>
References: <20211013185812.590931-1-clabbe@baylibre.com>
 <20211013185812.590931-5-clabbe@baylibre.com>
 <20211014073752.GM8429@kadam>
 <YWyB8kwsqAvHMuhb@Red>
 <20211102174027.GK2794@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102174027.GK2794@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 02, 2021 at 08:40:28PM +0300, Dan Carpenter a écrit :
> On Sun, Oct 17, 2021 at 10:05:06PM +0200, LABBE Corentin wrote:
> > Le Thu, Oct 14, 2021 at 10:37:52AM +0300, Dan Carpenter a écrit :
> > > On Wed, Oct 13, 2021 at 06:58:06PM +0000, Corentin Labbe wrote:
> > > > +config VIDEO_ZORAN_DEBUG
> > > > +	bool "Enable zoran debugfs"
> > > > +	depends on VIDEO_ZORAN
> > > > +	depends on DEBUG_FS
> > > > +	help
> > > > +	  Say y to enable zoran debug file.
> > > > +	  This will create /sys/kernel/debug/CARD_NAME/debug for displaying
> > > > +	  stats and debug information.
> > > 
> > > Why bother with a CONFIG?  Just make it always on?
> > > 
> > 
> > Hello
> > 
> > I love to provides choice to user (and so avoid a dep on DEBUG_FS), even if I think I am the only one remaining user.
> 
> Sorry, for the delay, I was on vacation.
> 
> No, there is no depends on DEBUG_FS in the method that I am describing.
> 
> How that works is when DEBUG_FS is turned on then it's on for everything,
> but when it's disabled it's disabled for everything.  You do not need
> the "depends on DEBUG_FS" and if you make this an option the it feels
> like it should be a selects DEBUG_FS instead.
> 
> How this normally works is that when you have debugfs disabled, there
> are dummy files in the debugfs .h files.  I bet the compiler can tell
> most of those are empty and removes them.  So if you have DEBUG_FS then
> it doesn't use that much more memory than when VIDEO_ZORAN_DEBUG is
> disabled.
> 
> I don't know if I'm being clear at all #jetlag.
> 
> It should be easy to check.  Just remove the "depends on DEBUG_FS" and
> enable VIDEO_ZORAN_DEBUG.  Disable DEBUG_FS.  It should still build fine
> because of the dummy functions.  That's build 1.  Then disable
> VIDEO_ZORAN_DEBUG and that's build 2.  See how much memory difference
> there is between 1 and 2.
> 

No worry for the delay.
Anyway, I have removed VIDEO_ZORAN_DEBUG in v3 since Hans Verkuil also asked for its removing.

Regards
