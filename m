Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC3316BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhBJQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:48:34 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38483 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhBJQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:48:05 -0500
Received: by mail-ot1-f45.google.com with SMTP id e4so2388550ote.5;
        Wed, 10 Feb 2021 08:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=adc+2nnIR7t1ejzx3W6cWVT9M1mXeq25Jq+T/s+mbV4=;
        b=MUaJMoMz0uwfSlLGz60dOxalvkmapIayNDYiQ3lNWXBzz1PwzbpfsBLwQnIGtH0To8
         tIU+PX35CPKCoZn87l/yc/BQs3wiPgMnddEJB+QDrFxUzUqJlxq+n2WXGZ70d/u4B+4c
         5rVOnMOQ6UN4DdiDmcpSOaSltRtGs2iNvuq8rV/Cg3dI53AyZZDWm+Z8FeXoXHvpb4Gx
         BygSR1801Im4wwRDAKMTHM6oe8b3DGHmSD2WvIG9y9ap01y7/g+mFv67ryx6TrYJRmPR
         psyZF27KOVKxWJZxUu/OWcRJA7qcyNwNw2Lzp7rkNa79Ont6w9P9nngN5gXjqiIK82Qw
         PdDw==
X-Gm-Message-State: AOAM533ud44iWOJ6lrBET6AphN9+AlujuzF7ir3Y5u4JXSKfj5deQPD7
        mFU3BlNtpNyPbNcxcf4WhA==
X-Google-Smtp-Source: ABdhPJzDBx6iO9hFxjii9+Tc5ZPdKtL7/LaOdiPcwmllkri6r4LtMp26ANi5eTLgATXAnBb8PjSItg==
X-Received: by 2002:a9d:2277:: with SMTP id o110mr2841529ota.30.1612975644823;
        Wed, 10 Feb 2021 08:47:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm567977oif.9.2021.02.10.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:47:23 -0800 (PST)
Received: (nullmailer pid 2308105 invoked by uid 1000);
        Wed, 10 Feb 2021 16:47:22 -0000
Date:   Wed, 10 Feb 2021 10:47:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, drinkcat@chromium.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: spmi: modify the constraint
 'maxItems' to 'minItems'
Message-ID: <20210210164722.GA2308044@robh.at.kernel.org>
References: <1612675154-2747-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1612675154-2747-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612675154-2747-2-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Feb 2021 13:19:11 +0800, Hsin-Hsiung Wang wrote:
> The constraint of 'maxItem: 1' might be larger than 1, so we modify it
> to 'minItem: 1'.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
> changes since v5:
> - update the constraint of minItem to 1.
> ---
>  Documentation/devicetree/bindings/spmi/spmi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
