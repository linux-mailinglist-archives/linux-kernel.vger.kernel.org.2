Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B360332829B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhCAPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbhCAPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:35:03 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836AC061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:34:21 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id s7so6753308qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 07:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8o5wiaij5UYSXhiWC+bZXUTl/d5DaYIBBJW4hei8xPE=;
        b=bVPo7AsBkD8R8JFcQf2asAV0d3tEbYslpk2Yv0YTGryVMqGr2P4So9l4teAnJFOKJ6
         BlJDhvCnEl1yP771vvgsFpYf7vvL+VumPV36cJbu/7GVpkeXNcKA0WUMXxb+jhiUBb4o
         KRQosN1OBQYrI+Jz4s2oW2UYqdAkal06R5Ys6XwZTSCFA9F7vdBRT0qkoqruVI8aEvMm
         oIlmeA74uhxT0FEmRu19flm3kWhe7UjiRkCHiRnW37RxKBmcoXUit723M7EQjqbTd9BU
         C3gLq4nzI3Eta1hUvlnpF7wUImXHgacyGFyMejJxYI6zIRuZfPUGBzFiF1Afg/g9gc/e
         bCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8o5wiaij5UYSXhiWC+bZXUTl/d5DaYIBBJW4hei8xPE=;
        b=mRTv3nMfDOKdbYSkPOHL7ZAaBrfNBhkd+AiBM1NNISfT7F/upjS9vwX9LL4WbV99pJ
         5lL1NxpiHBaLFTvuwN2HKgHpQtqEdtcIDd2O63YQk33T6WkdpJtzNVGV8GVxcf0p2Vko
         xSgqeDFIxx6Fy5kNrfnZPFQynaZABoON6pM1KsRLjumAWozC43HlIgDbWXirLlNz1X4u
         1WIFrIQywBV+liNBVxHHqb1UI/FelttMdCbRn23P8I7UHKKdyTuGa8/d/ovs4RfnWF6h
         WPSCofDkr7YPSSll3JSzOWJ1KaidM4zarSjYD6jZD4fohYZTHoStuUqTa2kVZM0IsMyj
         qzkQ==
X-Gm-Message-State: AOAM5330A1K6N6VijThCcR8dft9uf4GAtsdjlxnBeFEq5S1JzqU3dCYd
        r1Qy6VwgG+ohQNnxc8MBe/ACWnsL+e0TXEE99bioWw==
X-Google-Smtp-Source: ABdhPJxo/QBWJu3JxBMIxRYvNVb7rwJ/f/Rz49LoILx00gkog4kprX4rsfblT5OYcgYiAqe4m6P1J3ezhcTLqoLF2t4=
X-Received: by 2002:a37:8cd:: with SMTP id 196mr14474597qki.434.1614612861002;
 Mon, 01 Mar 2021 07:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20210212192658.3476137-1-dmitry.baryshkov@linaro.org> <YCeM+0JUEPQQkGsF@kroah.com>
In-Reply-To: <YCeM+0JUEPQQkGsF@kroah.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 1 Mar 2021 18:34:10 +0300
Message-ID: <CAA8EJpo-U74KAyoHY=9wutk=iCOBMv6T1Ez-MEogYdPE6X1yCQ@mail.gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: restrict user apps from sending kernel
 RPC messages
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Feb 2021 at 11:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 12, 2021 at 10:26:58PM +0300, Dmitry Baryshkov wrote:
> > Verify that user applications are not using the kernel RPC message
> > handle to restrict them from directly attaching to guest OS on the
> > remote subsystem. This is a port of CVE-2019-2308 fix.
>
> A port of the fix of what to what?

I'm sorry for the confusion. It is a port of the original
Qualcomm/CodeAurora fix to the upstream driver.

See https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?id=cc2e11eeb988964af72309f71b0fb21c11ed6ca9,

> Is this to go only into a stable tree (if so what ones and what is the
> id in Linus's tree), or is it to go into Linus's tree like normal (if so
> how can this be a port)?

It's a port from QCI kernel, not a backport.
So I'd prefer for it to go into Linus's tree (and then be backported
to relevant -stable trees).

-- 
With best wishes
Dmitry
