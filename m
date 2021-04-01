Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48A9351CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhDASTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbhDASBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:01:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9AAC02FE95;
        Thu,  1 Apr 2021 09:01:45 -0700 (PDT)
Received: from [192.168.0.20] (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D94A589B;
        Thu,  1 Apr 2021 18:01:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617292901;
        bh=9PpGK5DYSDHyjsBaiZozxLkq3MRlWpOKUyVcUk0phsM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Uiw4WeVEXPnxxHr7LLQidTggt4sWeyauxEFAhUcE0FUK7yFqCD2KdFq8rV2lw76U+
         gkiQAf9iyDxgO+JlkvUSWu9vQgIxmbPZXOwy0enYuP9Xrh4qz4q8Vgxrc2Yoag0hry
         2siBoSR0PL/6S54FPzmolSfRMU2WcluNHE9owqUg=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH 24/32] MAINTAINERS: update imi,rdacm2x-gmsl.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <b03a41b5051b6cb115b2aa9c3d610e75d84dcfea.1617279356.git.mchehab+huawei@kernel.org>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <aee4c49c-04f8-c553-63ce-868c46ade0e8@ideasonboard.com>
Date:   Thu, 1 Apr 2021 17:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b03a41b5051b6cb115b2aa9c3d610e75d84dcfea.1617279356.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 01/04/2021 13:17, Mauro Carvalho Chehab wrote:
> The file name: Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
> should be, instead: Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Fixes: e9f817689789 ("media: dt-bindings: media: i2c: Add bindings for IMI RDACM2x")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Indeed, confirmed,

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1644b6e9697c..b405ee71f730 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15258,7 +15258,7 @@ M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>  M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
> +F:	Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml
>  F:	drivers/media/i2c/max9271.c
>  F:	drivers/media/i2c/max9271.h
>  F:	drivers/media/i2c/rdacm21.c
> 

