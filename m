Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226DA43BF71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhJ0CSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:18:05 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42612 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJ0CSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:18:02 -0400
Received: by mail-ot1-f48.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso1478755ota.9;
        Tue, 26 Oct 2021 19:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4e48CX0qvtEmKBUWQL7AMrMjdEX7VZo66I22J7xcWhA=;
        b=Nt6GaM/Pv39VUGRbSozFgdRFUUhixZZm+2qABvt9zs2/MpQJg8jbueouxZR8lQujj9
         2gTII6yKxJp734X4lH8oRMnlPNgdNEozs7v2N2WlIE7Vgrq+LRSdvq6+51ruJ3BQxvgo
         5I9yzVMudUo+oaGeEnHiPui94iwAikeGgeULYztZ3dGNg/WQm0ROS8Hb7RawPeY9p3j7
         rGt4eZbTuODgMKPyvbZFBWXRlLndtKx7vhJCNDrxCbAa19thhwVTez7bBnRKRzZ809u6
         Z4QjOUu6hxvngaw3WlHcCtDbJNMBvYiH3b1w+FaHKISHigAe9lbDDeM002hq/PBAURWl
         S6hA==
X-Gm-Message-State: AOAM531rAb8DsaZNuapcxkxaXNwFWMt9eFRLWj8aNNzCTxk/PO6ETJ1J
        xP61YF1F+kOV+aKdB/PxgQ==
X-Google-Smtp-Source: ABdhPJyChzGuvY5bqBc8KDyGx9en8XmDx9zzO4Uf41ZkubxMcyZGH6scuTsDj6Yr361N81N/JssaGQ==
X-Received: by 2002:a05:6830:1c2f:: with SMTP id f15mr23060547ote.63.1635300937707;
        Tue, 26 Oct 2021 19:15:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f10sm5521224otc.26.2021.10.26.19.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 19:15:37 -0700 (PDT)
Received: (nullmailer pid 3809599 invoked by uid 1000);
        Wed, 27 Oct 2021 02:15:36 -0000
Date:   Tue, 26 Oct 2021 21:15:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Benson Leung <bleung@chromium.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: change naming of mediatek rpmsg
 property
Message-ID: <YXi2SBjJin9Nw1Rh@robh.at.kernel.org>
References: <20211018115111.14096-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018115111.14096-1-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 19:51:11 +0800, Tinghan Shen wrote:
> Change from "mtk,rpmsg-name" to "mediatek,rpmsg-name" to sync with the
> vendor name defined in vendor-prefixes.yaml.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
