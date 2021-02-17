Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B931DD18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhBQQPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhBQQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:12:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88889C061574;
        Wed, 17 Feb 2021 08:12:15 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id i23so16901819ejg.10;
        Wed, 17 Feb 2021 08:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PvHnK2Kxh4/xxv8lM9GK97Ij0mdmR95VbATZqITurVA=;
        b=BnX1n6Z1F484sz2L1Y37k+fzsOIBbDvcamI2TFCucLnmedTYA7eW4F9uYMoKSMELyH
         nFvadc8u3p4zQ0OptXxiSl9H1oVgiNqKxgAWIWsc4sYaN9XD9pFCnI3bY6nHn+pvL+Z6
         j1e6F0xbRWo0UqQhygrI00hG6nX45CTosuNVs8/BwJxV8EoyHehYdGfx314y8h07hneE
         eQNUyPiYxzV5rFJCuCbvMf+0y8VNa7DA7eXHOX1LvGi3jIN4+svW8SXNHdL7Bl7AItwU
         Z7eTTSccqR63FdLudI+dOo91/TwTu5AD6y4Fna4RHg9KkjAwlfl29cRFfdhbz9/loYTa
         I96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PvHnK2Kxh4/xxv8lM9GK97Ij0mdmR95VbATZqITurVA=;
        b=aWPYqcpUJ1qlhJkqMoxoRFTunMzB1pKWYaniRILT3fMC90W0GL5V7Cz1RhqeF0u0Ud
         SfK3oIzIbVFDptfT6h+s/jyOuQiuItPTwWIil3B3FbMFqGOTFKXEEwCNI97alNNxwjYc
         HdlUjAm4rfUiMJnTr5XUZY0vyv0FjcQnNFL/g7BxxRgGKjLDvDck8dbZ9NvCQp1SJcYf
         Yv5+Os/LUKEWg1XAW+XfhH6goyADQg6BcwJETn9yjMvuD3lcoeSYA6r2ogtOLDnPSyaa
         HBWlRrm7HRu2oJAmrUtci7Ik71NthX5JwiaXXiXGvF0vmSusDLDxeagtFpkHAd1krjXN
         ibyA==
X-Gm-Message-State: AOAM531Avik7aWe8Ih3RTONG01yiL1fkaGWrLijDs6qShNekIfS0ObCG
        WWqYdckGZk0NCmBTMLwbnUTxsZZhvXzrIvXBag==
X-Google-Smtp-Source: ABdhPJzdfRN8S4Ap+nEoUFnwjiIl/FDYo8PL14eRmzgezhQeqjWZhA2mSB1AYKy/qj3614lbsfDsUEDgg2p5DKudALk=
X-Received: by 2002:a17:906:5a91:: with SMTP id l17mr15516816ejq.231.1613578334250;
 Wed, 17 Feb 2021 08:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20210217153038.1068170-1-rsalvaterra@gmail.com> <20210217171029.40922d14@kernel.org>
In-Reply-To: <20210217171029.40922d14@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 17 Feb 2021 16:12:03 +0000
Message-ID: <CALjTZvYh8enD96x=npj0Dnwf_yuhA_6h5Cd8AtKHMdC2oojVkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     gregory.clement@bootlin.com, andrew@lunn.ch,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Marek,

On Wed, 17 Feb 2021 at 16:10, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> Rui, in the future make the subject prefix
>   [PATCH mvebu-dt]
> or
>   [PATCH mvebu/dt]
>
> so that Gregory knows its for him and for which branch.

Thanks, will do!

Cheers,
Rui
