Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E443E501
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJ1P0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhJ1PZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:25:59 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:23:31 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g25so3274700qvf.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOVoYXRHI5sNBWLXNQNXSjOsNry4SjlW/GjCDgN+QZw=;
        b=mE++Z0a0PPlRUkk6R75IRCCUodjtsEUnnLfylnq63z4c5436WEDxvqrJgHpJtZn3K5
         jMGtw3eWXI7rdw2Fik8lCefKcMChJ//NjezCloryhA7LWjmilO25wDcdkaOlb9s2o4yC
         57N1H6KhjCqlVAu3AtGl3hWmAmfAVs9pr8Q/5dgBJtg1PPUaUOhO3GBPImLcGUSiiSno
         MlcWssjTT7oLHA4Gz8NEeumDYfdI6tSglF0rq+Na+i2Km7MEC5XiNa/LkKWCiaMXJAhL
         ipV/7y6recr65xFDRn1mlrj1cFLPjfiLlqDaFY9mQ/mKo/xx1HLFjTt7RhAvfnu9ywED
         NoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mOVoYXRHI5sNBWLXNQNXSjOsNry4SjlW/GjCDgN+QZw=;
        b=3jOHT1zd/D5/sgfpuPkZ/pOtcZHugGqkj1nfFZL9dsSA0L+SVZEf2TD087kut2e6ED
         3qT/+qKjhZgzww3z2MseLHSw+2taGqI3LkO1GYWSyH6t2VFjn5/h5AIjrWFsJ4JtQ9Ib
         EAJAMn0FPMcpx0nN6FW6IpU/JoykYEklUv6xZFtuAimGFmQNuWM1X6KVEdD+kVEMWYnc
         geFYwHK61JsNVPA9zCGfeUTUMyDpx1QdFVK0eZqmVp2Jr/4MVCk33WrcjTLA6saETyfk
         KqFo9Y/d4gFt8gJAm/zvmfGLGo07eROs8OfHhxbyz1zkJqKYKN4X9y1+sUiyO68GO8U/
         u4kg==
X-Gm-Message-State: AOAM531rRC5HafEb9/Cg7n+OFZ0oBmd3fqRgtNVHfmv5rpQO/tJ8xZS3
        QcDFhNza7eELNM0qLQTFZsOma6zIzhxdsB8s/z8=
X-Google-Smtp-Source: ABdhPJxZcqGt/AL0gMONY8/y92jwlGyjci7sYU0xuRmAp2TlTBvPQZI6R2lXM/zyqaYIZw/K2yuHcg==
X-Received: by 2002:a05:6214:4119:: with SMTP id kc25mr4650274qvb.65.1635434611069;
        Thu, 28 Oct 2021 08:23:31 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id u22sm1131685qta.23.2021.10.28.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:23:30 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Mark Brown <broonie@kernel.org>, perex@perex.cz
Cc:     Vijendar.Mukunda@amd.com, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.co
Subject: Re: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC
Date:   Thu, 28 Oct 2021 11:23:29 -0400
Message-ID: <51280965.5nCgCKSeW0@ubuntu-mate-laptop>
In-Reply-To: <YXqXdV0YC5BhEARB@sirena.org.uk>
References: <20211027184835.112916-1-julianbraha@gmail.com> <YXqXdV0YC5BhEARB@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 28, 2021 8:28:37 AM EDT you wrote:
> On Wed, Oct 27, 2021 at 02:48:35PM -0400, Julian Braha wrote:
> > When SND_SOC_AMD_RENOIR_MACH or SND_SOC_AMD_RV_RT5682_MACH
> > are selected, and GPIOLIB is not selected, Kbuild gives
> > the following warnings, respectively:
> 
> I can't seem to find any indication that this has been sent before...
> 

Hi Mark,

When I previously submitted this patch, I did not send it to all relevant 
maintainers. Also the subject line was flawed.
Here's the original: 
https://lore.kernel.org/lkml/20210430143919.43362-1-julianbraha@gmail.com/

- Julian Braha


