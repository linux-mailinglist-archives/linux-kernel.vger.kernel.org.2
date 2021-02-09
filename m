Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A4331532F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBIPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhBIPua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:50:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:49:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y18so24331478edw.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VecoGZ4GzWVFIM0otW3JLzPjrBseKAGL1qDTMuL9rhQ=;
        b=CIlh381kw95e85vYr57RlSuDC8kY8uEDiHm3Z8pePwVEf5EWMktOAJ8fGRfI8LyX79
         kO9nexVJp1Drhi5KDy+WElL2nlFVJNS4sVk60qwTKrQjxfmYIaG63VGkNeCsomyiLBGB
         ympVvtXZztYSxkyGsegiNStxZyW3MiGeRjmRTq8b6fYNiohin0XYQA0pMZPKtkC6ecEl
         pQqqwB4hWjBMRzfrJKQiuAT+/W9aP9UU3cFW4cBq8WMuMntzUHQ3LOqpc3+qdriViebo
         S+js95KFw5dV3JIc7xY0dJlwoY/0500CIrFUNNQhH2I2/yOgoOLP3mp7ZpaTltK07skQ
         cynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VecoGZ4GzWVFIM0otW3JLzPjrBseKAGL1qDTMuL9rhQ=;
        b=VjF0iVg7oEmQfdc3FabmC0DdbhRPt3NXmliuCkPSHjmKDUIIKYnFCYdXCnjn3R0K2s
         VhrK01ryc9XINEVgDryknEeGTtQcEEnLz3AxCiGD3aY9AQVHCHnyD44XBgpsm09W7bZl
         UNizA4dd1s6+ZA/mifHIH35c/YrKejLXN20FD9OilrwfslT347vHhKv0SIaO7lkotW1k
         eONuNV/DXOzElfqsEtvRQcRD0W9+tSkY9WgAlfHwvLXhRLny+3xG92P23jmkzL0z6gpD
         W2C3Bdmpg8COPSD28JL4h1JW5TVkYmhD0qQYrH5XIuhkBNceNs4jcRSGGFkrDRV0WjfW
         zRaw==
X-Gm-Message-State: AOAM533o3IchbW+ykkHX5AryxZCIkojesLcM9y15poIVaA4gthBWeJKb
        5OwD9iHMAqvUhyW8BIj2Iem7yYjib5xc7Io98GclHQ==
X-Google-Smtp-Source: ABdhPJxY4AjMbkZIQt1FqfH6XSv98lRusycD/W81ImCx2ZhTZq/tiEGg+xyJm+Pfkabf+n79kGMITiS2GYWaVpasTic=
X-Received: by 2002:aa7:c98e:: with SMTP id c14mr20178301edt.213.1612885788168;
 Tue, 09 Feb 2021 07:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20210205132505.20173-1-sakari.ailus@linux.intel.com>
 <20210205132505.20173-8-sakari.ailus@linux.intel.com> <CAMpxmJU7J9JBSwCN+GLDpuOL=iZ1PH=oZZuGiAyovuf2TQ=o9A@mail.gmail.com>
 <CAJZ5v0jUqtYDpBn-ezsftCrY=9iD3sAKhyyFf_+CMkthLnsZow@mail.gmail.com>
In-Reply-To: <CAJZ5v0jUqtYDpBn-ezsftCrY=9iD3sAKhyyFf_+CMkthLnsZow@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 9 Feb 2021 16:49:37 +0100
Message-ID: <CAMpxmJW61Bd1SR3-i6=OV6RgafiEdfp4sNN0M6EYa7NSeOTFKg@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] at24: Support probing while off
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 5:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Feb 8, 2021 at 5:44 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 2:25 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > In certain use cases (where the chip is part of a camera module, and the
> > > camera module is wired together with a camera privacy LED), powering on
> > > the device during probe is undesirable. Add support for the at24 to
> > > execute probe while being powered off. For this to happen, a hint in form
> > > of a device property is required from the firmware.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > ---
> >
> > I'll ack this but I still claim that the name
> > acpi_dev_state_low_power() is super misleading for this use-case and
> > I've been saying that for 10 versions now with everyone just ignoring
> > my remarks. :/
>
> Well, the function in question simply checks if the current ACPI power
> state of the device is different from "full power", so its name
> appears to be quite adequate to me.
>
> If the way in which it is used is confusing, though, I guess
> explaining what's going on would be welcome.
>

Yes, I have explained it multiple time already - last time at v9 of this series:

    https://www.spinics.net/lists/kernel/msg3816807.html

Bartosz

> > Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
