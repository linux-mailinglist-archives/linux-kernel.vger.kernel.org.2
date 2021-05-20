Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D96389D67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhETFzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETFzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:55:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AFDA600CD;
        Thu, 20 May 2021 05:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621490029;
        bh=M9giGNBwQA1Znk12XUOKI5iucIgIMugq6CqnDQ3Xplo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUhN9U27WOSYEKV9NiuA6kursZeAOP0zHiTwIfxARyxW/6keVm+xtBTVGJw3kg0ov
         vrgs+cwcZIR2+xC7H3gBZEFwTi93ze19ITi430hGjdS9EKQFgHVAAM0BTa7N+H5vU1
         +yfGm4kvE5hzbAPrsWN24gyrSWTaspnFS0RBSQ2Q=
Date:   Thu, 20 May 2021 07:53:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/4] nvmem: eeprom: at25: add support for FRAM
Message-ID: <YKX5aaV3DGvIm8RP@kroah.com>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-2-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520054714.8736-2-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:47:11AM +0200, Jiri Prchal wrote:
> Added enum and string for FRAM to expose it as "fram".

documentation???
