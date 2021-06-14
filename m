Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43B53A6977
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhFNPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:01:53 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:44569 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhFNPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:01:30 -0400
Received: by mail-lj1-f177.google.com with SMTP id d2so20508297ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2ifPKFPXw+H1+XH/FElieTkSuvTHAXJjptrAzf+O/o=;
        b=WFXINDqaAXfBVeiL3HnMRcJ+t27wzLTnISKsyZAtOmblsbkkBS4MCZ46zTlpjK4JvE
         /Pf+CdFhiSbVJ/W6e+PMAKVo3D+wnSihIYddEJpNrYHpmPks3H0BOj3zjmhn+6Kz4PNb
         uMNIHC0LKBqWwfD7FT2jfCqBDQsPnct2KsDuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2ifPKFPXw+H1+XH/FElieTkSuvTHAXJjptrAzf+O/o=;
        b=jo8LNeg1EzcK/cye7TIc3MaZIu9OTQBhLp/GvtBFBjFPr6iDlKlm6ObN7UiwnN9vki
         lY2XdIyEzzil/Xvc4SUbM/QBbbKKaS7oX5SgIQV1vCfPr80FPQnRvAiyXKdWgx3pVeiD
         PeYpLO56FNwuHe6/DRY8EZD4Onkr1/+HJZhxYNFNjWy32S34oIvbTh7VnJg1S/K77ABn
         OBFQLDsbNcB+L2pZWjJvsf4ni48w+/Ra48Mww2HVinOkl4ASL5/9+yDNPKMUerssrNGy
         k0M3VzYqdkjn2TqIx//hpTKgb5NPW7gLw26TREsY5nE2vv2JZGqO3RzzSa5mDDB9Hsr8
         UJ2w==
X-Gm-Message-State: AOAM532HznVYtGYkQmVMDaFTBiSIpSA+ZAqHFGwkTU6gG9YQJGZAi5yQ
        nKxjXPWNAWR6kmBZQSMscs5gELlgPwTJbW/J
X-Google-Smtp-Source: ABdhPJwTb0obDHBmE2HtlGh7qX4aMHHjZjxQx9Lrr0UE3iAXSnobXpi2dLO2mkSIzCzqmCIbC2Jk3g==
X-Received: by 2002:a05:651c:211d:: with SMTP id a29mr14134929ljq.115.1623682705467;
        Mon, 14 Jun 2021 07:58:25 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z139sm1626944lfc.150.2021.06.14.07.58.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 07:58:23 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k8so3680598lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:58:23 -0700 (PDT)
X-Received: by 2002:a2e:a549:: with SMTP id e9mr2705701ljn.411.1623682703202;
 Mon, 14 Jun 2021 07:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210607055131.156184-3-aneesh.kumar@linux.ibm.com> <20210614145536.GB28801@xsang-OptiPlex-9020>
In-Reply-To: <20210614145536.GB28801@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Jun 2021 07:58:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+TcJtrwEUzoht2j0R3+jw=OCqckptdf4Q9vNgCPSpXA@mail.gmail.com>
Message-ID: <CAHk-=wg+TcJtrwEUzoht2j0R3+jw=OCqckptdf4Q9vNgCPSpXA@mail.gmail.com>
Subject: Re: [mm/mremap] ecf8443e51: vm-scalability.throughput -29.4% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 7:39 AM kernel test robot <oliver.sang@intel.com> wrote:
>

> FYI, we noticed a -29.4% regression of vm-scalability.throughput due to commit:
> ecf8443e51a8 ("[PATCH v7 02/11] mm/mremap: Fix race between MOVE_PUD mremap and pageout")

Ouch.

I guess it's not a huge surprise, but that's a fairly large regression.

Probably because the pud lock is just one single lock ("No scalability
reason to split PUD locks yet").

What happens if pud_lockptr() were to do the same thing that pmd_lockptr() does?

                Linus
