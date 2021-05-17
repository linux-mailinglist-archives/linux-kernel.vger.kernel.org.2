Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01518382E10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhEQN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:58:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:56:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h21so4869522qtu.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgmyCKaAKZGVNxTY5A/pM798vKb97NwfHdPP/vxvmWU=;
        b=WZUdyoeWXO0448S6mUcE9CZhyKL4c+OfRMK2oE5brWpbpUG6s6Tc8y5xQTjfUJFXRi
         WonuzkbIpZ68ok2CXoREOmOMvDzjiLmE7vDRFQ+/EKB+a+9k6KQNr5yEjM8tdYtGvBfF
         nU55gxwoSHVLnrOHLkGNRcS3NJVp9hD0Wh9wH4PP0Sr4B+ubgktR6oWAGqle+0eC7DUg
         pcYgZW1PcvSfLROGD2ryDBUR13LzL3Eq7vxWEkRuKpirCRJWQE0vbvI4WgjxzlN1g0k7
         IMpb4961skqHpxq9YB5PuIcwwC0raZzJLlxYlFJQvaXymzE3qI77ol+BQI/6HC5nMhb+
         qeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VgmyCKaAKZGVNxTY5A/pM798vKb97NwfHdPP/vxvmWU=;
        b=WjfM6Iyo+k/CWWLzmwnpchbd/HXA67hxvqLD4K25BTT1ejDEGWMcXhq8or3ah9I+m8
         k9zvzXKg6a5UwIuagyCGjDdS6wZcUxayVcRy96pGV1uGNDmTW8tzZP29NYHjPRzMHcwv
         qt8pVrmqoU7nXxqIdPoG1TRNFV0A7n/XrKuStQEpxa8PrKw2yA1CupukAzLkfqLkDCKV
         7rk04MwSS8Anci0XAFhzZQpZxCgLJ2Ai1x8KaWIP/KhjCmRlx6SXJ047W5oK0rQB19sx
         GRvaOnDD99ALSdCn4HBlfW0c1eI/qFMa035Yt41npsyIs4K5O2TUqskWL6mFknGdWVP7
         YATg==
X-Gm-Message-State: AOAM532t3hDjP2v8g41ln9K/oKfcXhQe3QU4GgBRaMdk65ydNHqnrzSr
        BVMFtfs28I05OLihBUz8rUI1mxX6mYg=
X-Google-Smtp-Source: ABdhPJzOmjltS9KI/5t83hJMS7v/IpuO1NqP+SVBncPEjD3XebcUltp9P644oxsuMHxi4e9cLT68ow==
X-Received: by 2002:a05:622a:48b:: with SMTP id p11mr21702155qtx.346.1621259815560;
        Mon, 17 May 2021 06:56:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10sm10541506qka.26.2021.05.17.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:56:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 May 2021 06:56:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc2
Message-ID: <20210517135653.GA2116459@roeck-us.net>
References: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgX-4PTGAH7kRvqHYiq9wPJ-zN6jhLsuOAj6cG__g9N9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 03:48:13PM -0700, Linus Torvalds wrote:
> So a week has passed, and rc2 is tagged and pushed out.
> 
> Things look pretty normal: rc2 tends to be fairly quiet as people
> start finding issues, and while 5.13 looks to be a pretty big release
> over-all, the changes in rc2 are if anything slightly smaller than
> average.  But it's well within the noise.
> 
> The fixes here are all over the place - drivers, arch updates,
> documentation, tooling.. Nothing particularly stands out, although a
> fix for some VGA text-mode font size issues is funny (as in "strange",
> not "ha-ha funny") just because so few people presumably use the
> extended SVGA text modes any more. That's not recent breakage either.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 460 fail: 2
Failed tests:
	arm:raspi2:multi_v7_defconfig:net,usb:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:net,usb:bcm2836-rpi-2-b:rootfs

I have seen a pull request that fixes the raspi2 problem. Hopefully that
fix should be in -rc3.

Guenter
