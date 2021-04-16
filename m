Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3649361959
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhDPFfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDPFfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:35:51 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:35:26 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a21so13659527oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFCuQjzeWEqVOnSxH9l3seK+DWkURq4UwkFrvexD2eU=;
        b=d0yTUxmTcD6nOU09FHnlzTo0lx2mwWzMVSDLY7FdcLjHeVJeVLjeilmVNNQ4CSC/gh
         IhmShyVpFwEkb9hwfZVsXO0m2pbhuetrECeMDuRev7x0LLI2satvKrdejFVsmSttz8cO
         oxxjcQ8yK62sSn2/mMDFyyFkm/OXJ3r0QDr8VbDowa9jo+XZzn1QF7cf/GB0qU4esOsP
         EYTV3EC9dhbV2KS33vH86rsn3jkQNG0sytqkXlFoTPb8zNX3wCrRAF2oz/YdjIx6Unjd
         9dYYB0VszdZtUdpViQaMQfDmz00euvrj3EZxr2Xl/tTsda+uRd+y6tZv1kQPUbeREXed
         giRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFCuQjzeWEqVOnSxH9l3seK+DWkURq4UwkFrvexD2eU=;
        b=pA46ZCVUUBUXmucWRm4GWiYwh/E1O2Gf/iyv5R0W4X4tvSsqUPP8LjPLo0p8oR4Hz6
         ciCVhMwIOelZt1ahODpKszsr9QWJHgPzezVszy1cK/X4cdj80wJoKSpvOx2Q7z4iPvhZ
         hVlFf0fQBeTyUs4p1whUaxhKiPiqfk4/2gKf6Es93Xe2DRWzg43WVpf+Ix9E+5dqBBUv
         1q8NrJX4e4PNeBWYlWItbrI5tAhHGpZEWKYhGb4XH/un3dlGr1HAKHMdmDs1scdBHYbf
         BA8Acf50wH/7P+jlgSRJCPS38a0/a31QUtHV7l7qVAdkRKuUaAWZQFDAu+jf0kX43Rxy
         OPfg==
X-Gm-Message-State: AOAM532tysmbV9AlYyPPs1Tva/2HRkihsvvtaR28nmKjkpaQPxVwIViM
        uxAFTbDxk5nFk5xfSZGYUHODVm+aKMDlOyI8UkJ6QlHj2WGyPhMe
X-Google-Smtp-Source: ABdhPJypqEgjQFMCGz9v5f2MQTPTCxXxge7bZue6TFEQc+HYzUoahf5lCYEmOL2SVqpvYBWuuf78thQEnheNwoAxOXo=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr4986993oif.5.1618551325311;
 Thu, 15 Apr 2021 22:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210415212508.7ef57d73@Zen-II-x12.niklas.com> <20210415221626.3a33787f@Zen-II-x12.niklas.com>
In-Reply-To: <20210415221626.3a33787f@Zen-II-x12.niklas.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Apr 2021 01:35:14 -0400
Message-ID: <CADnq5_MqWX9wGN7p+8RYqQ7dxV84sQjdgv9nWFrDgbVLh46oDw@mail.gmail.com>
Subject: Re: [Regression] amdgpu driver broken on AMD HD7770 GHz edition.
To:     David Niklas <Hgntkwis@vfemail.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 12:48 AM David Niklas <Hgntkwis@vfemail.net> wrote:
>
> Hey,
>
> I forgot to give you a bug tracker in case you want one.
> Here: https://bugzilla.kernel.org/show_bug.cgi?id=212691

I've followed up on the bug report.  Please take a look there.

Alex

>
> Thanks,
> David
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
