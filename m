Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37840408C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbhIMNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbhIMNGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:06:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A4C0613A7;
        Mon, 13 Sep 2021 06:04:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id j12so17154350ljg.10;
        Mon, 13 Sep 2021 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdVszoPfkP5+3xSMJWK4c78cuwygZKo1iummJFR4SMM=;
        b=De1hyk8IpuJO89EwScfFDxWniZuOIgBoXs0Bcv6cEYm3jhfjDgZaJgCFA7desNyLbG
         oWFZp8n6NyIoVyW5ayBL85G4bcz6CP2VORAT3Ayewt9VD6rXnyEXeG2aE99Lwxitnuwb
         HpVUNFipkD8WsoGaSXZ0VelVuRPxYFZrob3RjqR21C8HkPVWChFj/IWVeMAgtaxEHWYn
         rVpqZ8MJ2PsdbRDgMO7L3/WOZZLNkGep9UISsqLuLUd4EXLyzy9KKjb5vsqOm6PQfOaF
         +lXyy06VKaxWRZEPi2yje+Cya9nYLxK6bMGMziDQKxT6tcNyEgeQ6UpYEndJzxFa3Dz2
         kohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdVszoPfkP5+3xSMJWK4c78cuwygZKo1iummJFR4SMM=;
        b=Fv/VzmKuG8w+/6FyRPaDDqR4SBgttVCN1CIONPQnlK6GgkQPDHF0YwILOiBIj9IH4t
         mw3UiHKjgIuPRzSk0sjKSS5sPc83+trOdPYrdNxRONEi69MjEeNjDAzi/nxOlXpNVow1
         aotvQN1tEP5maQWjFCy44kaocR52RC9RvClXCL42ImGqE4bypGXrjt3l6vAZX6zc7iVK
         m9ss3GYjYDyeQRRqjx27PGbA2LsQJNFQ3JV6fSyVh94mUaS3gvqkW63wJqFx5Ti6socO
         Eb1z28hjvdPq3BDIk7Sw+Tmzz8ouekZyoorIdsuT7lFevXmdjtd8T8/DFOXR01fFbmAO
         EVHA==
X-Gm-Message-State: AOAM531dzfJq+YN06cOmW7ivWCiphz6GH714BIw/9+yE8GneljsTDyhR
        /prsPOWv/tXOXyIY9E+zjFLCR9nWbDHr92gJdvU=
X-Google-Smtp-Source: ABdhPJyapPwIOJ4iZsGjLhObcjcAMnBA6vJhfLb+R+mSJyhunzcosVW1T1D7lBEFop7FvtY38jGSHd5TbbyPOOZNxCo=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr10574876ljj.92.1631538241665;
 Mon, 13 Sep 2021 06:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210818070209.1540451-1-michal.vokac@ysoft.com> <20210818070209.1540451-2-michal.vokac@ysoft.com>
In-Reply-To: <20210818070209.1540451-2-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 13 Sep 2021 10:03:50 -0300
Message-ID: <CAOMZO5DUYrVZ0F_ZF66jtCkgTAM5YsqDvxaQJHGeTc-+4c2Yrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Remove the unused white LED channel
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 4:02 AM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> Since the reg property was added to each channel node in commit
> b86d3d21cd4c ("ARM: dts: imx6dl-yapp4: Add reg property to the lp5562
> channel node") it is possible to skip unused channels.
>
> Remove the actually unused white LED channel.
>
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
