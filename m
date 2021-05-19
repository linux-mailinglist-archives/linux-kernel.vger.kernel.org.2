Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA21389355
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354812AbhESQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347757AbhESQNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:13:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:11:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so19871311lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n38yI3oq9hOs0w7+qSvFPZKuNPxOuHm402NSUUthZyA=;
        b=BrlJyx9AUrw2lHOaGBlhvxuHGUWn4JGwoZHMIip/Cz5zCwjc3amf34js0LZtyhhYg/
         Kn+CAL4R8ueE98Wxql/NUDPbmhynUChlJlPuL8SRI4i/0L7ZpSD6YwBgZXhGhOewPA/3
         td+EVvuvVWxSislyyclLVv2EpK7SiWO5zda0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n38yI3oq9hOs0w7+qSvFPZKuNPxOuHm402NSUUthZyA=;
        b=e0nH+2/SaTkgR0y0Xp296EC2HpZ4vj5DO75djCwcUOwlPOqXWHps7mAyg6RuCpW9T+
         8O6mj/XGEBKHUVJxxdxKNqvDUd7suqlcMBSdwlsvgc2hpwLy6ahza76frq2mwO8n74Bu
         0nnAeAfM9o4s91FgZQKo+lO0IW8oENez0jZAUggniN/ljpApasmGg2us/H0QOAMCEZMa
         VqC+Qw8YzjWVrkdNkeFVP3vTz0kZrB57wzRe6vmQlv+uFpgOdzzFHQ4wvR17F+FjAzwD
         lk0h0JxrvajTYHKymnEOvJMO6Wo4QolfbP5OXYppqfvbcHmasYOcg0ZJ+JHy0zqHiTtX
         MIew==
X-Gm-Message-State: AOAM530CTAPTLvGJNnPo1pOa5yAPdsR/Tc9mbIdM0tRgFPv8oQJBzZyO
        PRL3NAxSP8EtfMqiHNUKfwKqJ8QEtjzGKaom/6U=
X-Google-Smtp-Source: ABdhPJxuwWm/zeU4/GQlQ3ah6VNo7ljJorXvPIl2M2SW9bcVh7dJZkmSzcmgj1Z+eKhTveCDRGlueQ==
X-Received: by 2002:a05:6512:3c8e:: with SMTP id h14mr166138lfv.472.1621440707240;
        Wed, 19 May 2021 09:11:47 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y26sm12173lfb.164.2021.05.19.09.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:11:45 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j6so17236742lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:11:44 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr157954lfs.41.1621440704505;
 Wed, 19 May 2021 09:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210519024322.GA29704@xsang-OptiPlex-9020> <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
 <20210519133330.GA14452@lst.de> <87y2ca6a69.fsf@tynnyri.adurom.net>
In-Reply-To: <87y2ca6a69.fsf@tynnyri.adurom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 May 2021 06:11:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgYqF3bffW0EPmVTUFcoV0jXECu-A_dyWZ0ZwUwhCHi+A@mail.gmail.com>
Message-ID: <CAHk-=wgYqF3bffW0EPmVTUFcoV0jXECu-A_dyWZ0ZwUwhCHi+A@mail.gmail.com>
Subject: Re: [i915] b12d691ea5: kernel_BUG_at_mm/memory.c
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 5:00 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Christoph Hellwig <hch@lst.de> writes:
>
> > On Tue, May 18, 2021 at 04:58:31PM -1000, Linus Torvalds wrote:
> >>
> >> I'd be inclined to revert the commits as "not ready yet", but it would
> >> be better if somebody can go "yeah, this should be done properly like
> >> X".
> >
> > I think reverting just this commit for now is the best thing.
>
> Yes, please revert it if there's no quick fix. On my Dell XPS 13 9310
> laptop (with Debian 10) X won't start until I revert commit
> b12d691ea5e0, so this is a major issue.

Reverted.

                 Linus
