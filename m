Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443DA305916
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhA0LCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbhA0K4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:56:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F3C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:56:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so1220214wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5ZypdbGue2nFWiMnP3sDxiiEiuMQbxRDc+4h+Q/e794=;
        b=pNrZuakhy4nMglczzFTxUJnnX/9b0g7MGkGsWCJ84IeQcC8u2mhBI+a4Wcw/p1b4yH
         4JCC3dw6bgLAiAQljagvI4VsBiR+Usw6qrCYpm+VaPyUh+L60ix3fmTqRQwsrll6ZwHQ
         AcOKpudZCn6/StlgzEnqWKLmuEG9Pv+bCqc1iX5lfrj5KUT6LSnH3d4xFpojxm+eqzh7
         fCJ9vFjx4V5ka9riCsTNExqUB4jP4x0qNDUMkisfVsLICGXn4TWmw3GPDzhNH7F39iYX
         Nv5SRtpENSirwyBD+YR7NcFCr8zp8EE+jG7PyuxlHKDbLA9+jti28l6gOwRhYVZyH7ZR
         kwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ZypdbGue2nFWiMnP3sDxiiEiuMQbxRDc+4h+Q/e794=;
        b=eVtg0feoNyNON1P8ifPmDU7QKQOWdL1ajKtuckykwRCW2y8/pFvBi2g9X9KW2KWs4M
         l6comsOWFvqVp6bpnvdeI6W2GF81GQYnakILdc4V/rzQ0L9S+27Yt/p42VYo9iQedS+M
         iN4We8DgaqatyRIf1i5myJwquOvmn4CSZYfeEhwi7er9zN7JFdXSjST5viKPu0cd6rIC
         F6VsxRzcYgQKcUzP2jUDn+K6ebzJLVAJs56IIDDX5lVXeAHQtxNJoQIFfBQEDN0rjQ+G
         tEMOhoVnfviudKzKwpV7TiMtAcOea1xpQ+zOoJk4TGPqAuJf9kVb6Os/JiBq2CxqodiE
         57uw==
X-Gm-Message-State: AOAM533Xu7B6kxkKmiM6Ue0Z0NZQ2UnjAd3XNyrcTiK4Tk7/WZI6Fcz7
        p5v+GrCU2Qgqx6WmJ61JOgySCE4FlNSzig==
X-Google-Smtp-Source: ABdhPJze1zv39dN3foB3pelQvWpQEDLYXG7Q4xIRAOPF4Qy58C+fieDmIVrY+Znepr5x1AX+M8whVw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr3651337wmp.156.1611744966607;
        Wed, 27 Jan 2021 02:56:06 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l11sm2375202wrt.23.2021.01.27.02.56.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 02:56:05 -0800 (PST)
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: Remove bit clock state check
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127063038.1399-1-srivasam@codeaurora.org>
 <16199fa8-7a87-6e7f-9db6-1d5cd8493d4c@linaro.org>
 <d33fd359-9dbf-b03c-ccd1-d93c7d207ccf@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0bdf2a43-799b-1c89-940d-8dd0f54ab24e@linaro.org>
Date:   Wed, 27 Jan 2021 10:56:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d33fd359-9dbf-b03c-ccd1-d93c7d207ccf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2021 10:54, Srinivasa Rao Mandadapu wrote:
>>
> Actually this is MI2S OSR clock disable on failure of bit clock enable.
> 
> Do You think it's redundant?
My Bad!! Just ignore my comment on removing this!

--srini
