Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14E63E97FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhHKSxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:53:51 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41803 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhHKSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:53:49 -0400
Received: by mail-pl1-f180.google.com with SMTP id e15so3875602plh.8;
        Wed, 11 Aug 2021 11:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06qEygJLTx39dSgIqgtwE46EcOnHTjW1rAqvEK4oK0U=;
        b=o/22w2xtrGZZ6EJABGZ8LPjpDidUHDLyaxuBZB19gCKopDGVk5kZ/nBdtzwNw8QF/K
         TN1zhO4zREwV2ESIVV2nj9gKo3GbUtQwQI8mbdtK3Fb1TXVfzqE7cSvxwzo3jtfx2W/a
         xIOhXEQ6dU+7PmVCgTNkMRG5BZYxz7yHYmI1yge9bWUSoIH2cAwW/RsLiETvsC3Qibqs
         8yIUf/WxbMyg1cHUO6cItjnsa/vZibXZHXjlUpKY6nDER8bMas63qQcKhyJnNsfiJ6SI
         7JXtNrGqbyrIbW+jCMHeKYhJjRnbEtKF+Brl498h391o5K6aG3+5k8Jc4xYQpoUTpirz
         ZDrw==
X-Gm-Message-State: AOAM531/0UsvCr/MuOpOMS6hcHO6CIk+uDcg1HfAh2YlE++UR7LZBl+e
        c2ZvqelSJVeFYfEKCdqC1w==
X-Google-Smtp-Source: ABdhPJwzpBJ1ynaRsE7+HKXnfeFz0YJ0Zr9leVRMDLimx0O+ThxMCysCraSCWxOuhZEfzKK92jq4YA==
X-Received: by 2002:a17:90a:150d:: with SMTP id l13mr66203pja.93.1628708005765;
        Wed, 11 Aug 2021 11:53:25 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id u27sm262625pfg.83.2021.08.11.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:53:25 -0700 (PDT)
Received: (nullmailer pid 89551 invoked by uid 1000);
        Wed, 11 Aug 2021 18:53:20 -0000
Date:   Wed, 11 Aug 2021 12:53:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        punit1.agrawal@toshiba.co.jp, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: Add DT bindings for PLL of
 Toshiba Visconti TMPV770x SoC
Message-ID: <YRQcoD6xhxCf2gy8@robh.at.kernel.org>
References: <20210804092244.390376-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210804092244.390376-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804092244.390376-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 18:22:41 +0900, Nobuhiro Iwamatsu wrote:
> Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../clock/toshiba,tmpv770x-pipllct.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
