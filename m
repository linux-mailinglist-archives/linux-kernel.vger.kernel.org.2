Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F198C3F35DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbhHTVFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhHTVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:05:43 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:05:05 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f15so10801263ilk.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHuE68SZeZJgo+ZJ5047NRixzSrlnFN0gqAr82i7YR8=;
        b=mn6E6ELoWiFgPJPOOfbw3ckSVf0xoK3tXZ1RucjWFtWtIdk6bbX+bhVl69KHevLS6o
         5eT2qowd6SG4JEwqxjmWQcE+aL1SElXiJ+ofmGEyhpny9Fr8O6OEd3blMOBTfn4xPnFj
         Y0EcBTzvH76uzG2rh5QuY6BYihUcoEm2QMrQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHuE68SZeZJgo+ZJ5047NRixzSrlnFN0gqAr82i7YR8=;
        b=t2dpHgdesu46x0peFNWM9KHHmOBedDRx1jLdAWmEEFug4xzJujTQ6zIKQwYnm99DWH
         HpU6LJnSSp83a40Huqi6oPKXAoTsEafFqKC+HZ41vnWA8H0gy9rNeuB/iJbs/MBD+dI3
         QmwlifOkDSLlzHPbZC+ahI8C2e92/39RsxqAXfssTVSPsR24TvlVxFfwwNvnKfJVqUlF
         BJ/vGwJe5cMdzBw79HRlgxYLk3ojmOKWje1bi73T+1/pozo6oSeLHZKwaAWeCasTAtQy
         Px12aZsJKDYj7jiDEy63V9RtMHrPrDU2rGntjJm9Mh2XKvQ8VMBXvT/sBSHpzCVdWrCq
         UeJg==
X-Gm-Message-State: AOAM532ZmI7eCoT6u58uagTbHkgrgCXVgKWJevJmY7Jko7vNEpZSDjVg
        bZuJ5H8YQFxUfiySsPYXCa467qkeFFy97g==
X-Google-Smtp-Source: ABdhPJzK0cQB+Niv7bw12fMvpdCw9Z5xlpR+GW1L9XaD4FRTGxESgPSaWmOYk28cjkt8AsE+08UTNQ==
X-Received: by 2002:a92:1812:: with SMTP id 18mr14766151ily.83.1629493504616;
        Fri, 20 Aug 2021 14:05:04 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id m184sm4002476ioa.17.2021.08.20.14.05.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 14:05:04 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id b4so1247394ilr.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:05:04 -0700 (PDT)
X-Received: by 2002:a92:d304:: with SMTP id x4mr15198676ila.82.1629493503689;
 Fri, 20 Aug 2021 14:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210820133829.1.Ica46f428de8c3beb600760dbcd63cf879ec24baf@changeid>
In-Reply-To: <20210820133829.1.Ica46f428de8c3beb600760dbcd63cf879ec24baf@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Aug 2021 14:04:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwAcJEDE3BQYuCDq4kRKPFAsuzPOseGY66wfXcW8Wn7A@mail.gmail.com>
Message-ID: <CAD=FV=UwAcJEDE3BQYuCDq4kRKPFAsuzPOseGY66wfXcW8Wn7A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add RK3399 Gru gpio-line-names
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 20, 2021 at 1:38 PM Brian Norris <briannorris@chromium.org> wrote:
>
> It's convenient to get nice names for GPIOs. In particular, Chrome OS
> tooling looks for "AP_FLASH_WP" and "AP_FLASH_WP_L". The rest are
> provided for convenience.
>
> Gru-Bob and Gru-Kevin share the gru-chromebook.dtsi, and for the most
> part they share pin meanings. I omitted a few areas where components
> were available only on one or the other.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 176 +++++++++++++++++
>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 180 ++++++++++++++++++
>  2 files changed, 356 insertions(+)

I didn't walk through the schematics and double-check the rails
personally, but the idea here is right. This matches the type of thing
we did for veyron, like in commit ca3516b32cd9 ("ARM: dts: rockchip:
Add pin names for rk3288-veyron-minnie")

I guess one minor nit (now that I look back on the veyron patch where
I mentioned it explicitly in the commit message) is that on the veyron
ones we sorted this down at the bottom with the other pinctrl stuff
instead of sorting it alphabetically with everything else. I'll let
Heiko say which he likes better.

I also notice for veyron that we had a second "ABI" exception for the
recovery mode pin, but I believe that goes through a different
mechanism now so we're good there.

Even though I didn't do a line-by-line review, I'll still give:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...though it's possible an "Acked-by" would be more in the spirit of
that? Not sure...

-Doug
