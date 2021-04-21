Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03AB36636D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhDUBmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhDUBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:42:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D8C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 18:42:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r20so45837530ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 18:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UczsTWIr8+6VGiM8h97MiUANVxQ4dEWzhNFeeY1J0DQ=;
        b=cZLLvzHjL6Dq4J/0YCjfOBoiNTj7ewYzT1U23fS0KzQTjaU8mQUilogtZrIJ7+42GC
         xJOaS/vJ9R4ip+jJO/7/VkfvKeZ1N19VH6bMk6p3sJvJ/8MV9k6b1Uhtuu5PnrTxoyuC
         p3jJPx9WUIzvA+JNn1nRDIxk8RfPKu/c1iC52DBvnfnRH+ZjIXyN/LA4ViClEYddTO2v
         DzcWFH1YGZZlpLMpxWHSPUOq3ln7wsmS9enK8A3069UZaL/Wge0m9zM81HBYTdf7wvfs
         WHzZiDUmbadFm7ksECr9cHgRIxsyMVAJHfTTOpG3pD8KhUQTU49hOJFnr7JwSkjAva6H
         qjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UczsTWIr8+6VGiM8h97MiUANVxQ4dEWzhNFeeY1J0DQ=;
        b=sgQdB83871PXPeL6Xklg6hAQz3M2p0kXsVP6WmG+4QH7Nl4sB6i0RtNCE5EHWapZmj
         IvHE6RQALcdpWpuT+yZTEWOMnW0Ci/3C26bH2XQGkb7n1aIGug2/Hy/OoMNewCN4qS+L
         vRNEuAf8/H/s8nXOp3gd0yDRN8ePj6XKIacOFsb745WxI9Qekq3M6BIUDFaEMRnlCxXP
         k98NkJVvW8q8KFr8Zqne3Gpbx/p5fU6Udib5TvqZqpuvL7TDpOlftWki21N+lgyWprCD
         EXgt8xeKzXAke0p/x4QKUHX4He2tYqkdsNRZztVC/Sh5v+1F4GKSiPMj1zWtVFvuWAZv
         qUqQ==
X-Gm-Message-State: AOAM532eYufDGNTx9oBH6AmeGYty+PDRmzmfQsSWqzFA1AqvFBTWuDxi
        pMDKtbtRqxg+L1VRzDKflBQTBVwev50qkG3UfznAsA==
X-Google-Smtp-Source: ABdhPJysu1OHhax+Ts9VQYHrJtlutyWAr60vpOpiyXjGPssUyyiGMaeV1ncpertHo98xbqHHp0y0CZsctY3Bm8Fe/CA=
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr17035527ljj.490.1618969332659;
 Tue, 20 Apr 2021 18:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210415054036.581117-1-davidgow@google.com> <2a35b57e-3261-8ebe-d9f3-66b3dedff756@linuxfoundation.org>
In-Reply-To: <2a35b57e-3261-8ebe-d9f3-66b3dedff756@linuxfoundation.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Apr 2021 09:42:01 +0800
Message-ID: <CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: dev-tools: Add Testing Overview
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thank for you writing this much needed document.

Thanks, Shuah: I hope I haven't misrepresented kselftest too much. :-)

> Looks great. How about adding a section for Static analysis tools?
> A mention coccicheck scripts and mention of smatch?

Good idea. I agree it'd be great to have such a section, though I
doubt I'm the most qualified person to write it. If no one else picks
it up, though, I can try to put a basic follow-up patch together when
I've got some time.

Cheers,
-- David
