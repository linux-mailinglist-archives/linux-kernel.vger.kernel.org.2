Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285883CF14F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbhGTAqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349769AbhGTAoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:44:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 724C261004;
        Tue, 20 Jul 2021 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626744313;
        bh=bpoJFkc4WP2VzWtNaJ/5hbShq0wuVrNcAqjgy9xe0dM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kSj9FQkIYMaGBkCPL2bAtuP3Wu493GiAD+3SIzDma00gZQ7n71KbZ12bbw7242ZF5
         G/2VNmUGmYDduNbI6QpMcn11skyy9Y2gBzrTlCI8oEl23fDaOEVHt5a6jrdtikPLB7
         j4Cv5q3sGI0QczWO4SPDqcFK1aPqnVGzF8nTPoH/3URgrW3DkFWOyKqm+EwmjpyiV0
         2LoBWYuBGKvDzXSzOwDExCUAISxiZecCNVR+01Cy2BUFnqCpK0BwlvtSPTSJhydt3t
         ObQtZJ1AR4rRrqsDC4qmMYBCj/NDhpMEaplAFNflZeH9DdBAF7AafvFPZwjqOtfjl8
         47IYGc95m1Z5A==
Subject: Re: [PATCH] f2fs: multidevice: support direct IO
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210719084729.26117-1-chao@kernel.org>
 <YPXEMU8nQdv8n4Dg@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <3c2646ae-138b-c0fe-a757-06ae16b31928@kernel.org>
Date:   Tue, 20 Jul 2021 09:25:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPXEMU8nQdv8n4Dg@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/20 2:28, Jaegeuk Kim wrote:
> On 07/19, Chao Yu wrote:
>> Commit 3c62be17d4f5 ("f2fs: support multiple devices") missed
>> to support direct IO for multiple device feature, this patch
>> adds to support the missing part of multidevice feature.
>>
>> In addition, for multiple device image, we should be aware of
>> any issued direct write IO rather than just buffered write IO,
>> so that fsync and syncfs can issue a preflush command to the
>> device where direct write IO goes, to persist user data for
>> posix compliant.
> 
> Is this aligned to Eric's iomap work?

Will rebase to it soon, when would you plan to queue that iomap serial?

Thanks,
