Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972FD34F3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhC3WDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:03:44 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44547 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhC3WDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:03:41 -0400
Received: by mail-ot1-f53.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso17016328oti.11;
        Tue, 30 Mar 2021 15:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kT3zV71FJ+KWr7wDc18R/r+VQdMcPYEV3G2c+81a2Jk=;
        b=hS3Et4u4j1B0Oa9dHBHFv5NLGFT3o+oMFm+qm7SkpXGk5J3scKNe6V7W39jqh7JF8V
         ts5c5cdZmyCdI05GmqFfljx6YUX4NDZzV8/4ZnW2DsAgwSTLRTTejrARwv0TSKpOvCu0
         U3uns5O1tSm3DZybT/n18d2JeCHk6xDpJ6PXy5VbrSuzWGUwiwU/09I0iEkEkTyaa79Y
         x8vSXqliwYMBOlGpFD0vb+R0T3OSVOSkafQuGpt1OkYpQmi8/D8OpIPwF01xMnUnfNeO
         HX3ZKmswJmIZ3IFROKfpH1pgfQHqbtfqUszkdbRn+VD60v39TuvpMuoPgQPm/C5AWEwY
         O1tg==
X-Gm-Message-State: AOAM532pz8WU9CGxW7BKDOFq0eu6/yK+A+ijT2a4FaUWT6ADs1gkw83T
        e7RYDRWJqA4ULSeUU8LalA==
X-Google-Smtp-Source: ABdhPJyh2I7htYL3QyX1DObBLG3JvR3UrFCpUcE/E4wzSOKe1drGK80ocIqUyt6nVh4CFLt6ehNY8Q==
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr41666otq.107.1617141821156;
        Tue, 30 Mar 2021 15:03:41 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c9sm37793ooq.31.2021.03.30.15.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:03:40 -0700 (PDT)
Received: (nullmailer pid 794287 invoked by uid 1000);
        Tue, 30 Mar 2021 22:03:39 -0000
Date:   Tue, 30 Mar 2021 17:03:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/1] ASoC: intel, keembay-i2s: Fix a dt_binding_check
 warning
Message-ID: <20210330220339.GA794236@robh.at.kernel.org>
References: <20210329081435.2200-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329081435.2200-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 16:14:35 +0800, Zhen Lei wrote:
> The property "dmas" contains two items: DMA "TX" and "RX" channel,
> Therefore, its value also needs to be written in two parts.
> 
> Otherwise, below YAML check warning is reported:
> Documentation/devicetree/bindings/sound/intel,keembay-i2s.example.dt.yaml:\
> i2s@20140000: dmas: [[4294967295, 29, 4294967295, 33]] is too short
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/sound/intel,keembay-i2s.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
