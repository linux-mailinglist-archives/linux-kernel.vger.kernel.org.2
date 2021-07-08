Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2909B3BF7C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhGHJuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:50:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35089 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhGHJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:49:59 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m1Qcm-0007PE-Dh
        for linux-kernel@vger.kernel.org; Thu, 08 Jul 2021 09:47:16 +0000
Received: by mail-wr1-f69.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so1719069wrc.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 02:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqWyNGudVuElSm2fjSw0fUVrxrGpZuSoG0yfc9ufVeY=;
        b=AZ9cgO9cdFAFiJyxIqVePQ5HePOYwCljunutpL7ig9v2tDFdBGXmUjjXSq6Lvjkd79
         1l49JO2qWliRANUQ4wxEqWKhZh1fF907oyNJv8hKS/LFSoSszS86+DMDuTJLuW1w1Sga
         dSXOfpx9+Y5J6SUmuA5P1K3qLji0wNqwouQLsnjybs4WgwpBvaOf/mT7S0IGIhG+yTBY
         FXZ78j0k7viqY/Qj4AxwkgxgFnK201AZOkTr+TiFc0wldx4wqIJeKF4kT/vNTCb4atbm
         430g4uDziTpcxNGdcfdk/4KMNwU2izgt0jwR9vYdQvn1OF42PPPeVJgs0gIqk1gGbgdG
         H1Fw==
X-Gm-Message-State: AOAM530hQmQ1tgI96401YNgEkoB3ZqfASgC+T8BNjd4AfyKnLIFxRn3Z
        So6jSV55G+7MuNvm7th6vqHaUGwGExi7OM5f9FxzUlvXhahyEnpW3Q2OSwOSGV48kkid3jlnzS3
        lOIA+GqPQCgLFfsGkOKpgCqCoCsVOC2cZ51seWQmIkw==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr33862434wri.348.1625737636226;
        Thu, 08 Jul 2021 02:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA3YilHPZ1h4YN/boLpRhydKgVWfFWvPY1mi0CfKNUCFbOLg+vcpMYWAsmGhdef7F2n7aCtg==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr33862416wri.348.1625737636070;
        Thu, 08 Jul 2021 02:47:16 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id d24sm8936115wmb.42.2021.07.08.02.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 02:47:15 -0700 (PDT)
Subject: Re: [PATCH 6/9] memory: mtk-smi: Add smi sub common support
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-7-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f5df9d97-b883-2786-dd9c-d4980e1d70d1@canonical.com>
Date:   Thu, 8 Jul 2021 11:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616114346.18812-7-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2021 13:43, Yong Wu wrote:
> This patch adds smi-sub-common support. some larbs may connect with the
> smi-sub-common, then connect with smi-common.

Please start sentences with capital letter. This (similarly to "This
patch") appears in multiple patches.

> 
> Before we create device link between smi-larb with smi-common, If we have
> sub-common, we should use device link the smi-larb and smi-sub-common,
> then use device link between the smi-sub-common with smi-common. This is
> for enabling clock/power automatically.
> Move the device link code to a new interface for reusing.
> 
> there is no SW extra setting for smi-sub-common.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 78 ++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 26 deletions(-)
> 


Best regards,
Krzysztof
