Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ABD3EC5D7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhHNWmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNWmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:42:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54102C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:42:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c24so26859984lfi.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bKqY2ODulb1XJEskPNVxqR6YJVPe7PXRasqK0cTAlPw=;
        b=IfzL7SZdV9M3O8SuXZsUZPgiFgvNUj1w3FZXDHvTQfoV31EirOgqC7z6DHs2xGXt+M
         QNwHX5mgFK6PnSrprJ/jZZo6Mf5DgiBvkMiRzl7VmD3oJnEu5405COmfi7MbGO0pBCPD
         9HoM7FII/IBjp/rJUlkUBFDKc9ou7d2RpPoGT9lMds26qjZwVaQIOMDd642EzSyXsDO3
         3gdJlA++QLmr2zYPkXhoFisvs8NjtD0Ei4UgHfi560mwxCt/Ia7X5qGkiskAEoDzOtcR
         1mMvFdikTWA0JeEi8RZMXp1XFDeqXd0CA7So/qqCU0JqjRVJoEeZiC6Ts1kXxbaipEfZ
         c/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bKqY2ODulb1XJEskPNVxqR6YJVPe7PXRasqK0cTAlPw=;
        b=IQ1JusypYZDeetbmpw5zJgAjAWmvrA8UYCd4MF9ZZe+p4kLljRzQXXYsf0rIMIqywt
         K9MecGSzueTR6var4dnNfho+vvLojvVEHCv4B0y/o9hpdS7gEq72Myklf3WR3q0RyL6B
         NiuoGRdzJMyhXLT/i/xn6nj6BtfioG1FeLQpnbw5IkoL6H3G+bPzdkFP9yjkcLYGEUBK
         d+2qcn8ScKejaOJH0aCmaf/M+HiO+Q+Tq5SG5ZNxxnIYI472GyOnQYSdcRZyMLmEJbgp
         gS0hq9zvy5NLZ7NxO2m1X5wIvYg7A80zkHYFmQ+ex4sNjeklXzNGqvdHJGiN10idZX80
         gPUA==
X-Gm-Message-State: AOAM5338L6GnvcU5zb4rX57bOsLZNKCMg+QFeY+3dNNb2p4K/lRbM2nS
        2YFfj2Fo7YQfoyGr3Bkbi9c=
X-Google-Smtp-Source: ABdhPJy3XK7chN4zWmy3RKYxYeip8yvnowvQOoN0H/oc6dg/vrLJIx+Jz2irz7qf2h0uQ9lcYlSwdQ==
X-Received: by 2002:ac2:4e16:: with SMTP id e22mr6301838lfr.134.1628980939715;
        Sat, 14 Aug 2021 15:42:19 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id w6sm518097lfk.163.2021.08.14.15.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 15:42:19 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 17EMgG8j008711;
        Sun, 15 Aug 2021 01:42:17 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 17EMgFoZ008710;
        Sun, 15 Aug 2021 01:42:15 +0300
Date:   Sun, 15 Aug 2021 01:42:15 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rtc: pch-rtc: add Intel Series PCH built-in
 read-only RTC
Message-ID: <20210814224215.GX15173@home.paul.comp>
References: <20210810154436.125678-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810154436.125678-1-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:44:34PM +0300, Ivan Mikhaylov wrote:
> Add RTC driver with dt binding tree document. Also this driver adds one sysfs
> attribute for host power control which I think is odd for RTC driver.
> Need I cut it off and use I2C_SLAVE_FORCE? I2C_SLAVE_FORCE is not good
> way too from my point of view. Is there any better approach?

Reading the C620 datasheet I see this interface also allows other
commands (wake up, watchdog feeding, reboot etc.) and reading statuses
(e.g Intruder Detect, POWER_OK_BAD).

I think if there's any plan to use anything other but RTC via this
interface then the driver should be registered as an MFD.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
