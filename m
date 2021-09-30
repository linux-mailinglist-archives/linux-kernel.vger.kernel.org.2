Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1AB41DD71
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbhI3Paa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245004AbhI3Pa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:30:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14859C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:28:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so7058291pjw.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jx2U1fXVMAX8YVJnygiZPmNCKOQJD2Hj7BS/kMAYEgs=;
        b=agBAaxvELaCg38+3MxkDJ5W3WTSUor6hjrK6UKjt7TpCZZuOPc7FM6IKQBxSyoc52K
         ilxpSY9wGu5Gckh+Y8wN93EqxSZzaoJx/7UfSc/o94BA/avp/+GptpxHQJdaTadAAjUO
         dApT93yF6zsQdX+lxSSJHyhabVLKYswM5ji7mIpRt06U+F8zgITyyWPHLuyJeCwWWRGN
         Y15ffW0I+FZnbmTTtme+SdoYeyiWGTduhyGuvTThXHcvhLrxiSGC2HEm/q23MDFOHhgq
         oCJmcf19GZOambHRb3p397D+7b6T+d8k74DqQhG9jcverKvnrcGX3TISXhAdq6YTGeUa
         BG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jx2U1fXVMAX8YVJnygiZPmNCKOQJD2Hj7BS/kMAYEgs=;
        b=o5FRr8mmt/AAcuG7b5l9X7xke5Ix7SgkivKFKU7QmQYc8q042Gb/XOBklLcAR/JEbc
         iscwxxVfi0UG+i8nA8wdGM/X6P66o00/SrqodlcWUODsqy6RrQ44Lkl4piyUhjp5LOi2
         Fcaq+D6A4KKtDgFkrY2AeDzxW/gSi/urTi5X2moqNcaZKzS95Y3HvjlkfMHm/3XS4syU
         M+hXNpjzaAUTurE6HUU+ZTkENL13Uwzrq2CQkiHlaM+RjhV5avoL0F6UrN16kORUPRk+
         BCblHmwXCc3rxWSHz8/7ZVEIjFcgV9+s22sARqLgIRbdlw194pq1z6ZxadjnHZzP3otO
         TIgw==
X-Gm-Message-State: AOAM531hNU9mEqq7e3mO+vxOsJjMbccq4haIf4eadPgJaXw5l914vTl/
        67iqWZsa5NfQEZuVXN6ggyfIAzFGDzztNuZUa0wOCg==
X-Google-Smtp-Source: ABdhPJy+Q5gdj1FvBjL6jYwPI7vYzDx17vSL3eDwmyx/hbSgqCzUcrj89W/AlsE7w1znCFVh/khI/9h4dUStCMaYHDk=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr13753493pju.8.1633015726357;
 Thu, 30 Sep 2021 08:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com> <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com>
In-Reply-To: <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Sep 2021 08:28:36 -0700
Message-ID: <CAPcyv4iNp41mZcpzGCPR9Xty83j+abk_SOxvsx1xaQ8wALRv0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 4:20 AM Yehezkel Bernat <yehezkelshb@gmail.com> wrote:
>
> On Thu, Sep 30, 2021 at 4:05 AM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> > no functional
> > changes other than value 2 being not visible to the user.
> >
>
> Are we sure we don't break any user-facing tool with it? Tools might use this to
> "remember" how the device was authorized this time.

That's why it was highlighted in the changelog. Hopefully a
Thunderbolt developer can confirm if it is a non-issue.
Documentation/ABI/testing/sysfs-bus-thunderbolt does not seem to
answer this question about whether authorized_show and
authorized_store need to be symmetric.
