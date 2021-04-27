Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114C136C6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhD0NXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:23:37 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40888 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbhD0NXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:23:34 -0400
Received: by mail-ot1-f46.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso22283005otp.7;
        Tue, 27 Apr 2021 06:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL9fHLMOaZnrAAxMCEfFxqWkDZJNdUJTbPFfIJXD5Io=;
        b=L6ECgGYSQWE9cZUfBpQsyfrkAeXLNZVUsPjpjpmP4sZGZztbzwsgYIG404QzXjNVqw
         9omf+Ld31cXgr/4zLsts1k7tJhDPd0BzQ5y1iKwLd1T3lxUFRS8N7CFCIzI+DUZd4zkF
         R3z4N0iKmmiUBoTgUNyWPSv02OdRZLhSCj1HeE39VprNhmGmBSUnzfwmxd1kywciiQtO
         TP63Bt4ln3NhmHyAwZiOTHleDEbvNYFOiUo0P8N5tEMQSjF7206YbspGBaUxmSBp60Cz
         eQRVDmcinGCZwh9Yhd4TBgEIdW9gSiuFTT8WkPb+wc2EHBxVO3o2OuiUWgueB5mU2wyX
         5wTw==
X-Gm-Message-State: AOAM5338pdBsxoAR97kfGrarh+cwDF/kN/no2vuRmpmaA3macZVEtgEv
        FZ/f9Ph3va63IvlXBunY8Hx8UWJufgUrZ3VI+WAHtJUVAZs=
X-Google-Smtp-Source: ABdhPJxmXYPD3RQ2P5xNJi5j79vzmnSUWEqyteq6fgG1zY+79QF9i5W3aX0H8ATySWs1Y1UpcIwSg5jPRLZV9GYVTQM=
X-Received: by 2002:a05:6830:2458:: with SMTP id x24mr8607052otr.206.1619529770539;
 Tue, 27 Apr 2021 06:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210426185404.2466195-1-Julia.Lawall@inria.fr> <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
In-Reply-To: <YIgPNRiaz2Jup+PT@hovoldconsulting.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Apr 2021 15:22:39 +0200
Message-ID: <CAJZ5v0gdBC+zEADs52GnR55Df8gPwG=CF5K_2SRrtoYQXZ-DxA@mail.gmail.com>
Subject: Re: [PATCH v2] coccinelle: api: semantic patch to use pm_runtime_resume_and_get
To:     Johan Hovold <johan@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 3:18 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Apr 26, 2021 at 08:54:04PM +0200, Julia Lawall wrote:
> > pm_runtime_get_sync keeps a reference count on failure, which can lead
> > to leaks.  pm_runtime_resume_and_get drops the reference count in the
> > failure case.  This rule very conservatively follows the definition of
> > pm_runtime_resume_and_get to address the cases where the reference
> > count is unlikely to be needed in the failure case.
> >
> > pm_runtime_resume_and_get was introduced in
> > commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> > deal with usage counter")
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> As I've said elsewhere, not sure trying to do a mass conversion of this
> is a good idea.

No, it isn't.

> People may not be used to the interface, but it is
> consistent and has its use. The recent flurry of conversions show that
> those also risk introducing new bugs in code that is currently tested
> and correct.
>
> By giving the script kiddies another toy like this, the influx of broken
> patches is just bound to increase.
>
> Would also be good to CC the PM maintainer on this issue.

There are many call sites in the kernel where replacing
pm_runtime_get_sync() with pm_runtime_resume_and_get() mechanically
would introduce an error, so please don't do that.

Every such replacement should be reviewed by the people familiar with
the code in question.

Thanks,
Rafael
