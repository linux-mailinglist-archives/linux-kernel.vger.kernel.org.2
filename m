Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75D3F1B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhHSODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbhHSODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:03:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60964C061575;
        Thu, 19 Aug 2021 07:02:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l11so3970840plk.6;
        Thu, 19 Aug 2021 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPbncxjS8+CRZMB+URkKfMjYqspGoseMxP9R1d5h3bI=;
        b=iJww7ckAlPCcBlt4pR6imhAX6kOsewAD54+jHnISrcTb6QD17Saa2ylGuWsnZdix0e
         IiZGYxuDMQypwnVSNb/0f5lgKGsGuY83F6s7Z41O2GF+bmXH4Ap3B+OlZW/yIKJydhJ1
         hjSvuC/Gy6Ebm5MbeL26xmLSsujVLJ6MPl5z6ZJj57AYovHdYISZjB3Zbtad0QY33vZm
         J1cod4dAExa1BsHWKKCeWhzScs9Vi/uiW2skkbbd3LUWdZRyg9NAa3ksekTi6+zH4x09
         cq/HkchUtYVPwaKprVARwPggiEBuUkzXfJdQZ+0z6MgnsLqx7I9Aox0jVfOMBH1hUmRx
         8lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPbncxjS8+CRZMB+URkKfMjYqspGoseMxP9R1d5h3bI=;
        b=PWcoxw4eLixcBrJm+q3uZcQMv1jVU7UmMTZwnIpRU4wEW5t9PFZbQMGM3V86t2Ece0
         pqd6hk/uZcKfJHAPwarTbceGVhSOX4plh9InU4Ud2oz6ZGy/6tbpaS8XMbBeNYanhnCW
         wB+tH0QY/kfb7vHOE2HYumu+w73dlnrewnm731u0a5c+3hm6V2/wBeGMGOT+pQKEHL7G
         y+emIkI3Vwoslwsjx258FLhe4649YhJ+NmrBY/T71i/BZUvbhBg0mq7qESU9EyDjFkaw
         BLDCeonzVx/hm9WlNnpDnAIm9gEd6nPAVi+HYWMtYh1a9GxBVDmF4DFxmQugfVFIHaQ1
         ESgw==
X-Gm-Message-State: AOAM531OBNkmLlp8J5Qd2QWKODlPpFO5+bRqgdwyIPNtYcJhnVhP4vMs
        nGlhTmL8MzARRqpAk4K74U0CQlSVtrxtY4J4YCM=
X-Google-Smtp-Source: ABdhPJyYyT4088igMJEFLIESixCrUXYqdZwyUVetjYOQWAUh0zSQL8lpRJNz6LZlWQth20qmN0Aex4EEm0x9qzZ/PKg=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr12024733pls.17.1629381746768; Thu, 19
 Aug 2021 07:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210819033001.20136-1-hpa@redhat.com> <1360c64f-b695-a4b8-8b61-a4dfb0e896f0@redhat.com>
 <CAHp75VcdOc+G1Yov9HcGhMbEqzGwemmD7=SHd3qOOsEdAqjg2Q@mail.gmail.com>
 <CAHp75VfvjVeq716d=aGvZXvmzbpW4+XG66ryVYrBxk5G5Wd6cg@mail.gmail.com>
 <a5e52890-c162-ab48-4858-3eb0e971e5a1@redhat.com> <07cfd37a-cce6-56f2-0ff1-d4daeccfc67c@redhat.com>
In-Reply-To: <07cfd37a-cce6-56f2-0ff1-d4daeccfc67c@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 17:01:47 +0300
Message-ID: <CAHp75VfTc5tyoVnWYBsu9dNJyqyN1wLB2qEqSXyCdtYqZEzq9Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Intel platform driver code movement
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Alex Hung <alex.hung@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dell.Client.Kernel@dell.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 4:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/19/21 3:31 PM, Hans de Goede wrote:

...

> Note that drivers/platform/x86/intel_ips.h is deliberately not moved
> (for now) since it is also used by the i915 driver.
>
> My plan is to merge a follow-up patch moving that through drm-intel-next
> once 5.15-rc1 is out.

Why we can't do it in the same patch?

-- 
With Best Regards,
Andy Shevchenko
