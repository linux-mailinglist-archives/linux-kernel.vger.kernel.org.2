Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE4401F9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbhIFS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbhIFS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:25 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB94C0613D9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:13 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i23so6243601vsj.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6BKrN7X5suyNsmFH5r3sUKXBVHf29sG6WVeH2BVyjM=;
        b=clAkQy9mohMLPnVHW5cIgwm5UEQQ5nDlPiwgp0cwJEYS0ycJTwv/DWUsRr0B8bbniX
         5/nkndYJJQt+jFffYyrtHZE10RuffIy6IiG+DYcDqlWqy8v1aJQBv/22QpJfJH5sAPEp
         lFzSMj0ku9aH22fxeXosDlemQyfBnrg21y/mGp51LbpdTK2SbNrLJNY55iFB8CjdVghV
         cCQba6HKcoqGwISK6MvywQ7Ew8wNqzUPIVUUw2uSew4EA9ZcK7Tn69EDc0rfdmfmLWbZ
         QQBHqFLn51nzUM6pTyUzm7OOUvLdQYde41jakHoVKOSwyJNU9iVB7OSZZDf1tmA+23aw
         oPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6BKrN7X5suyNsmFH5r3sUKXBVHf29sG6WVeH2BVyjM=;
        b=RXqez9LEAKMlqgxPTCFMK2mhxotdKDTI9QxPSSpq2EKjyNrkgGoowHJr6+zhVXUIBu
         6DXafCmvVk/K6WJ/UgUzKfKHo3bOb50QTOkpEntbE3TAGan5AcCIWtZUcA03xg7VTC3M
         BL5Sr6eF0EWs9eQ+LhmKckCpKphAcm9pbrkVv2jJk/qaJkoVuQecq44PrkJ4OBt3DsBH
         0tn8aEztVKcHa41DkLXaIQviBciv8OOcOyZkqKi1pH8QY2+iStTVdvmlkbhW3EQ54Xjd
         Z2DwwAEX5163ieUen9WRP8ec3YwNFxJN3iYW15v1HXCjBHN+AFlx41PpSd/JcOYkheCO
         /lYQ==
X-Gm-Message-State: AOAM533I4wX2854EvWG/swQjz0F9cZ2YbnxywdAZY4kn16Dpmy85uGW7
        fnSSlmQWWWPVMfcF/GMjlgqsry+RjzcMpcT1QsyKuYwH
X-Google-Smtp-Source: ABdhPJyg4VWsnkepgpvWdmz4JefgU8pNg5h7OlRD3wfkop9WYoZH2bRCi5vo8Qu00MZRxt35BDmA2bUFrpbKx4ektFA=
X-Received: by 2002:a05:6102:188:: with SMTP id r8mr6850374vsq.11.1630952712249;
 Mon, 06 Sep 2021 11:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210831202133.2165222-1-jim.cromie@gmail.com>
 <20210831202133.2165222-6-jim.cromie@gmail.com> <b3c4b3aa-b873-a2aa-c1ad-5fed80038c6e@linux.intel.com>
 <CAJfuBxw-i-7YUenvBGHA0unBQ8BqmOGRF3nRYNwNPLVaxWpSvQ@mail.gmail.com> <1aabb5c0-eef9-a483-2631-25726c9dc268@linux.intel.com>
In-Reply-To: <1aabb5c0-eef9-a483-2631-25726c9dc268@linux.intel.com>
From:   jim.cromie@gmail.com
Date:   Mon, 6 Sep 2021 12:24:46 -0600
Message-ID: <CAJfuBxxQ-dNWHv1VGu7Hh705wZbxmsStDa_-cc=63fDtNZiyjg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v7 5/8] drm_print: add choice to use dynamic
 debug in drm-debug
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll try to extract the "executive summary" from this, you tell me if I
> got it right.
>
> So using or not using dynamic debug for DRM debug ends up being about
> shifting the cost between kernel binary size (data section grows by each
> pr_debug call site) and runtime conditionals?

Yes.

> Since the table sizes you mention seem significant enough, I think that
> justifies existence of DRM_USE_DYNAMIC_DEBUG. It would probably be a
> good idea to put some commentary on that there. Ideally including some
> rough estimates both including space cost per call site and space cost
> for a typical distro kernel build?

yeah, agreed.  I presume you mean in Kconfig entry,
since commits have some size info now - I have i915, amdgpu, nouveau;
I can see some prose improvements for 5/8




> Regards,
>
> Tvrtko

thanks
Jim
