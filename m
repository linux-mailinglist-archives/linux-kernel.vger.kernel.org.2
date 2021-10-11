Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E118429902
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhJKVgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbhJKVgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:36:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129CCC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:34:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z20so72715648edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiVrD2iDMBLBuofZXrBJ94/4zVuoaHiijnyH+PFPUI4=;
        b=sUgkyZRXsMgRphN+3Cln7odpz9WBkA07Z7nSznDv7LyV8d71mGBfBYUgBlZe0lIRVA
         Q1Yyy2I91YCTFRsqixHz2O0cXOKbPP/SXZXIwcFpIenOrn+5WHs+Hh3HPqDf9FF4YRp/
         T6mfEor8mUi4tukIbLoifQQv2VW1GLxOJbheoCx+V7JWQQbT+EFGMhMUIy4EH74jiU5k
         3GTDcQlRH4/1Nra5ghsU5kiWJBbK3A7vqOlAfDBQZKLQjbP/o0GUaEGB49OGax+67rqM
         dBDS1wxgcG4mbdENUpPmlvDCJZIUxKFe+AMwkSz5kNlEa9/UXgr4HtjwyH526toiA7Mm
         rsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiVrD2iDMBLBuofZXrBJ94/4zVuoaHiijnyH+PFPUI4=;
        b=TfSWD9bCm6l91aXB6LfH6ccNFnCyKcsztY/ii4wAQZ/JrFz3XOBCpkbtkX0mA/5jOh
         M05TGfn+hZ5Bz3y/4M7ItPy1k70sj26KkjG3J5CIGARcTnyN3yLNwtmJu5i5WCe3HWBK
         6znKrVJZJOtSfHYZ7tbsl/fFFC6H4KDeIe4lgrL/G7TSuEsSTzzvs1IerHMW4/TeAo3i
         oe9TbzaxIw7fmq6HipTR6+4UgzYYZhttZgb9lfYtZJqfd3mqWohdB+Wj9zITSbEDxvIE
         yZd1pWOr87Qw8PwdTE/EGcBZbNp9dRGsyp0bxI9InV7WacX01bJBIfWCetO+6MQQJBdX
         f9Hw==
X-Gm-Message-State: AOAM530L6g3N5wqOxTmoWKHtskvWF5UuiJq5yhTOK6fzr4djL4SI9Mko
        GGzMKNUHjfgZZtbLLv4IsNQW9tQj43W1ZPoUu7YOWg==
X-Google-Smtp-Source: ABdhPJwSiy6AaVg267aL3oPbb2eMX1xe0pHHXkjDBpG2vywKG9+bqelpJKF79VASCUvtV/kmN1sV++sHiqrEcRt1PAs=
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr5946787edz.198.1633988087485;
 Mon, 11 Oct 2021 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211011134517.833565002@linuxfoundation.org> <CA+G9fYutz0ZgJ=rrg8=Fd7vh9c7G-SJfF2YoH5wZyGzUHu4Dqw@mail.gmail.com>
 <CAK8P3a3WYDbLm40OEMDcDfBJWRqfaWLvVQu4eD8W=UEjkBrpUw@mail.gmail.com>
In-Reply-To: <CAK8P3a3WYDbLm40OEMDcDfBJWRqfaWLvVQu4eD8W=UEjkBrpUw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Oct 2021 03:04:35 +0530
Message-ID: <CA+G9fYubbNMtp9XX3AWb-7srT6D1B0rB8BLM8e1HSKeCM75u7g@mail.gmail.com>
Subject: Re: [PATCH 5.14 000/151] 5.14.12-rc1 review
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like a really long backtrace, and there is something about stack
> corruption, so I wonder if the stack is actually overflowing here. Can
> you see if the same thing happens with Ard's vmap-stack branch from [1]
> or if that shows a different output?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-vmap-stacks

I do not see any crash on this tree and arm-vmap-stacks branch.

- Naresh
