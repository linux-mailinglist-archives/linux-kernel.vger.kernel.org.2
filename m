Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853EE3B65F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhF1Ppc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237291AbhF1Poy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:44:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CB6D61465;
        Mon, 28 Jun 2021 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624894948;
        bh=agu2aFVx83M/6lYwPR0cpmCBMPta7Q6L7ar27lECxvI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iFELAZj/sJ6lDMa+ON2D04Vp/xFVR4/QdCFz2ZywJO49sQSKEorcaAlqA1LcOiH3Y
         R/SaLuy3zLXwcXGHH6vaJmim2oJzx262JAyso1s5R5XqtEXXv3gPRXp9bhW5XKg18G
         0STngTvGd8Ny+vtSAaeMeupg38/SOvYOV0sIciM9JI1pUCgnaRkGaKodcJ48cfnkRD
         qXF0BRCttG+/aojqJ2YCMuAqzl2BzxPzYdhmjwvJbM1klE/BXgZcerzwUz8wmxEuEP
         j+S/DRAdbNkw/9fWDGrrU4btAmXRix+VW9kLrmUEJyd3GbBrZ5cVBBJKj0p77jyvY8
         /R5GBvznw8EbA==
Subject: Re: [f2fs-dev] [PATCH] f2fs: enable extent cache for compression
 files in read-only
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210621024027.1511092-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <84fd594d-8079-caf6-090e-9ceb4cb0a86b@kernel.org>
Date:   Mon, 28 Jun 2021 23:42:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621024027.1511092-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/21 10:40, Jaegeuk Kim wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Let's allow extent cache for RO partition.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
