Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52913338A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCJJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCJJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:22:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFCBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:22:46 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x4so25588302lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpZ+pkoDgZkjwssVaGIfHtpG80mv7ecIlWX/mJKDp9E=;
        b=Dx5wVzf+PTZw4A54jcWtPGPN1I+GRu3qRjRozpppgh3p77erkhdW7ULPuakUGWxvGl
         fJEDjlXMwfcUA/LG0FVJIaWrq3v4Rh/kHqCSMRYtann19Pjozqfz4hiOYEi22LER274I
         j3ey2oHtkBxTqfPTQD7N+Uw3g24Jv5jAoouq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpZ+pkoDgZkjwssVaGIfHtpG80mv7ecIlWX/mJKDp9E=;
        b=H1gtMfvSI7yeJipN980UCEfWnD3/lNEr9UeAjNKl8MFKfQVhIm++0ZHb9kCsFypU2j
         V2OQCz1xTOpGcHFtw+lTfSCH5jyD9KGBWdTsk5ZMXATQv75srq7HRF5ZknlVwOKMYkco
         e3UwMeZV7MKNXmtxqDrs2stHNGvul4AjrqybmMFRCEVGq2jVEZ4qCXrBTnS4Tcj/xupa
         WrLC6V8aZ0ZbCtp+DhyD3Jwfdz2NZ1Br9modsxtTI9TmbzQsOM7JlbgDE1oCo++/RPfX
         FYGw4Bxef4T/ejusvMZEDJoRo5MEvye0IGYBZtqrGyGMBe5LeY7GLjbOWpqEXHlGR96G
         +nlA==
X-Gm-Message-State: AOAM531elToY6DiZ0OX5nuCHdXZws1x9rKTJzhZd/egw9nx++Fp5i2VO
        oQJmGpA6GLfTyGakFvejT0O7YjWOdMZLH5flP4Yh5w==
X-Google-Smtp-Source: ABdhPJwF4szkL55sAOtiaq5Pvt6aCXZl1ThSle1JWyDBgh3FOmB6lTRjepbw38wmzLsif/kHuRq2U7O0rX5gWyto1TQ=
X-Received: by 2002:a05:6512:12c3:: with SMTP id p3mr1429035lfg.97.1615368164840;
 Wed, 10 Mar 2021 01:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20210309044349.6605-1-tonylu@linux.alibaba.com> <203c49a3-6dd8-105e-e12a-0e15da0d4df7@gmail.com>
In-Reply-To: <203c49a3-6dd8-105e-e12a-0e15da0d4df7@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 10 Mar 2021 09:22:34 +0000
Message-ID: <CACAyw9-tacJC-5Cimars4Ncu0PzZ6gg-qfj7g_yz_UgX5h6H-Q@mail.gmail.com>
Subject: Re: [PATCH] net: add net namespace inode for all net_dev events
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Tony Lu <tonylu@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>, rostedt@goodmis.org,
        mingo@redhat.com, Networking <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 at 20:12, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> On 3/9/21 5:43 AM, Tony Lu wrote:
> > There are lots of net namespaces on the host runs containers like k8s.
> > It is very common to see the same interface names among different net
> > namespaces, such as eth0. It is not possible to distinguish them without
> > net namespace inode.
> >
> > This adds net namespace inode for all net_dev events, help us
> > distinguish between different net devices.
> >
> > Output:
> >   <idle>-0       [006] ..s.   133.306989: net_dev_xmit: net_inum=4026531992 dev=eth0 skbaddr=0000000011a87c68 len=54 rc=0
> >
> > Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> > ---
> >
>
> There was a proposal from Lorenz to use netns cookies (SO_NETNS_COOKIE) instead.
>
> They have a guarantee of being not reused.
>
> After 3d368ab87cf6681f9 ("net: initialize net->net_cookie at netns setup")
> net->net_cookie is directly available.

The patch set is at
https://lore.kernel.org/bpf/20210219154330.93615-1-lmb@cloudflare.com/
but I decided to abandon it. I can work around my issue by comparing
the netns inode of two processes, which is "good enough" for now.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
