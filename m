Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C6359449
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhDIFFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhDIFFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:05:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D7D8610A2;
        Fri,  9 Apr 2021 05:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617944709;
        bh=j8l4SEopzg9LwuyP7KnznlhaAIzJcQ/gKMBLZiJDf1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nhy8T7GqBtLAiMSeoGybvs3lX+YqxBSaEQUXfuuyJBFu8qfSIYqPZgVgQUkakqxr+
         NeFfY8s20V0tbE8m2nzjV5f0dfduVeWnWK7eyEd2104TsLVWe0ytJVHN8EeNE9EW/s
         J4FOMtLtcWU01Amm0XSWAGwI28oZPO0B5ILnQDMY=
Date:   Thu, 8 Apr 2021 22:05:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <christian.brauner@ubuntu.com>, <masahiroy@kernel.org>,
        <ktkhai@virtuozzo.com>, <linux-kernel@vger.kernel.org>,
        "Zhiqi Song" <songzhiqi1@huawei.com>
Subject: Re: [PATCH] init/version.c: remove unused including
 <linux/version.h>
Message-Id: <20210408220508.c7ce7b1b90202a19223ed1f4@linux-foundation.org>
In-Reply-To: <1617863218-14905-1-git-send-email-tiantao6@hisilicon.com>
References: <1617863218-14905-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:58 +0800 Tian Tao <tiantao6@hisilicon.com> wrote:

> Remove including <linux/version.h> that don't need it.
> 

Um, how can version.c possibly not include version.h?

Sure, it may obtain access to version.h via some other include, but
that's plain luck and nonsense.  And it's unreliable and it requires
whichever-header-is-doing-this to continue to include version.h on
behalf of some .c file which should be including it directly!


