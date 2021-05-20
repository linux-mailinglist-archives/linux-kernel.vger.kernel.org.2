Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E195E389EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhETHKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhETHKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:10:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C21CA6124C;
        Thu, 20 May 2021 07:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621494530;
        bh=/hvP4vNjX4gtYC9WWzk/yQSQZPjYP3EYj+Eiaj4tT54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLq19CMOvIwuUBOxvgt+NT+VBwGljc5C/YxPv+pwiFukdg1hWlcA66JU9rsdXm/ZV
         SdvyOQXV27Fv2H84PPWuvIhZUo7IXO7KYvUJOE1zybZSBQT7bEKOC2XGtB9Bor4D17
         wfPC+4WV62xM3o00uPh4r+d854Cp4OCOq6B7laXw=
Date:   Thu, 20 May 2021 09:08:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/4] nvmem: eeprom: at25: add support for FRAM
Message-ID: <YKYLAIrRJPks51yx@kroah.com>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-2-jiri.prchal@aksignal.cz>
 <YKX5aaV3DGvIm8RP@kroah.com>
 <81420093-7af6-bed3-eee7-38be125a67e4@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81420093-7af6-bed3-eee7-38be125a67e4@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:54:52AM +0200, Jiří Prchal wrote:
> 
> On 20. 05. 21 7:53, Greg Kroah-Hartman wrote:
> > On Thu, May 20, 2021 at 07:47:11AM +0200, Jiri Prchal wrote:
> > > Added enum and string for FRAM to expose it as "fram".
> > 
> > documentation???
> > 
> Hi Greg,
> please help me, you mean more explanation in commit message?

No, I mean you need to document user/kernel apis that you add in
Documentation/ABI/ please.

thanks,

greg k-h
