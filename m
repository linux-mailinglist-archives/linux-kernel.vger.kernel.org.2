Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728AE31199E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhBFDOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhBFCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:38:25 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD930C08ED53
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 15:30:12 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r38so5591563pgk.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuoZTsAa+emkzSEvsXs+jp0cxHIStdgFTDYBF0y1Zlk=;
        b=NTIMc7RAPHbP2GpsLMJKNE5NEpWhtHXYXweLonU3exUG9mrQEI/lgsYuES3XleG1bw
         H6l9w+gwvYXrJF9ZdVktEQ92iXFmxPl7DlrKnwyWveIQepKjR9bN+Vy3ttJ3hySBk81O
         rAm4TA41vyNkj0TbmBwixq5dcD9Yy3rcB0acNEHGaEUKLGknNLr8H2i8iXBSNO2b/BA0
         7BJWJDcsvBH1q/hqQmEkDDdX5LcARAtnYDyqEY+/BzQyEnwzulTCY6QnfdRYdGyxI1gb
         ah9yPJDUuPoymKa9QFv2SZSgFiDk44WDGNvONTcu7vOC8b2ASSvpNWsqp88S0rTNpTs5
         JEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuoZTsAa+emkzSEvsXs+jp0cxHIStdgFTDYBF0y1Zlk=;
        b=kY1y0fszgxESwNV0/qCbRplp7BxYFwi9ItSkZz1xAWZOHoOXkj9Sy8n6bKiWeD0DAJ
         uPifB+8jhjDSAL2+PcCxdTRB1fDPHCSibTwy51kxiGYr42FOYbf63xqgoSX6h22OzDc/
         uBvso3G+pol7BWlAv3M6Ka3CY26nlFzhmX2xWWsj8XEmWDUKplZPTaEpv4dPWnQ5YT9b
         YZx2YtQnxLQ7z2QExsWsBR4d6CtaHCK+GDbazlTRZjtxu+yOhqLF0vi6VwF+CesB7aSb
         PLSc41BWALyaIMMFPP0Ky1dvcILI0nN2mFNArLSWF8pkumQJ5ZR8ZUuzgPlJdUEFFUsD
         RxiQ==
X-Gm-Message-State: AOAM5307SOpxbWNjxV3a8qF7pU/shFokTg8iJ0lWGU8TGYH0Ml7nXL3h
        S2ishg8HePn1AJGpALNx8IW/nDqFj7n9QlsLTmsrBQ==
X-Google-Smtp-Source: ABdhPJz7fjyjm3zP1E+EhYMfal+dyUbCIoiAkSjxIRFTTVzV+vtyVuFOVRJZrajRJRodu6bhYCLn4XUNuyE+29+NJQs=
X-Received: by 2002:a65:4184:: with SMTP id a4mr6772997pgq.384.1612567812337;
 Fri, 05 Feb 2021 15:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20210119235226.93280-1-dlatypov@google.com>
In-Reply-To: <20210119235226.93280-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:30:01 -0800
Message-ID: <CAFd5g44PkcWQG9SQdkUFjV_pttJr==6+R14w5NBOifK_hwDStw@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: make start.rst example Kconfig follow style.rst
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 3:52 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The primary change is that we want to encourage people to respect
> KUNIT_ALL_TESTS to make it easy to run all the relevant tests for a
> given config.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
