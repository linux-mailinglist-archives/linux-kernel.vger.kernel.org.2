Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2CF41E8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352922AbhJAIPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352716AbhJAIOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:14:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9786615A4;
        Fri,  1 Oct 2021 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633075951;
        bh=4iD8lC8KJ0MVZhs97JJ08xmNkfcRSjGl6FLqVIbz6kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Paysoc6WYJy5j/CQ24zPFNgWVk37SRBwpJtYUPW1LiEg+aiFD5fhjTTUTjhy6l5f4
         y2ImnoUiJpC3wZlsuXZzW0FyekLfkKo5CTaFDcgwwlskpqrg28dxcmDCG1Dqyydcmn
         49hCJ4IbNJ3G7IdLybwf/grsfCPzPMwvNmx96aomnjwIlsNwlMeT2wmHBhGnLhRA7M
         99BTtpTFqxBn6uVQ5m/o6ywfdmKFeZ0E0zqhQY8lyqJw/ajqE9ZYdh03Ale41wSVxX
         XlAzq5z3KiLAHnW5fZsM3JFwd3PhORztn09F+R/UtvSt8nv/gBj2lmTdcgPK7LW5vh
         FBnU5kfXgK5jw==
Date:   Fri, 1 Oct 2021 13:42:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v12 01/11] phy: HiSilicon: Add driver for Kirin 970 PCIe
 PHY
Message-ID: <YVbC61dhsvAnqBqL@matsya>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
 <b7a4ff41b57d861b003f1a00cae81f3d226fbe18.1632814194.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a4ff41b57d861b003f1a00cae81f3d226fbe18.1632814194.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-21, 09:34, Mauro Carvalho Chehab wrote:
> The Kirin 970 PHY is somewhat similar to the Kirin 960, but it
> does a lot more. Add the needed bits for PCIe to start working on
> HiKey 970 boards.

Applied, thanks

-- 
~Vinod
