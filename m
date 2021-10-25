Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2708A439112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJYIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229928AbhJYIY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:24:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D9F260F46;
        Mon, 25 Oct 2021 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635150125;
        bh=APOL5RoCizGxqVuPkb770u6tvkOYLzgDYT6J7o+vNH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6snvvbdQ7hZ0z/OryQqVaoK8wLppqwzWpvScuEBvVDUzJv+d5yvjsM39g8Vv8KFf
         rwspREU4zEDNWCjaq/KJrjDdX2kpDEW09Mkzsp5+R7s4HCj1Af9kC8ByVJr7enTQwd
         KPPYKo/UluOZ3U/kgHWORDeUsyXb3LvhCk1tvTECMo7LmH1OFDhDzHaIRSQevT5GGc
         RwyiEzGjNddT3jO3vxQA0+GzcaOGwCzebIzBCJbcz86gG9Cn+ICODXSJg305XT006s
         XFqBSrFVNh3WVT8pUDD6eBy95X8LoUoQ5eYi7DOePghqhneHA5k5wgNOXdjMFMZ0bJ
         RmHW5x9VACanA==
Date:   Mon, 25 Oct 2021 13:52:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        steen.hegelund@microchip.com
Subject: Re: [PATCH] phy: Sparx5 Eth SerDes: Fix return value check in
 sparx5_serdes_probe()
Message-ID: <YXZpKXqn0iY4td2G@matsya>
References: <20210909072149.2934047-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909072149.2934047-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-21, 15:21, Yang Yingliang wrote:
> In case of error, the function devm_ioremap() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.

Applied, thanks

-- 
~Vinod
