Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B42325B63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZBx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:53:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205AC06174A;
        Thu, 25 Feb 2021 17:52:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s23so5166389pji.1;
        Thu, 25 Feb 2021 17:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+5ckLxtZN7g1f4bK7OAcWwoHeEDxsTCLl40t/qcq+w=;
        b=BcBntO6NCR6zKCefLRgrDot6YvgESzT9dhwz4u3tYcRq3/EdR64wzKWw3wKV1dGEEE
         X7UWbO0HlrI74MiQ6XZx3sQSv6OaPKn7sCyA12BK1mz37ePO9myHqEIwv1keuLGIA708
         zHssmlY8swwxmaE/rsH+GvNYPV/BlFgyf/YXFmNKKZdTiC+acUCLrG7YGX8EAumOEtyg
         OjlGB+Ptt9vH3ommMDPV9UfiSW/B1fMEwtZmdfzXcoj/eu5CKO5eV+M80iHTkT6DZjZY
         dYVRDoXDDSH4fmTzWz1v9sHRmmBqgv/sBN4qE3espery4kLsjKV2Fs8dXXTaEkqIPi1L
         xn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=n+5ckLxtZN7g1f4bK7OAcWwoHeEDxsTCLl40t/qcq+w=;
        b=sidwUOlbhTx74yhykHww6mQxfjDywepZNe7m8y0g7/rj+evqQVdpNCZWiU21BWS1MX
         BdcdEsdv5nzGXkM3GCq65W2x9QryvsSOdD6Hik1lzl1hjkBEyrl3dY5CNRB/hJpJlHP0
         53siegwhUbGZgir725k5Lrm9S1jEu8G6LFaBWeEdlwuJQnfd46R7J7SJSd9cS5D8l9Cv
         04qxDSgyautmiX4R4qEda92OUzSNF0sHEhejV3Px52P9nM2CgdfiZHUDazJpknvTMqaN
         dElivRHp8HygqUfXi2XyJUSd+86nwfPB/jkc81V0t03wRSQeupu86gj0gwz+qVKxVCPV
         fKvw==
X-Gm-Message-State: AOAM531n8jfxGCbsMPlMt7PPsPtcOVJ4oDm3hqvkLFMcQHAShISsKqkO
        b6DDL52OzO3Coax+jC9iE2U=
X-Google-Smtp-Source: ABdhPJybLEnspD16K522FWBRcvW4qzlNfHZFu0Ehrxl4fUxFJ1DV5zzqPcwq5sP+EIQUXGX1qR1TYg==
X-Received: by 2002:a17:902:7c83:b029:e2:b157:e25c with SMTP id y3-20020a1709027c83b02900e2b157e25cmr718399pll.32.1614304364176;
        Thu, 25 Feb 2021 17:52:44 -0800 (PST)
Received: from lenovo ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x123sm4546021pfd.24.2021.02.25.17.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 17:52:43 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:52:37 +0800
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haidong Yao <yaohaidong369@gmail.com>
Subject: Re: [PATCH v2 0/3] Fixes & a new supplementary feature to SPRD
 mailbox driver
Message-ID: <20210226015237.GA2610@lenovo>
Mail-Followup-To: Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haidong Yao <yaohaidong369@gmail.com>
References: <20210213122143.19240-1-orsonzhai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213122143.19240-1-orsonzhai@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Sat, Feb 13, 2021 at 08:21:40PM +0800, Orson Zhai wrote:
> Fix a real problem fot SPRD's mailbox driver in patch 1/3.
> Add supplementary inbox support for newly added sc9863a in patch 3/3 and
> change dt bindings yaml accordingly in patch 2/3.
> 
> Changes Log:
> V2:
> - Change patches order. (Yaml go to the head of dirver)
> - Remove unnecessary initializing refcnt to zero. 
> - Add fix of possible crash caused by NULL of chan->cl. (Actually move from
>   changes to sprd-mailbox.c of patch v1)
> - Remove unnecessary "inline" for do_inbox_isr().
> - Fix yaml errors from Rob's robot checking.
> - Add sc9863a compatible string for real supplementary inbox usage. (sc9860
>   is not supported by supp-inbox)
> - Add more details to supp-inbox in commit messages.

Do you have any comments about this changes to v2?

Thanks,
Orson

> 
> Orson Zhai (3):
>   mailbox: sprd: Introduce refcnt when clients requests/free channels
>   dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
>   mailbox: sprd: Add supplementary inbox support
> 
>  .../bindings/mailbox/sprd-mailbox.yaml        |  18 ++-
>  drivers/mailbox/sprd-mailbox.c                | 135 +++++++++++++-----
>  2 files changed, 117 insertions(+), 36 deletions(-)
> 
> -- 
> 2.17.1
> 
