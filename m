Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252E836C507
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhD0L1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbhD0L1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:27:18 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n99MYH9KB6XVOl2PjPq9XHT/BHcPgJy77LgUdJogers=; b=OuIoYHwKpGvvZNGwZBIBWAae2m
        8arFge8KNdRexJp2XzR426x7RiiJ1uOd6uQJ8ztxIOyYFruPTvAViAwlrp7GZ7U5ykGD5WkAfUwOS
        eYSW7eejXiBUbQiU53bJIDxAZHySc/8FjbD8x9C5g/X3DbYLKZgVW2nzMIPwxgm6CzlNXZ2F8s/S8
        JdbBPgf2TZ4C/6KIUFW1WxR8pMsMQxATZDRmeep7xDmyqU3Yz4y948FoKQzkYfFZErgjA2E7gVR+Y
        bkthcFKZPpTVWnqq9nebukju8Ffh6pRgcp7J5jhXM4K9wOZDiqXDF7EG1x0g175MDhF7gL90En9Px
        VE4GFDpA==;
Received: from [2a01:799:95f:4600:cca0:57ac:c55d:a485] (port=61453)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1lbLrL-0005O3-I4; Tue, 27 Apr 2021 13:26:31 +0200
Subject: Re: [PATCH] drm/gud: cleanup coding style a bit
To:     Bernard Zhao <bernard@vivo.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210402085523.76928-1-bernard@vivo.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <4313dfba-7f3c-169e-5619-ca9c0a0a1f4d@tronnes.org>
Date:   Tue, 27 Apr 2021 13:26:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210402085523.76928-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 02.04.2021 10.55, skrev Bernard Zhao:
> Fix coccicheck warning:
> drivers/gpu/drm/gud/gud_internal.h:89:2-3: Unneeded semicolon
> drivers/gpu/drm/gud/gud_internal.h:107:2-3: Unneeded semicolon
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---

Applied to drm-misc-next.

Thanks,
Noralf.
