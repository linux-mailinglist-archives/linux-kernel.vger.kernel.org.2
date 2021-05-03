Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47A3715FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhECNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhECNcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30FF61157;
        Mon,  3 May 2021 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620048698;
        bh=y0aNX63GrLtCzRF3/YYmoONu99cT979DYL0ElS2dVPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnlyYhekri+ttWxM4G8NSYtpm8myivKAVX1qwx+2NdYqE/xLScN8U9tiBfixKXUMz
         UcIlqyOTbeH7kQuOzBIHbDZ6BIIbKW2J6WOnvEUw8TcXjsH2u1eb64i43seJRNllvi
         YSz8WAkrPhB5xmaRtUmSqN5jKtYBNrrvidgBZd9dC/yyVFhyeisShX3lvCjTBTZO9U
         PmkBQ0UKXmKueYUVXuD/ywoY5oW0sv0tsCjgMCI70AxreaPgJxrzqS3AnnqYLJLXzq
         za7fu5yqXIxKACwbNxlKSMlVLV8oCZv88OnWtZgtDA3XLeAgXGo9FrD/pAJNvv6/KS
         lkGSewnUNw7wA==
Date:   Mon, 3 May 2021 19:01:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 50/69] Revert "dmaengine: qcom_hidma: Check for driver
 register failure"
Message-ID: <YI/7NifC/XeYEYIa@vkoul-mobl.Dlink>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-51-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503115736.2104747-51-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-21, 13:57, Greg Kroah-Hartman wrote:
> This reverts commit a474b3f0428d6b02a538aa10b3c3b722751cb382.
> 
> Because of recent interactions with developers from @umn.edu, all
> commits from them have been recently re-reviewed to ensure if they were
> correct or not.
> 
> Upon review, this commit was found to be incorrect for the reasons
> below, so it must be reverted.  It will be fixed up "correctly" in a
> later kernel change.
> 
> The original change is NOT correct, as it does not correctly unwind from
> the resources that was allocated before the call to
> platform_driver_register().

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
