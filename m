Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B903CA0F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhGOOxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:53:21 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:57640 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234745AbhGOOxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:53:20 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 16FEoJbu030676;
        Thu, 15 Jul 2021 16:50:19 +0200
Date:   Thu, 15 Jul 2021 16:50:19 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] auxdisplay: charlcd: Drop unneeded initializers
 and switch to C99 style
Message-ID: <20210715145019.GH27830@1wt.eu>
References: <20210715144152.83582-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715144152.83582-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 05:41:52PM +0300, Andy Shevchenko wrote:
> For structure initializers the fields are 0 (or NULL) by default, so
> there is no need to fill them explicitly. Besides that, much easier
> to read when initializers use C99 style. Hence, convert to C99 style
> as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy!
Acked-by: Willy Tarreau <w@1wt.eu>

Willy
