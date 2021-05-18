Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846CE387FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbhERSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhERSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:47:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3B6C061573;
        Tue, 18 May 2021 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=2VlXeVuiNm+OAkwPJObB4las2/rLa5h+25CK1rauGGY=; b=XVrGAywSSnBWXXuV+iHw2nR4Oo
        +HsOkxzb4r9OIhLgXATe+P2iPfG4EW885/F7a0WuY6HYYQIGNJeE34IbeEApD1Bpvk38jMyF2vt/P
        tl82ArXvbZVAeT13hZ8b64pTU3ko2y8giE/027kQy6TM7KCmw2IISosOwRRP60xxdFnNWH1MPB/kw
        +7yuC4xWaiuGDIfyFoSYiMlsswUpWRlY0wVM28nPm5MivEdU1dDJu4LkBG0YvIoGrZsYUy8l6G/Gw
        uvvhUGkHwI9294wkK1LsZhnPeQHvg+TUQpNlHSeNWuVyMIA/ByRwVEZa+v7t6YeNHd9dZzAuuRcO1
        e8omKbtg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lj4j5-00EtFe-79; Tue, 18 May 2021 18:45:55 +0000
Subject: Re: [PATCH] ASoC: omap-twl4030: fix kernel-doc syntax in file header
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        grandmaster@al2klimov.de, keescook@chromium.org
References: <20210518183451.15097-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c7756a9b-5e9c-3f1b-932a-c77922d287f0@infradead.org>
Date:   Tue, 18 May 2021 11:45:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210518183451.15097-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 11:34 AM, Aditya Srivastava wrote:
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  include/linux/platform_data/omap-twl4030.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

