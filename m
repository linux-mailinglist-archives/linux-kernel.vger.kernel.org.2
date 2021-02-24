Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A65323873
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhBXIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhBXIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:16:37 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78678C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:15:57 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z11so1692418lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zgACkb1Gl2wYqG0IX7Bk5ltVRdUXsQvJfegYjpg1tZE=;
        b=u2YysyXZkhrGm+nkbp3dNTPKlj2GGxT9cW+rv/Buicw/cO1h6RLXqSOfZQdk8ReIy/
         i0v9BFCu5O8v/MQvq6V0DKaLPa3lt7rWT3yBlnpvXUw797B3oiK7yt88SrG8fRSkIHXj
         9SqHGaFl3reLD3jznmhj86LLdkmGpZxmVoVuJIuJiRi9KHVrSQaC/NWckup0MiQ7jriK
         G0KYBU1xHnczdcN0rJ6t2RJf3OAiCohpVp49ZWdzOEhZ05A5JesIKPPi0CBHokQscnCo
         W19xIYp4DIWx6eLTctD3RsfPU4bYgU/7yIfCaYyEeD/Apj+Ul3Oxtj6NEGuC29wmVDfl
         QrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgACkb1Gl2wYqG0IX7Bk5ltVRdUXsQvJfegYjpg1tZE=;
        b=eMUDXsCOKjbReI1U2TCWYuRYikGc7+okYxQUJC+lM6JxoNHKcjGyYmgbddF5jEF3cW
         qZyMi0BmL+RLBmjTIWV50IsfBpoCIX0kxIi+8qm8st0jtJ+QVmn94wCiX7VvxaatylG0
         CcbMBv1sXwSfSF1t4ZDr5A3o8YFCN5anMK6nve64QYqxqhr+MHAHNfbVaWF0+BF/w3T2
         cl+rPRQN9b0K/f5DEAATaualThevrPT2UG0HrH1jwDX+3ouVbEVt2rfSt1q5F/BCew37
         AcR6wFtSDW1dl47CQyfzB+qAqwbtDlaUZLIIGY4APAwQp8sP0EUFhSIfqFS88MqB+My1
         GKGw==
X-Gm-Message-State: AOAM531Qw/PERnNmIIxTy+zAjTkMfMQsx2BDw529jjvhix0kQzUfgZmp
        hQrguziLM6Qu37WCliKOybguvg==
X-Google-Smtp-Source: ABdhPJy5IykOHiQfPHqwX4rQuxdhmVigyjK7qplhy3RE7lzn+5/voNL1wvbcmQezshUAMlH2iYqAQg==
X-Received: by 2002:a05:6512:96e:: with SMTP id v14mr18111051lft.513.1614154555890;
        Wed, 24 Feb 2021 00:15:55 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id a4sm290291ljk.50.2021.02.24.00.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:15:55 -0800 (PST)
Date:   Wed, 24 Feb 2021 09:15:53 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        allen.lkml@gmail.com, zajec5@gmail.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
Message-ID: <20210224081553.GB2653493@jade>
References: <20210217092714.121297-2-allen.lkml@gmail.com>
 <20210217092714.121297-2-allen.lkml@gmail.com>
 <8d87655f-27c6-6a66-6eb0-9244279fbf2c@linux.microsoft.com>
 <20210223081948.GA1836717@jade>
 <cbc963d5-6c4b-7e69-4a9b-3d66b95affab@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbc963d5-6c4b-7e69-4a9b-3d66b95affab@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 09:56:13PM +0530, Allen Pais wrote:
> 
> 
> > > > > -	/*
> > > > > -	 * Ask OP-TEE to free all cached shared memory objects to decrease
> > > > > -	 * reference counters and also avoid wild pointers in secure world
> > > > > -	 * into the old shared memory range.
> > > > > -	 */
> > > > > -	optee_disable_shm_cache(optee);
> > > > > +	if (shutdown) {
> > > > > +		optee_disable_shm_cache(optee);
> > > > > +	} else {
> > > > > +		/*
> > > > > +		 * Ask OP-TEE to free all cached shared memory
> > > > > +		 * objects to decrease reference counters and
> > > > > +		 * also avoid wild pointers in secure world
> > > > > +		 * into the old shared memory range.
> > > > > +		 */
> > > > > +		optee_disable_shm_cache(optee);
> > > > Calling optee_disable_shm_cache() in both if and else. It could be
> > > > put in front of if().
> > > > 
> > > 
> > >    Ideally, I could just use optee_remove for shutdown() too.
> > > But it would not look good. Hence this approach.
> > 
> > What is the problem with using optee_remove() for shutdown()?
> > 
> 
>  There is no problem, I just thought it would be more cleaner/readable
> with this approach. If you'd like to keep it simple by just calling
> optee_remove() for shutdown() too, I could quickly send out V2.

In the patch you posted it looks like you'd like to call
only optee_disable_shm_cache() in the case of shutdown. Like:

static void optee_shutdown(struct platform_device *pdev)
{
        optee_disable_shm_cache(platform_get_drvdata(pdev));
}

and optee_remove() kept as it was before this patch.

Cheers,
Jens
