Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD43F2A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbhHTKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237148AbhHTKgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:36:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EC896112E;
        Fri, 20 Aug 2021 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629455744;
        bh=SydDpYYDbjGzNxExamcwlWD3d7fH3OLPI08AP14CvKs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lJyu6sICFwf4b5c9/JLk6MN2NdKm1QPFUz5x/ZUXnzgmGpipdUqQA90TvVbwSoQJm
         hLEe0ttWJYSQ82f/mZtnBUrz3hoQAS8+9U4AMtU+o73y7/nLPlFOQVJL+vmN4bmL+U
         ze1438LiElPMQpbauuiXR7kg8ogXZS+wrFnDle8i4B3M1gkHycLV0wEDTAsJN+wW91
         Hmgm//HZYppZt9e01Bp7WO9iQ3HE3iIr8/2Wk/7bhhbOa+No16fj9BFEZU7HvFRyGp
         P7DwmR2s0pSAWzWGRGjwDCSLbYYR8JkE7FFXpIxEqTueYRL8FKUXkWtfm8lwYSWzyB
         O9AvM7fhU4BaA==
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: separate out iostat feature
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210820035229.216975-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0d38cd03-ad4d-38ee-35e6-a4582a3423ee@kernel.org>
Date:   Fri, 20 Aug 2021 18:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820035229.216975-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/20 11:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added F2FS_IOSTAT config option to support getting IO statistics through
> sysfs and printing out periodic IO statistics tracepoint events and
> moved I/O statistics related codes into separate files for better
> maintenance.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
