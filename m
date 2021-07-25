Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE043D5092
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 01:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhGYW0Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jul 2021 18:26:25 -0400
Received: from aposti.net ([89.234.176.197]:46310 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhGYW0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 18:26:24 -0400
Date:   Mon, 26 Jul 2021 00:06:44 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/3] dt-bindings: Add DT bindings for QiShenglong
 Gopher 2b panel
To:     Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8JPTWQ.0T8NM4BDXSSK2@crapouillou.net>
In-Reply-To: <20210725221527.1771892-3-akawolf0@gmail.com>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
        <20210725221527.1771892-3-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artjom,

Le lun., juil. 26 2021 at 01:15:26 +0300, Artjom Vejsel 
<akawolf0@gmail.com> a écrit :
> Add DT bindings for QiShenglong Gopher 2b 4.3" 480(RGB)x272 TFT LCD 
> panel.
> 
> Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 
> ++
>  1 file changed, 2 insertions(+)
> 
> diff --git 
> a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml 
> b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 3624363938dd..e7f3db118c5d 100644
> --- 
> a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ 
> b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -244,6 +244,8 @@ properties:
>        - powertip,ph800480t013-idf02
>          # QiaoDian XianShi Corporation 4"3 TFT LCD panel
>        - qiaodian,qd43003c0-40
> +        # Shenzhen QiShenglong Industrialist Co., Ltd. Gopher 2b 
> 4.3" 480(RGB)x272 TFT LCD panel
> +      - qishenglong,gopher2b-lcd-panel
>          # Rocktech Displays Ltd. RK101II01D-CT 10.1" TFT 1280x800
>        - rocktech,rk101ii01d-ct
>          # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD 
> panel
> --
> 2.32.0
> 


