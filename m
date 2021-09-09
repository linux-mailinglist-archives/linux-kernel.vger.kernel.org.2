Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849CD4059B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhIIOxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhIIOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:53:18 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:52:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id s15so1612817qta.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWnxOkinOj0Rv/WgMSK/DhHIhMThEl0qiXZwPb4IXXs=;
        b=S1a2pKZ/j23obfbT+v4H2TZwSB21CQkMZtmMzMv52dlOmL0qPrF2haw+LRlHhvAlhK
         sYRavalsQfQGcKfRld8BKUaBSMHac4/VOMUglKK/sRnPdTt0EWD4RT4n7Z5Ufn8hgnkO
         /WkBmZs68e6QFr0TBIswqncFibAnTn7ONSywSPi8CDgxNOI2kPD+M7BPyDumFWVfZZHD
         nItaRuHbvlPsmaUP7O+mQWzDJRH4nSLF5Xkm23W34R1pIhjhqb8VWYwZZ9b13BU36v5j
         280dIOCxpjz9mFh6UWRupSV8lN7om/3JY58SG9Mmbm9URCoVpRT0weRBKAA9kWtObkV4
         98bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWnxOkinOj0Rv/WgMSK/DhHIhMThEl0qiXZwPb4IXXs=;
        b=iMpymSzdziOr1ZDj8GTkFQ1P5fmGY9rs/3WqY0twducH2lq9W741xfSiIMw1gs1efy
         JQUTEwNBAUNMOps1Lb8KLUHLXpkke/VFsuod6Ej4/3Vtsv7a207HBo7qpRyMzFizH9EE
         H+6dAuAyl8KUtLrt9txRXJx0/wWeIdmoHsXzvfDYjepIm/lIgCzPzzDc1k0We8mmBPZ0
         qwAxKPrxvHmnYDJC0yHBdfk0A/I58eehQApJ7bgP0GrdEvyYNp1+ytkfmHWEPfYJwRlu
         JdH9A0/naeHWGSs9CwMO9xGOg75XxpCmzUwdhSUWjbC1eYkNhEVfb4LkGQsf4DgJ8aSr
         bBCw==
X-Gm-Message-State: AOAM530cpaqe0iafFihdS5rjXtq2iyNpks+hvTOyTn330u/TFlpN3Gg/
        TitTFuu0AiAHhxOYDcSmBehweBQcax1RE5NmzJU=
X-Google-Smtp-Source: ABdhPJxWZIbXAUjD9Pp5Wc7TSwzLmUAe1aESKVwTRaeiWG0XCn1mvfHxKEUxfsrkNNiTTn2nsiozBa4te2GqkfHTni4=
X-Received: by 2002:ac8:4d41:: with SMTP id x1mr3184655qtv.283.1631199128562;
 Thu, 09 Sep 2021 07:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic> <bf6fe59d-c760-40d4-8201-4170cd90ffc3.wujinhua@linux.alibaba.com>
 <YTnq/3rzmD6ADyZm@zn.tnic>
In-Reply-To: <YTnq/3rzmD6ADyZm@zn.tnic>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Thu, 9 Sep 2021 22:51:56 +0800
Message-ID: <CAJRGBZxHQ3tPrvWWoz9xb0pf=tZ0vrrQYX-Tjr5c=UbxntPtew@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=EF=BC=9A=5BPATCH=5D_perf=3A_optimize_clear_page_in_In?=
        =?UTF-8?Q?tel_specified_model_with_movq_instruction?=
To:     Borislav Petkov <bp@alien8.de>
Cc:     wujinhua <wujinhua@linux.alibaba.com>, x86 <x86@kernel.org>,
        "zelin.deng" <zelin.deng@linux.alibaba.com>,
        "jiayu.ni" <jiayu.ni@linux.alibaba.com>, ak <ak@linux.intel.com>,
        "luming.yu" <luming.yu@intel.com>, "fan.du" <fan.du@intel.com>,
        "artie.ding" <artie.ding@linux.alibaba.com>,
        "tony.luck" <tony.luck@intel.com>, tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "pawan.kumar.gupta" <pawan.kumar.gupta@linux.intel.com>,
        "fenghua.yu" <fenghua.yu@intel.com>, hpa <hpa@zytor.com>,
        "ricardo.neri-calderon" <ricardo.neri-calderon@linux.intel.com>,
        peterz <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 7:08 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Sep 09, 2021 at 07:02:08PM +0800, wujinhua wrote:
> > I provide three tests and result for you. All the tests run in Intel
> > CPX.
>
> I said
>
> "What you should do is show the extensive tests you've run with
> real-world benchmarks..."
>
> Are your tests real-world benchmarks?
>
> IOW, no microbenchmarks please.

In theory, I thought it should help system boot time , app/dock launch
time as well
as some customer specific marco benchmarks.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
