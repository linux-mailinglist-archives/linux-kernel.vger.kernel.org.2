Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1329435B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhJUG44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhJUG4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:56:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15828C06161C;
        Wed, 20 Oct 2021 23:54:39 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h20so6011424qko.13;
        Wed, 20 Oct 2021 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcvMFf/PBr+vnHvIHJelZJWVuinTtq0U/FPg7ugQ1tQ=;
        b=fKQNDYIvhjIM8psQ+eqv0/5/XiwPvK1WAG172nhm62aA9HlwIglIVu0t5bb+9Vawkn
         HX2XiS6o77RXEOokv4CDIXefrTjngtVofwbsNcI11AkElhsk73M5VYo7d8Wu+34PL6bH
         ESzq9z6/c8fWKj6vQaoXkziRZwPaINvapGAVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcvMFf/PBr+vnHvIHJelZJWVuinTtq0U/FPg7ugQ1tQ=;
        b=Xxde6hO6OGNxOv63dy3eqF4K30m4PbHJ2aPu3r4e3cPD2YunbZp2djaUk5+y1ez/Kg
         WDN/YTbwPYTnWZ5xkgwl69NJODuj/d/OPcIiROj+DTJOWvEXrmyVnaKbpyYQUTIhrLl1
         H0ia0IT0Ez0s8O2nnGwvaHpAA+VjrGtTRAGhTfk5m/f/c2KUno3rcUHUsjq0ZMKWx0As
         KINOPCwpKMqQX7izIoEtKWTX+kF8rAZ7dExBp0XW6F27YcZfcp8z+Bezi2VEAQ5rcHae
         M9+EApvq0K3Y6ldUn+dTt7+MZLSL0T01swquAR/u0DG6Btojnf0SssW4JYwc+aBzkwfW
         rSVQ==
X-Gm-Message-State: AOAM533hAgx71TlAeRnlVIWJJ64/4PMjYu/hHpXa1UEUT/ItAnkBO8Hr
        P6sOsyZs0JrUMeYW7ESZy+VuLJ97dIYQJq3yGAI=
X-Google-Smtp-Source: ABdhPJyNQXn6PsIjcPW1B5CBugTu/eSKAk7xtFNqEkuM+K8Qi1CV2TZfRtUCVD3mpjg30nViRLCT9/QQR6/tXwx/n+c=
X-Received: by 2002:a37:68c4:: with SMTP id d187mr3011594qkc.36.1634799278179;
 Wed, 20 Oct 2021 23:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-2-chiawei_wang@aspeedtech.com> <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
 <CACPK8Xfj=wJBCX5ogyf02pLJsLrooVWBJ92GJ1E+jxQW5wiFEw@mail.gmail.com>
 <HK0PR06MB3779F430883E60E7E47849BE91BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8Xc2wzx1dthFYC_0vm4mj9e1BbL+Kwkqc_PvPFj4sqjOJg@mail.gmail.com>
In-Reply-To: <CACPK8Xc2wzx1dthFYC_0vm4mj9e1BbL+Kwkqc_PvPFj4sqjOJg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 21 Oct 2021 06:54:26 +0000
Message-ID: <CACPK8Xfc+vuqbnw8xuXGtGwKRLnb7EwYZYE0Z-+g3fUM28yc6w@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 06:48, Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 21 Oct 2021 at 06:37, ChiaWei Wang <chiawei_wang@aspeedtech.com> wrote:
> > However, like Rob mentioned, when doing 'make dtbs_check', there is a warning:
> >
> > /builds/robherring/linux-dt-review/arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml:
> > lpc@1e789000: 'ibt@140', 'kcs@114', 'kcs@24', 'kcs@28', 'kcs@2c', 'lhc@a0', 'reg-io-width' do not match any of the regexes:
> > '^lpc-ctrl@[0-9a-f]+$', '^lpc-snoop@[0-9a-f]+$', '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
> > From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> >
> > As part of this series has been applied, maybe we can fix this later?

FWIW, this fixes the warnings for me;

--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -56,6 +56,9 @@ properties:

   ranges: true

+  reg-io-width:
+    const: 4
+
 patternProperties:
   "^lpc-ctrl@[0-9a-f]+$":
     type: object
@@ -144,6 +147,9 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32-array
         description: The LPC I/O ports to snoop

+      clocks:
+        maxItems: 1
+
     required:
       - compatible
       - interrupts

make ARCH=arm CROSS_COMPILE="arm-linux-gnueabi-" dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml

If you are able to test this and send a patch that would be appreciated.

Cheers,

Joel
