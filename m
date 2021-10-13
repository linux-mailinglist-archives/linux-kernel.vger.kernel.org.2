Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9393342C4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJMPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7A860F21;
        Wed, 13 Oct 2021 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138563;
        bh=BtCe891vLfW+speZQd9E3ZgbCkoMfZzWSEEVYCAx9iI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YO2Q3KYQzf20NEucNUVx6Oswm3ZojnFmUJpa5NoUMhECTlHOuK039nOXFIdSZ3oC9
         pAkhRpKgy7KqmdYfcxGd2odq86WdIdvjfFIs7lbtRWAkQjYkigrCPLzUh+JbhyAlNp
         vCKTdHpsZoIth6vKb9Xf5WVAHhIEIqBbX70XvevJkp6rlMXlqrxtv395Tt7FGDoNnD
         myESfy8qvCfE9JppV8rnWQ2jysqlelCdUlklBhLisWiBCwaxJeYy5IuCpTJJJVojIj
         BR4dmZ0bMvkAqmTsCUr3CorX80pQ5FGnBDR+KOrmmxZOoUx4xFEJsxpLaMzreqwmFk
         Q5wsxyy8LoFeA==
Message-ID: <5ebc307e-09e5-e064-269d-027c3ba615ef@kernel.org>
Date:   Wed, 13 Oct 2021 23:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fall back to the original version
 check when clock_gettime is not supported
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210928204658.2230524-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20210928204658.2230524-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/29 4:46, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In lower versions than macOS 10.12, they don't support clock_gettime
> function. It breaks the build, so we need to fall back to the original
> kernel version check algorithm, in that case.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
