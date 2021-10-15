Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C722342FA76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhJORrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:47:14 -0400
Received: from foss.arm.com ([217.140.110.172]:46684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237319AbhJORrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:47:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6344B11D4;
        Fri, 15 Oct 2021 10:45:05 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA7CF3F70D;
        Fri, 15 Oct 2021 10:45:03 -0700 (PDT)
Subject: Re: [PATCH] ASoC: dt-bindings: rockchip: i2s-tdm: fix rockchip, cru
 requirement
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015143115.1445707-1-frattaroli.nicolas@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8553b0cd-95e4-c3db-c75a-d3b28e99f131@arm.com>
Date:   Fri, 15 Oct 2021 18:44:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015143115.1445707-1-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-15 15:31, Nicolas Frattaroli wrote:
> The behaviour described in the bindings is exactly the opposite
> of what it should be, so this patch fixes the description and
> adjusts the if conditions for adding rockchip,cru to required.
> 
> Fixes: 510f1c133aed ("ASoC: dt-bindings: rockchip: add i2s-tdm bindings")
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>   .../devicetree/bindings/sound/rockchip,i2s-tdm.yaml   | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> index ce3e18b50230..93f5221e9381 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
> @@ -86,7 +86,7 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/phandle
>       description:
>         The phandle of the cru.
> -      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
> +      Required if either trcm-sync-tx-only or trcm-sync-rx-only are specified.
>   
>     rockchip,grf:
>       $ref: /schemas/types.yaml#/definitions/phandle
> @@ -147,8 +147,13 @@ required:
>   allOf:
>     - if:
>         properties:
> -        rockchip,trcm-sync-tx-only: false
> -        rockchip,trcm-sync-rx-only: false
> +        rockchip,trcm-sync-tx-only: true
> +    then:
> +      required:
> +        - rockchip,cru
> +  - if:
> +      properties:
> +        rockchip,trcm-sync-rx-only: true

FWIW, isn't this just a long-winded way to say

   if:
     anyOf:
       - properties:
           rockchip,trcm-sync-tx-only: true
       - properties:
           rockchip,trcm-sync-rx-only: true

which itself could still be more concisely

   if:
     not:
       properties:
         rockchip,trcm-sync-tx-only: false
         rockchip,trcm-sync-rx-only: false

?

Robin.

>       then:
>         required:
>           - rockchip,cru
> 
