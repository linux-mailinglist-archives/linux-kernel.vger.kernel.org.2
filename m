Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A47424CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbhJGF2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhJGF2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:28:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB2A60F6D;
        Thu,  7 Oct 2021 05:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633584404;
        bh=QqmyEQpHgC3C4+/OVPi6gbIPhuxRqSoGV3n0WbYwbEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iObknFTYbCIn2HzSPecreysRmY24UzEfOzfeWW21TtJtTKgGbGYszOY2S2MRCwPIe
         wmpf2rvLx3E5OcD8uOgVPm9XFZpan0FvYhKf1MXueKiNrfU4pazuxClLKhe4Nxg6Qv
         FO9m9aAMuvprn6rGw5bphgcvnSex1I5Y9VtBkmJY=
Date:   Thu, 7 Oct 2021 07:26:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: document new 'dynamic' common property
Message-ID: <YV6FEisHXqdBuduZ@kroah.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-9-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007000954.30621-9-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 05:09:53PM -0700, Zev Weiss wrote:
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

I know I can not take patches without any changelog text.  Maybe other
maintainers are more "lax" :(

thanks,

greg k-h
