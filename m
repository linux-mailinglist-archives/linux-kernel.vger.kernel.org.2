Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D023F68B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHXSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:04:20 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38471 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhHXSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:04:04 -0400
Received: by mail-ot1-f44.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso37139533ots.5;
        Tue, 24 Aug 2021 11:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pzcR6KfvbOWTe3o73soBGsabxlr0DD0//iL4Tmb4lKw=;
        b=KNuOiNgN5uu9w403gOxaMH3ok6i0TRY0LIQwFYEbdY89Iugv341B5tgysKBxPMWJsO
         YJ2ZVrssR7IyMsTB5iIWy1juvX1YTb9SjqgrcAsvUPVU7zhYl0Rl6/9fAJ34lQmVel+q
         eUjSbPUj7fDvkzZR8kbpmnx0iqfvdQEvGpfx6chUYCQCSSeO22+CwHE0cxAPB/4WcdAV
         HuAUkQ+X3UYF8ln1KWKgWehvcjMvslPSysrOJEPRv9FjXZRY8zVxlbRATRVfK7NsKBJJ
         PrAVTCWB6t+9Is1GklR5Af3MqFlW6K3+2hKepDgj8Gk93EwAHWgQFwskgGiggy7POe1r
         8E9Q==
X-Gm-Message-State: AOAM533S2ieK60PLty+eQAzEiBQDnUuiDBqY1jQu/xHlLOPUhPPJxonh
        7Tjb0aW3eXnxVSFfuWm5pA==
X-Google-Smtp-Source: ABdhPJwUCQ0B+E1Lp9msS+XzKTGdquG6FeiXzSimbNOU3cWCcnsa1SXe0WgxlpKbAWQKc3CrIlWVKA==
X-Received: by 2002:aca:bfc4:: with SMTP id p187mr3742944oif.21.1629828200154;
        Tue, 24 Aug 2021 11:03:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bg9sm4676161oib.26.2021.08.24.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:03:19 -0700 (PDT)
Received: (nullmailer pid 726225 invoked by uid 1000);
        Tue, 24 Aug 2021 18:03:18 -0000
Date:   Tue, 24 Aug 2021 13:03:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 4/4] ASoC: dt-bindings: rockchip: Add compatible for
 rk3568 spdif
Message-ID: <YSU0Zk5LpSX9xZG1@robh.at.kernel.org>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629800162-12824-5-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629800162-12824-5-git-send-email-sugar.zhang@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 18:16:02 +0800, Sugar Zhang wrote:
> This patch adds compatible string for rk3568 spdif.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
