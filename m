Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAD3D1480
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhGUQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhGUQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD1246109F;
        Wed, 21 Jul 2021 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626886143;
        bh=s+F7hwqvx1Im40EqlbcvxgltsvKjKASH0j59Wu8mKFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbGho/J4vtDTKRnidPu6sgmzcYap3tWvi+kGGi+L4x6EfZ2p4egoci4aI3CSc1D5F
         sacRxGKsf7dh7UZETpsOyY6b9SI6pHxpGuATmsGUlH7C9t9zWGdVjjNWaVADBqriaN
         WWizV5cPWXRPVdqae7bhQZHA+DOirFoW40+F6p2vSLw3G78rK/QNqWWHre9wdQ3uO5
         gIylL/Op8v2XCILDf9Rpgkr2V0Qtw7tcvDtPKrL26MPzh3tD5Gn+Up/oqZ8CNQ4jlm
         Eug04Agnyvfiic9d0bQtkS7KPPVPWGBZ+lmxD0nA+nrZRrg4gHjSWk3x+WyGCxZEEe
         1X+0BHBcK1ybg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m6FOh-0003tF-QY; Wed, 21 Jul 2021 18:48:40 +0200
Date:   Wed, 21 Jul 2021 18:48:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: add ID for CEL EM3588 USB ZigBee
 stick
Message-ID: <YPhP56ZpNa7EDc8H@hovoldconsulting.com>
References: <20210721161745.2101328-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721161745.2101328-1-john@metanate.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 05:17:45PM +0100, John Keeping wrote:
> Add the USB serial device ID for the CEL ZigBee EM3588 radio stick.
> 
> Signed-off-by: John Keeping <john@metanate.com>

Applied, thanks.

Johan
