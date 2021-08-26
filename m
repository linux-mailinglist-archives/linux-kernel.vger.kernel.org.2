Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9D3F8A99
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbhHZPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHZPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:00:57 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E585C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:00:10 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so3855038otf.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kBkecJZQQz9+/hoAGi3+c4sptw+K9lAwZDNPONTgzkM=;
        b=EXAWTxXqGOK90Au7/sagYpj+G7IxY22woE2fH4eH4r9g0YUR0EzY0AnbQ6Mho+efdJ
         NAgBMg7J9GF83KsGgou2OzGxl3t2ul19Cy4fQdVcojets0ECerNqfA0bsNCqXO5vWMGT
         V7xh80s99Eyn0R2I7Zv6A/1Kx6+hR0Qo1xTcMf9tdRpKWUPtjDrJGhvABXckpLgyb7Tf
         zr7YtCX7QSWYeb1tJ2BO8oQZToqAgijCkYT6bwuuOnod9NayxZ0NOSyuQV2CztMsbZQO
         4mxLEea1b8HRsYQeoKJug+rzsp0aNYGhtgMzLYqFB9iqYjb9qwTIhjY48qgVmzY6fHNd
         k1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kBkecJZQQz9+/hoAGi3+c4sptw+K9lAwZDNPONTgzkM=;
        b=oWlG7qUz2tB8VFcNQKO2uA61Q5nep5YgXKRs+ppAZHWGSFtXw02kuf+2yIJxAM7FPe
         9iSmwmwbViBmWGCoZXFtt2OE6Y/iP5QQckffc8WGkviBN2XdjCTsdpNMTBTMie9wJLON
         0T/CDaEXwjzk5xpBCv7pS3mcMZi7C65NA6Eon7rsCBnikxxTqh22QbZF6IOdCp560KQ9
         wUBAUm+MsUyvsBcAYR4RXEqeqJa254vGqLDjB0wbkCXpojkJTjVnwNw+D0x+oUe4CFyR
         IqMZ7cqsZjwRojK+ZOy7xGWCMNJcjfUcOWOkMvStwzN+MjMfVjoCwTboDzVmNQOSMR3s
         jJZQ==
X-Gm-Message-State: AOAM5332Htm32WdGPLQoDda+JqXUk3cwUJfploqYh/TUSr2EbZsIvWD0
        CtZii0LS0c7FfGe5OLrEWqOis1M221E=
X-Google-Smtp-Source: ABdhPJw5V66NxDj2jnNRyC1UEOtx5+2hUQ9mns0EgEp4dTMnYW5nVYqLN+SYxHop2PwSQImAlAf8qg==
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr3438340otu.16.1629990005887;
        Thu, 26 Aug 2021 08:00:05 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id s10sm609650oog.14.2021.08.26.08.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 08:00:05 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Provide a TODO file for this driver
To:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210826014959.26857-1-fmdefrancesco@gmail.com>
 <20210826101956.GB1416@agape.jhs>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a2dbe053-55ec-bf33-e4c1-fb4ec32fb93b@lwfinger.net>
Date:   Thu, 26 Aug 2021 10:00:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826101956.GB1416@agape.jhs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 5:19 AM, Fabio Aiuto wrote:
> Maybe I'm wrong but I think Larry is working on cfg80211 not exactly with
> lib80211 or mac80211. So I'd remove the clauses on parentheses.
> 
That is correct. I am not changing it to work with mac80211 - merely cfg80211. 
Making it work with mac80211 would be a worthy goal, but not mine.

Larry

