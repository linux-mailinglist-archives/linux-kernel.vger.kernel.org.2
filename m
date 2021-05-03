Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01843715FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhECNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234283AbhECNcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:32:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 307E16115B;
        Mon,  3 May 2021 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620048717;
        bh=WX/MeeWzRzZTMekcTKOAMojNkOIUoDiWQyAGIZi6vc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHd11X/qu6i8aGW2Mq+faxlMazznSy9E4+VtOSupVhh9+zNjo/VvicfGsZT9oX/Rc
         wBBWp6k7pLBGmmp5t6VDMQacz+RTJVCr3nSdsj7lUlVUjv56nFEqO9WHVJVO2xxgSQ
         jxLXG6VGrsUhmUiYsO8DA/Eme1DUGiMIclh3c7AAHi4IPrBMsut2f4S/x3AG3XqzRi
         MWn/INvH4SuYZskqVGX46ny4UxQ8E7dcPjw9mXXgdyA2Kk12049kudb/te8XhK9NV8
         IaVGzKdIJJCAJV/g0rY2+GdCcCi95GFdzr56E0qrzy6aJuYSvk5In2I1tZAQZ70trE
         dK8EUeuytiWsA==
Date:   Mon, 3 May 2021 19:01:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 51/69] dmaengine: qcom_hidma: comment
 platform_driver_register call
Message-ID: <YI/7STt+bBxLjwVp@vkoul-mobl.Dlink>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-52-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503115736.2104747-52-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-21, 13:57, Greg Kroah-Hartman wrote:
> From: Phillip Potter <phil@philpotter.co.uk>
> 
> Place a comment in hidma_mgmt_init explaining why success must
> currently be assumed, due to the cleanup issue that would need to
> be considered were this module ever to be unloadable or were this
> platform_driver_register call ever to fail.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
