Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8632332D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhBWVVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:21:17 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37698 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhBWVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:21:09 -0500
Received: by mail-ot1-f42.google.com with SMTP id s6so89103otk.4;
        Tue, 23 Feb 2021 13:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QLDc40XgWd994geRO/ZckMMcOSU/AJw7iM92n9iT4cg=;
        b=ACkkLF/f2zrpbBdjEvbVGx0hnCvMsTdPxwYxvYdGMB2kXlaD9hxxUP3ILgS4jafjJS
         3M1BwuKNW7YWW6w/22X36q+SumXMKx7oL549gp7Us0lyCBGLqTzb18UQWa9rFqXaDWSP
         iznWptg4ek+NtR3Og83p+ireO/hinXOPsgXG6QroizRLQH7taP/cYvF9EHEZS3SWAiKR
         KFskzdi8Y9IkglCvuJNTvs4sQZ+xkm9kAPy5qNmELBpm7IfceMcZa3DInXGM+wsp0MU8
         SQrRJ9AgYTtJOOkdWF9y4GDLmbmQ6pOlY5MfBjpqbudBl7hjbaCQ+zut1OgauLcUntEY
         RoDA==
X-Gm-Message-State: AOAM531Ikw32WyEUJoXYNlob3f+Z0o733jOQXAaBe+bK23DD23Xu9g46
        f6V+Dynyg6FOKLz9MpIrCw==
X-Google-Smtp-Source: ABdhPJwpIqi/EVgpwLtYI+f8VHMRyPi2oDXSVEqGQCIBglvOINYx6xTKUsAGj5jcQkVID1m46sp/cQ==
X-Received: by 2002:a05:6830:1c75:: with SMTP id s21mr7282330otg.207.1614115228332;
        Tue, 23 Feb 2021 13:20:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 94sm4652003otf.41.2021.02.23.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:20:28 -0800 (PST)
Received: (nullmailer pid 81444 invoked by uid 1000);
        Tue, 23 Feb 2021 21:20:27 -0000
Date:   Tue, 23 Feb 2021 15:20:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dts: drop dangling c6x symlink
Message-ID: <20210223212027.GA79748@robh.at.kernel.org>
References: <20210223204114.E7F55E0155@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223204114.E7F55E0155@unicorn.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 21:41:14 +0100, Michal Kubecek wrote:
> With c6x architecture removal, scripts/dtc/include-prefixes/c6x symlink
> lost its target. Drop the dangling symlink which triggers some distribution
> check scripts.
> 
> Fixes: a579fcfa8e49 ("c6x: remove architecture")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  scripts/dtc/include-prefixes/c6x | 1 -
>  1 file changed, 1 deletion(-)
>  delete mode 120000 scripts/dtc/include-prefixes/c6x
> 

Applied, thanks!
