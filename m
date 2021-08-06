Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7E3E2DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbhHFP3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:29:31 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44782 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhHFP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:29:30 -0400
Received: by mail-ot1-f42.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so9283681ota.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvnZTpfqNXYlMwiDla5Df7o21nbRMMmfR1MJcKcZfxg=;
        b=Ltv0qjSEI7kbnK/Nchx7MU+oaismJsr3C6NEZO8T6cywDDgXccfwXNlJle8WIxr2KB
         UWEhJkLovS1YdQ0HXKNMAPwt5rGvRjZec1bYHvrZGgnjzZ16jGRtxt2r4qhbl6MC9e7D
         SucsQYwwjSTk+c0QkHw6tQwdLiO5/7x4PcQJcT2pE41GZr3bklkRG86in3RLbdbaxV/t
         8ju6vzemLteE/4eqCFxg8q1hCfj4YzgwHGxLYgmYA2mETbd+vhBS0SC4BzOLpUDtildf
         RQeP4I/QMYeilh7Dy4To3/zuX2/FjkZPk6iEEPh1Kq5GuGWLiIu0sE8aRTnDcD/d2ToR
         V4rw==
X-Gm-Message-State: AOAM531Fb+WoRRgJWSuVcP+t100SQssm9n12HP50L4d43lj2Pbj0cEuc
        h9i0FWmd0Tp+Mh65d+X67+Ub+dKFcnFMf1Y+OGg=
X-Google-Smtp-Source: ABdhPJxh3uJdSoXVhtUENiMtg5Z6lvoVL0fD8XC9XodAbluNbjovX64Uqgi8OsVoxNNxLEm4SL/WXkoFWJbtVHPzAC0=
X-Received: by 2002:a9d:a75:: with SMTP id 108mr5933004otg.260.1628263753593;
 Fri, 06 Aug 2021 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210805220850.131545-1-djrscally@gmail.com>
In-Reply-To: <20210805220850.131545-1-djrscally@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Aug 2021 17:29:02 +0200
Message-ID: <CAJZ5v0g1Udw1oyVSOBO1HefawDNSfHYbMK7=ggR0WKOCawCosg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Check for endpoints in fwnode->secondary more sensibly
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 12:10 AM Daniel Scally <djrscally@gmail.com> wrote:
>
> Hello all
>
> A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
> against fwnode->secondary if none was found against the primary. It's actually
> better to do this in fwnode_graph_get_next_endpoint() instead, since that
> function is called by fwnode_graph_get_endpoint_by_id() and also directly called
> in a bunch of other places (primarily sensor drivers checking that they have
> endpoints connected during probe). This small series just adds the equivalent
> functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
> commit.
>
> Thanks
> Dan
>
>
> Daniel Scally (2):
>   device property: Check fwnode->secondary in
>     fwnode_graph_get_next_endpoint()
>   Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
>     for fwnode->secondary"
>
>  drivers/base/property.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

The series looks good to me, but can you please resend it with a CC to
linux-acpi?
