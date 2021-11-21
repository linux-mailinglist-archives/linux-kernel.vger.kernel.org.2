Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CD4583FF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 15:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhKUOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 09:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhKUOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 09:15:05 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA3C061574;
        Sun, 21 Nov 2021 06:12:00 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id b17so31307421uas.0;
        Sun, 21 Nov 2021 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ekq5nYIICzg5NIjoLxX2n2oDnL+G6sOR9vxyDeRhzUM=;
        b=WTt3G4WMYmY0iRBD+80UqNFoPQKEdmcYTe8VGuFTmahv4O+B+jVy06eePdGfjWcXCZ
         k7Scxoe4NoN7wOHtE9iMjCzcpGAzK4uJE9pYkoTMLAjJecv0NRczgRRXSsC+ksEDttKV
         t5ZxtmfSh3CAQpJ3CoiEsoWh6POHxswn489nR8svXCG0H9fQMl0FfRY8eUwB5h7vQihs
         KeDv0hfG/JEkJAtYHnqw0tvf1+ZDxoRTpBTGlDu0pFuMVtnzl6Ql/Knhr4L6YG7/zuI9
         4/3bgQeR11UHwaoK+BRmmJspMF2B8hFzjY9QK14lnfsNRDFkNOlMTNhYFPfJy+SiRoae
         VWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ekq5nYIICzg5NIjoLxX2n2oDnL+G6sOR9vxyDeRhzUM=;
        b=czMLJQgTzYaipQPXR7LFQXYO53Rdqf8r4kOPk+X6tRNaDvVRZMlxs6CpAegvMfKCFO
         e2mJ5lN112DqFt3ZvbVpS+LQ/VgR/1wzKwtWseyvGki28XI+5O3XLXEAb9VDI1hi9q8g
         gHudYFydi2eb8e7eIiWspwOYs+NLBK8zp6uRSgoo4XmdMjuJtXzFTkyFA9Bzx7c2oc1Z
         oBY8rUHuYVkUEBP1Edr+aQMlcPaF5td1RwMaKVhnSrc8/NgU0URHsr97LSm4YLGz1m90
         8u+JePVu+Z4cmp3ad3BDPXL3eDwGVy+HMKKvxkzAhxbIhEkuWyV/7qiq3H5F9KArST1U
         0kqw==
X-Gm-Message-State: AOAM532HbLeRJn6OfYiVUeCiqNVYsmLAmDe4IvzGw4Fiqrksz7CEsbag
        2QvamaoleU51dviXmjnGcwJCRyzJ63HcPKSN1gY=
X-Google-Smtp-Source: ABdhPJzbFG6H2qloDUjJhgEiV0ZggzLG3OhnovVTs6t1Lv+tULfU1/SIrI40NftSMr1h2p/Go5T6lU29Ukmf9kXZrjg=
X-Received: by 2002:a67:f988:: with SMTP id b8mr116392725vsq.51.1637503919575;
 Sun, 21 Nov 2021 06:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20211104161804.587250-1-aford173@gmail.com> <CAJ+vNU2jcWyCm3UyiOnvknS0t+mSdpaB+CgGWYO3jxXTa3LhRA@mail.gmail.com>
 <CAHCN7xJrnZMQgXVMJg7MZdFMWyesf6Ph7HnfMH7-9bm1qODHFw@mail.gmail.com>
 <CAJ+vNU32GXtbKWGQXoE7pkXU8FcKh+HQJJduwRbRJ0tC-d6GoA@mail.gmail.com> <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
In-Reply-To: <CAHCN7xLAm21zUJQ8s4s--+ygmeVY0qyo0WSLp7ZM9bT9R3sjxw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 21 Nov 2021 11:11:49 -0300
Message-ID: <CAOMZO5Am4P17mOXWrPs0ns9AwOXM_ZpBdzbYTYJfv_48Ea=BHg@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] arm64: imx8mn: Enable more imx8m Nano functions
To:     Adam Ford <aford173@gmail.com>
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

Hi Adam,

On Sun, Nov 21, 2021 at 10:07 AM Adam Ford <aford173@gmail.com> wrote:

> I cannot replicate your issue.  I applied the patch series to
> 5.16-rc1, and it's still working for me.

Could the different behavior be caused by different TF-A versions that
you and Tim used?

Which ATF version do you use? Is it TF-A v2.5?

Thanks
