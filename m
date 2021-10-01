Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181B941EAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353524AbhJAK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhJAK0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:26:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61D5A6103D;
        Fri,  1 Oct 2021 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633083874;
        bh=d2B3aqMqCeg19jkk4r/VHqci8GXUvcnxdV2Hf+/w4Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oq0EJTGmH24SIL3sllAtZp7cphGmYZyf40/foG2HbPnUXk/plxpKAGr/YaiCcfOiF
         TRKJWDcOtQ+ziqW6RhhLTD2V6yqe/oLEsZqYjSfDHJyvEE7rXKEB0esqK8Hvv7mMeI
         TGd3F6hTPp/8DhoUDoi9veNWHyHBLijbkcDRtvdjM9ZD4j61+qUAtTNYKjHnN8LHnu
         +yVsdC2VnAVRHRqS88R27Xwrrv2hPFhxWLyBqSixR3m4ry3zerYCgb/CD6MsN/It4N
         o7J2ROHkwGASNURqiuqiWUPNMD1uodpKhwOhuKbqheyfTdpSR7zKUqbQSEoPkTJdzH
         jjBjbRs3GUsrQ==
Date:   Fri, 1 Oct 2021 15:54:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Make use of the helper function
 devm_add_action_or_reset()
Message-ID: <YVbh3gRziCXf1iAk@matsya>
References: <20210922130024.745-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922130024.745-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-21, 21:00, Cai Huoqing wrote:
> The helper function devm_add_action_or_reset() will internally
> call devm_add_action(), and gif devm_add_action() fails then it will
> execute the action mentioned and return the error code. So
> use devm_add_action_or_reset() instead of devm_add_action()
> to simplify the error handling, reduce the code.

Applied, thanks

-- 
~Vinod
