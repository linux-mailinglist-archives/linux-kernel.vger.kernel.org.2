Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023BE38E70C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhEXNEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhEXNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:04:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E69C061574;
        Mon, 24 May 2021 06:03:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a4so18660421ljd.5;
        Mon, 24 May 2021 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lJlGnGduEocetJmBQ8Pfu4ZGwFw5g0I5XxXSnQKbns=;
        b=WuhoXzsNTFdGt6yOYF0aPTz5hHdsp6ZiWkmKgDxO3MVQwfNGYxNW+hGTOG9fdL/gfI
         C3QfQVCBXWzm62Mknn6a8G86OsDsHNA6bpeWZdNs2g5K66ojHY1WGVqXHw4YiBFIb3nL
         aimQqo88abVN2TFIOlH265ht7+gnspJlmzj8K+NvFl/JFqbquxthw+yaupJDLfvpnAyw
         eHhdRX1hkCoqpeHXrJl8YBYcAukyt8PvmJgjUzuo6jLypyG2WOZWgkIc9Wd3HXfm0uX9
         RbTutaVuYnhxIC+TzCyMShBYeUwr7oNShgnyFnUHXPSYAYPC0WSaSZMetTxVfVcS/PD9
         7cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lJlGnGduEocetJmBQ8Pfu4ZGwFw5g0I5XxXSnQKbns=;
        b=COjCad8PJB+ATgMDxFAsD3I9VYrfkCTrbRcc9br406/9JMoL+SHqTTWQoDvlISAnYj
         9a66UepSFc6e/HAagHXtyBYJFJBDHHT6KenkEqm7+YOZ7sl17HbFXK8FaeBEAFtFuHuC
         2xidLgfEiN1LRPzM6lx+Vit7QS9GosEo6HuhzU2xTsX4r5MnhJa54lcJ4gX4xOZVq6b2
         zuaWgM9CAkGozjrL3KEKiGIp4R+5IXNA4ICEfYAdiVt3EAU6d0AisL3N1aSMuynwz4NI
         KD6jOoSpax1z4PR3JY9Q5Qbr1pfZqnQhV7MrTDB1qOOUZStRCqlCz060Pyf1gVpf6Hm+
         mSTg==
X-Gm-Message-State: AOAM530eKZipcTzjVPfjbsXmLuoIZtD5B/5W8qAoQWQN4Fwvo5peQ575
        M1vYQaY4Yt+5/RiNNYLk55ZNk1YclBS1Whw/y6M=
X-Google-Smtp-Source: ABdhPJyxEA2qIFK5BzLlM+kPNZZWRQXtWZclbcEyf2ds/9GJF/CQcWrRmqsQE01OLy8mfcF1aO2qvAscAjTbfHHIGj0=
X-Received: by 2002:a05:651c:604:: with SMTP id k4mr16638962lje.121.1621861381299;
 Mon, 24 May 2021 06:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210524120917.6573-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20210524120917.6573-1-cniedermaier@dh-electronics.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 May 2021 10:02:50 -0300
Message-ID: <CAOMZO5D7P8Ae0zuyDbQhFAz6F4iRcoVW0euz2oCcK+CRHH5OMA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM DRC02 boards
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, kernel@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, May 24, 2021 at 9:17 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:

> +      - description: i.MX6S DHCOM DRC02 Board
> +        items:
> +          - const: dh,imx6s-dhcom-drc02
> +          - const: dh,imx6s-dhcom-som
> +          - const: fsl,imx6s

We don't have an fsl,imx6s compatible for the i.MX6 Solo variant. We
just use fsl,imx6dl instead.
