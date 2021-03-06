Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657A832FD6B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCFVSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:18:38 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35997 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:18:22 -0500
Received: by mail-pg1-f172.google.com with SMTP id t26so3784194pgv.3;
        Sat, 06 Mar 2021 13:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XDUfdodzGUJFOwgS+gmCdHVWDq2RAg4FN8l3oGXsrm0=;
        b=MQeaQyM5GoQ8qR18Ss0sTqAnGka0fMy3iCRrMjOf1WymZBsg2isIFkqr0jN8rRHDlA
         QwyXhmboM4VjXfMEYVCcrTBO5TCJtf3SW2tXNLFu1qABu0f0TX26hL4Fa/4HKjfhXQHB
         YISddxM5O4As9qVca4inRFb9NT3M23csBBuWsBb0mQnIUP9xEFjhdrZZM/+fHGaw3VXC
         nGAbtFrSGPVb5CbSfimOpkO+AOLUzE3dW0DRdnojOHfgpmDUrEWv+iUM0aha6QOdTJEU
         TRNoVLAUWsCrHC5bAOle3CYJ20t++QPt8cUPqGDOYZInzw0hAptSnMPXuXTcRiGKL0oH
         VZyg==
X-Gm-Message-State: AOAM532LZtlWg5371N4OEUjbJOhxcIoBN/QqUy+w01tod582AAtscW7u
        82Nx9yAyN4fkg/OFeHJaBg==
X-Google-Smtp-Source: ABdhPJx2hPmB5uR/5kjSKm8WOFSkMWpazJAqqNAaf78kUPuyyvz5crWMRZmC8R8pB60cvsDiCD2JUQ==
X-Received: by 2002:aa7:8b07:0:b029:1f3:e233:3997 with SMTP id f7-20020aa78b070000b02901f3e2333997mr2182648pfd.27.1615065501681;
        Sat, 06 Mar 2021 13:18:21 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id f19sm6176840pgl.49.2021.03.06.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 13:18:20 -0800 (PST)
Received: (nullmailer pid 1228594 invoked by uid 1000);
        Sat, 06 Mar 2021 21:18:16 -0000
Date:   Sat, 6 Mar 2021 14:18:16 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        jonas.gorski@gmail.com, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 3/4] dt-bindings: clock: Add BCM63268 timer binding
Message-ID: <20210306211816.GA1228536@robh.at.kernel.org>
References: <20210225194201.17001-1-noltari@gmail.com>
 <20210225194201.17001-4-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225194201.17001-4-noltari@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 20:42:00 +0100, Álvaro Fernández Rojas wrote:
> Document the Broadcom BCM63268 Clock and Reset controller.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  .../clock/brcm,bcm63268-timer-clocks.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
