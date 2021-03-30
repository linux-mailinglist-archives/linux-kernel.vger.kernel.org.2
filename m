Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4634F1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhC3Tir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhC3TiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:38:13 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9AC061574;
        Tue, 30 Mar 2021 12:38:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d12so17584166oiw.12;
        Tue, 30 Mar 2021 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xI3kli3hS2fPyhDQvDMlAZ1DPbV3ke0jXU3XxGK6Iv0=;
        b=RxSEomzzNVufOedcbWjk9wGu6u/ZW28ITrTPqkZjm5KifOBlzu8GaTsCv+jhx2CLwl
         FlChfR7smLmVMwMr+wEqKHZkNTWcmieN0k4M+QEKlw6CvglIU9q7wD1TS8Rgt3VSP25+
         FSnTMKpxoZnEIYnDDyGyLWQ3ARtcIvtZztgQv6TAMMJ1FuC+IL5hWei1w0K27HBz8Xpw
         C7YTxIyHAF3d/wXikFXJ+RawHCITkwX9nquErtqIenu8EKM2vs8ibmsPMQaloICQTuAK
         JR2CI5DeaBI1YD2B+tWc1uqKwQcFrO3/TrkkiTjT4Kt7WvMOjpUwjtJZ2ygFrXCha29w
         qulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xI3kli3hS2fPyhDQvDMlAZ1DPbV3ke0jXU3XxGK6Iv0=;
        b=DtyclUieLGpDuboRXMnSNzBwW9H9NiNMFF7eGg6LOXeqceKPYSm1Py+FPatu3G6T1W
         +ODi70sOSBOa/dtCJKnthiEae+gd7mfg0ypI7TkGRIJsnFNsruMB85fxNuGWI4GZXIZa
         PTMYFWzGW4mzrXlpbkL/Y1JF+sZFYyHLwDexLJObZt/b9qwJ33GQbI3n/ELhEs1FbNja
         I7oFwjOjrtbDmVvrQP8GaH+zD7BpXvd4NR4IRgaZQ0+d0x9SOU2Z9TooMa5lkMODte2f
         3IoAnWceNA4WGTCUQbc43kZRKuIxBv61Pg5ZTBctmsuNhNKsrtgkYICtKnps42e1MRZ2
         s/rg==
X-Gm-Message-State: AOAM530VU7AvLg+wkNpCHs/n58aBxRznIjode6IXlBngGhQuhlOg1vP1
        67sqSHaqb/gY1qFtf+9cyKM=
X-Google-Smtp-Source: ABdhPJyAf0AtIWDRIdBNifFO42dpVXVRAIUztA0dKGsmOxAz3+0OVv43Me3QLKjxHEYgkLXKqk+F7w==
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr4540965oie.4.1617133092545;
        Tue, 30 Mar 2021 12:38:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v195sm4331370oia.38.2021.03.30.12.38.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Mar 2021 12:38:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Mar 2021 12:38:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <20210330193810.GA235990@roeck-us.net>
References: <YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net>
 <5105ada1-643a-8e58-a52d-d3c8dbef86b9@roeck-us.net>
 <20210330112254.GB4976@sirena.org.uk>
 <YGNdoYq5lyERVGLO@hatter.bewilderbeest.net>
 <20210330174221.GJ4976@sirena.org.uk>
 <YGNmaNzWOYrJROvX@hatter.bewilderbeest.net>
 <20210330180200.GK4976@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330180200.GK4976@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 07:02:00PM +0100, Mark Brown wrote:
> On Tue, Mar 30, 2021 at 12:56:56PM -0500, Zev Weiss wrote:
> 
> > Okay, to expand a bit on the description in my initial message -- we've
> > got a single chassis with multiple server boards and a single manager board
> > that handles, among other things, power control for the servers.
> > The manager board has one LM25066 for each attached server, which acts as
> > the "power switch" for that server.  There thus really isn't any driver to
> > speak of for the downstream device.
> 
> This sounds like you need a driver representing those server boards (or
> the slots they plug into perhaps) that represents everything about those
> boards to userspace, including power switching.  I don't see why you
> wouldn't have a driver for that - it's a thing that physically exists
> and clearly has some software control, and you'd presumably also expect
> to represent some labelling about the slot as well.

Absolutely agree.

Thanks,
Guenter
