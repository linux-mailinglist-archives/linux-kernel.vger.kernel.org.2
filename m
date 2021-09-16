Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D093240D2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhIPFZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233914AbhIPFZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:25:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 003E661130;
        Thu, 16 Sep 2021 05:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631769850;
        bh=51gGk7MhHQvQamAED401HmrrplIw3FKz2qx4WKc0qSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Zl8Jq6ZWOdUyLQ/anmXWzyxmKqQFBoZG7eYTMBPLG3IXWKQlmb/MLAS6EiBed4g2
         lrDelvqxb+unI2V/rWA/hB8JfXYy6MH4j2dLGX4tO+6Nk7E+tOTUZOZirDCjHzb3ky
         Csz2/bXTaXzsoMx0MHyslXn7m8gCTcq6eCW/P8MM=
Date:   Thu, 16 Sep 2021 07:23:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     arnd@arndb.de, derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        linux-kernel@vger.kernel.org, lee.jones@linaro.or
Subject: Re: [PATCH misc v2 1/2] mfd: rsmu: Resolve naming conflict between
 idt8a340_reg.h and idt82p33_reg.h
Message-ID: <YULU5g358pqWpqOV@kroah.com>
References: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631731629-20862-1-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:47:08PM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

As I said before, I can not take patches without any changelog text :(
