Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF4429924
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhJKVwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJKVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:52:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21637C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:50:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t16so51131069eds.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbnJkfP68nHZ3a2B4RSKKTibPUZ/ageATGkXYfFBQeA=;
        b=wLrEp738E2QE/+wYqTY3hjxN9yRwjnhaIUGqGzkwx7F+3V1gNbPuwK8cuMGZkf6qlj
         Qx4o8N/faB6TKanGlV8f7QH16fFV2n0T3iAmvme93mc1BM+iINuyk+lvkN70GAEcoDC3
         XscO2Rsp2ntS04xhHMBK8qKuenxdc30kre8sW6ZALbK8je+1QC1k4rHrX2XT4zqrUQi5
         4/Znh46HtG0vckXvm3/mIpxle1pr06T6/l4o0NCbo3t9fSRr7ZE/bLeJsqvSXPHCBWPP
         bAk98y4L8ojIhG4q0ZiM2unngfKLO+qMl3qQ83XzOGYzfEqrNRdDqGMuB1UBgXLjdRDx
         hW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbnJkfP68nHZ3a2B4RSKKTibPUZ/ageATGkXYfFBQeA=;
        b=utomrbzF1BPepywWOubqQAFHr27OVjLwps2PFR8DwubYlp2bOnLTduqV3pp7o2G+z3
         Kz/a6E6L788VbwspyfROoDOxmVUMYmLBNmnwDq6OZL1EynTdVnO5rz1JxWZTty/kCKxF
         VeDBJHwj13jWpW4RtKu2inZEv3BWVBK6UxnLvlbYF4EPOGRF7ihIppXSIplfOoRQzB+S
         F6eHSeGa38wsNd4UKxfHmeyzZRBa3SB9o7ujKu5B+37pI046QqMFmB+mnuaP+ddvyFXa
         5A8YMclGmrlH16jOoZlugA11snTgMex6q0CnCp0s55hQaaYupx3ghNnzI0e34WI5tZ6U
         wQXg==
X-Gm-Message-State: AOAM532THXcxsRkALV06Bst3X74IQkBY0/zInM2Pm7sM9XcLuJ6BPmTp
        WX+gwwdoI5NJw2Raag9BQ4hsEuFicKBF7R8tTJHB
X-Google-Smtp-Source: ABdhPJyrSTRdQppLh24WldFNMDLLvyr9OizmicicS/BIr9WD5NO4WYCcMlMiaxUzVotn7yzZVJ5XgkZmGfXaJIdEQ4c=
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr27622527eji.126.1633989030703;
 Mon, 11 Oct 2021 14:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211011202229.28289-1-fw@strlen.de>
In-Reply-To: <20211011202229.28289-1-fw@strlen.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Oct 2021 17:50:19 -0400
Message-ID: <CAHC9VhRg_JVk+zpxR9XvPb7zL9qGohEsMmNr9Crtj+KOFYt8Rg@mail.gmail.com>
Subject: Re: [PATCH selinux v3] selinux: remove unneeded ipv6 hook wrappers
To:     Florian Westphal <fw@strlen.de>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 4:22 PM Florian Westphal <fw@strlen.de> wrote:
>
> Netfilter places the protocol number the hook function is getting called
> from in state->pf, so we can use that instead of an extra wrapper.
>
> While at it, remove one-line wrappers too and make
> selinux_ip_{out,forward,postroute} useable as hook function.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  v3: also remove the one-line wrappers, just adjust function signature
>  of the actual functions (Ondrej Mosnacek)
>
>  security/selinux/hooks.c | 80 +++++++++-------------------------------
>  1 file changed, 18 insertions(+), 62 deletions(-)

Merged into selinux/next, thanks Florian!

-- 
paul moore
www.paul-moore.com
