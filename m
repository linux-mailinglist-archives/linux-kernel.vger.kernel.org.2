Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56D73FC8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhHaNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhHaNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:49:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B1CC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:48:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dm15so26901852edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mmFZqBTqVe/Ey7uTSUFYWtRV0draZMGsqhEcHMQAYl4=;
        b=DdIdN2gVK1lhYyHe9hvYZT5TMv5NHj5+ItxjlgKrSVaAXZCjU6xPVeogpX7UJLGATp
         kQeKhPtI+bgTwQCPI9q/kyMQyOx0IukRHNuooqwbZLjkQy6D3+nMkFhixYNO9fI2BxaE
         Rx7O4fISi1KVsLfY5D4AMv1K4+UUTw4SXKLG+Nh1lClmozc4n8m5wSr3rbVfQdONdj14
         YikvRa/VwJ3rfZU0Ke3sjg+NKsEPurQuGLFa5qzhYihC9Zx8jNICDOizu1lCoa7KlWK9
         +uU72zv9FEQzhavJmCNm1O92El/fdUer2w0BFoQ6DaxSnq3i/I6e8qkzMW0K/aKAM15U
         P5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mmFZqBTqVe/Ey7uTSUFYWtRV0draZMGsqhEcHMQAYl4=;
        b=hoZ1Vhh67p7b8mS9t4xJ04JLZhSMRGTBI1uyJlAl4YXkcCkCi8w882dTaLJrnJRCl2
         US9Z+0S8xPXSG/cJ6fHBTvlh3wecFD/+Gz4ycyyqRb4oGFDIVnB6JsdHokpKy/YllX+u
         aJ41mTGlCNa7dKFYeFG6MN8UW7tjCBKOLEHMiHkoOA0ums0N6QAmqH+EuE9fDfRQ9yZB
         6pgKEv8XNGrZFzvp+OJ1qqbxB6Ld0ZHy/nOBJ8Lxzq7pcaiq1qajbgorEbvsxs0V3j19
         +df1rKCn/ekKwINq2Bd4+eMFqfe9Is9ZGB8h6Qr6X9VeJxeD3h4cbNn+ssG8lzttv1OX
         4yiw==
X-Gm-Message-State: AOAM53001oeq1p5ijR1PIwzcAPCSuhMDTF7qvsLb+DWppTOl2lwkgBTL
        a8sUomoSRWegFl/KovnS3ZcSihXmF7UP8VtHQzio
X-Google-Smtp-Source: ABdhPJyBmci35BWRh85c9NvhHKnkLvl+JlF07VCIPxOUECowRZwFI8fl3IYxjDZDqSUZJuzv+0oCDWdGUH3TKpXgEnU=
X-Received: by 2002:aa7:d04a:: with SMTP id n10mr27898033edo.12.1630417691192;
 Tue, 31 Aug 2021 06:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
 <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com> <CAHC9VhTEs9E+ZeGGp96NnOhmr-6MZLXf6ckHeG8w5jh3AfgKiQ@mail.gmail.com>
 <20210830094525.3c97e460@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAHC9VhRHx=+Fek7W4oyZWVBUENQ8VnD+mWXUytKPKg+9p-J4LQ@mail.gmail.com> <84262e7b-fda6-9d7d-b0bd-1bb0e945e6f9@linux.alibaba.com>
In-Reply-To: <84262e7b-fda6-9d7d-b0bd-1bb0e945e6f9@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Aug 2021 09:48:00 -0400
Message-ID: <CAHC9VhRPUa-oD_85j6RcAVvp7sLZQEAGGapYYP1fEt7Ax5LMfA@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix NULL pointer reference in cipso_v4_doi_free
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:42 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba=
.com> wrote:
> On 2021/8/31 =E4=B8=8A=E5=8D=8812:50, Paul Moore wrote:
> [SNIP]
> >>>> Reported-by: Abaci <abaci@linux.alibaba.com>
> >>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> >>>> ---
> >>>>  net/netlabel/netlabel_cipso_v4.c | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> I see this was already merged, but it looks good to me, thanks for
> >>> making those changes.
> >>
> >> FWIW it looks like v1 was also merged:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/=
?id=3D733c99ee8b
> >
> > Yeah, that is unfortunate, there was a brief discussion about that
> > over on one of the -stable patches for the v1 patch (odd that I never
> > saw a patchbot post for the v1 patch?).  Having both merged should be
> > harmless, but we want to revert the v1 patch as soon as we can.
> > Michael, can you take care of this?
>
> As v1 already merged, may be we could just goon with it?
>
> Actually both working to fix the problem, v1 will cover all the
> cases, v2 take care one case since that's currently the only one,
> but maybe there will be more in future.

No.  Please revert v1 and stick with the v2 patch.  The v1 patch is in
my opinion a rather ugly hack that addresses the symptom of the
problem and not the root cause.

It isn't your fault that both v1 and v2 were merged, but I'm asking
you to help cleanup the mess.  If you aren't able to do that please
let us know so that others can fix this properly.

--=20
paul moore
www.paul-moore.com
