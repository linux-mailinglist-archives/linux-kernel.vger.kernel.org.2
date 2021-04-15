Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F013604D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhDOIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhDOIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:49:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:49:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b17so16440780pgh.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EqqgG+q8KzPD6ybwhaMMrl+lTUL1ThiaE2usmOBrbU=;
        b=vfEhPcBuw6/bl7NR8nCxzGsao6TLi2NirGNNZYMBz1Indy9smfYatKTzZBrgZHQBu1
         8IiRk896u8QitG0cES3OJ+6NbD88dhnRq8dUAMeGL9PsGUY0FXKGXceJ1lupog7yc65P
         4ZSp99yAV2pgT5UM3+Cx+tic3/jpNk+vFbLnEFYKohVTigzttQn1xG0LhY7mXuLAnfK5
         yzoQlvW1vPRjDeO7vW+9iJtyxJ5GNoZtvJPd4AY9j+DUVurXRKFUTLwHhFLKe8+wTFM2
         kbaI6Z4EawlksGBRwcGusRiQQaz5oTwDR8jYlpDL56n/uUlK/tG8gGTTI1CL089VCrn2
         RWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EqqgG+q8KzPD6ybwhaMMrl+lTUL1ThiaE2usmOBrbU=;
        b=SFxpFBCDqasDgrQYEPjqywG9VfyfHsgeWGimVhnnLb5ZnFu1h69RiZsGP3GLeb41T4
         GKWbrxIVctK5Lb2ZLtDGNdTudJgyXSwBk9Z5ke9ZqEnOpGL94Hi+F1qVGpyx/+Zbj4gc
         QQZiv6e/9yMJZGZMjaVcsfIuI0SmV3Lv48s5I/FLVw6Oy5SQ6YRFgBmirbT4iutKjVm5
         0Kck/SmVLHpz24BpUhi+oDECopxCxxLhG/pOVYR+Htp2bTKj6OSxHu+MuNoLAE3ZP7e8
         rH1zif0OR/LVQw2PWNlQUH8QRZ7EWNBspeBpmVI/PsZYklH7w3t/dmPI3fBta3kGVEYw
         OWOg==
X-Gm-Message-State: AOAM530Krz1PiQ0m3zi9S5jAIAGcWSprCznrdY4+hd07nlL4M0CMIodC
        GQlWjKxIGa/NohZhQfZ01jXFy99Va09kmIYZH20=
X-Google-Smtp-Source: ABdhPJzV8NcdMMkmFae6tlWn2vbxz7EW8i/bYcidOFXALsI3VmGy1faviRJnJ8EJuaDKQBomhvY1T9lDbTPGL/KjICY=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr2218277pff.40.1618476544690; Thu, 15
 Apr 2021 01:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com> <YHcqxMLR44laX2PZ@smile.fi.intel.com>
 <YHc68v7keeITnA3K@kroah.com> <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
 <YHf6s2r28XOtP2+2@kroah.com>
In-Reply-To: <YHf6s2r28XOtP2+2@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Apr 2021 11:48:48 +0300
Message-ID: <CAHp75Vf7UrRuN=rBkBYrSDz3yiUq4_k2HVvCJ7cTB=_4y8+W7g@mail.gmail.com>
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:35 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 14, 2021 at 10:14:34PM +0300, Alexander Shishkin wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >
> > >> Using raw buffer APIs against uuid_t / guid_t.
> > >
> > > So you want to do that, or you do not want to do that?  Totally
> > > confused,
> >
> > My understanding is that:
> > 1) generate_random_uuid() use is allegedly bad even though it's in their
> > header,
> > 2) poking directly at the byte array inside uuid_t is bad, even though,
> > again, header.
> >
> > It is, indeed, not ideal.
> >
> > If agreeable, I'll update this patch to the below and respin the whole
> > series.
>
> You are showing that Andy wrote this, when you are the one that did :(

> Anyway, I've dropped this single patch from the series and applied the
> rest.  Feel free to send this patch as a stand-alone one once you have
> the authorship issues sorted out.

Internally it was proposed by me as well, so authorship is correct.

-- 
With Best Regards,
Andy Shevchenko
