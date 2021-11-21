Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E771745840A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhKUOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 09:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhKUOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 09:20:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223EC061574;
        Sun, 21 Nov 2021 06:17:24 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so64937683edb.8;
        Sun, 21 Nov 2021 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShHRmCcVEJj0a/nM7y9KPmoK+HrmonPdTpFQaYkAuHI=;
        b=AO9D4Sh+oAdGVEZIirqgA0SnjwAsXeqsTtm6X0ZIj/A1xvGAkqVAUZ7/NuBnsFzrr6
         1ChH3NHfNMV9gflhu/RkKG0GQ3IvdZGfxPoiemA2Xqj7H/xvmBILl2nbtyrezj1cW11/
         aQlY/QwL+G/Dt6ZcpVFtL5m+HSeeCi1k7sK1hJOEuqaYtPoX9ikYSavV1AQpKE8ZHRAT
         8I9Tz2hU+XrTnSV2gnM7+H3Dwo72h3PxLOrCRNbO8H4Fza5/JYLZomRwLavk53r6sYtm
         oD6w8LfTsCdewa6/s2kZ8u91vkvCwcqnjZ4wfLARX5IF2+WcSQ3ESqCtE/dnUyNP1XET
         vPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShHRmCcVEJj0a/nM7y9KPmoK+HrmonPdTpFQaYkAuHI=;
        b=rLyBH8PPm+sHUIrjIaDP3HcwORV+KAZVEPwu/puvyfAK8YWEvC4aPvu6RziKcxUc3f
         FzmWCHgiqFK9kCIu/NU6/27hqbNv+mePGbKrjEy7Nu5egbvOCwVNxrwWB1gh+oPpgY8e
         RTSko5PLs1NuFgyNp8kJKjDNtgD9XQTCehFIWlVFiWS4GCwZb4/HiVG4NBNucqH5ca1L
         4gZUxvbnPze3GWRBDqSyyhvuSRRfkb3GEQ3NzguyhKnSuUMe7GXEKb6lLpCYZYmfGsxU
         3hmegr6n/VDbduYr7m2JlrJpNNE8OE8JN7dAetmu6E49DGUrxZCyOvNRR35VTY27krZp
         s/SA==
X-Gm-Message-State: AOAM532bPwlY3I6FAvJCKevKuSqVx7D8gg3quh7vfz/J0TjzhIlp5NvD
        frR2pFDlzGgczvwv99btbQz/HGxz7tS/GtAWKsk=
X-Google-Smtp-Source: ABdhPJyuDJKc4E27+YhUM6jyOtARE7XCkMgCzB55cTNlmZJgOi5aBJFLYdzOVKMPTRQX4C7CWQBoV1Ul18t7CPcL1fI=
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr31645885ejc.336.1637504242305;
 Sun, 21 Nov 2021 06:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
 <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com>
 <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com> <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
In-Reply-To: <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 21 Nov 2021 08:17:11 -0600
Message-ID: <CAHCN7xLzR5LqqydC7uydsXQPFVn=nyqKD8ZEH3EjcPuwQky5WA@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021 at 8:12 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Sun, Nov 21, 2021 at 10:07 AM Adam Ford <aford173@gmail.com> wrote:
>
> > I cannot replicate your issue.  I applied the patch series to
> > 5.16-rc1, and it's still working for me.
>
> Could the different behavior be caused by different TF-A versions that
> you and Tim used?
>
> Which ATF version do you use? Is it TF-A v2.5?

I am using https://source.codeaurora.org/external/imx/imx-atf/log/?h=lf_v2.4

Since the driver sending SMCC commands to ATF isn't doing that, I
assume it's safe to use the linux power-domain drivers with the ATF
from NXP's kernel.

If you can point me to the repo you think I should be using, I'll give it a try.

thanks,

adam

>
> Thanks
