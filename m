Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3625339F790
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhFHNUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:20:18 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37456 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhFHNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:19:57 -0400
Received: by mail-ua1-f42.google.com with SMTP id w28so11583481uae.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeJwkXf02FHfkTc2tBhjPcNKSoYfgCe3Kp4yq0sZmLQ=;
        b=rf8YIY99EbZMH7/g12lKGP+/SS1HGQgyS+TwSAWEoUkshR9P9Ec3G/WR5fH6jYhGbN
         bl5LprBy5xsyf0h/IPEzPCJlzOerq5GFGC8npSAHFpt0HgQiGeRy1h90ikX15ib8uCVe
         BSMcQGvJRyTIHbKsWuB39rNXYMN2ogOqjqdhSwRBLpjleKKw5E36j8Jomg9WzHSygfpf
         BB+ZHFK5AHq78zJlPPK1igG5DSdmy2PBnoK9uT6iAXAPuxUA783R5bDjZYH4z51UBrLE
         +TCW7CIO8Osk8FlZeidbHZjQg8zN+3WG1XQtFr4OlHWO1S6v0CUG8s7RwpfirhwtiWWr
         /kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeJwkXf02FHfkTc2tBhjPcNKSoYfgCe3Kp4yq0sZmLQ=;
        b=lXUfk7yp6m7M+aDdhAMil1S/l/lVr185M5dx4TRC27OJQOA2SoKLa2JmofY1J+tMCF
         aP6T8+qxwujwDZ4m+kBKITeU7OBXSI6lS1lFcNfQDryyTbf2tkbZyDVAMaXrDHAm314W
         ILQxs9DE0B+heQoP2NPSYJFwAX1S9/eLdyxzfwPdDFA24FFFPL8ySZgbaXEr5GIU47p+
         E2UFZl4zNzF7GcQ1kXxDw/hLanR36j8sG78QhDz3E3x7IG9YFhhThP9s7vSIb1V4F5Jv
         0uWcODncKIVGknajMI7Yta0FwniBDjEOdtEkKYnOC5CHIJt73juzdf0TjIf3VR4fBytA
         FQJA==
X-Gm-Message-State: AOAM532KK73EoPwWMh9qxialAKKTL7oDc6RbeiiMF7kTKZ+5VLX3jSiO
        ZdsXistjcNmnWcr4lUsHl9/Ib5P7jzroZ2FgV1OJyw==
X-Google-Smtp-Source: ABdhPJyNWit/KMWObghRKbmC6vtI+CqqBIJIhWt5YdpyC0OBpfA57D9EyglRt+y4bBMHLxwHJLZJWt4XwfmLKDDM/Aw=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr12675863uak.19.1623158223925;
 Tue, 08 Jun 2021 06:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <1623002884-57244-1-git-send-email-zhouyanjie@wanyeetech.com> <1623002884-57244-2-git-send-email-zhouyanjie@wanyeetech.com>
In-Reply-To: <1623002884-57244-2-git-send-email-zhouyanjie@wanyeetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:26 +0200
Message-ID: <CAPDyKFrHuMZdHJ+KKBffCu+FiOJr14ynBnjYW_oGpNQN8+Hy8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: JZ4740: Add bindings for JZ4775.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sihui.liu@ingenic.com, jun.jiang@ingenic.com,
        sernia.zhou@foxmail.com, Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 at 20:08, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)
<zhouyanjie@wanyeetech.com> wrote:
>
> Add the MMC bindings for the JZ4775 SoC from Ingenic.
>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml b/Doc=
umentation/devicetree/bindings/mmc/ingenic,mmc.yaml
> index 04ba8b7..546480f 100644
> --- a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
> @@ -19,6 +19,7 @@ properties:
>            - ingenic,jz4740-mmc
>            - ingenic,jz4725b-mmc
>            - ingenic,jz4760-mmc
> +          - ingenic,jz4775-mmc
>            - ingenic,jz4780-mmc
>            - ingenic,x1000-mmc
>        - items:
> --
> 2.7.4
>
