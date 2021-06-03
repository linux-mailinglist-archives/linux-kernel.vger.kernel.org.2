Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BEA39A970
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFCRpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:45:22 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45758 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFCRpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:45:21 -0400
Received: by mail-wr1-f44.google.com with SMTP id z8so6663737wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=okckV04a+Y2elinebUcRRfGaPp6ssJZ3DbsuQ4OOgZ4=;
        b=tsS3eP6hQWuKt4hjonfExiQ1dz5OpJGYMw24ZEG6/qCpMjO5JmP5xZvJqB1CnoIrDI
         UQS3hXYmN+3IZkQ/i8I+HuoChVvN7J1GAzO5PMTNUxdMcGzns9zQyWGIK+o60zKYStCo
         b4EoI/hWhgb8aEpjB8vflkLJpD9PZM90pTOznyAFCJRQAapHsqNHXTjj3Zwrkf/hxMcE
         6dJtjU0om9hKLSSXOJqQe0LrXF8zgyumf71Iw2suD1GeQp5GAZEeQjmrti160pOT1qzg
         j2bEvg7UHevy05w/c1aSDP4FAgf8k6mV1+vcD3Q1xe5BO9yQHwojWuOaHXdkvZ4wkFA+
         j8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okckV04a+Y2elinebUcRRfGaPp6ssJZ3DbsuQ4OOgZ4=;
        b=bXgIY5bLqr/WiO2WpbDvWsq/O08Qw9aBwjA5ZOHs97a/JGH4zQOPjxKJLCSo1bNUjr
         fk+EOJAfS6RynuDYpWTVPcNF2ZVuMtjcMG8HSVnNkHekgxajEkkKpuk/7DuX/g1NwPT1
         qnj6EcCunzlj13X//ipmEQl2WwELdbYY95/rx5waCSXpjIBfkuStQhr7lAXFFxxeolWm
         nyNtlhGEMHdBKmPM0TJE2HWpKDiz04ydhzCrXeVZR5isLKblZLDndz6EUHB5GZb/T+gK
         1w1fpj831RGOj2wEkEmNfQXgJRrKvef8x0u373u2QRR8PAL/sifDghmwe8EfaWtzUCsn
         shsA==
X-Gm-Message-State: AOAM532hGI9D8s1Xyr2k/aWycWcXgJQtludR9YPPQwjOGuDr+i4yUNol
        0rDtA8CT0QHyW/xZu6PzQNtbrP6S8a4zCQ==
X-Google-Smtp-Source: ABdhPJxc8GBv5MWHwNdKUo9Ass5iXG8Y4dR3LXh2wRU11oE/YZ060aGOdU14D3PwAAWiNpY6YH+IFA==
X-Received: by 2002:adf:ec43:: with SMTP id w3mr148203wrn.270.1622742143250;
        Thu, 03 Jun 2021 10:42:23 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id h46sm4728578wrh.44.2021.06.03.10.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:42:22 -0700 (PDT)
Subject: Re: Add PMIC wrapper support for Mediatek MT8195 SoC IC
To:     James Lo <james.lo@mediatek.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210602112050.12338-1-james.lo@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <2b569103-4c35-8096-a0ce-1b7e5939cf7f@gmail.com>
Date:   Thu, 3 Jun 2021 19:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602112050.12338-1-james.lo@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2021 13:20, James Lo wrote:
> This series adds support for new SoC MT8195 to the pmic-wrap driver.
> 
> Henry Chen (2):
>   dt-bindings: mediatek: add compatible for MT8195 pwrap
>   soc: mediatek: pwrap: add pwrap driver for MT8195 SoC

Whole series pushed to v5.13-next/soc

Thanks!

> 
>  .../bindings/soc/mediatek/pwrap.txt           |  1 +
>  drivers/soc/mediatek/mtk-pmic-wrap.c          | 35 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> 
