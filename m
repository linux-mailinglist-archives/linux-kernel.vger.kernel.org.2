Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38E631BC39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBOPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBOPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:23:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 155AD64DA8;
        Mon, 15 Feb 2021 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613402571;
        bh=iNB1WC3wUGi26SUhsBoDGB0vzb+NLWwq/Cl4l6L6OXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TakcIT6C5at7HLfdzcK3BNMR9JhcEslIrVJKezH6NUHOwRi0rB/T6Q8rkuaq8+32F
         lPWKUcPJ1oxqNQeH7reKS5q9e7tmyjzbsHlVEZRXD6DI1lGSnDXQ6IsTa3arg2y009
         dYuSvUcItJkRq9Y6+6JP22f03OgOAHt9l4HM751Y=
Date:   Mon, 15 Feb 2021 16:22:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Emad <alaaemadhossney.ae@gmail.com>
Cc:     mchehab+huawei@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] staging: hikey9xx: hi6421-spmi-pmic: fixing
Message-ID: <YCqRyapToC1bejfg@kroah.com>
References: <20210215143652.14122-1-alaaemadhossney.ae@gmail.com>
 <YCqKgM4RD8nGCS7E@kroah.com>
 <CAM1DhOiS7M6sqkUtKy9aDTmUEVFwBxOhuzk=iKyUax8U+nsR9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM1DhOiS7M6sqkUtKy9aDTmUEVFwBxOhuzk=iKyUax8U+nsR9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 05:02:50PM +0200, Alaa Emad wrote:
> sorry ,i thought it needs to change the description so i resent .

If so, then say what you changed below the --- line and make it a v2
patch, like the Documentation tells you to do, right?

> please guide me how to fix this or it is good?

No, see above.

thanks,

greg k-h
