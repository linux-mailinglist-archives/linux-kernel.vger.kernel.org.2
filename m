Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC5391E65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhEZRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhEZRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:52:26 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650E4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 10:50:54 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id d21so2308373oic.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/c57EaMZe63RxWJqN2eTbUojjqf7amOpyeK+rzirKyA=;
        b=NqTeQ4OktpJUauRiGh3Gmw3ee3au0KwtbKalcc2n/ZPWIK9JWYadoVUGNABW0sZRbK
         KEniJtapBu+rUGURe6kstQzd6GNJYP3TELrRV+JptSxiQ+v3DDjZAl1leSY+PMPZZ8TX
         47Cd1RQ4xO9Q8Y/gnu/WfjaDj0nVw/LEB29C+T4YYwtPPpnjpjae40LS8mzYhtaJ3Go8
         kaTvLGqsOr6mMg7SEbSt6RcVmJ+Cr3DBDBYUhDLgRv9XqUYzidGzJ/UZ6SGoyYqRe4+/
         VPzVjAPyPadVtc6TVwU8tsPnP2ALWdnNKkf3XiShKx0KJpN3c5ueir67CyTkj3sPZCGy
         uwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/c57EaMZe63RxWJqN2eTbUojjqf7amOpyeK+rzirKyA=;
        b=Zohtndskpv4gi4JDh9xEDoqzRJEI8neJX+7Wlcufg54a/TuuzdeZse+az7FuUB4fsU
         RUZ1Hbo/oR9osId+YBhW1KNgemzddQWt6lDv90eK1dkwwITLq0F1UnVOZ9o04/GmxPgJ
         s0MqSTFp0cGpsYoef7kP1xqdu0XA/7pfZfKSxQl0i04mBGTtz6Qs3eBSFcNw3VzggWUK
         mmPE3YEkyMIogmKtnSLm7YSMjrUsCf9XCf1t8lLw7jOLhx+f03vDybSr8QmKHAW2J9sH
         nwxHcbT/PgQ7A/kr37/DVB3V3so5mVElCaSJxWvjncqsJoshLKCaTKSsMo4OQvXUHAzE
         LMVA==
X-Gm-Message-State: AOAM533E+8XCPV9n+PTjhvZOu7iua242ZNCUmnaE3ekjPiaZ/8QGYPQf
        gpYgnTXhS9yIcTV8ozrs8eiW7KFOAxAaLHUCelSfGw==
X-Google-Smtp-Source: ABdhPJzGo+pDWJGs5vYRHDuQIaA+tpNsfp+SmxEWvGcJc+7FFirv7FUDc1yvV+EgBjBVpEB9HFNw3StzZlJcs5UdaUI=
X-Received: by 2002:a05:6808:f94:: with SMTP id o20mr2735598oiw.121.1622051453632;
 Wed, 26 May 2021 10:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190734.624918-1-elver@google.com> <20210429190734.624918-3-elver@google.com>
 <20210526174217.GB19898@willie-the-truck>
In-Reply-To: <20210526174217.GB19898@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 May 2021 19:50:41 +0200
Message-ID: <CANpmjNOOW6-8su=VNipvb7ztQ0TdF9THn+yeWepz7D7BAL418Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
To:     Will Deacon <will@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 at 19:42, Will Deacon <will@kernel.org> wrote:
> Hi Marco,
>
> On Thu, Apr 29, 2021 at 09:07:34PM +0200, Marco Elver wrote:
> > To help catch ABI breaks at compile-time, add compile-time assertions to
> > verify the siginfo_t layout.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+)
>
> Do you want me to queue this patch in the arm64 tree, or is the series all
> going together via another route?

I think Eric will queue them together with a bunch of other cleanups,
because as-is these patches are out-of-date as of:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0e31f3a38e77612ed8967aaad28db6d3ee674b5

Thanks,
-- Marco
