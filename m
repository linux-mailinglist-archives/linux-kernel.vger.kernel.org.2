Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25C38B097
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhETN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhETN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:56:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:55:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so4147361pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kxtcShnR4fpUjqDaEgBJYEGF8sbXlhk7b1s7ImUtLjM=;
        b=E4I69EpcwEjDBlR279V9//Ag7yQZPuvVOWJKTpmUYjDtyHqpl9Jnkc6aG+J+IKtlbv
         c3JGg/D7C2HnwXpw0W0maJ4DQxEDA4VuBTzEac4vVCs82kvQDmQg0ozxqvYiut6G2Gf5
         6a1GQJwgXUoL5YWsV3s1zbAnqjE9qSOL3WC3Vwbg74gv0CIJzHCXPvqHjuxr44HCn9Hp
         amVldq672VVxORU+1rCglrMj5ZgoP87Ubv6AXWRBpuzuVp5mlcreEo/BlMFwcwyEEWVp
         yG4cX9VxDE3ccZ9J39YjGVyr8tWsPpi6IuOp7ygeIJAyhNE+ZDur4gptX2LpZ3X4YZBi
         YWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kxtcShnR4fpUjqDaEgBJYEGF8sbXlhk7b1s7ImUtLjM=;
        b=uJ9s/ctLVsV8d4qHqyXoql1pEqE8QPp1xPohN7y39R3B0q45NlGJpif5Mm0vu1bJao
         wkoVOZ9pA6BTteIh+zuA/5FMW1DqVH9HZy2l6P4B9y3L6iWV2nbnXzPIFJNFzYBxZa/c
         +5NOw9RSQRZL/beKF/KPImdpO4sbpvpy6rvxzMqk5KDXWfMx0bym6zDVouzIJgn5Coj1
         LzYvvo8tsvm68DJ5YNSdh1iMurJH6g3TkvRJxn2l/ZbHz5qtXc7L3WzGwey2nQgflTN5
         ludynIKY9cJ95JIbd26DpfMDN5e8LB4eSEZAXoyQwKc+boBayvwPlGGUt4KHT8xpubEL
         AAbA==
X-Gm-Message-State: AOAM532WiEfSFkY4MRi9QnlGArGcd2kNh/kcNjPK9lV00cXf+x47VjNJ
        bMdM8+yDE9thyqGXH2dSmWCb1F7loGreGjjJsuk=
X-Google-Smtp-Source: ABdhPJy3BzTnhaqsq0tYiKlRnvgZddzTH1DlQBhAMf3srr+VQ8wJl2BaTPwmIZCr37rCXBt/jIWtKxwIlBYi/r4qN20=
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr4948115pjq.179.1621518915614;
 Thu, 20 May 2021 06:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210314233323.23377-1-chunkuang.hu@kernel.org>
 <20210314233323.23377-2-chunkuang.hu@kernel.org> <CAAOTY_8ASVD_kApnRmrrsA6nh3XDYAyS-u0g7jK_GF4KipT=wg@mail.gmail.com>
In-Reply-To: <CAAOTY_8ASVD_kApnRmrrsA6nh3XDYAyS-u0g7jK_GF4KipT=wg@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 20 May 2021 08:55:04 -0500
Message-ID: <CABb+yY21AOrZUzoKaFuiqaEyzXn8t4AxjkOM2_G88mxTpX-_Bg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: mtk-cmdq: Remove cmdq_cb_status
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 6:21 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Jassi:
>
> Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=88=
15=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > cmdq_cb_status is an error status. Use the standard error number
> > instead of cmdq_cb_status to prevent status duplication.
>
> How do you think about this series?
>
Hmm, I can't remember the reason I didn't pick. But it was definitely
under "todo" label. I will pick it.
BTW, it helps to see Acked-by's from someone working for the h/w vendor.

thanks.
