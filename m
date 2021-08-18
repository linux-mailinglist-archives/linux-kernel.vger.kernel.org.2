Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95033F05BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhHROIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237887AbhHROIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AD14610A3;
        Wed, 18 Aug 2021 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629295664;
        bh=hGLlWsyvSf4AqdvWej7th3DOiRfeRhKplfyBiO2scnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gzai0b48N7Q8tCJJN53hvTcDbMHxQnGmBDyS23Pi5XB25fFs/omG6ojBTD0l2J0Kt
         hcGF5k42AgA/9E0cVp+KkdmDweT2LNii2l+B6VjwhAzAOldDCQY/O+keXR2RKdsJ4F
         cF7XdbGUv/fdGQTtl0UDLcec33qrQ28JWcSI5vYZf4wvTZIeoREtvP6ff+U53Ud9YW
         Q5Re3Gbs3mmHrGllt6DR8GNxoHaYxb4die41n0sFa5YfCcqCtT5OaV3M4AFGLygiO7
         0eqP74vaSV5mnLV10A1226CI1Mgl/jkndTQRZXGHgCgZh6+xXr1nI2lsu7wCS8zSyP
         lJZ2joRSkPWHA==
Received: by mail-ej1-f51.google.com with SMTP id u3so5359833ejz.1;
        Wed, 18 Aug 2021 07:07:44 -0700 (PDT)
X-Gm-Message-State: AOAM531bxE8ek4DN3UQCQxXW/cfhGI9ksTzzs7RCR5jYDSCBufD3cEsX
        8gUGDNM3cVTangj7O+6IM7XqxB7RyHvr9+M/oA==
X-Google-Smtp-Source: ABdhPJyMRU9wZavLT2iM1oxpue184YEj4Ok01jg2LrhdI+xH47FqlsX6LU8vqZAm3uqWGAejuZaCJKMLTeJts4wK0rA=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr10111594eje.341.1629295663029;
 Wed, 18 Aug 2021 07:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210818130950.3715-1-Wentao_Liang_g@163.com>
In-Reply-To: <20210818130950.3715-1-Wentao_Liang_g@163.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Aug 2021 09:07:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLfvfi42QGkM_WqKUm0GPZ6z=ybBz9kaR5UakKd0mzGEw@mail.gmail.com>
Message-ID: <CAL_JsqLfvfi42QGkM_WqKUm0GPZ6z=ybBz9kaR5UakKd0mzGEw@mail.gmail.com>
Subject: Re: [PATCH] drivers:of:property.c: fix a potential double put
 (release) bug
To:     Wentao_Liang <Wentao_Liang_g@163.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Saravana

On Wed, Aug 18, 2021 at 8:26 AM Wentao_Liang <Wentao_Liang_g@163.com> wrote:
>
> In line 1423 (#1), of_link_to_phandle() is called. In the function
> (line 1140, #2), "of_node_put(sup_np);" drops the reference to phandle
> and may cause phandle to be released. However, after the function
> returns, the phandle is subsequently dropped again (line 1424, #3) by
> the same put function. Double putting the phandle can lead to an
> incorrect reference count.
>
> We believe that the first put of the phandle is unnecessary (#3). We
> can fix the above bug by removing the redundant "of_node_put()" in line
> 1423.
>
> 1401 static int of_link_property(struct device_node *con_np,
>                                 const char *prop_name)
> 1402 {
> ...
> 1409     while (!matched && s->parse_prop) {
> ...
> 1414
> 1415         while ((phandle = s->parse_prop(con_np, prop_name, i))) {
> ...
>                  //#1 phandle is dropped in this function
> 1423             of_link_to_phandle(con_dev_np, phandle);
>
> 1424             //#3 the second drop to phandle
>                  of_node_put(phandle);
>
> 1425             of_node_put(con_dev_np);
> 1426         }
> ...
> 1428     }
> 1429     return 0;
> 1430 }
>
> 1095 static int of_link_to_phandle(struct device_node *con_np,
> 1096                   struct device_node *sup_np)
> 1097 {
> 1098     struct device *sup_dev;
> 1099     struct device_node *tmp_np = sup_np;
> ...
> 1140     of_node_put(sup_np);  //#2 the first drop to phandle
>                                //   (unnecessary)
> 1141
> 1142     return 0;
> 1143 }
>
> Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
> ---
>  drivers/of/property.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6c028632f425..408fdde1a20c 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1137,7 +1137,6 @@ static int of_link_to_phandle(struct device_node *con_np,
>         put_device(sup_dev);
>
>         fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
> -       of_node_put(sup_np);
>
>         return 0;
>  }
> --
> 2.25.1
>
