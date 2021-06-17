Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455283AAF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhFQJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhFQJIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:08:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5DAA613EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623920788;
        bh=NhgPnttuZxMZXJV+ZeDbAA58wSDZFz54WXGoCVsuvmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c0tQAMtCVsndLWPbDgqSvmLEYumfCmYAOYh40qnpsvVkwnwO4dHag4jo3+coUfYGg
         gh9VP9Y4540zlQ06DQIz2NJt14ysuCEdLZk1+dVfjxZJ+8b7a9/82HdsoBqKlG6yzd
         9E7+OZwID+grOkYy+ITw65MIHVBVkVkOc55/aWqESPqKNGdtrwxCrhyJOxiX4F8uhM
         A7J9RrqdgsP8xGZ5MbwwiyIOldaKcdpOW4jeKahLj+v/eSsZv8e4UuBOYt3Dtq+R9m
         6ssA2zvPoVEhYIbbXNUACzjso2cBCisHHqSNUOjWj6qmzML3KBS/YBkWEBpJjApP3t
         Xd8/DHm6EPmkg==
Received: by mail-ej1-f50.google.com with SMTP id l1so8630723ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:06:28 -0700 (PDT)
X-Gm-Message-State: AOAM5303qHxaqiTZfxZsONoWtYhac9T8piMU6QjO75hqoer5TSapxBZA
        OznapQ/xJbe9S9Q6RbXew6yC5Efici9B+CzLAw==
X-Google-Smtp-Source: ABdhPJwbKvx5OWeMbwbeoUBrf+TTIITu0s/lazICYsC+cvH8aIDifQ88CpSvYA8kANh6rZgWuu6l9F7+vyUXt2Y1xy4=
X-Received: by 2002:a17:906:ece7:: with SMTP id qt7mr4058782ejb.194.1623920787448;
 Thu, 17 Jun 2021 02:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
 <20210314233323.23377-2-chunkuang.hu@kernel.org> <CAAOTY_8ASVD_kApnRmrrsA6nh3XDYAyS-u0g7jK_GF4KipT=wg@mail.gmail.com>
 <CABb+yY21AOrZUzoKaFuiqaEyzXn8t4AxjkOM2_G88mxTpX-_Bg@mail.gmail.com>
In-Reply-To: <CABb+yY21AOrZUzoKaFuiqaEyzXn8t4AxjkOM2_G88mxTpX-_Bg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 17 Jun 2021 17:06:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY__eEUdpdQ4a8pK0HPUgbYQEaxBEWASTwkwUCMTuEyQW4Q@mail.gmail.com>
Message-ID: <CAAOTY__eEUdpdQ4a8pK0HPUgbYQEaxBEWASTwkwUCMTuEyQW4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: mtk-cmdq: Remove cmdq_cb_status
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jassi:

Jassi Brar <jassisinghbrar@gmail.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:55=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, May 19, 2021 at 6:21 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> w=
rote:
> >
> > Hi, Jassi:
> >
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=
=8815=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:33=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > cmdq_cb_status is an error status. Use the standard error number
> > > instead of cmdq_cb_status to prevent status duplication.
> >
> > How do you think about this series?
> >
> Hmm, I can't remember the reason I didn't pick. But it was definitely
> under "todo" label. I will pick it.
> BTW, it helps to see Acked-by's from someone working for the h/w vendor.

Yongqiang is working for the h/w vendor and have reviewed this series,
does this get any help?

Regards,
Chun-Kuang.

>
> thanks.
