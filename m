Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DA394212
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhE1LnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:43:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:29196 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhE1LnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622202043; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iKtHjZ/rofYuairfVqHRAd4Wg7JbXco3Cm/ai/WlXJ2otA5KCVxugkLGGc9+E6j/9u
    RWXUWl1TlMM3jlf6LjpAe9a2VM1O3qOBTQjdvQs4SUq/cUq3ZroWD4brdTOrZZRpfZR6
    SWNXNYPar19BI3dfkUU6SgVJcTFsF7mc4LbM4wIFoZ1Q7hMHRoFGbbXeFHybB0F670sV
    y68wi6Dr3vi0sqp/sQgfonkzZyLwrw5rOjC97QDEIfVlZXa3AsBrydkZCQRjs+He3WTh
    LVEgRV5vEO4hoOlI28XvpwnwEnHtcpwZRHkr20X0sgQEn45fF5Fo+uUxXfYq5F7AR6ab
    jtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622202043;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fv9ibB0sf+3bWaxRtLUVQh+LAQVhcvJ61+bnxcNARI0=;
    b=M4/IDH3Zs3jZsL1pedVlWNN1kc3F6HfoWjFs8948vpaHb73OJcgcrFYyWtqdi3Kk0H
    rodYl4zU0PiMn/lSAVfzwyxFdBOjlaRNwJLL8cDe+QRL1b7EvFXpSPpNCTTLThOdBMlU
    Zm9R9+6XcYp6JKIXNoR3FZcUm9SvJ+ulYlziEH3hGnrI2Gp8jXtIcZvegmjI1vEZteqB
    WwL2cYuyUq/VFzdQDkBBCXasQwMgJ3cxx5NtaoPDqbV9TbirsRA8DewV4v9KS+WwK5+I
    ksehurSB+u6VFklM5uDi1dR/SxJkqle3JV2kfMhkmQnG5gOfzmeuIB4nAsM+RZQYS/jG
    VAKw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622202043;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=fv9ibB0sf+3bWaxRtLUVQh+LAQVhcvJ61+bnxcNARI0=;
    b=f+7LYe/4CP15pC9erHlhpmP0giYpKtUDRceqOcaAWWe0EFiJUdvvoQ4JAVW9mYg5rj
    mk5XGQKbiYhO98vPS9PjtlKVYqciiWWm9x3771OeTazE7Lm06iR5DX/lhZU/AsOgY0Xs
    sUF8OdLTt7jrp2RgVEibGlLqhtyqC02UhfglxuBfKWOK2suxD3aebHvLVPhqeqXpzgV3
    SP9w+MaZtZ5MrCprNlmQOgrQl7jmGlCXpLcTDfC2sj6KxTTgu9/gxMUHYZErbtHJWA7c
    sZx+WDY9UAkJOQhgr/1wOm1cMfmYW2CLbjob+ddizDkX9ZlLH20uhkZBsy7hhn2s1QFF
    irDQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczFY4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id U0b2c9x4SBeg626
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 28 May 2021 13:40:42 +0200 (CEST)
Date:   Fri, 28 May 2021 13:40:35 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Mark Brown <broonie@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ASoC: dt-bindings: nxp,tfa989x: Add tfa9897
 support
Message-ID: <YLDWs2iz2CWbznkA@gerhold.net>
References: <20210528105101.508254-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528105101.508254-1-vincent.knecht@mailoo.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:50:58PM +0200, Vincent Knecht wrote:
> Document TFA9897 bindings.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!
Stephan

> ---
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> index 45db5776550c..46ddc1f3fc0c 100644
> --- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> +++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      enum:
>        - nxp,tfa9895
> +      - nxp,tfa9897
>  
>    reg:
>      maxItems: 1
> -- 
> 2.31.1
> 
> 
> 
