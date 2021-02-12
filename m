Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5EB319C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBLJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhBLJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:56:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:55:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so5513830pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D7Yd2gi+KI4gPD0nZT1VEYRq+EDsM1Zcn3kMJP9fD0A=;
        b=e6KXBJ/H5Fy2nEZx45ttHC2k7nn+qtN8koPZfJaXzZ2N+/bCfg6MogL3s0ehXtcAEp
         0Q4R/oxms/wHRD84qZZkYWFo8K0MefW6/oBWBxZlWZPFdV4UZ5foxk1ngsnTTbzVWO5F
         eE6Fqbch4SNgMAF4OeWd0pRly1RgWUnR0Gzl4kaQraxSoQhBwhLWN3lQtFnv8LlxUjKA
         HVnShniFT5U+zlm2zyat6KkZHpWwHn/mMZYnPXdotU5LxVqrvuDXUdvx5HDoyjiixr1c
         YqRacNsOqp//XGVpeQAE7h28s8PVjJGM9rF+ir4bmg2n+20+BfMs5v/UiqYFe76Zcifo
         DGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7Yd2gi+KI4gPD0nZT1VEYRq+EDsM1Zcn3kMJP9fD0A=;
        b=F5GdmQjRn0SEaQ0GNJX3ijQK1NpheqY51EyuU94B4iELrQN08fdW46dRkQ76OhT4LW
         WIt6dHi9b7mlN09R27uI8MY+z570W2IrI7xgFQOLUkyJlGee+V3f6FBhLAlr5HSquxVy
         6NhiPYHkCAOoxycQZUgspy4PMA9NtuXcJPO8IvNqr3GQzmkbOSAy5wlvCSgep/Iq3hre
         nW1xY/7GxUvrKH2asDydd0UlzlMAWJbM7xBx3qVRSiMr3Iw8AiuJDnt/ojWnlTIPxEcP
         HQvxXV4sTHfTbZo6B2PecbyyyiLeZNLgmubFRCBJLRsxEs2q7VgzR0G9071KYg7OP5ga
         gckQ==
X-Gm-Message-State: AOAM532sh/4A1JM8UNljnYYXl0jza56W+8NDSSTh7LHJ1ff3WdSPjzbW
        hYAnrmLsruAcnpqDzw6I4XXaew==
X-Google-Smtp-Source: ABdhPJz/AAQZNSDiokFZ2T7m8vBev8D9/51jRrArWknSlPXRoWrEXGh+hysWkS4poObxzimtSM67FA==
X-Received: by 2002:a62:8445:0:b029:1c1:c862:8fc4 with SMTP id k66-20020a6284450000b02901c1c8628fc4mr2199503pfd.77.1613123732518;
        Fri, 12 Feb 2021 01:55:32 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id l25sm7841344pff.105.2021.02.12.01.55.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 01:55:31 -0800 (PST)
Date:   Fri, 12 Feb 2021 15:25:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Pritthijit Nath <pritthijit.nath@icloud.com>,
        devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Message-ID: <20210212095529.2nsjc5wacegnd757@vireshk-i7>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
 <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
 <YCZHsMPgyqtRMTII@kroah.com>
 <20210212092130.cxo6tuess6msf4kb@vireshk-i7>
 <YCZPzV7KiT/y//m2@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCZPzV7KiT/y//m2@hovoldconsulting.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-21, 10:52, Johan Hovold wrote:
> But what will the checkpatch crew then work on?

Lol..

> Better staging than the rest of the kernel.

[ /me wondering on who stops them from sending patches for rest of the
kernel ? ]

-- 
viresh
