Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80873786D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhEJLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:11:30 -0400
Received: from onstation.org ([52.200.56.107]:33058 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhEJKsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:48:16 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 06:48:14 EDT
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3A7E73E9FF;
        Mon, 10 May 2021 10:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1620643319;
        bh=6y+Fzt4oWzPMV01Ga2YdSBHuWTVF3ofTAHQn+x+PJmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRE1U8Rj3MLTexBrgPH+cxlh/pQd518l2EkidlivYwlL0QLIWEs+Q/XPyrcTPg0cl
         d3GxrPsgj7yEbpcP93H6/l3TfKPWhulcdoVQpMVo7ZRnqspkf6ljinyrCx0k2sLvkB
         a+hApArrdIQRbvrAJNJwBQw786fkrByiVubdkGSw=
Date:   Mon, 10 May 2021 06:41:58 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v1 1/1] backlight: lm3630a_bl: Put fwnode in error case
 during ->probe()
Message-ID: <20210510104158.GA296@onstation.org>
References: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:57:16PM +0300, Andy Shevchenko wrote:
> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: 8fbce8efe15cd ("backlight: lm3630a: Add firmware node support")
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Brian Masney <masneyb@onstation.org>

