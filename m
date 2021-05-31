Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84A395711
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhEaIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhEaIhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AFD961186;
        Mon, 31 May 2021 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622450123;
        bh=IRK46P+onnXUcW3yqKhMmjGzMOTmOvOELF+sM6g16GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebzXpGuZK57+n+kaoTCkB6EiUMEY//OwlZL1u8m97Rd5WbdGEKbINQxn5AQzHYZpt
         vdqL1sSMKnHNHRQ6hbftgJ9k93g/19rnROMpXeq92LfwY+wL5ADKsJOyY2x9QcLf53
         iplqYdQ7Rvf+/YclQfR532hHh8tpgxHiXG1LqqL35n/29nfNXhEqjyi7aPcsnybSYr
         TBZ0O0s+XSDzgj1wcDd+7K1KBNzD+0HlAniwqp26tttu7nQrJWaDbtBf7ycUc/IiLG
         krqFa2T+RNZPn7ncnW0JuvutNI2unzq2j+boMa6ipTVi6+ZjYTiMBtVSrJTZTrgzfo
         Pb/JCd6bV/2SQ==
Date:   Mon, 31 May 2021 14:05:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, kishon@ti.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: phy: convert rockchip-usb-phy.txt to
 YAML
Message-ID: <YLSfxzJDekpDVFHd@vkoul-mobl.Dlink>
References: <20210518165658.12764-1-jbx6244@gmail.com>
 <20210518165658.12764-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518165658.12764-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-21, 18:56, Johan Jonker wrote:
> Current dts files with Rockchip 'usbphy' nodes are manually verified.
> In order to automate this process rockchip-usb-phy.txt has to be
> converted to YAML.

Applied, thanks

-- 
~Vinod
