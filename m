Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A639453C83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhKPXGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhKPXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:06:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A5C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:03:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so2047331edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OncezJwLKaCBAdc2N83msCRwxQ8NYV+tSR/RKJKEx0c=;
        b=5PDIMyXZ3vl5Ys7OQ9B2WBwxt/cAAQRmuO5ZJcdZp/btZqSBuKIJgGdn/uJgbIfCYm
         p9c/c1NFnWrOIBEkkV/pIhV27P1TPvbHcDf44VcdYRDSIq43z63UoPFWGGn7XKVX+KC+
         sZGQMUa/Th8f2EVtzydCSURejcmJWwiLG7W80jRmxBPeGa3by7CytGKPLHOnY3+kzPgR
         1Zds/dcOuHcGCezTVxyXyLk3eBzAF7bRCPAVBk2X7oeGcqWOKp4zoTA2CAtcx6gopJkq
         u+2JS93MfhJf5NJzIn7T3Dby3iqnLad+ig3DGeSiw0rN90I3w710TjD0GxR6qpZ7hXKx
         KWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OncezJwLKaCBAdc2N83msCRwxQ8NYV+tSR/RKJKEx0c=;
        b=Rpry69/Su68DXnTefBIqbYpJR2cPA6Sm0Z2cqcVEoJFZZtwBom0nRIzhFKEW8gbEXE
         tFNwp2KY2SC/uKB4nN8P6xmhaVFW4tGMdotvOXx3uD23viiUQ8Qxk7d27LbTVsaH+gKA
         nwoje6708mWXirg6vnDNb6fJeOlcLK5V6mOav4uryNI9nmDrb0mvvKuq6KVdV+dez3WS
         ousx/NWm6OR1n0ucwyQQfJSVeDb520OWBCfeGa8kX+IH/00mk/1n/68c00YMgVQTcGAs
         IUI6QsDsSresxfXfEWExO+plhXd8iBB+kT9tX9GEs5Bqpg29kwFic8BZQrnIdJGBqjRZ
         fi5g==
X-Gm-Message-State: AOAM532TgCe4Ss/Kyx1UM7VGzF3IZhidTYh01HJJWbM22oY4OwFTCbSy
        tWjsCSVEkPCW5XXoR11NlZhPy/bxkeBZnTm43Q+7lQ==
X-Google-Smtp-Source: ABdhPJwWy39+/yLiUeOVB0YjJV6T47n4/9gnCrr92mfw6QBoQdR458H5S+Kl4u370QTgaR6/zFjNqvG5rvqswil+U+0=
X-Received: by 2002:a17:906:d214:: with SMTP id w20mr15642955ejz.120.1637103825033;
 Tue, 16 Nov 2021 15:03:45 -0800 (PST)
MIME-Version: 1.0
References: <5831447.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <5831447.lOV4Wx5bFT@natalenko.name>
From:   Marios Makassikis <mmakassikis@freebox.fr>
Date:   Wed, 17 Nov 2021 00:03:34 +0100
Message-ID: <CAF6XXKXKivX-_OR+ZtqQP4yMVtJ=rGTPWvBDQSdys1vTCBHKUw@mail.gmail.com>
Subject: Re: ksmbd: Unsupported addition info
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:44 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hello Namjae et al.
>
> With the latest ksmbd from the next branch I have an issue with wife's Wi=
ndows
> 10 laptop while copying/removing files from the network share. On her cli=
ent it
> looks like copy operation (server -> laptop) reaches 99% and then stalls,=
 and
> on the server side there's this in the kernel log:
>
> ```
> ksmbd: Unsupported addition info: 0xf)
> ksmbd: Unsupported addition info: 0x20)
> ```
>
> repeated multiple times. I must note that in fact the file gets copied to=
 her
> laptop, but Windows copy dialog just hangs.
>
> Any idea what it could be and how to avoid it? This also happened before =
(I'm
> a pretty early ksmbd adopter), but I'm reporting it just now because I na=
=C3=AFvely
> hoped it would be fixed automagically :). This never happened to me with
> userspace Samba though.
>
> This is my smb.conf:
>
> ```
> [global]
> workgroup =3D KANAPKA
> server string =3D ksmbd server %v
> netbios name =3D defiant
> valid users =3D __guest
>
> [Shared]
> valid users =3D __guest
> path =3D /mnt/shared
> force user =3D _shared
> force group =3D _shared
> browsable =3D no
> writeable =3D yes
> veto files =3D /lost+found/
> ```
>
> Appreciate your time and looking forward to your response.
>
> Thanks.
>

Hello,

This sounds like an issue reported on github a couple of months ago [1].

Can you specify the exact Windows version (+ edition) ?

Are you accessing the share through a network-mapped drive ? If not,
can you try to reproduce it ?

Does this happen with files of any type ? IIRC, the "Unsupported addition i=
nfo"
message you're seeing is related to Windows requesting some attributes
that are not handled yet by ksmbd. It seems it was added to fix
windows 10 clients
after ACLs support was added [2]. Makes me wonder if Windows doesn't like t=
he
fake response it is getting when it's trying to read the SACLs.

https://github.com/cifsd-team/ksmbd-tools/issues/208
https://github.com/namjaejeon/ksmbd/commit/cb9167856ffca6483

> --
> Oleksandr Natalenko (post-factum)
>
>
