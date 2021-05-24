Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B438E0C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEXGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhEXGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:02:48 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3314C061756
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 23:01:18 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so24195381otp.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sLMIpW2Ge4GhccaqX0f4ED9sUyQ6GUsKxhCWraflgrQ=;
        b=kVwYjulbTpXvf8F/AH3Cn0+PqDxe6AsTYtT1ijwLpjc9Obx9CbTmoSemY8OjUw5tYq
         rghjvabI9aDAfy2KPMPOW60+THjy42P4Hk8yAjtHoNQ/Gt4be51wkQTQyQj5PlXT9Z8Q
         euKF6L1zMRk4m61B6LOZ8/zAZNWibeDQj15O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sLMIpW2Ge4GhccaqX0f4ED9sUyQ6GUsKxhCWraflgrQ=;
        b=ilmNAfBgFbigDXxYPp18JQvYTEHpXc/61Et1+WjHQm9Vv4dKXpq8buhsu/Ljj14IqX
         B2OFkv9A8D3uwMmiHDQknL7UYikpD8bZ3BamaJg2zFNDV4/xL8LqvBkPh3UCNcuVsaws
         5ncnjgFOUlvQxPO4WoYPOYUgTtB6K2Zzgg6ol+B/vWLaq+dKKFxaOwlbrh77ta/+ZfFM
         bBx+7wErMp3r8Vkhe7XGgtvZUXTDyS1j160g6Zq1jqgjksW0Qcfs0qxkpRYqXxigcpi6
         IsSgqgxtvC6uky+0zKQsCQ8YSSE+O3ByrzwFHIiJECnfey+EKcAbHXYV62cOA2QraWwO
         Yvjw==
X-Gm-Message-State: AOAM5307YjSgphNlyXKSWJN7E8i+uYW2ViWliX1fCDPshBKvWXNsqfqg
        U4PrtIBXhehG7oVSX7ok0cHajLGskjg4VpdN3zsJlA==
X-Google-Smtp-Source: ABdhPJxUXFeT7fRAQnyP76eyIBN6bZDnvKj0MzPI3ELpSWl7G60SJAr6Ae5/UXm1yxBeM2GrXn7ehxeepjeJze0/e+U=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr17357557otp.34.1621836078248;
 Sun, 23 May 2021 23:01:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 23 May 2021 23:01:17 -0700
MIME-Version: 1.0
In-Reply-To: <CAGETcx_LKwfv3Lx0mpxXaSdvoz284THwjqoHoOmZDwtcTf1zWg@mail.gmail.com>
References: <20210520002519.3538432-1-swboyd@chromium.org> <20210520002519.3538432-4-swboyd@chromium.org>
 <CAGETcx_LKwfv3Lx0mpxXaSdvoz284THwjqoHoOmZDwtcTf1zWg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sun, 23 May 2021 23:01:17 -0700
Message-ID: <CAE-0n518E_Yfy7-Au-pO40SQzZAn6NLr8u1pGyPMWWr0wRgpJA@mail.gmail.com>
Subject: Re: [PATCH 3/7] component: Introduce struct aggregate_device
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2021-05-20 13:20:45)
> On Wed, May 19, 2021 at 5:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > -       master->parent = parent;
> > -       master->ops = ops;
> > -       master->match = match;
> > +       id = ida_alloc(&aggregate_ida, GFP_KERNEL);
> > +       if (id < 0) {
> > +               kfree(adev);
> > +               return id;
> > +       }
> > +
> > +       adev->id = id;
> > +       adev->parent = parent;
> > +       adev->dev.parent = parent;
>
> Don't set adev->dev.parent. You are creating a functional 1-1
> dependency where none exists. The real dependencies are the 1-many
> dependencies between the aggregate and the components. Use device
> links to capture that and enforce proper suspend/resume and runtime PM
> ordering.
>

Ah ok. Yeah it seems like that was the thing causing me runtime PM
problems. I've removed the parent patch from this series now and I'll
look at working in the device links now.
