Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093673EBC41
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhHMSzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:55:37 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42741 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhHMSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:55:35 -0400
Received: by mail-ot1-f41.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so13161279otl.9;
        Fri, 13 Aug 2021 11:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgYDaCCAVB+2In14a1kG5iiSGAnj8Z0BlZoSrQOooJs=;
        b=gaDT+3bYD/zDK+W0Sd4DLRWAT2BRaie2I0Hx9mpy+WvfLtLVOQg+op1VHJWfQCOnQZ
         VEAPqPnn4qpARpC2JDMM3eDIbzeH1ZdEqWMnoQ9qdMRRFk/0ddNK6+SxNmwZmmBFnEV+
         qDkycbs4GgNQsFoDUwa7KplI4SnY5sJHcBuc+BoNSID+bCnXntgr3ifJ5mjSS5yeS31g
         t2m86S5gYNzBZvc/lVdf251xS6mZCzjT7SjMrfDl6EBPC2q3tfW/XyOApkK9XEJoP1jq
         FkAJv9eEiYer5pPCZcixS6XFG5PKcH+NA4C+zwlQH41RX07Bvzm5ER0+twirRHVIaygj
         Ml1A==
X-Gm-Message-State: AOAM530zKDiEjTEysVMFbaR5qtrc0FNq1iu2u+36YwrlwzSpmV4+6Ohy
        /yoeYeTvNiWFZyVfrNnxCw==
X-Google-Smtp-Source: ABdhPJwxmdmo6xRjRihAW2AtHQF9dDvG9ZJaa+9boQ+XVewLk7MSFFS49dAeSXvzPiaFF5dc7aHLPg==
X-Received: by 2002:a05:6830:1f54:: with SMTP id u20mr3256501oth.320.1628880892451;
        Fri, 13 Aug 2021 11:54:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r2sm522068oig.1.2021.08.13.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:54:51 -0700 (PDT)
Received: (nullmailer pid 3858276 invoked by uid 1000);
        Fri, 13 Aug 2021 18:54:50 -0000
Date:   Fri, 13 Aug 2021 13:54:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: power: add rk3568-pmu-io-domain
 support
Message-ID: <YRa/+rrW3ciW/tJf@robh.at.kernel.org>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
 <20210805120107.27007-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805120107.27007-2-michael.riesch@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 14:01:01 +0200, Michael Riesch wrote:
> Add binding for the RK3568 along a SoC-specific description of
> voltage supplies.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [add soc-specific section]
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> v3:
> - add missing compatible for the rk3568 to grf.yaml
> 
>  .../bindings/power/rockchip-io-domain.yaml    | 30 +++++++++++++++++++
>  .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
>  2 files changed, 31 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
