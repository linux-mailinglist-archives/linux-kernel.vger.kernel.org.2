Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A873C6AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhGMG7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 02:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhGMG7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 02:59:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D715260FF4;
        Tue, 13 Jul 2021 06:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626159372;
        bh=yjiQ5x8/CBaAkwI/8+3VNl+FY1HWxYFNJi4wy4YGxFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcm6dKc/DEN8QKDXol3AEM/0EY0IWTN75O8YlFfeVbDwC7THfozhzfRgqMr4qqnGr
         U48fuCGeTYys3z/aoL1oy96R8TE3PjZQybzE1sqK4pBlzGWl3+Nc9S1tO6ZfvZHLat
         4VIFFVGuhcJpmsWGVvuV734mlwwa/Sfr1ZbXTfvs=
Date:   Tue, 13 Jul 2021 08:56:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pandith.n@intel.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, furong.zhou@intel.com,
        mgross@linux.intel.com, mallikarjunappa.sangannavar@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
Message-ID: <YO05CYrWFWYpjMni@kroah.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713065347.21554-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> Changes in V5 :
> Local variables are always initialized before use in all cases
> of capture function
> No need of counter 3 definiton in enumeration
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>

Something went wrong with your scripts :(
