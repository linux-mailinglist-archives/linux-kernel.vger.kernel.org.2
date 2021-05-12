Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528E837D0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbhELRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbhELQMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:12:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC8C0610E7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:50:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q6so12278505qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lUNZPIvUpUF22GN5HWhSK1rgVPittay1FdfmyU3qBis=;
        b=eNHinH3Lowl5TPC4qzBSoPxoX/gKqjEPywzf7TT5e+BrQATO37VG3Y0VkR8+l6xCIx
         z7b9RVrTWPtyjqGdGlzIqGZhQCtj5s5mbfmFfg2B1aQJRU0YGWpsglyGrBCkdp1HAsmg
         Vw8u/JZMDNenOo0Y1QlWc+iHA3Ekihxi0JYZowvMgscNMV8UzWhyFcaCPi4gH6m4IDQ1
         NRpe2ULsORnUome5DaDnwiSiDbGnKkwKbEeHN0cOLDe69d4x2ITvJmL8RHilEyN1PTto
         nAs/I1FE3BUsXuTWphyVnOKc+YO4jv1Bw0veBcHO3aOEa6j03FmeBtPe2Rd8ePrTN3Ys
         01OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lUNZPIvUpUF22GN5HWhSK1rgVPittay1FdfmyU3qBis=;
        b=DGBOwGQeQmJ/AO1QIHv8deHqnld3Le3iJQUqQi69umlosy+MiXbnnFrlzQyfJJmO/j
         fLQzaMeEPHAlkHn6rB5AlN85JHK0E5BIkGYcJCLyO2u0ujSwh8pVDLbvrjXlRHa/6llW
         BwaC0+tBom9ucw+9k8VOysrsYmL0DuN8PhDGViogjFW0RkRtE/4tTeuaQ3W8DfMk6Gq2
         pL96zTJS3+TQqcly+rV8KMfBCbYQkLp0VzTXhsSwjh3c7eBebjgn4ChoDrKpKJi9Is8A
         T1CDm/CZY6QJS13KjvWepki2yjTtbdDD5rqAJpKnaMgIHqhBMbm+FiE0+ODKGnyr71E9
         KqFw==
X-Gm-Message-State: AOAM530CnvQltnqfJqd7ucY8TkvXysgJpozjyWjQzjh0NKskP0UoA6FU
        96pKxQVHwHPMqxpj1p5RxS7Yha4CbFnDNXbU+uuDpQ==
X-Google-Smtp-Source: ABdhPJz6I3XQOp+zixZ7kGGsPE2zOHfne5RsDQ+wRfzC9asD+rAhS7zspcx9Gw5yOVuvTqVd8JrQY59x/0A4Nigu9LA=
X-Received: by 2002:a0c:e3d4:: with SMTP id e20mr36129254qvl.10.1620834631926;
 Wed, 12 May 2021 08:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210322003915.3199775-1-mw@semihalf.com> <YFiKHu3hlAk+joOn@lunn.ch>
In-Reply-To: <YFiKHu3hlAk+joOn@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 12 May 2021 17:50:19 +0200
Message-ID: <CAPv3WKdf5aX2W77N_-FBM5hugYW-ME1DvkjNuCUrcU8FG2XENg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ensure backward compatibility of the AP807 Xenon
To:     =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

pon., 22 mar 2021 o 13:14 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> On Mon, Mar 22, 2021 at 01:39:15AM +0100, Marcin Wojtas wrote:
> > A recent switch to a dedicated AP807 compatible string for the Xenon
> > SD/MMC controller result in the driver not being probed when
> > using updated device tree with the older kernel revisions.
> > It may also be problematic for other OSs/firmware that use
> > Linux device tree sources as a reference. Resolve the problem
> > with backward compatibility by restoring a previous compatible
> > string as secondary one.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>

Do you have any feedback about this patch? I just noticed it's not
merged in v5.13-rc1, it would be great to have it in the next release
though.

Best regards,
Marcin
