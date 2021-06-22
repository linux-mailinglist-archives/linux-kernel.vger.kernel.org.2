Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49073B0D01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhFVSjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhFVSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:39:12 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A08C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:36:56 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u10so21675vsu.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X582ckIshWor1vloajSsyeHfuFh3jfQXUW3m4Q8smqI=;
        b=o1jHn6o+eHT1RVFF4RmYAjBIIibQSdaxhwqXjxdJGsIUTKf6alXrrQi1qF2E1wT+ok
         fNToG9ZlHvCuQ4ez1PXEtGiQTSvNGY05YUxjQochgBdMk6d1r7rPmkKXo8oi5GEeycG2
         94KPLMd7Y0AZWIQIuxKTJar5UvL2Rd1JNayyQd7roX9cZV/pvJqBVNUIXo+tuYJAYXse
         uUPbnu1aEkbRcr8Uhl6epJBkyrfNvgN0+cxzWMX4BF351UI0ptYDg5kDuudhUohGkNIJ
         uK0+BUUPYIoDl7A9M24NkD00wyq1WlPQKw3QBAjEcjVvHjyruYeBlI/OKZokSh8thlAj
         ANtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X582ckIshWor1vloajSsyeHfuFh3jfQXUW3m4Q8smqI=;
        b=HV29Cz0NyACY2H722E5cE7F3I2IqBO/f5B/qMQXy2Rw8GI5X1VxI7qkB8Uu7g1jmjP
         QUpt/hgzKrjmF1UwpeyxrGfJKpi1eXgjGvNku6Qto9JIlgnBksdEh0h7GAHtcnb406qZ
         JqwRLZKFWBu4S2rLuyFgAXa77CIQEbkfngai8OzNvHAP+NzzMsKjPo21yxJ4p6SyAjLG
         DU/rrA86BnwiheeofFMvi0pPanStTwxNGrqaNL5f9VtBy9dSd3jJHLlKo2vkuaO5iXyB
         cgu1vDvVolcsLSHpyVhl1RHGJ/8GPOhOAjsggpaHYufaoCAqJCOtv2buSg9pg7S+e6Me
         sJuw==
X-Gm-Message-State: AOAM532aP+8UHqaRmaY1/kcnGIsKsNxWnPS33mcpqgXEcaf1khPJSya6
        bTradcXsxb2DT0KrzKL3rVs04GNOEDaFwBV2EkI=
X-Google-Smtp-Source: ABdhPJxhBKhEsQhWrXYbQLxxBLqOgxiMT+e50uXcIlef+zj/VxJ35FOy0gP1IO+cPJpVTfIjUg+1x0v8CW/qcoFIGWQ=
X-Received: by 2002:a05:6102:22e7:: with SMTP id b7mr24640330vsh.14.1624387015578;
 Tue, 22 Jun 2021 11:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxxH9KVgJ7k0P5LX3fTSa4Pumcmu2NMC4P=TrGDVXE2ktQ@mail.gmail.com>
 <YNIaFnfnZPGVd1t3@codewreck.org>
In-Reply-To: <YNIaFnfnZPGVd1t3@codewreck.org>
From:   jim.cromie@gmail.com
Date:   Tue, 22 Jun 2021 12:36:29 -0600
Message-ID: <CAJfuBxywD3QrsoGszMnVbF2RYcCF7r3h7sCOg6hK7K60E+4qKA@mail.gmail.com>
Subject: Re: [V9fs-developer] KCSAN BUG report on p9_client_cb / p9_client_rpc
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     kasan-dev@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:13 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> jim.cromie@gmail.com wrote on Tue, Jun 22, 2021 at 10:42:58AM -0600:
> > I got this on rc7 + my hacks ( not near p9 )
> > ISTM someone here will know what it means.
> > If theres anything else i can do to help,
> > (configs, drop my patches and retry)
> >  please let me know
>
> Thanks for the report!
>
> > [   14.904783] ==================================================================
> > [   14.905848] BUG: KCSAN: data-race in p9_client_cb / p9_client_rpc
>
> hm, this code hasn't changed in ages (unless someone merged code behind
> my back :D)
>
> I had assumed the p9_req_put() in p9_client_cb would protect the tag,
> but that doesn't appear to be true -- could you try this patch if this
> is reproductible to you?
>

I applied your patch on top of my triggering case, it fixes the report  !
you have my tested-by

> The tag is actually reclaimed in the woken up p9_client_rpc thread so
> that would be a good match (reset in the other thread vs. read here),
> caching the value is good enough but that is definitely not obvious...
>
> --
> Dominique
