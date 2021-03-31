Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1500B345651
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCWDg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCWDgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:36:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:36:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so9483093pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 20:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=QcoGEv6othHcWZINQSxl9j7i28YBgiBeHl93kbbbbAo=;
        b=NA8kI08ftwqjTn42DvaVLFdD4awUyUtJwV00MuFtAoZb9wPGTCtjKLukp0WJ+epC6c
         NZewRtuEZw1ixVP7dM92EUYV5Hkc/onlfPdcmtMgE7oHgNUA87ZPONBVAcUS0mOrr+BJ
         W7uzlJAAW9abzYkMdcney2w23rtDEJyNPH6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=QcoGEv6othHcWZINQSxl9j7i28YBgiBeHl93kbbbbAo=;
        b=dDB38snloQ1oLNFohIXNnZO+Abq4f8BVAQThpP8Skx0XktY7ZyUhCTYI3gwSh7IcE1
         MFDCMnvvyFqu1hf9o8YAxYgTlmE06sMnpLbGtZt6cUzSG+ZEee8/rUaiMlfY0XZEgYu8
         Vg0cC7AISLAK8WOo07lg/OEhjggFz8vAU9O52ulEj3m/iwZcR7ZoF4G35YWrd4UX6wbl
         A3i3pQVEjWN3Dpe3WLkKF4/3oV8SAT5VZwMvlrtRgNQYE/+v7DK49/Nv1DiZJj2XuiIl
         oSPsW591TcgJqzMdBd/CESkBLcraD0PsBJpYRfhGEFUgsDqvIfOxAVe3YawVVaZj5Q5k
         8prA==
X-Gm-Message-State: AOAM531h54jS+GFQxOaT/nQ1JA8wGCD8AXpj9nekw0M3V0jyeu9bXIzn
        kIty+PBvaWg76OuY1cl09sIbxl03XQ6OrA==
X-Google-Smtp-Source: ABdhPJyuwHnpO1HwQrmXNeZIEHfcp+mcAaux44TQ5Lg8SUV+vuiy/AoN3W9NItb8lV65MM8Tv3fhWA==
X-Received: by 2002:a17:90a:7c48:: with SMTP id e8mr2365758pjl.89.1616470581820;
        Mon, 22 Mar 2021 20:36:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:e90d:d453:87ae:2e10])
        by smtp.gmail.com with ESMTPSA id 193sm5544897pfa.148.2021.03.22.20.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 20:36:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YEUQlY4X1e2PO8tl@builder.lan>
References: <20210223214539.1336155-1-swboyd@chromium.org> <20210223214539.1336155-7-swboyd@chromium.org> <b9174acc-9826-eb82-b399-ed95f7e83085@codeaurora.org> <161483844056.1478170.8701629037531614722@swboyd.mtv.corp.google.com> <5ac262bf-a70a-4ca3-01a8-d1432732d26f@codeaurora.org> <161501150705.1478170.3739297122787060750@swboyd.mtv.corp.google.com> <YEUQlY4X1e2PO8tl@builder.lan>
Subject: Re: [PATCH 6/6] firmware: qcom_scm: Only compile legacy calls on ARM
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Elliot Berman <eberman@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Mon, 22 Mar 2021 20:36:19 -0700
Message-ID: <161647057967.3012082.16471020030801311825@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-03-07 09:42:45)
> On Sat 06 Mar 00:18 CST 2021, Stephen Boyd wrote:
>=20
> > Quoting Elliot Berman (2021-03-05 10:18:09)
> > > On 3/3/2021 10:14 PM, Stephen Boyd wrote:
> > > > Quoting Elliot Berman (2021-03-03 19:35:08)
> > >=20
> > >  > +    desc.args[0] =3D flags;
> > >  > +    desc.args[1] =3D virt_to_phys(entry);
> > >  > +
> > >  > +    return scm_legacy_call_atomic(NULL, &desc, NULL);
> > >  > +}
> > >  > +EXPORT_SYMBOL(qcom_scm_set_cold_boot_addr);
> > >=20
> > > This should still be qcom_scm_call.
> >=20
> > You mean s/scm_legacy_call_atomic/qcom_scm_call/ right?
> >=20
> > I don't really want to resend the rest of the patches if this last one
> > is the only one that needs an update. This was a semi-RFC anyway so
> > maybe it's fine if the first 5 patches get merged and then I can resend
> > this one? Otherwise I will resend this again next week or so with less
> > diff for this patch.
>=20
> I'm fine with merging the first 5, but was hoping that Elliot could
> provide either a "Reviewed-by" or at least an "Acked-by" on these.
>=20

I'll take the silence as I should resend the whole series?
