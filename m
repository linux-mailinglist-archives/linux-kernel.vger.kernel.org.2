Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F83C31887B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhBKKnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:43:43 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34232 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBKKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:40:35 -0500
Received: by mail-ed1-f49.google.com with SMTP id df22so6447704edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEHaEqfkX/bCOFj6WvJkc8sOHle2pKOr8Ss2R/h0+rg=;
        b=S7/+9AwJzuEowD6/OdatnEBK4jQwTFHLnC+2qBT9lo3b8X/xWPpJWBIFEo1pl2hzkg
         5ukO9ppDwNrFYVpEN4UbWp/clp5GZ2V/wkMr6FoqE8CMwZPJRNKIgdNUvGQKc/aQd9U9
         0G5htnVjX88Ds595228v/6VxPgOiBk0yCpnmjWHgRh2IN1gRZjsp0rBt6UDwajdu9jTL
         aWz7Tv6BroJ/T/WGT3iwNNgPST45kCWQhMLN+4qr3JapmtgFWM/icDEtzVaBAk85wolZ
         FFif6mJJJ0az+tAzTLPgOx/+XFQAHX9f3PYjA7NHoTWmLdAXd4erGR+AR60WmamLTnvM
         7xgg==
X-Gm-Message-State: AOAM531OTi1F5ABMJkU2hPQbZUcYckPrcoILND8NW8DIFjgYyAHpHB19
        NqTjWppfztxnoLWhu+kxI45ttfwRUV/Gew==
X-Google-Smtp-Source: ABdhPJxkMyanZ1p+7Er/P/KJpQO8vzqz/H3KoMSia1z59D4yDXygc/Hpm+nY7jNcZQaxHPzaPSdTog==
X-Received: by 2002:a50:d302:: with SMTP id g2mr7827149edh.75.1613039992492;
        Thu, 11 Feb 2021 02:39:52 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id h15sm3877669ejj.43.2021.02.11.02.39.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 02:39:51 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id df22so6447640edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:39:51 -0800 (PST)
X-Received: by 2002:a05:6402:104e:: with SMTP id e14mr7915504edu.316.1613039991789;
 Thu, 11 Feb 2021 02:39:51 -0800 (PST)
MIME-Version: 1.0
References: <YCQvl3+KviQNh2JI@karthik-strix-linux.karthek.com>
 <YCQxeMVM92dtfEpO@karthik-strix-linux.karthek.com> <YCUBEMUyvRcQkFF7@kroah.com>
In-Reply-To: <YCUBEMUyvRcQkFF7@kroah.com>
From:   karthek <mail@karthek.com>
Date:   Thu, 11 Feb 2021 16:09:39 +0530
X-Gmail-Original-Message-ID: <CAJ5zXr0KkBy207yFx=hSWWqwduJDE=TydqWTjF0FFfyM0OvtrA@mail.gmail.com>
Message-ID: <CAJ5zXr0KkBy207yFx=hSWWqwduJDE=TydqWTjF0FFfyM0OvtrA@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix function comments to follow kernel-doc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry

On Thu, Feb 11, 2021 at 3:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 11, 2021 at 12:48:16AM +0530, karthek wrote:
> > check this out
>
> Why ask us again when you already sent a patch?  Do you see any other
> developers doing that on the mailing lists?
>
> thanks,
>
> greg k-h
