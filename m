Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9F311C88
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBFKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhBFKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:09:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E74064E64;
        Sat,  6 Feb 2021 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612606152;
        bh=cabH66ldT873jRobELTAz31M07fKYkniu9V/epPMIGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xlx1/ndqPI9A7Brd1nYSOuZoQz/IrYbA+eXCZjfGmpuW0+ddNbdD4N9BDMguQWqVb
         BfF7sTfiKKiiuy7IK2ZTRs1Lq7tyXGPwV5tf9SGXzAy9s73g7s8+vrc7dTGR5KpBZ3
         tICJRgxHNRUDud8NCqmj4K/RDKdd95pl8cHJT2NYxhTlv42D6qJSL1t4Ugbt4UgVuU
         FVkWZRk4nXuwKJgZ0NIj7dRfWFduX1bO+BMQIglWGIW4G8dzEIvu4LLknwdwSe3wiW
         RJ+mHsG0S9+t0A5QJiPj6Myd1RkReDkvnSnGLYoTLI1WkedpXMOKvyu8uwxZIefh+N
         sjNEW1N8nyb7w==
Date:   Sat, 6 Feb 2021 15:39:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: cpcap-usb: Simplify bool conversion
Message-ID: <20210206100908.GL2656@vkoul-mobl.Dlink>
References: <1611905915-50394-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611905915-50394-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 15:38, Yang Li wrote:
> Fix the following coccicheck warning:
> ./drivers/phy/motorola/phy-cpcap-usb.c:146:31-36: WARNING: conversion to
> bool not needed here

Applied, thanks

-- 
~Vinod
