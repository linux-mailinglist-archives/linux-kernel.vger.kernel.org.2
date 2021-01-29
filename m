Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71A43085F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhA2Gko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhA2Gkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:40:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1E3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=waQy023mklfE113iOH/3aXsuJ/hgfNp5E4aPKpbysLQ=; b=ue3P7cXVdPN7uYQgi2DfpVu1fO
        /hKK7fVtM/D86UFjGSDRkZIyWGSPwLZujtA66iOXYDXiQqr4C/AZK92CQ3HICi3r3CFuMwlToFKiF
        GnwTBLhd3xJCagQ2aNGE+CDMMErx8yoIZ7xrFFPQH/Ls588jAAX503rmEcnNDZeNOJk2Q84MEo86S
        CMbxPmXMnIqjoEUdMHg+ChZLR7Cczv6roD9hpIPDh8MtJl/4+dLo/mwqd2xEoCF29rBC7kzqj+xOE
        JkQAtXhYagGy1PwU55DO1mgFzAEbKv2nGB9L4oLdrfecH8TXEV6VZCXrctVWFTwU2j261wuVOMi5T
        zIQYjJmg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.253])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5NRg-0004Vq-Gh; Fri, 29 Jan 2021 06:39:52 +0000
Subject: Re: [PATCH] parser: Fix kernel-doc markups
To:     bingjingc <bingjingc@synology.com>, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jack@suse.cz
References: <20210129050037.10722-1-bingjingc@synology.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5cd0b56-de00-bc4f-d4c6-9108d7cab780@infradead.org>
Date:   Thu, 28 Jan 2021 22:39:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210129050037.10722-1-bingjingc@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 9:00 PM, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> Fix existing issues at the kernel-doc markups
> 
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  lib/parser.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks for the kernel-doc patch.

-- 
~Randy
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
