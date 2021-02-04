Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EEF30F9E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbhBDRhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhBDRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:35:10 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E692C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:34:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id w204so4011779ybg.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g1sMYk4jMbfGlD37L/VSSp+6/9LFoKJqj/BayIq9xFk=;
        b=aUg4gnPtZthLYhO5UXfTNeQARQ8mO6hJDqbNStk/Rz6UXyDW4t9Ju4/1uuLBavZoPo
         4HDMBEtABl1u5Zch9srQ4DV3+HZ5qJcNNv/6AXBFuQCem6UwIGH/XeXL6ftv6qx62OqV
         i2dC7ekpaZ/XPTxFQZVSht/S/+umYzxWEDTKAjhwVRjOyL3hfLgT3OwjqOMZuLfEQ0AQ
         wzmMVvyKi0jdxLYJzYsccODml1pFsvtjW7RuYga6gsjE5WA/LuWiNUbP2VjDnu2RITnl
         U3LncMsf3ICcj5Y7oHj/RZ2LQXIBM3NwSnSymqZHmf59mbBIESnMSynUTEjlPx4OL+ly
         ALdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1sMYk4jMbfGlD37L/VSSp+6/9LFoKJqj/BayIq9xFk=;
        b=W5W4yEmL1BSfsQLDairGxdh/DRv5Eu168EtnqMLu++8yEMneZZALnSg2d9DbJhrd1Z
         j55b0DTkPmVfuHVpmRvKALgtOdM6nRUpMckjAxOw85FQHNur9QAs4JSheK8jZTJ+rfP/
         sYRqjU03ExMeEVfPsvn276Ow1wriopejYYprysmhU0ygp/bHBW/8QFZfkWDNp+qHRZ0F
         lomSdfuLFH4Y2GzXMOpdo2m2jPNeyv5IpUmkWogHxUSYUebUWbWXp5iS+91zBLvp1Pws
         6pYFELt0IaKIDUa2XTDu5LoH4GIzTRwdLy/zPGh8ffrPwP6KOVqCTE1VSMfXO6HCNW2s
         b8tg==
X-Gm-Message-State: AOAM531LoMQ9/b3qMghw/nLK5TXW5klTlbcfrAJDSslKNKTo/9NrQ5JF
        49/il2RfRg0cyENEXoVIPNLbxWy5RSFGA0HE2TzwMw==
X-Google-Smtp-Source: ABdhPJy4giCW2AraYjhK6Yjp2t0DYhM0Cmgsfyi0OtXVHYjSXtvXk7PVTdz2Hvycja2NhNqN3hztKLkbZZ5b2CdI/mA=
X-Received: by 2002:a25:1086:: with SMTP id 128mr364500ybq.375.1612460069483;
 Thu, 04 Feb 2021 09:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20210204123331.21e4598b@canb.auug.org.au> <CAMzD94RaWQM3J8LctNE_C1fHKYCW8WkbVMda4UV95YbYskQXZw@mail.gmail.com>
 <20210204153611.iqpok4ligorpujyo@skbuf>
In-Reply-To: <20210204153611.iqpok4ligorpujyo@skbuf>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 4 Feb 2021 09:34:18 -0800
Message-ID: <CAMzD94Th4aku5zsGfOp96kvk7VU5RE1+0AVszExB5-nogEaq4w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I've just sent the patch series:
https://patchwork.kernel.org/project/netdevbpf/list/?series=428099.

Thanks,
Brian

On Thu, Feb 4, 2021 at 7:36 AM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> Hi Brian,
>
> On Wed, Feb 03, 2021 at 07:52:08PM -0800, Brian Vazquez wrote:
> > Hi Stephen, thanks for the report. I'm having trouble trying to
> > compile for ppc, but I believe this should fix the problem, could you
> > test this patch, please? Thanks!
>
> Could you please submit the patch formally to net-next? Thanks.
