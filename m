Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0038B421981
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 23:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhJDV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhJDV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:58:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5584C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 14:56:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so462723pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9y7riDeNDbxZ4NRQpyssCDChvJ1LIqCruwwNdCr++pI=;
        b=hJUynXsHtowO6YPoMbbKMPqmgbqGhndnyHzbik6Zs5eroP91LAH9jm5AM0L/V9naxE
         mX0LOUSlAm0NdTMwQTlTTiQ0f5agxLDy/iPEy/YXT8/H8IaIZJfHyuhggzfPjjX4o3jZ
         3bPXStzm4jLJeLrm/OBHFFy4KODGpGSyGmLjAincLYQK8ymDWfBMtKTmQ5vxy3GDYPdb
         qQZ/zrfmzfa/8WpBr8CFYI4hOaSthMzus7rLK+zf4nizFNoyOx3DZcitvxBlS5Oby9ac
         HzqG8fvoMWrEYbah99LuZqN1a8nZTpU6Bp1F/FGnSgDy9efhr7LKkN3XNU+6Z9Nl/50B
         +A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9y7riDeNDbxZ4NRQpyssCDChvJ1LIqCruwwNdCr++pI=;
        b=l5VKMOCYvaj3q2w/VaUGXC+84Z4U5Df6yTjHmJEhTrX7/WhnlbkUT6i8Fo48vsTjFs
         Pwxac5pESJrEG9jPhblIRkM3E8kn+uY0UXUHbDgp1tmOwRYNnTnM9jLcbJ318MLzWGde
         zYu3K30gcbNbxw/NAVK2kJC+0MesGTCoKtde03ZMrz6JYWUrkyL5l/NgpMxuXoqMNftd
         8oJ3GEkAuV3NKEoi2Uz0L1rFwYVhaA+0vZrZelDEZg0ep+u5RS5NoVv5WYC9Q6PBZYRG
         B8rWkLGGnbIMl7Mn2RbrQ/Pg4DZ4r8eec0HbeBmKgp1p1UVGkecWecGhnTItn7rdp2nb
         DsmQ==
X-Gm-Message-State: AOAM530IPrBSFZB5lQjQk6feVl7S4IuqdMx8cMl3JWpMrG3sqALCzP22
        lnimI6cUjP9zq+DQQ001TaPv1A5sw3A1mfcTJ233lQ==
X-Google-Smtp-Source: ABdhPJyEGQe2OxC51Cpuh85Aq3vgJ4MoUwZn8lG1eKS5I4pm0MxqDpX83ESO4dVzGLS0tT9NGJ7NPpTwQsD+RYk3buQ=
X-Received: by 2002:a17:90b:1e05:: with SMTP id pg5mr6778604pjb.173.1633384604995;
 Mon, 04 Oct 2021 14:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210929224823.556943-1-rajatja@google.com> <2df726b3-e5c4-0fbb-991d-e31e74348d52@suse.com>
In-Reply-To: <2df726b3-e5c4-0fbb-991d-e31e74348d52@suse.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 4 Oct 2021 14:56:08 -0700
Message-ID: <CACK8Z6F7jqTSyqO9of7JXtTu_unLSEDWC=ExoC2tRbbiLM_h8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: hub: Mark root hubs on removable devices, as removable.
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        levinale@google.com, bleung@google.com, rajatxjain@gmail.com,
        jsbarnes@google.com, pmalani@google.com,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Dmitry Torokhov

On Thu, Sep 30, 2021 at 1:02 AM Oliver Neukum <oneukum@suse.com> wrote:
>
>
> On 30.09.21 00:48, Rajat Jain wrote:
> > Currently all usb root hubs are always marked as DEVICE_REMOVABLE_UNKNOWN
> > unconditionally. Let us try to help the users to identify the removable
> > root hubs, by checking the device on which the root hub sits. If the base
> > (parent) device on which the root hub sits, is removable (e.g. on
> > thunderbolt docks), then the roothub is also marked as removable.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Hi,
>
> frankly, why? You are needlessly throwing away information about where
> in the tree
> removal can happen.

I think this comment was meant for the *next* patch
(https://lkml.org/lkml/2021/9/29/1023) and perhaps we can discuss this
there? Let me copy your comment there and respond.

*This* patch does not throw away any information as currently the root
hubs are always and unconditionally marked as "unknown". This patch
aims to provide information where we can, for roothubs only.

Thanks,

Rajat


This looks like a worsening, not an improvement to me.
>
>     Regards
>         Oliver
>
