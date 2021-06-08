Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6DD3A04F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhFHUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:07:09 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40858 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhFHUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:07:08 -0400
Received: by mail-lf1-f42.google.com with SMTP id w33so34088505lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VA4/EeEWVYB2RZpfY/7MCPpZ1URpNBIwal6LqpDu9Y=;
        b=TahCSIF/i0xA3DerBJu6GjSC/EJvAeBPSmikEGruKj6ogGxYDBBnNlGHOO89xqocNm
         RZYLB5I/Fmrz5uCkAicoyf9Bae1fTxzL4HLzfCgqP+yn5rCBSvrxCQMkFH77z87c+uon
         NsceUN//bSVQRzitifKc4UnB/aijHdb1If/UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VA4/EeEWVYB2RZpfY/7MCPpZ1URpNBIwal6LqpDu9Y=;
        b=OWuF7IWmnZStQYsAOTgZGQOxm2mSTk5mHiShbLYzUkZNhK5Kw/zOY+5/4ZoNGh4zHH
         IWRvJZrEXYV8wIiduNkAQCqd+4xZV9teSZuH/tQDskUg65DGWW84CA5lE+1s1nFsorRi
         rv41bGkLCoIYplVLJV2Gr0qYmGDpH9wbKVbkW+RFf38eWgRFcaH+Lw43UffDOpjeBNP1
         VqGZUUweIca2m9+oZZtx7WTvlSrXpNQLJoKSpPjkv/0zdcpeO10eJpqj0OBHiEOh9PmY
         IkVQQ8NFsyHLN7N75VvB3g8WuYrqgRK79xpwDKbIep8SGuxfpTb9z+cntvJ4ovNWkmSD
         BwZw==
X-Gm-Message-State: AOAM5331M2tqFhuGU1TkZUwWGUTzvHMk+k1X0hl7U21urFCKgDw3tbsw
        MKVJUjQwQeyi9vvkmZp46hre1fhJBr7fjSghtUc=
X-Google-Smtp-Source: ABdhPJx4Y3I2/VwygcPtI7O6d8TksvBaXG4GbsnP1R/BMjedMIk9oFwkz1K2hSmkeF8LL1xhmZewgw==
X-Received: by 2002:a05:6512:3482:: with SMTP id v2mr16216709lfr.417.1623182653785;
        Tue, 08 Jun 2021 13:04:13 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id k3sm82590lfe.110.2021.06.08.13.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 13:04:13 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id r16so9480301ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 13:04:13 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr19294016ljd.411.1623182653026;
 Tue, 08 Jun 2021 13:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <YLx/iA8xeRzwhXJn@zn.tnic> <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com> <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic> <YL1UucKH0GfXddZo@sashalap> <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YL+368+oKRORwUzx@zn.tnic> <CAHk-=wh1nz4=72vk3+q5TuPwBF2HMY4SnBOZr6WSLp=s4KExSA@mail.gmail.com>
 <YL/MoOZFRwo261WG@zn.tnic>
In-Reply-To: <YL/MoOZFRwo261WG@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jun 2021 13:03:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7BWwNR5+z7bn1xxa1Rc1Dzo-SDnahJ2cLePmRcG8uWw@mail.gmail.com>
Message-ID: <CAHk-=wh7BWwNR5+z7bn1xxa1Rc1Dzo-SDnahJ2cLePmRcG8uWw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 1:01 PM Borislav Petkov <bp@alien8.de> wrote:
>
> How's that (comment re-flowed):

Ack, looks good. Additionally, please refer to this thread on
lore.kernel.org in the commit message so that we can find that
confirmation about Windows behavior, and I think we're all set.

          Linus
