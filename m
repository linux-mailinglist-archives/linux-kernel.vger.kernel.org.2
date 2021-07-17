Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C23CC2B8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhGQLHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 07:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhGQLHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 07:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98DD1613D8;
        Sat, 17 Jul 2021 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626519856;
        bh=XCEqKJfNeIitRHbTuY2JqLyiAxu7pt4itT138B/8Zbg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Lw9ZD+ytp5hZ5JO5iZgXvl/ntvNvmTJcpI2rWT58zSQqLAjdLXzQ/HfjR40mus9wZ
         f5SHL55lkf900Y09d6w53UbNYrCUoz8x6v05bm4zCeD2WoDBklmTLO74RzoCab50Ho
         iyPE6Ynpq1IL1hjGodJb/tZ+r3f5tZLsVYhMohhi8A1TA8r40TlLvDGx6A4J/sx0fo
         4U6++8B6JiFmUts5WKcxnLFBzT/sHXqaE6iz5JcMiVORQc2IAG8pJVz7Ap0o/SA93a
         B3ThaSqkfBsDukQZ8f9An46WDrixKlr0fjeyBYFbR3efnT8M/glaLOj1yMc446uXi6
         j0nb5bdsdo52g==
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: add periodic check in kernel
 version check
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210716215703.1560325-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <57f7ac57-03f5-e9cf-6850-d5e5c2948242@kernel.org>
Date:   Sat, 17 Jul 2021 19:04:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716215703.1560325-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/17 5:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In previous, we did a full scan right after kernel version is changed
> and it triggered many unnecessary full scan whenever a newly built
> kernel is downloaded. Plus, we are lack of a periodic health check of
> on-disk filesystem images. So, I added a monthly periodic check after
> a new vesion is updated.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
