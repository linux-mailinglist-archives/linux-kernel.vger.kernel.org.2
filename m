Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC901387FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351634AbhERSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351619AbhERSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:43:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F1C061573;
        Tue, 18 May 2021 11:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=AXHfQEiZb4FEClTJpPTzUe0awna37gKzJrDJwe4H3PM=; b=edwnqHvMraw5cTKcTgefcWikbi
        LpZmbCir/yE1mN7DGgu4u4bA8pO2oRhiQoidj8JlgxBp+NBQqfOXWoIgnqzdudt1fNtyAdL6H2owF
        bJyQf1p2PLGLZEINXorxXg8cSHZus0ZHdI2uS05ly5i0UpF+EnXFUW2gkkdJN0BR1bGWS5yGXigsw
        NUGdPt2lioCf1C8JX1XdHNZsDKKu0ASDEutTWeVr6XVUSKg3rI4l1MgBD0MppvU5An/ZUh6QQu6oC
        t88nN7UvZEB04oYszVnYWBkGzI/oua5OdHVUn0p/cuASTjxrl/SyJicCTv0tZyK/vTV6lB8Qv/wjc
        oQxd/4iQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lj4fB-00Et9I-8A; Tue, 18 May 2021 18:41:53 +0000
Subject: Re: [PATCH] gpio: fix kernel-doc syntax in file header
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
References: <20210518175339.12399-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97aa0210-c89f-691e-66f8-db83ddbf48e5@infradead.org>
Date:   Tue, 18 May 2021 11:41:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210518175339.12399-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 10:53 AM, Aditya Srivastava wrote:
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> * Applies perfectly on next-20210514
> 
>  include/linux/nsc_gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

