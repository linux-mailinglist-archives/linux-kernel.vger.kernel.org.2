Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C563956F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhEaIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhEaIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:30:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09ECE611EE;
        Mon, 31 May 2021 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622449718;
        bh=CyJbfMGzwJNZlA99CLSRuq+u4eO2mAC1TIdyj8Vg2c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc19KuZdghby4ebCgT8IgUem4RbTm7z710VqZLx649KokwndqDrJbUOJa2QZUr5zh
         FS2RoHhYXAOHScLRfGXgNRaCaWjD8seNnVMrqu0BXxt3jw+0FDPfMROB/zQ1fzWx8B
         QuH3szbvhO9WZp90Xzyq7VDtcY3zPE5ibvLju1o5CCS/JJxI40us/t5JzierdtzwDv
         5CO32MLUqvNajPf8qhti1IMeBA9TIj4WEBwsD7c8pSBtjJmbnaAnQIS0MGoBSvj6br
         RPF602gI6acx5wG/fiRy5y8jPOZbQnS6DRzBVkcQpVSqtvsgnfMawyEHJ1lWwPMMGa
         OhZoozrcqOvkg==
Date:   Mon, 31 May 2021 13:58:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Heiko Stuebner <heiko@sntech.de>, kbuild@lists.01.org
Subject: Re: [PATCH v2] phy: phy-mtk-tphy: Fix some resource leaks in
 mtk_phy_init()
Message-ID: <YLSeM/yWWQC81UUs@vkoul-mobl.Dlink>
References: <1621420659-15858-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621420659-15858-1-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-21, 18:37, Tiezhu Yang wrote:
> Use clk_disable_unprepare() in the error path of mtk_phy_init() to fix
> some resource leaks.

Applied, thanks

-- 
~Vinod
