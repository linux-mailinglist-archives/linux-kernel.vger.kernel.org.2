Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF8C3589C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhDHQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhDHQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:29:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EBC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:29:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so4091182ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+BA7pPnB/AN+gDj3+d2nQVCNRxMwStn1XIx/naXyYk=;
        b=jJ59X6GbzIkozVa+JnPx5FldU2Q0BlyvkSQ0IuBYuW/IZ3Nsu7EBSvN+5dg6TzWMFT
         Y55Jnv/ug8+MvQ9iJQx7pxGUbGS4llHUK3sovPUaJAPu/ArXF+7cDcbwqIK/mX3czmlr
         kswuRA4d6DfN7Rn/PjRUgrUlHgITPwbQ+SVPySThjcrzZRAgmrZoG2aYvpS62eLxW1PF
         xA0cNwrdXu0o4R68JSZbGpmQK1lNrD0HiNJhqhQI9YMZdxjjQmJeQzgMZPkn2TCVjaD/
         /9F/4mcZMnmbYDYciz1LUTTNgnZ6eXxO4qAIp3zQ9b3hfly0hsjKkaP3hIa4tDpAOSrp
         N48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+BA7pPnB/AN+gDj3+d2nQVCNRxMwStn1XIx/naXyYk=;
        b=Jdi3B/1Tbe8ixowXLik7YQzxIwZi63A0yzoRQvopWpgnw/4aWgBtPt6JDIdwfjikG5
         TPorQge/5THuTEHB3yD12ZgaGyDCpFaycFe7GqzyNduqDLzfKNjiEetA/e/kpU1UowRM
         uIjVI+7rQ1B3Soc2W+q+xue8A4fNYkB6/87o2UipBrr7jKO+Ho8LHfzxHjNG9cWPJW5G
         be6WNzkOK3aUDNZxKkGpNqZrOZBvM5+xMjgw2E73VNZRpBjuZtzoQUamObM32418tfAN
         KxnAtbQjlYVC3isT9onA+Y6SLNUf+W8pnoeNATGdDVOHSOLaU0vnL2QVA+xnrR2pVF49
         BpvA==
X-Gm-Message-State: AOAM530Oe6JjAHm3XOrt/2ZhVQeJbegyqTt9RCMDztp85he4o9C16Ja7
        X+8wULRIjUC4pdKwsy8UPWo/A/hLctM6kQDoqRaAhA==
X-Google-Smtp-Source: ABdhPJwpz3Agsds4CltanV5MPnJBwQjNh2MBfp8OMb0UzlYbHSSr47QG76XN9/9v3vJMeoGQPasQ9VO7vWzBb7To3dc=
X-Received: by 2002:a17:906:94c9:: with SMTP id d9mr11343799ejy.314.1617899358268;
 Thu, 08 Apr 2021 09:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
 <20210408040537.2703241-4-pasha.tatashin@soleen.com> <480272f8fb3e46d24a0ee1418fb85809@kernel.org>
 <CA+CK2bDc+9EsH_TLTgg9Pqv_-rZfZfPohdZEfsYjT8ss+8skjg@mail.gmail.com> <87v98wom5n.wl-maz@kernel.org>
In-Reply-To: <87v98wom5n.wl-maz@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 8 Apr 2021 12:28:42 -0400
Message-ID: <CA+CK2bB9M05UKfvu66_wMK1u_HBvRws4R0KxPgTu4vPdKuGy9w@mail.gmail.com>
Subject: Re: [PATCH v13 03/18] arm64: hyp-stub: Move el1_sync into the vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thank you for noticing this. Not sure how this missmerge happened. I
> > have added the missing case, and VHE is initialized correctly during
> > boot.
> > [   14.698175] kvm [1]: VHE mode initialized successfully
> >
> > During normal boot, kexec reboot, and kdump reboot. I will respin the
> > series and send the version 14 soon.
>
> Please give people a chance to review this lot first. This isn't code
> that is easy to digest, and immediate re-spinning does more harm than
> good (this isn't targeting 5.13, I would assume).
>

There are people who are testing this series, this is why I wanted to
respin. But, I will wait for review comments before sending the next
version. In the meantime I will send a fixed version of this patch as
a reply to this thread instead.

Thanks,
Pasha
