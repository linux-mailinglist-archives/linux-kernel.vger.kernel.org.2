Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDE3D44A6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 05:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhGXDIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbhGXDIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:08:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AAC061575;
        Fri, 23 Jul 2021 20:48:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso7839818pjb.0;
        Fri, 23 Jul 2021 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=drRdoRPVvIOW8RduDt4Qr9OrFZJLe5m69Q4ARSPuMAI=;
        b=NyJogceTa51XIxBL8f30axynBP77R3tEn8vAuwpGkn6m8DDAk1SVATudiKBUljHg4o
         F3hnrcQ/EFu0qJboFOpmlbqbrmxoszZ3I75X11dBT6/l5TVnyuGuVXRkECHP2qXEceCz
         ypb/ugRleAtvABIzDXMGkw1t88hbJHoeRzNc9Oz8q1NZx9qAX31mSIAHq0vv8QRgLr6i
         R7jHpFowPVErxc/ov1eBS0hdgVVteijugIJaEUrsBLCFDCQFyK4dzr4HxFF/wfZs1Z7r
         5g/mrO+1q/ZsUVARRMsT4ORQME3QY2nv4wrrxDpCVVedpAQK+Ox0RJ4yiVVzzYXIzxoY
         HTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=drRdoRPVvIOW8RduDt4Qr9OrFZJLe5m69Q4ARSPuMAI=;
        b=XOMin9JuSDbgPYwRcUw3P12LAYMm8UouZjAbsthNAca6cUs5rgeHBroEsDVjxs64RU
         HNvgEhKSgQAWN34KHq1rcqdQF6hrzV+GgApLokaJuB63ET7bOzcWl17i10Jr0EBSqs2H
         AqsK1OJa/jQz1FIQCvxLnhNyF1UQjtpX9q67pP3uo5YmJkvEEx0or3sXyLWLxfdyQs+n
         5YSgOb5sizd/WsutzkGYUxP9hF9lpelDc0txyfYgVbD0TFGPKx1XP+RXswrN7P65sQWG
         UYVeEtpp2MbikZB6712RYoOcD3XQx1OUnjHXBvK0dUmoM79IRMeSBHsiXj12aGJbMMuT
         eiTQ==
X-Gm-Message-State: AOAM531KZuBoGRMGLEAjjVY500SY9VxVFmFZLorXq21oJyLbrBXI6YSM
        Jlz8y9Lgke9ipHZK6oF3itu/3DQwxNO6ffihrc0=
X-Google-Smtp-Source: ABdhPJy3wb//4zWrhrJZdRmnuv+p/6ztM5ejga/WKmBRuPr9lInP7kk3C97iDOclXibRhPyeVE54EttwP4tNAUzaUMI=
X-Received: by 2002:a17:902:aa43:b029:12b:d643:6814 with SMTP id
 c3-20020a170902aa43b029012bd6436814mr3214706plr.34.1627098525999; Fri, 23 Jul
 2021 20:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210723060328.16581-1-src.res@email.cn>
In-Reply-To: <20210723060328.16581-1-src.res@email.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Sat, 24 Jul 2021 11:48:36 +0800
Message-ID: <CAMU9jJpd8==NEdCE8h-P=qvzqfA5peaNhL8w06vu6rq1aEzJnA@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: reformat zh_CN/dev-tools/testing-overview
To:     Hu Haowen <src.res@email.cn>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Wu X.C." <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Reorganise several long lines in order to satisfy the kernel coding
> style.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thanks,

Yanteng
