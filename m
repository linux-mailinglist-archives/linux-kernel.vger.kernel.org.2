Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3603A05AD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhFHVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhFHVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:25:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251ACC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 14:23:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d16so16694130pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwY6vzlCqExbU7ohOZltUzd/GYI1ox+DIPkINKqAaqw=;
        b=TkmNukddIntlibsHqbZsl407feheFr5O49mSW6dhXKYBHWbMwVEOig5XBLNcVq4T8o
         467ALTYPO2e68oOyEB9jFZCZ49uaBT+H8n85eJif48IcwUgH6iPdvQknPNLD8dGTF7q8
         VOFfLYEeASNG9j6oHnr/U5/9VGslLO+dD0+2HG/d7dposoZk0uAGPZmSTBsi54jUKxCc
         XsKH6s3pXqjEm0BXD8vlQjaozFg8kvWT/0fRT9y0RdIiLUo7ZvpKF/ZTKbKImaYFQw8P
         IQA7fvr4vMjS6D0t6M0YRiQEhUzVC0BsdJsdKh2vB0pzZUIuhNqfIRvEeHB5z2K8dy2t
         ubbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwY6vzlCqExbU7ohOZltUzd/GYI1ox+DIPkINKqAaqw=;
        b=sb1nhGf7mv6z5AkgSnvdliI+k1DUepy4LkFqphZXr+DdDEwwJD3Koj39yNknpL3QI1
         CbrnA2wLp/Q2UGpzTdUm4lxIH7U8LEnlo5Q87mueuQ9WyVAC6K3RAT/R/L6gZC+BgUBl
         yUISygQLMD4j9JuV7AwAfbnXDc61zS3Uwnd79pwMDoAUMe/IOfH7gmBrFSmwknN3dD9B
         ZFw0UKLXnnBuJNRR9he9bop+SirrK03iSHv5t9wz0qCTCeuS+ATH+zpLRlPPuRb+nG/T
         4wR47XBD4qMl+RQgdueTX/ot9JfqI+7i5dqO7HiHDmxwlHg+peXhWaZJnMn6pt/me9zE
         O7Iw==
X-Gm-Message-State: AOAM532Sbtgp57DVpRVg54zvFZdzDNdInanV1DEOEcz2H477VQU4MVIx
        X+NWftaWkrDnMH+cgpGIbRrZdX6cdLasB1re1AB3cA==
X-Google-Smtp-Source: ABdhPJzPqZ2OsbFsnEe73BbevuNOQSZUnggZitP9Zltw+Kb+sS+q5huD8grDmisPRzLTuZummfkz+I/I5B83u4uRVf0=
X-Received: by 2002:a05:6a00:1893:b029:2ec:a754:570e with SMTP id
 x19-20020a056a001893b02902eca754570emr1708673pfh.38.1623187417561; Tue, 08
 Jun 2021 14:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210608064852.609327-1-davidgow@google.com> <20210608065128.610640-1-davidgow@google.com>
In-Reply-To: <20210608065128.610640-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Jun 2021 14:23:26 -0700
Message-ID: <CAFd5g441kq9KsmeFr_OgbexShN-rJRzrh97kxxYRmC7Yvt+g-w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kasan: test: make use of kunit_skip()
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:51 PM David Gow <davidgow@google.com> wrote:
>
> From: Marco Elver <elver@google.com>
>
> Make use of the recently added kunit_skip() to skip tests, as it permits
> TAP parsers to recognize if a test was deliberately skipped.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
