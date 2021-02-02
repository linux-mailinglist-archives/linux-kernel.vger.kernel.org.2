Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1830C892
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhBBRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbhBBRxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:53:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:52:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id sa23so15029130ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tB4S5jLhLKvo7gnN06wmykthBef2GlOrD2/xcVl1A4=;
        b=a7ZnMTm4sWt6fyn+YApSQ0w4EABfeCbs9vFvoF2wWi5tUInQEA9ulPooKhD1GMMVeB
         TAA+Wt19ay/5u7Ngp3nONfJFLbQ2JuGUBoXoZHeWizvJiRIltrPVcS7RDkYH8EhMGnwT
         PWRuZXgGETL+EFckEimG550ma+kboXbKPeaxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tB4S5jLhLKvo7gnN06wmykthBef2GlOrD2/xcVl1A4=;
        b=mjW/ZvtkevzEQkeNUEEjZaLSfkmJ+MXBC5nytNyuTQCCvPEI/GNETzsFhPQSUm8T3T
         4XMlKxH2HbAklcmA51MbQwGWTQEipEfrS/xdZJgATIpqZ2Ewbykywyha0AIJ0vO8kP7Z
         5fciT6XRlFh3rCKKOGS2INH5M8qnajvzf6p5H3FX66UEF4MevXrdaLr59ixih/nLu5QY
         Fn0fdds2gbpK/LA8QFY8C5Ao2ALMM/arr5qNWnkt8WOn3XwsChIhkmAJ6qc/9ZIgwTtH
         kGRAphRkW0OmFjqm4zqftjsWT2fXw0Tt/h7o9oIsHDTstlcbpfUlF6sC77RcVwBOzruj
         Wedg==
X-Gm-Message-State: AOAM5308++jOmEGCriGE/5A5nGPwfKzfKjR+cG8J7jHiGnQli1Of8dAO
        Oi8Nz6G2P1x3NYX9gRDiB3O9W0kVeVY9++F9iFdZXA==
X-Google-Smtp-Source: ABdhPJz9j3bI4orrAdE7VqjHuU+Oh1ba5hhmYn/Zjuu6iN8UHXGhDXjaATmQaFyVUpo5W2FIaguym6nJO9O98UfQMrM=
X-Received: by 2002:a17:906:2407:: with SMTP id z7mr23893655eja.219.1612288345094;
 Tue, 02 Feb 2021 09:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20210202164531.3982778-1-bleung@chromium.org> <YBmFo5L1eeUwCJ9B@kroah.com>
In-Reply-To: <YBmFo5L1eeUwCJ9B@kroah.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Tue, 2 Feb 2021 09:52:13 -0800
Message-ID: <CANLzEkuFgLK9saqHhHdrKhOjsiG001d1N9EYXsnohoMPHsAPGg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Fix call to typec_partner_set_pd_revision
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Feb 2, 2021 at 9:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 02, 2021 at 08:45:31AM -0800, Benson Leung wrote:
> > typec_partner_set_pd_revision returns void now.
> >
> > Fixes: cefc011f8daf ("platform/chrome: cros_ec_typec: Set Partner PD revision from status")
> > Signed-off-by: Benson Leung <bleung@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
>
> What changed from "v1"?
>

Just the "Fixes" line in the commit message.

-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
