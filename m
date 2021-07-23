Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0803D438A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 01:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhGWXSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhGWXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:18:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FECC061575;
        Fri, 23 Jul 2021 16:59:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n19so4606824ioz.0;
        Fri, 23 Jul 2021 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiDACkcaGfVG9TmW2biO8dZY6cfo1/gxjtjvcU264pg=;
        b=gWRe6SMgaPvcfXAdd6tpPvrUmvywiaCnBV5uYBeAn10agVBitz8ejYP0qjQ4b2E9aU
         Yy0aDKawOx5k1btJ+y5Tl4MAyozu5dc4a5j7ejKzD97S9K8MAX17JF8jJiYTTFEAvIGm
         6BNGvr+Xs7e/yXSUlnrY3egcwIVGfdQIoznWK8yUmNNHSvT1znpzwLzZPEcg/rA6ghwl
         Ko0HEGV8CaT3/hG1JZEi715xP3eMMuY7FEkd5ZOyefP8oYdY8S4mSyzMaJ/Z6Zp0UgVA
         WjRHiRnVIncXlyj8oBv5lJ6u0iRBF0ILL44hiN+0+LetCJR5UmjizjIFb212j0TBXb+c
         pHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiDACkcaGfVG9TmW2biO8dZY6cfo1/gxjtjvcU264pg=;
        b=SDR5GnM5NCOaKM6aAL7ZlZz77VeQS/Y/6N+bnRuf1LB59DuZdYlATolKE7eoKrSIfN
         u81cMKS3MsDnNOA6Kfc1b18Le2xmUlFmGeU/iwMB24/JI9oQzliWOCBA+AlkpOO8bDZT
         5L9oFOAtc9AVxa7Zj0tWMqJ5JECt02bbL3RZplM7DgH7DaiUNAxX5V1cXOvCLq8H3w+c
         uOmtiCcviCxATYx+9kjT5DWcXvuZw/zYKjCJa69T1fyFD2L+nMr5PVEH5taRQS2bfIGA
         apaYBtvcB/un7IVgIOiqaKhfYunf/JxPs2cA+JHdspyz2h/KLDPit0gdjl9J1++DMOxK
         wf8A==
X-Gm-Message-State: AOAM530ZZpJZ/b8EFUQ4J8zIhEXC3mSDitDEjSWI1IZG8+t9TeIYTGQB
        gyYzTJnzfWGc55l+UfG265uEeLS1OqU2LKt1+LU=
X-Google-Smtp-Source: ABdhPJwR1WbFxz9U2Ynuu7C/o0kObcKmhZHkNuOdmmMLocNfX/gIpZL1oofwMeAw22PyYW3zy5W1kIJYYz6T54K9MVU=
X-Received: by 2002:a05:6638:240c:: with SMTP id z12mr6124273jat.41.1627084746308;
 Fri, 23 Jul 2021 16:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210721235526.10588-1-msbroadf@gmail.com> <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com> <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
In-Reply-To: <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
From:   Michael <msbroadf@gmail.com>
Date:   Sat, 24 Jul 2021 09:58:54 +1000
Message-ID: <CALdjXpBPRraC8xxORgE3SXw4xFnTW-Y6rLbcS+Cx0xYq3+aBeQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the lsusb on the client when the device fails to attach
---------------------------------------
michael@ubuntu:~$ lsusb
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub


Here is the lsusb on the host before use
-----------------------------------------------------
pi@raspberrypi:~ $ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 045e:02e6 Microsoft Corp. Wireless XBox Controller Dongle
Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

On Sat, 24 Jul 2021 at 02:29, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/21/21 8:27 PM, Michael wrote:
> > You can pass through any bluetooth dongle (or xbox wireless dongle) through usbip and it will cause this issue.
> >
> > For example, here is one of my customers https://www.virtualhere.com/comment/9432#comment-9432 <https://www.virtualhere.com/comment/9432#comment-9432> with the issue.
> >
> > The device is in the VDEV_ST_USED state when a reset occurs and so its never re-enabled
> >
> > Furthermore there is a bug in the line pr_err("vhci_device speed not set\n");
> > (L479) because resetting a full-speed device is not an error.
> >
>
> Can you provide me the full demsg from host and client including the part
> where device is attached? I assume usbip tools from Linux sources are used?
>
> Also send me lsusb output on host and client
>
> thanks,
> -- Shuah
