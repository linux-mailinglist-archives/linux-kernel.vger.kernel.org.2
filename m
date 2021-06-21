Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C03AEB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFUOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:24:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86721C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:22:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q192so7197625pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8L+cd+ZQnTliBnbuqbahlYKMU/bFlGdaEWT+XDryuZI=;
        b=dDIxGFZonS5d2guwsqbUn2ZNdVnahSjKxnJNiJ2rDNoD8zO8Jk0pUBBIAWfU3PkRPH
         KuFeaDX33DXkPKL/5wJCUaMyaYDyC+RDoYasJymcxt68eNG69MeQei7wGMSk9S8FYP0k
         VMyIVd1WlDqNOTkQZDQVqlUuXCqEXCUZEIDkH+u/JJKbuvJQqKCZ1Yr60pm7+gT6Ra9L
         fNj24dLytBMmOz0TRnxMuIsGRkG59I3GALaGaxtF0Vmhk1KhcWXcxTNMjJdOAvK3nlIU
         Je8nYmTxMYaiOxR+Xw6+myXxmoyuoXDSJ4vcpacn6Dw9jJg/QrLiOKyAD5ygpjr+XHYM
         1Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8L+cd+ZQnTliBnbuqbahlYKMU/bFlGdaEWT+XDryuZI=;
        b=toUzII4UMOeZuTD3r9B+PT77P3nAiQ4GrUetgutyItUQOt3/mnHhjfrrMdAhAzfqOs
         syepYK1zoKolZCe0phIsPXOpDbE2bhX7+DQYx0i8EdNoVI0affGyYja17MBjfTLc/8Hs
         wmBf3YovoqxEySsbaBcG+K+h2cawPf9A7ox9umKYxZdjSiw9/kyE6uDrG+G22hmeoJZi
         429Apsah0wMxSYbhyWSOm88Gc3QzjhpVEDmaNMKnIBUyUqR4xy43vlDJDyptXmA35poh
         zCyLBfRaWCPZ4WC0G+SjtcaOdDmen0dV1T1xsNp1f8IAa+d5RsrakvpEygbeQHhmzlC1
         ApoQ==
X-Gm-Message-State: AOAM533thOEDpImtvIxIILEW7Xf1dLyeSRPNUBZy5A7AL/MiM1pOzd2/
        qCIms2vIeNg/BGCg0slTklo=
X-Google-Smtp-Source: ABdhPJzZ6AmPiFqoTJcZ4tUQRgeJ1RJjJAfN/W5xkONC67cFCSfCwrZunMX6TFVg9VAcgVbj4ZSUEQ==
X-Received: by 2002:a63:185b:: with SMTP id 27mr24580741pgy.164.1624285357096;
        Mon, 21 Jun 2021 07:22:37 -0700 (PDT)
Received: from ojas ([122.177.154.120])
        by smtp.gmail.com with ESMTPSA id v4sm17119750pgr.65.2021.06.21.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:22:36 -0700 (PDT)
Date:   Mon, 21 Jun 2021 19:52:26 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: vchiq: Refactor vchiq cdev code
Message-ID: <20210621142226.GA186979@ojas>
References: <cover.1624185152.git.ojaswin98@gmail.com>
 <e786f8c7f92561065b840490c32959932526dac6.1624185152.git.ojaswin98@gmail.com>
 <20210621082132.GC1901@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621082132.GC1901@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

On Mon, Jun 21, 2021 at 11:21:32AM +0300, Dan Carpenter wrote:
> On Sun, Jun 20, 2021 at 06:25:46PM +0530, Ojaswin Mujoo wrote:
> >  	vchiq_debugfs_init();
> >  
> >  	vchiq_log_info(vchiq_arm_log_level,
> > -		"vchiq: initialised - version %d (min %d), device %d.%d",
> > -		VCHIQ_VERSION, VCHIQ_VERSION_MIN,
> > -		MAJOR(vchiq_devid), MINOR(vchiq_devid));
> > +		       "vchiq: platform initialised - version %d (min %d)",
> > +		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
> > +
> > +	/*
> > +	 * We don't handle error here since the function handles
> > +	 * cleanup in cases of failure. Further, we can proceed
> > +	 * even if this function fails.
> > +	 */
> > +	vchiq_register_chrdev(&pdev->dev);
> 
> I feel like ignoring errors and just continuing seems helpful, but it's
> actually doing the users a disservice.  If it's an error during, boot
> that's different, in that case it's better to get some kind of minimally
> useful boot so the user can debug the problem.  But if the error isn't
> going to prevent the system from booting then it's better to just return
> an error so they can fix the problem and try again.
Got it, I'll fix this in the next revision.

Thank you,
Ojaswin

> 
> regards,
> dan carpenter
> 
