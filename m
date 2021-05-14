Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14084380439
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhENH2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhENH2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:28:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:27:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so940014wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9tnZ9evfnbV2gxFSdDXTY64rXupCRZyW/vv9n4TlN8=;
        b=MIurMscQNGv4VZ6tzwhpDr7DzPbE1lxnX7hhE2XtuM82IE4cR8QJXBCMMNNDnVDg8X
         XCS/Gx3si6HBXuRHCaCL9DThQ3tLSYbQIoDtBdkHtYmCbZyQvr27pkzhdTLOYJHHWkj6
         sqChVKqmNRVjlg/aRd/mMpdqIhS/Ar4iBRJ7ttcdBl0S5tBPC1cmJD4+tgoeWJ0k8B0g
         xAV6We96t22fmldVwUewaB70BvG5j6kUV0SeRgmail60uzMXgK1e6EaSkNJo1OMKX209
         jufk+n4zf2jGz9a4wr9qhPc4WBjVGCLeGppkVo633TCrxHwu5FmBFqjoLMGDzkcDowSl
         rFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9tnZ9evfnbV2gxFSdDXTY64rXupCRZyW/vv9n4TlN8=;
        b=ufC0vyK4Jg6LLa1EFv7EyjO/iEd+tynJVv7E8G7lxvbBefGnZ0t9/a0Fheb+N5mwk3
         xhY+iqcUmdEq4MPJcV0doOkajKLukkOq62GuE81LWrpT5ZWF4iZ7bYCvaeNIMejL3LRg
         BWYxZWqCwrkBeeKFOvNXVeCO+/CqbDYa7sm+tKN6hDOSHOM3KqBFmI0tMA6YKSamp8bc
         AfIDMXg7pkrb4otuughrvZh6AWugk08vVptRsCM1YZ9/4XCHAkf57UyEB6OtsfxrbC/p
         txN1FEzSKuhJt7vfLLBqV0iVybKFx6Nnxxvy+edXA2MNLtYHPHwojFfKStXg9c8cKoDx
         7nVw==
X-Gm-Message-State: AOAM530frQJKe1L7Nf8RPJu1nlnDZC4nKvFfwr3NvovWLewflBsGhM1R
        REbF9MOrZiMEz6Slgx944SEPufSpZDMO/mXSwDj1lA==
X-Google-Smtp-Source: ABdhPJwHjh48zkpYoAZ/2nORJLb3FRq5J0iYy27VTbDg3XN6mubKDH/X9sIK+VlaB4FVW8C1KS+Fwp0PX8EDvKtjQtA=
X-Received: by 2002:a05:600c:2315:: with SMTP id 21mr47477543wmo.39.1620977238261;
 Fri, 14 May 2021 00:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-7-davidgow@google.com>
 <20210514060618.GA3511397@lahna.fi.intel.com>
In-Reply-To: <20210514060618.GA3511397@lahna.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 14 May 2021 15:27:07 +0800
Message-ID: <CABVgOS=Zt8-dHPKTjjQ_C+jZ8ySZejjXyQYSN-hRF95cqCLYmw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] thunderbolt: test: Remove sone casts which are
 no longer required
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 2:08 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, May 13, 2021 at 12:32:01PM -0700, David Gow wrote:
> > With some of the stricter type checking in KUnit's EXPECT macros
> > removed, several casts in the thunderbolt KUnit tests are no longer
> > required.
> >
> > Remove the unnecessary casts, making the conditions clearer.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Looks good.
>
> Does this go through KUnit tree or you want me to take it? In case of
> the former feel free to add:
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>

Thanks. I think it's probably easier for this to go in via the KUnit
tree, unless Brendan or Shuah have any objections.

Cheers,
-- David
