Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359423B69C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhF1Ukv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhF1Ukt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:40:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15572C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:38:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f21so8303443ioh.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2IN8Z+sIZlGv6g5jbxKMc3TDU/gH2bfUrQ5chPxP8A=;
        b=Ie/uAPjKe+SAVEb99c07SDXehZOV7xkesFAzpljdesiolQA7N5HAv3IcaRFVrIqKGk
         MkYTKeZuoz5X6xafhC4e82mT9IzBdZwskrLqKSDTHwRsVnX1KAJgVyea++4VZ3qaXFzD
         4WvEXmUqC4LVXKm/1zUlS9/6ZgzZw3fzil+Ap7H47nFxhwh5P1W3+yA3wSRDJ6e3IoUu
         yjWA4OK2QnQrLO9X6l2hNmIYqSHJ7KtzFsk9iAjijOzornnVc/twfE+T1vDmtkAQi89M
         C676feJP+sSR7/YNZgMtny4d7wkrArgGVWD79Ad5mgtoh+nGY4XeiVx/Qe9aSzHBl/TF
         JmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2IN8Z+sIZlGv6g5jbxKMc3TDU/gH2bfUrQ5chPxP8A=;
        b=P07pvt/5sxQ9y2P8pdhghwESPSjBUG7cuCOB3A/7gz/5tQom6k7u/320mbNDrbUGDV
         uXxjGEJrCdqK3RPc0uNLefMAwauY4vODIw3ZY+1Lqwp03aWqn8UgEjyumyqZjT7ww7bk
         B6cC/6n1EhIpvxQV3DcV4dQ7dbMfOMxDEMyArnpYqdLj4dMUmMy8xgEQXl3O7dBd8+MD
         YdhVRfHoETgJW7OeA0TDXo0nivnanIn7c7+0MWIaBdUZeMxvn6dse4AagbEBBiUqiKZn
         hiSLpydwFvuEGeaZ1gMVp1y9SN6Tr6aBvHX3JNjWAwoCqjErnMr9sKKAXgpCReKmp17a
         0JVw==
X-Gm-Message-State: AOAM530fxL4OKEK6eOq9pNxURx0olikAIspOVVeiKxnoY61RYbWG8g92
        TbE797Z+KA832WQD94r/wwvFaAKkLgNaFjikMbo/jA==
X-Google-Smtp-Source: ABdhPJy4bIpkvfhQXmKg7hXoiT4mdXx5NrgDmTmRoIgofDOHTgMABtx/f8l6gLuZgi/rTHFgJiBsY6n8wqEKbURXFuw=
X-Received: by 2002:a02:77d1:: with SMTP id g200mr1248012jac.132.1624912702185;
 Mon, 28 Jun 2021 13:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623421410.git.ashish.kalra@amd.com> <8c581834c77284d5b9465b3388f07fa100f9fc4e.1623421410.git.ashish.kalra@amd.com>
 <CABayD+ckOsM4+sab00SggrH3_iFaiV-7h9tHHuL1J-o6_YQVKA@mail.gmail.com>
 <YNZXPEPxv54UmzNj@zn.tnic> <20210628193441.GB23232@ashkalra_ubuntu_server>
In-Reply-To: <20210628193441.GB23232@ashkalra_ubuntu_server>
From:   Steve Rutherford <srutherford@google.com>
Date:   Mon, 28 Jun 2021 13:37:46 -0700
Message-ID: <CABayD+e2n+7YB5a9he2VKLKSA80kXVteBMFQgtTG2-oNqqPDYA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] x86/kvm: Add guest support for detecting and
 enabling SEV Live Migration feature.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:34 PM Ashish Kalra <ashish.kalra@amd.com> wrote:
>
> Hello Steve,
>
> Do you have any final thoughts on this ?

Hi Ashish,

Don't block this because of my lack of understanding.  I'm still
curious about the interactions between SEV and kexec
--preserved-state. If you have concerns about --preserved-state
breaking live-migration (when returning to the original kernel), you
could have kexec's with that flag return an error on Live Migratable
SEV kernels.

Thanks,
Steve
