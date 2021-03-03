Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5032BEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574745AbhCCReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236430AbhCCOHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:07:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C686764EAE;
        Wed,  3 Mar 2021 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614780360;
        bh=Dp0+D625HwAqvxI89RK1lqFQ0TMsmccmmw5X2AV2AqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxJcA485F5jgnpF+bBLXnNgks0su/Sl0PRgMADE7m/ptDwGJNSX26wM6eextQlun9
         iyxOKNSGbKnvSJfGzXpesfvbixiMru1o9ms6VqsmSUnbqa0fK1COCrCZK7DUCT5827
         xVwj1KXxkqePMJ8sTxlm2UP0UwBDs4CGMGToUT4Q=
Date:   Wed, 3 Mar 2021 15:05:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: driver-model: device: Add helper macro examples
Message-ID: <YD+XxZ2/8vPeDt05@kroah.com>
References: <20210303133845.3939403-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303133845.3939403-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 02:38:43PM +0100, Geert Uytterhoeven wrote:
> 	Hi Jon, Greg, Rafael,
> 
> The DEVICE_ATTR_* and ATTRIBUTE_GROUPS() helper macros have existed for
> more than a decade, but are still not mentioned in the driver-model
> device documentation.  Hence this patch series adds them, including
> examples, to the documentation.
> 
> Thanks for your comments!
> 
> Geert Uytterhoeven (2):
>   docs: driver-model: device: Add DEVICE_ATTR_{RO,RW} examples
>   docs: driver-model: device: Add ATTRIBUTE_GROUPS() example

Thanks for adding these:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
