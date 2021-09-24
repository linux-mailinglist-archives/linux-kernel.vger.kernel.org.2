Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8587B41749A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbhIXNIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346353AbhIXNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:05:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9929C06114E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:47:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 81so6232246pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=4gPE6yuV641TUFz9oaQeWtbPkGh3Bp4kiLo+CYHmDH8=;
        b=aO9Gxmb7Mp9ZTlHNhiTP8lCJ1qQRBgBdGlbYFNXFAR0vRLS7xdtBHaYvqzzbQpmxAh
         1nVKsqVonV0qbiLyKcu862uUQ81C8F33QqanrMbuYR3Z2FzNTfymO1vGzYTme3MFPXQo
         5L2gbhIjG4fNzu2GgWy2vEHPjw8oB5ixzIqWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=4gPE6yuV641TUFz9oaQeWtbPkGh3Bp4kiLo+CYHmDH8=;
        b=foYofPdOz5X69wiiWuEcPMxUVqXTo5cAb9X/nRs6uQqea0wGWNJs76R1jQS2/hDb6x
         fLUP8h2oDnxKy0GQxr3sAsUjlt6eVyTyzkj7yYaFVzR1E8qzv4JCd3pcrfrRrGqGQX4j
         kLyfeYrxnJN4nNbV9P6rAViyzVjnzI1NrBGWa1lGaEiTK99RyZnVTbLqxUziaOcxk7Ic
         0Tc6Fk/jh7547xCIdDWElIScOA/bbn/tHhHdwooVErhBwvPlG8tm2UVJPryRA2l3QH09
         pko/Awa+N+fcBB5uGiBATEGdWxORKbtF4Y2+llOlD0dfnTOesq/B+WIvu8UNMtnsPNPa
         Rk4g==
X-Gm-Message-State: AOAM530p6mDs5p7vDAziHufDnk2w2Ee/66tLHUFWHuJBoBDZyD0wlVVB
        HmkzuOMgSu7U4kfQFDzUFpAm/g==
X-Google-Smtp-Source: ABdhPJxOhFXFGobTo1ScxpufyAH6iXMr4p/Di77RU3XXpVK9CjV3r1AJwPJfzlNsdz5QNOug2QnK9A==
X-Received: by 2002:a62:7696:0:b0:44b:4b19:6417 with SMTP id r144-20020a627696000000b0044b4b196417mr5628235pfc.5.1632487672401;
        Fri, 24 Sep 2021 05:47:52 -0700 (PDT)
Received: from [127.0.0.1] (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x15sm9914465pgt.34.2021.09.24.05.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 05:47:51 -0700 (PDT)
Date:   Fri, 24 Sep 2021 05:47:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
CC:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] firewire: cdev: Fix function cast error
User-Agent: K-9 Mail for Android
In-Reply-To: <20210924105733.GA78013@embeddedor>
References: <20210924105733.GA78013@embeddedor>
Message-ID: <5BB921B7-9D3C-460F-98D1-F277D31DC849@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 24, 2021 3:57:33 AM PDT, "Gustavo A=2E R=2E Silva" <gustavoar=
s@kernel=2Eorg> wrote:
>Fix the following function cast error when building with
>-Wcast-function-type:
>
>drivers/firewire/core-cdev=2Ec: In function =E2=80=98ioctl_create_iso_con=
text=E2=80=99:
>drivers/firewire/core-cdev=2Ec:985:8: error: cast between incompatible fu=
nction types from =E2=80=98void (*)(struct fw_iso_context *, dma_addr_t,  v=
oid *)=E2=80=99 {aka =E2=80=98void (*)(struct fw_iso_context *, long long u=
nsigned int,  void *)=E2=80=99} to =E2=80=98void (*)(struct fw_iso_context =
*, u32,  size_t,  void *, void *)=E2=80=99 {aka =E2=80=98void (*)(struct fw=
_iso_context *, unsigned int,  long unsigned int,  void *, void *)=E2=80=99=
} [-Werror=3Dcast-function-type]
>  985 |   cb =3D (fw_iso_callback_t)iso_mc_callback;
>      |        ^
>cc1: all warnings being treated as errors
>
>This helps with the ongoing efforts to globally enable -Wcast-function-ty=
pe,
>so when Control Flow Integrity checking lands in the kernel, incompatible
>function type casting doesn't interfere with it=2E
>
>Link: https://github=2Ecom/KSPP/linux/issues/20
>Link: https://github=2Ecom/KSPP/linux/issues/102
>Signed-off-by: Gustavo A=2E R=2E Silva <gustavoars@kernel=2Eorg>

I thought this looked familiar=2E=2E=2E

https://lore=2Ekernel=2Eorg/lkml/20200530090839=2E7895-1-oscar=2Ecarter@gm=
x=2Ecom/

I think someone just needs to pick this up since it got past review, etc=
=2E

-Kees


>---
> drivers/firewire/core-cdev=2Ec | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/firewire/core-cdev=2Ec b/drivers/firewire/core-cdev=
=2Ec
>index fb6c651214f3=2E=2Efd2923599667 100644
>--- a/drivers/firewire/core-cdev=2Ec
>+++ b/drivers/firewire/core-cdev=2Ec
>@@ -957,7 +957,10 @@ static int ioctl_create_iso_context(struct client *c=
lient, union ioctl_arg *arg)
> {
> 	struct fw_cdev_create_iso_context *a =3D &arg->create_iso_context;
> 	struct fw_iso_context *context;
>-	fw_iso_callback_t cb;
>+	union callback {
>+		fw_iso_callback_t sc;
>+		fw_iso_mc_callback_t mc;
>+	} cb;
> 	int ret;
>=20
> 	BUILD_BUG_ON(FW_CDEV_ISO_CONTEXT_TRANSMIT !=3D FW_ISO_CONTEXT_TRANSMIT =
||
>@@ -970,7 +973,7 @@ static int ioctl_create_iso_context(struct client *cl=
ient, union ioctl_arg *arg)
> 		if (a->speed > SCODE_3200 || a->channel > 63)
> 			return -EINVAL;
>=20
>-		cb =3D iso_callback;
>+		cb=2Esc =3D iso_callback;
> 		break;
>=20
> 	case FW_ISO_CONTEXT_RECEIVE:
>@@ -978,11 +981,11 @@ static int ioctl_create_iso_context(struct client *=
client, union ioctl_arg *arg)
> 		    a->channel > 63)
> 			return -EINVAL;
>=20
>-		cb =3D iso_callback;
>+		cb=2Esc =3D iso_callback;
> 		break;
>=20
> 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
>-		cb =3D (fw_iso_callback_t)iso_mc_callback;
>+		cb=2Emc =3D iso_mc_callback;
> 		break;
>=20
> 	default:
>@@ -990,7 +993,7 @@ static int ioctl_create_iso_context(struct client *cl=
ient, union ioctl_arg *arg)
> 	}
>=20
> 	context =3D fw_iso_context_create(client->device->card, a->type,
>-			a->channel, a->speed, a->header_size, cb, client);
>+			a->channel, a->speed, a->header_size, cb=2Esc, client);
> 	if (IS_ERR(context))
> 		return PTR_ERR(context);
> 	if (client->version < FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW)
