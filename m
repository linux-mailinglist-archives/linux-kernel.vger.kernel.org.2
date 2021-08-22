Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B53F3E01
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhHVFRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 01:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhHVFRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 01:17:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B21C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 22:16:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so10033391pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y8ajL1MXjnm98ftlu2xw9F3LVfgwHRHrIy4fib1NoNg=;
        b=Y0a8GbxIDGsupMPfALs9c9spCnnTUj10GqcmI81qVhXcdsNXwx3+WXpuFT/OMEwdqV
         ov72OppMgo1s3fFQNnWub4aPQ3g1ot25/8ftkZ5p3ZUdFTAy3eibMgeUHw1Ncik4DfoH
         1fyvWtmEFxySeGpMWW3u1iMK9poENxq7thhvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y8ajL1MXjnm98ftlu2xw9F3LVfgwHRHrIy4fib1NoNg=;
        b=G2HbkE2OwAs/RKoXSUqTnTSZW5lq9Bo8+XI9vCfBK8pr8Koeg7OWSzJjsu8hfzoZq2
         OCl8oM1aaob12mUs2zuXE1ijqvxx6LGsNcwxTccIY9pGTTw/u4mqJjDaIvZhYjif4caW
         N0lvP11+9ntZ7hrFlFUuLiJlXneaCdXCmUx/JOb6WvPs19u4iWa1VNe84CTFURT82OgL
         LgPg6fLR/PEBH65efrpD+KY3830RgdlDsjx4yB4V8UvAtQTmTS7BWl89egh2+lxVL6Ni
         WOO0qOLDRrcJ7BWScjUeJCBDE9yStCQfztR5CsgdyUpbAKjMJ55Y5IhPtyRLalxAp6Z+
         slCQ==
X-Gm-Message-State: AOAM5311jhLu9WLkv1+F/n2ztqvCpfUn7Al+biTw8iQHuCsxktDxRJlV
        9HgGtLepi0QRACYJ5nqAflcsuA==
X-Google-Smtp-Source: ABdhPJyR+NATVJLBLIhcM5YqAZh+Upqb5pIwMTUuXQGDWIR7A9ZoJQ38xuDUEW6TSdHtuwjl1NIx8w==
X-Received: by 2002:a17:90a:5147:: with SMTP id k7mr11682056pjm.73.1629609380131;
        Sat, 21 Aug 2021 22:16:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m194sm11771124pfd.58.2021.08.21.22.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 22:16:19 -0700 (PDT)
Date:   Sat, 21 Aug 2021 22:16:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] net: Cleanups for FORTIFY_SOURCE
Message-ID: <202108212215.35185C924B@keescook>
References: <20210819202825.3545692-1-keescook@chromium.org>
 <20210820100151.25f7ccd4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87tujjt8d9.fsf@codeaurora.org>
 <87eean9kby.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eean9kby.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 01:13:37PM +0300, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > Jakub Kicinski <kuba@kernel.org> writes:
> >
> >> On Thu, 19 Aug 2021 13:28:22 -0700 Kees Cook wrote:
> >>> Hi,
> >>> 
> >>> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >>> field bounds checking for memcpy(), memmove(), and memset(), avoid
> >>> intentionally writing across neighboring fields.
> >>> 
> >>> These three changes have been living in my memcpy() series[1], but have
> >>> no external dependencies. It's probably better to have these go via
> >>> netdev.
> >>
> >> Thanks.
> >>
> >> Kalle, Saeed - would you like to take the relevant changes? Presumably
> >> they would get into net-next anyway by the time the merge window opens.
> >
> > Ok, I'll take patch 1 to wireless-drivers-next.
> 
> Correction: I'll take patches 1 and 3 to wireless-drivers-next.

Great; thanks!

-- 
Kees Cook
