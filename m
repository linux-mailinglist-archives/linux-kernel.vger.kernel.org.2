Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD703F5E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhHXMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235449AbhHXMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629808484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9gIEIvnRStq5BFQTUMRVTiFtJWFqQXu4CAllH1gRE4Y=;
        b=PnGUI8wHIrEJOslCtMDCjk1qR+YbohESWc1Gnb1MAbzDk3hM29knjS2VzvSrWhsoOJHAGY
        HTDZ2IOTZHdU9KTi6TAfbC/0zLlNqi8MnofHhLqXzny5OdGjRq4N2D76WZtgtD0yjVVyo+
        tFi3MbIE95e50F6tc4PIL9AAG1BAcsQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-kMAcr228MMmEBzuvDYSQRg-1; Tue, 24 Aug 2021 08:34:43 -0400
X-MC-Unique: kMAcr228MMmEBzuvDYSQRg-1
Received: by mail-pj1-f69.google.com with SMTP id 11-20020a17090a198b00b001822e08fc1bso3816119pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gIEIvnRStq5BFQTUMRVTiFtJWFqQXu4CAllH1gRE4Y=;
        b=gFzu2qpZxjNL4F0rfkdlK64/VpPBVLwKqo1tC3u3UeDaHgzMkL+OinDbPBwDSqdL+o
         43ADQZufMVY36vA30Os0Ni79J/qOjY6RaIBVgbYYwv6N4juRRTv8hBALZrAwO8BO4Xsf
         M23uLiwDvbLY2qs6UyW8yItKYWx71nWGH/OQsKrPXSgqok2p/7+WWw3DymvuxuaHRLor
         NZEOHsYkjdQryXFufRQwdbDXTLKKtPD3mVhdOLtittIh+0XZ6RX/lGhuX425Uyl7xdYC
         lohoPPmc7I4p1EmD/thzJs2JMXY4XEdvakC1/M6QEP6+uiwPyJ0Jv/CJelmIWWN8Tmav
         JpQA==
X-Gm-Message-State: AOAM530m4T+72BuWKgCsWAYPp9bJFcyvarlsCXFu/8DLy//kESXceYuj
        cSZ3lPW4AVKxm/qF57RmYYz/XdqrvnkDu/bnB+vgKTKrT8KUmw9FWzSAEgPZEdZepPDqlNLHiFB
        UP3lV93zyy5UN2/t1ENWp/w74EiKXPfXRcCJwC97w
X-Received: by 2002:a17:90b:390d:: with SMTP id ob13mr2980638pjb.129.1629808482110;
        Tue, 24 Aug 2021 05:34:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2wM3Jwmz6hTsrLXnwbKAaycyYgAM3twY3NDHNH0/vSgjbyBv4gA75rV8sGYK9qZrqvOHJKagpbq3Qw2FR4nA=
X-Received: by 2002:a17:90b:390d:: with SMTP id ob13mr2980611pjb.129.1629808481773;
 Tue, 24 Aug 2021 05:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210819195300.GA8613@rowland.harvard.edu> <000000000000c322ab05c9f2e880@google.com>
 <20210820140620.GA35867@rowland.harvard.edu> <nycvar.YFH.7.76.2108241351490.15313@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2108241351490.15313@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 24 Aug 2021 14:34:30 +0200
Message-ID: <CAO-hwJL10rAS3BHoFOAD5evkd1zYw5ffb5u2c6uXYf9jh9jkoA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        mkubecek@suse.cz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 1:54 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 20 Aug 2021, Alan Stern wrote:
>
> > > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> >
> > That's good to know.  Still, I suspect there's a better way of handling
> > this condition.
> >
> > In particular, does it make sense to accept descriptors for input or
> > feature reports with length zero?  I can't imagine what good such
> > reports would do.
>
> I quickly went through drivers + some hidraw users, and can't spot any use
> case for it.
>
> > On the other hand, I'm not familiar enough with the code to know the
> > right way to reject these descriptors and reports.  It looks like the
> > HID subsystem was not designed with this sort of check in mind.
> >
> > Benjamin and Jiri, what do you think?  Is it okay to allow descriptors
> > for zero-length reports and just pretend they have length 1 (as the
> > patch tested by syzbot did), or should we instead reject them during
> > probing?
>
> I think it's a good band-aid for 5.14 (or 5.14-stable if we don't make
> it), and if it turns out to break something (which I don't expect), than
> we can look into rejecting already during probe.
>
> Benjamin, is there a way to run this quickly through your HID regression
> testing machinery?

[Sorry, on holidays since last week until the end of this one]

This patch addresses usbhid, so I don't have tests on this unless I
manually plug mice, keyboards or random input hardware :(

I can try to quickly get a logitech dj receiver test that should use
heavily control endpoints, and probably get a Wacom test. No guarantee
I can get it today though.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

