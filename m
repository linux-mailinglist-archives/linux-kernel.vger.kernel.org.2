Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C132394862
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 23:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhE1VhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 17:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE1VhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 17:37:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 14:35:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s4so2209466plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2YkA7fLjY3cLNTZrZoMg+tz6Rk4BTUp/rSUL7Ndl/8s=;
        b=fZ5yqn2YhKrxVZktVwhVm0J1eY/RutLmr7wBj7aQ+WLu0GNTcgZi94m/tKFvgaLPup
         xGBksKBYc8IgV2iafrtsYU1Png3g1KLVnL+TKNJlbzVmH2Ud9UEvydaODRIFsz8bndm3
         VumFD7z47Hfiz5jBCAvniFoXL9zMzdvq56kgMdWI4hVS5huw21FXAbyT8tTkoz0QBNtZ
         3QRYZryFrrzv4qcJI8NM8bNrXb4ypllYsp0VWA16BkhFMuAY1SFbZF8vk9nhVGIEuu4J
         R/azOdylHKyCzwhCxVfLEvVYSJFeLZLmggOFdDuAi+DzTm4RHUi4mbqJ8prNohwiaew5
         26Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2YkA7fLjY3cLNTZrZoMg+tz6Rk4BTUp/rSUL7Ndl/8s=;
        b=dt2R8JnAufWgFrv+iDRM+oyJVbe4cuTj6X7RWYAENokIhDpsPM8o39O76UHrHv2MHf
         NTOHUucvLOetcbJE4RcejHPysZ5kfqbdbnVCmwT9eSatPtbmECDjz0KohJi1u7aXMX5b
         QIADDg9oTkUiePBvr2bOEKZEAuih0WuN6JMtmIz5vH782AUXbg7P0xyCIVyzdQLGtei+
         jkscS/nzOxEuwImLt8TzkrDEAqnJvlOA2XNIn1ixwqCo5PQ0KXy2dbwLkxKFGWPSri7Y
         DF18qArSTOFL0t2cfzBdzFIkDxG4fJ1iLdXj7bFhKtNmNIgMj6zjFHC0E/7q/T73Sbv5
         +tTQ==
X-Gm-Message-State: AOAM531vhVPunzAKQ2znpnh29M8Dvsdc2pSU5Vl0rT9uk8VAIahns7JK
        tSHZUOy25ELHc5PdD3pJHa4=
X-Google-Smtp-Source: ABdhPJx1JXNdx4eBQJojKAiwmIPPtf9dYPZUez0myjwFx2+hnfyV0FBdy4Ojy3QmyeKt0PaZL6K+oA==
X-Received: by 2002:a17:90b:4a4a:: with SMTP id lb10mr6488583pjb.21.1622237726872;
        Fri, 28 May 2021 14:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([103.152.221.225])
        by smtp.gmail.com with ESMTPSA id e23sm5036020pfl.84.2021.05.28.14.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 14:35:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] ALSA: control led: fix memory leak in
 snd_ctl_led_register
From:   =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
In-Reply-To: <20210528140500.GS24442@kadam>
Date:   Sat, 29 May 2021 05:35:22 +0800
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam>
 <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
>>=20
>> Can you please give some advise on how to fix this WARN issue?
>=20
> But it feels like it spoils the fun if I write the commit...  Anyway:

It=E2=80=99s fine. I am still in the learning process. It=E2=80=99s also =
good to learn experience by comparing your patch and my patch.

>=20
> regards,
> dan carpenter
>=20
> diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> index 25f57c14f294..dd357abc1b58 100644
> --- a/sound/core/control_led.c
> +++ b/sound/core/control_led.c
> @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> 			for (; group > 0; group--) {
> 				led =3D &snd_ctl_leds[group - 1];
> 				device_del(&led->dev);
> +				device_put(&led->dev);
> 			}
> 			device_del(&snd_ctl_led_dev);
> 			return -ENOMEM;
> @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> 	for (group =3D 0; group < MAX_LED; group++) {
> 		led =3D &snd_ctl_leds[group];
> 		device_del(&led->dev);
> +		device_put(&led->dev);
> 	}
> 	device_del(&snd_ctl_led_dev);
> 	snd_ctl_led_clean(NULL);

Does this patch mean I should add device_put in the init and exit =
function other than snd_ctl_led_sysfs_remove? This will cause =
device_release bypass the release method checking?

