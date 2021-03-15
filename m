Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E933B002
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhCOKbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhCOKbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F2A60295;
        Mon, 15 Mar 2021 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615804268;
        bh=+7Gzy2h60gtU8dKM6TRRNJoI2wPB8/yaqzkEGaQ5Jok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVOQJANYIhWZb/KKDsj/HXdBmLQJsCokhyQDGoRLHzB8O2gTkBcOE/hb9HlaJwD30
         5bgW1vKWUNlSE+qN7p9xEQz0+JeTowLVlv4/REFrg9EKdm0VD47dUS9NYe1vI/GyMa
         NUDjtH2aTVD0VyAe0sUC0UpEb9ojBC5X02nln7W0jb6C63xi/go77+BhwTek1JxnY4
         4tcu18mSnr+EaQ9jQ1YqX6eS0/7G6uT5pD33ydF2JPmAbkhASVzERLsX8WjaGeYkml
         dlNr9Gi9grE996J1xKQNBJF4oi3omx1ayyvNRps+a5If1NlQoeY305cyOgwOU45pLw
         gHxPXjZV0QHrQ==
Date:   Mon, 15 Mar 2021 16:01:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>,
        =?utf-8?B?5ryG6bmP5oyvIChRaSBQZW5nemhlbik=?= 
        <aric.pzqi@ingenic.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] phy: ingenic: Fix a typo in ingenic_usb_phy_probe()
Message-ID: <YE83aN32WhcS7nuo@vkoul-mobl>
References: <20210305034933.3240914-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305034933.3240914-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-03-21, 03:49, 'Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix the return value check typo which testing the wrong variable
> in ingenic_usb_phy_probe().

Applied, thanks

-- 
~Vinod
