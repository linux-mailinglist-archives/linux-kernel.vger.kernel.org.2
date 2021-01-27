Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204C83060C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbhA0QOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbhA0QNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:13:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE786C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:12:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c2so3079856edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXTBY0cojnp19bCWf5qo/pfAGASLjMSh/1ClF23gmIY=;
        b=Nxk8GUyYBiMwT/7mHIGBVdt1fEX6AzZnc8RUWXshgkIvSIdnyubatKAYwyftlY5Rl9
         hrC//hwsCOFOugFFK5gOyrCpIEjFbV87fUYhT3UX0tsOyU7x6G40OJ+bhT2JZmeVDXcJ
         DUcbMLxYQ3Aqg7aXoNSRO0z6aqxP8ZS3q9V7MfrCxgAKe6lorl7BIzVqYgF1T6fBXxQ1
         u9Tz8PlkDvN5cntguytX8ChghtfoY6ovgZtl7Iws4N00iKjHGA6hlnT/44Eb46GpxnKr
         ozFGobyzGqICkr7zUpZxy0B0kygVAuEwO0kZqfTUp3q7ToOPxmzPJWG33G6UHgEXZbdI
         TROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXTBY0cojnp19bCWf5qo/pfAGASLjMSh/1ClF23gmIY=;
        b=snbYdo5T5QDFoxiJCIeVny3S+xCtrcOLDa9KaMgmiLXQ7buZQK7Ag/8fd3xRXT1g9D
         LOD+RoNnvq/lewb0ls0aWEgwm3YeuY8MycYg4wPV1n+MJhodK7jXAdNUfGUoSLSkizt1
         ixKNznIw7yrj4XMbquJRFofRhFQO/NoDHILymfCRov7xR55xJnBKeIVY27dkt7OkXNF/
         jnOYQhRNGw98+Mkha1Nr1DSFsTgJmI7URCkTm9agv4AWvrhhlLJIiV5IBAIZsIfYu2yE
         CBOtrFxSHpZS5uGxj7tlknRa4aFqhJpc8D+AIyIeE4wltCwaHK5H4PeDo0QNUt+AM7gv
         QagQ==
X-Gm-Message-State: AOAM5313GSQT3ieu5O04nqTXcbGQSMV/mEzYn1gTTp5+eraTAnfU2fP1
        LqYaJ9lByBbzhPRuiYnF5AjmnK8uuYD8OjH0sG/Yxw==
X-Google-Smtp-Source: ABdhPJzK6H9SxMCvG5Bo9eGL752ED1LdoP3JK2iq99ZwkI1HQyPjs+P5Ohx2412YOOcQFKwcUkmIbtUPxA4r44IMBLQ=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr9828766edv.116.1611763971646;
 Wed, 27 Jan 2021 08:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com> <161176207403.2744652.12806246618808213171.b4-ty@kernel.org>
In-Reply-To: <161176207403.2744652.12806246618808213171.b4-ty@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 11:12:15 -0500
Message-ID: <CA+CK2bBd-rKQAuxBSrBibdACvJHrrvLtKohjxEuXGciGUknB1g@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/18] arm64: MMU enabled kexec relocation
To:     Will Deacon <will@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        James Morse <james.morse@arm.com>,
        Selin Dag <selindag@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, rfontana@redhat.com,
        Sasha Levin <sashal@kernel.org>, steve.capper@arm.com,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-mm <linux-mm@kvack.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:59 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, 25 Jan 2021 14:19:05 -0500, Pavel Tatashin wrote:
> > Changelog:
> > v10:
> >       - Addressed a lot of comments form James Morse and from  Marc Zyngier
> >       - Added review-by's
> >       - Synchronized with mainline
> >
> > [...]
>
> Applied the first 12 patches to arm64 (for-next/kexec), thanks!

Great, thank you. I will resend the rest of the series based on your gate.

Pasha
