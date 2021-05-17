Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839A53839C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244452AbhEQQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbhEQQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:27:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63478C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:04:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so3858256pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPM3XY2HTvioHScLM83R+NuErUnzIub8aG9A2jzUcaw=;
        b=cRwEzDxEYyQdlyniQ7SLQRhkMJRv0XGRSAnkEI4uJMfGLaxJd/XOzU3lpDwdPqY4eP
         XK0iu0o2UGnpBTyAtNcPXMXanc96XMgmkYor2KhB3I2V+RsjtuFB4vgqKYOwt+FY0qKt
         6j+1jUMZz9k29/ajEKvNyP3FeciTcmdnUQgmajOOMVpYPIDPPte0t1793KzUsQPxYcXh
         9A+SOUsyefHZ6IIZBqmGoOZIuqWwa8f15/CDq+raU3hV2SJu1IUJ0cn3aIpT4WWd5vkk
         CCHqkSs7S78RwNJelSuJxLih/wple+pR8D+DWO6MAhtgy9RngWki+JJnldqiQWtUtHfN
         rKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPM3XY2HTvioHScLM83R+NuErUnzIub8aG9A2jzUcaw=;
        b=MYnmBMDsXwOhc1rmvr/angCOmCbTvUC3Nuv9FbfKeUcNyzKpo9S6FRDChT8sMtgtec
         Jg/GKquTH/WaX1pnHUtj7t1Z153Bu2rOFKfYzBzksx3//DhumqY7gzS5muA8q1FnadQR
         YYMTgW9u4I9hjki/2WkOGDsliX9d2wmMXvKUE0oGGtEM9UmJbEBptDoLuRqCJQrIxip0
         K4o1nCycGGReoCVByffdpznIpjsvG9FkWinq3uXVgW1WbGQugc+3CFX7MmEBmfWDuaNb
         6tHSLUu3qlRyiT3v3ud/GJkueyMDK/vo73GgY+Nn1bRo6LHf1Rpxxe+IxiuVJhKBZWol
         KmJQ==
X-Gm-Message-State: AOAM533bP1ymM1CZxtwU3Y1c6QJTeT6/jotLuJtYCuArP/CMYcIuvwDg
        lS//GgFF/KWVwmZcJqlDWaQ=
X-Google-Smtp-Source: ABdhPJxVm5vSooJwq7w/9m+Y/0Y0rnsJEhVpcEEIKgBlCseS+DB1OgkmRyMIGX76EvsxRLIb1Zqa4w==
X-Received: by 2002:a17:90b:1c05:: with SMTP id oc5mr393318pjb.38.1621263844018;
        Mon, 17 May 2021 08:04:04 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id g202sm3366101pfb.54.2021.05.17.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:04:03 -0700 (PDT)
Date:   Tue, 18 May 2021 00:03:58 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517150358.GB56459@hyeyoo>
References: <20210517132725.GA50495@hyeyoo>
 <s5hk0nxo4qr.wl-tiwai@suse.de>
 <20210517144811.GA54892@hyeyoo>
 <s5ha6oto1bb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6oto1bb.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:57:28PM +0200, Takashi Iwai wrote:
> Yes, there can be likely a few other holes in this driver, but for
> fixing them, we'd need an actual test device.  The initialization
> procedure of this device seems complex (multi-staged) and very
> sensitive.
> Takashi

Yeap, this driver is so complex,
and I agree that we need actual device to test
if we do that big scale of refactoring.

Sadly I don't have one :(

Thanks,
Hyeonggon
