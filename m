Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA46534FF57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCaLQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhCaLQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:16:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D24A6195D;
        Wed, 31 Mar 2021 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617189363;
        bh=+y8vuiilDhv05xBYXqxQZWWGkxtIXm6bEVC8PvtrtPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhBzSkzs7ZEnue62eQDuGw6bZaLK1fxVz24GDP3I9dHzN0GzTrnyt3BfngA3JQSA4
         ccgPrhju27iJuz4bth/+QdLEkaSgwNX1eiKAO8paigXXJqeorLGDvVVmiAtQY55W6z
         oHVUSEDY1B1LrRYxLfFb0NX03pYYgirJsVyVzfdINA29IyPsnj68lUvFaSUWYATyd8
         mz+cnzDJ+3SR4cS0lcQqEiRtA//a3EJDlfXaWUeDJuvkTejd5arIo/k+Bag93gCK1f
         9Rm76OddPXOl4yVjSv3NDsOr9QrtWURdoOClLHpGHGFwykNdAT4XSJCB2/aRAXnxhV
         RhyJkLoa7scHw==
Date:   Wed, 31 Mar 2021 16:45:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 0/5] j721e-wiz/cadence-torrent: Support to skip SERDES
 configuration
Message-ID: <YGRZ7oAiawC46zVF@vkoul-mobl.Dlink>
References: <20210330110138.24356-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330110138.24356-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-21, 16:31, Kishon Vijay Abraham I wrote:
> Add support to skip SERDES configuration if it's already configured in
> bootloader.
> 
> The wiz part was initially sent in [1] but that was sent more in the
> context of Sierra but this is in context of Torrent. The Sierra part
> would be sent later.

Applied, thanks

-- 
~Vinod
