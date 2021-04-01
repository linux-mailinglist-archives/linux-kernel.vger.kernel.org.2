Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5C351E74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhDASlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbhDASTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:19:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B543EC031142;
        Thu,  1 Apr 2021 09:37:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id i81so2368329oif.6;
        Thu, 01 Apr 2021 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMAsPGO6KHMaXJV1c7XmFTAteeel5n+TdsvM+DoZXYY=;
        b=i0l+2NcmEBlyy/ROf9cv+coomEMsgXfVia3f2a7y11ZDog1elb/h0OelTk+GNNpHQl
         erq+fQq9zkyZi0XP6N+A2rufvx8TwBHWFcojltglpSD/81Hvl3HlWa/plamnDN+c6hEg
         /LD7hmaxepMqMPpLUsNsU5GCBqK7MmNedGOEAWmptbn9knqoLRu3mlvqmoq1B500Igp/
         7qCiGjr6a8fs/w0jJzxdRiJPHCzZ0OIXFbONaRIf3s0UXe4BeAjHcUk8PYUTzI1E7f+W
         CG9a9QZElk8LPKKt5dV4X0t8AYVHHnYi/UpMeP85ySyNOhNw0g+pQkJFQruC5tMd0qo7
         tC/A==
X-Gm-Message-State: AOAM531oan1eTgn6QJnwpnHHR/PypgL2hD5y5SRSe7ANVkPFSOe3E5LQ
        5FloTp8ukKo9h+Ir3x8ppXXkyYvW3Q==
X-Google-Smtp-Source: ABdhPJxRZZ/7gbXG7ccAPufljlo8vDwhR8XiL5Yq3sseIy4zGTgiofKrzePcv1BaAmTLbUG1rovXig==
X-Received: by 2002:aca:4284:: with SMTP id p126mr6186372oia.178.1617295067179;
        Thu, 01 Apr 2021 09:37:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x18sm1261250otr.73.2021.04.01.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:37:46 -0700 (PDT)
Received: (nullmailer pid 572404 invoked by uid 1000);
        Thu, 01 Apr 2021 16:37:45 -0000
Date:   Thu, 1 Apr 2021 11:37:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 7/7] dt-bindings: clock: st: clkgen-fsyn: add new
 introduced compatible
Message-ID: <20210401163745.GA572347@robh.at.kernel.org>
References: <20210331201632.24530-1-avolmat@me.com>
 <20210331201632.24530-8-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331201632.24530-8-avolmat@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 22:16:32 +0200, Alain Volmat wrote:
> New compatible are added, supporting various kind of clkgen-fsyn
> used for STiH407, STiH410 and STiH418
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  Documentation/devicetree/bindings/clock/st/st,quadfs.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
