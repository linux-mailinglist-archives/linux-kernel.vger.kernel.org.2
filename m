Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFDD3FF551
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhIBVHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbhIBVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:07:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A08C061760;
        Thu,  2 Sep 2021 14:06:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d5so2261839pjx.2;
        Thu, 02 Sep 2021 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcUbkFpd1GGQUNeufnCep4XBgGZDKBrJJCE38qyZLp4=;
        b=cjYLyVsMx77HHxDdRL5InTnI5FyMDQAOOSKYvNZ8cUsgaiTUbVm7/VMnxB2ksYVSU/
         OV9tZBhvbHVGTOyPaSjOGarnc4M4MSqNf+TaRaxBYa9wt1QMINZVVKJoX4Y5Cx1qCd9F
         It872d+WS8Sq1rE4HNp/HFwi1mcVgDJ7j0dRZuS8i10wGslBwk7yqzhHSwCitnjmFVf6
         vI1fGZEvICifQJ71Bbde0db179yggx/D1RUptO8UNHNU83dA3d7qnHetYSV1N9e3ogfC
         w2L5+Myqm1QgKTvLXskla+zSZa6kIKtZDlsWnKyMgXmwBcNHIsbAjdvrHU+n2b3wLfZM
         VSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcUbkFpd1GGQUNeufnCep4XBgGZDKBrJJCE38qyZLp4=;
        b=arUV0jMwfwg9dgQNJeCoIfUd9Jc4IMNdglOEWNxuxaQDOd7SYmJA3golWaWhXisKVl
         /ZfeqH9GlOYn07GI7IBJ7U8ePOKORcER25KOjC0HfC6dxWoQYdnwPeeo2ceYmnqqpT9T
         ytZb1ERlkM5frBgJb8ERL7s1Hquyqi73Jt7xO1QWx68vfkZ2/qunvCvqOaTx6aVtfnwo
         PXEf287T38vZAgKYmiTnI2PvdWsa4ZGUD6mGzzHVbqfE+0JlW/qHJUSEEhEGmtQKnsjz
         S6xLsxrYMQS3bQSw2FI0RYn+Ts5gT5plND4ZghGFkPTEKSOM5+j8Jznw6TdIHHTL8Iz6
         rSXA==
X-Gm-Message-State: AOAM530/d5vpxHxbk4IE/tIR4zF/QddHsbQOGt6yMv/PihnYAp2f+1Cu
        2CSCihE7oMeTfFgObGgCCE8=
X-Google-Smtp-Source: ABdhPJxs60Xc8WrcB2TZAoVjvUE0aFZVSF4iBMFVtH9pK4yHT66CZqLXnAIjk+Ave7tXWTLamkrEZA==
X-Received: by 2002:a17:902:d2ca:b0:13a:8f:42ce with SMTP id n10-20020a170902d2ca00b0013a008f42cemr112120plc.58.1630616768490;
        Thu, 02 Sep 2021 14:06:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e16sm2934444pfc.214.2021.09.02.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:06:07 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: dts: NSP: Fix MX65 MDIO mux warnings
Date:   Thu,  2 Sep 2021 14:06:06 -0700
Message-Id: <20210902210606.3103191-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829223752.2748091-5-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com> <20210829223752.2748091-5-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 22:37:51 +0000, Matthew Hagan <mnhagan88@gmail.com> wrote:
> The naming of this node is based upon that of the initial EA9500 dts[1].
> However this does not conform with the mdio-mux format, yielding the
> following message when running dtbs_check:
> mdio-mii-mux: $nodename:0: 'mdio-mii-mux' does not match '^mdio-mux[\\-@]?'
> 
> Secondly, this node should be moved to within the axi node and given the
> appropriate unit address. This also requires exposing the axi node via a
> label in bcm-nsp.dtsi. This fixes the following warning:
> Warning (unit_address_vs_reg): /mdio-mii-mux: node has a reg or ranges property, but no unit name
> 
> [1]https://patchwork.ozlabs.org/project/linux-imx/patch/20180618174159.86150-1-npcomplete13@gmail.com/#1941353
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
