Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA641B6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhI1TH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhI1THY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:07:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AAAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:05:44 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e144so3378129iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYaPMO4zSUN63L5x5xUSR1CDiXdGr7bJrgBZxfWWnRM=;
        b=SGJcdHCygArkZYEIETz/wT+50dTV5xtQ1lZdrl9rOa78dS1YvLlQOq3YOhDQdB97q1
         zo8M2ixafgU9SNvjwIFhI1+ygeNugw2tAsCo1DtZ9Ns6CFBTlUYmpgmZbNEO8VsSohge
         qr7r/bBX45IiZeZC78iRqPy0U2KLBmJgPya+Hj8/CIo4U221V03qlABGqt5MjPF1O7Te
         a3MTnKC+oOm0rCt+xLVcKP8X84tunJnE0eu2WPvm/uyOSlzgrEh6u702TQ35iyneOI4b
         Sq2Y06PbIVovlsYid4ZzH/6ZdKBPO7LUN76gbJWOg/6+4RsAFF9vK/0dTYWDpAOkGyK/
         jvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYaPMO4zSUN63L5x5xUSR1CDiXdGr7bJrgBZxfWWnRM=;
        b=dikGviVCeAGpSjTU44ETzG5D0GD7DthY2s8cJ9j6zmwVaO+N0XxPieGh1Fu39k49Ev
         WWt/DM5A+4+BCP6akl7AhBcETDl5LFt/Vk4OV0ipA0BkXHbc4P/SNlXTvSPv8xwRDh5V
         4gmN+nNqEQfkBy3neLacb0psGZQaZetEzIjIUuBSoAWAoSfFSm0+zaaklMaAYtU/4BMy
         24IUs9NtO5j/vOJ0FmfuvJk8rVuIz/LR080+Bg7ssijHLInc+IV7z932Er2WC/tpMoth
         frTPztt+w2CMGsR8t4BOLX9O5PLIILd6AeVrwy1EELwjc/Amm58hIA/BlML1/bJ9StSv
         Oq5g==
X-Gm-Message-State: AOAM530WrwgG3fGjXdqHVFVF/xrEy5W8DuPBU9OP6vC/fx26bayXfAdZ
        6n6WzsbBbXQ4xmYHk9Co+pFiDqKdNoQOyl80a6N83A==
X-Google-Smtp-Source: ABdhPJye2c2rTcBY5maCu7+X+UzMZCbOkZHYNLHHfukiFlEG7A9xzy/JQd4I8fBvuBH8ndBmeHVokOpMGnvyAvT8xO4=
X-Received: by 2002:a02:5444:: with SMTP id t65mr6164748jaa.42.1632855943923;
 Tue, 28 Sep 2021 12:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629726117.git.ashish.kalra@amd.com> <6fd25c749205dd0b1eb492c60d41b124760cc6ae.1629726117.git.ashish.kalra@amd.com>
 <CABayD+fnZ+Ho4qoUjB6YfWW+tFGUuftpsVBF3d=-kcU0-CEu0g@mail.gmail.com>
 <YUixqL+SRVaVNF07@google.com> <20210921095838.GA17357@ashkalra_ubuntu_server>
 <YUnjEU+1icuihmbR@google.com> <YUnxa2gy4DzEI2uY@zn.tnic> <YUoDJxfNZgNjY8zh@google.com>
 <YUr5gCgNe7tT0U/+@zn.tnic> <20210922121008.GA18744@ashkalra_ubuntu_server> <YUs1ejsDB4W4wKGF@zn.tnic>
In-Reply-To: <YUs1ejsDB4W4wKGF@zn.tnic>
From:   Steve Rutherford <srutherford@google.com>
Date:   Tue, 28 Sep 2021 12:05:07 -0700
Message-ID: <CABayD+eFeu1mWG-UGXC0QZuYu68B9wJNWJhjUo=HHgc_jsfBag@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] x86/kvm: Add AMD SEV specific Hypercall3
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, thomas.lendacky@amd.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, dovmurik@linux.ibm.com, tobin@linux.ibm.com,
        jejb@linux.ibm.com, dgilbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 6:54 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 22, 2021 at 12:10:08PM +0000, Ashish Kalra wrote:
> > Then isn't it cleaner to simply do it via the paravirt_ops interface,
> > i.e, pv_ops.mmu.notify_page_enc_status_changed() where the callback
> > is only set when SEV and live migration feature are supported and
> > invoked through early_set_memory_decrypted()/encrypted().
> >
> > Another memory encryption platform can set it's callback accordingly.
>
> Yeah, that sounds even cleaner to me.
If I'm not mistaken, this is what the patch set does now?
