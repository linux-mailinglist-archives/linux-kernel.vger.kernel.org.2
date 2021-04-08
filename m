Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18803584C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhDHNcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:32:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhDHNcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:32:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617888759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuUsYOew2YF7y5GkbUWoKJyXhvK946o4aH2gFBQmJnE=;
        b=bcUCz7Eab1xa4w0STfioDYNAi/xtSuQudWOI9Rq1/64iOi9Pdarosmvi4CPPBUdhIGGTU9
        ybSFOd13IUGF9/zg0s8I0OiBzcS/VC8N+f0v7EkJmVefCFa+Dwbz7o7TCMXaKTSc4WnEPT
        gyyTYaVVWtWE+L3+2eJ8XuHPsSz6Mc4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01AF5B00E;
        Thu,  8 Apr 2021 13:32:39 +0000 (UTC)
Message-ID: <76912aea8616d98a257b33875020138015c06fae.camel@suse.com>
Subject: Re: [PATCH v2 2/3] USB: cdc-acm: fix unprivileged TIOCCSERIAL
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Apr 2021 15:32:26 +0200
In-Reply-To: <20210408131602.27956-3-johan@kernel.org>
References: <20210408131602.27956-1-johan@kernel.org>
         <20210408131602.27956-3-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.04.2021, 15:16 +0200 schrieb Johan Hovold:
> TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> serial devices is only useful for setting the close_delay and
> closing_wait parameters.
> 
> A non-privileged user has only ever been able to set the since long
> deprecated ASYNC_SPD flags and trying to change any other *supported*
> feature should result in -EPERM being returned. Setting the current
> values for any supported features should return success.
> 
> Fix the cdc-acm implementation which instead indicated that the
> TIOCSSERIAL ioctl was not even implemented when a non-privileged user
> set the current values.
> 
> Fixes: ba2d8ce9db0a ("cdc-acm: implement TIOCSSERIAL to avoid blocking close(2)")
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

