Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857742C2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhJMOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233590AbhJMOUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:20:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FDEC610CB;
        Wed, 13 Oct 2021 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634134699;
        bh=o4y3ndbyguXXtobJH495oY++cOr/9vmGtB8WTaG/fpU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=av+dZT88Z7sB4/D4rZDz/3/76Rv7wPRbzhefNoP52xc09A28Tl1oUmSPBUeKsrMYT
         ACebys9J1xqMDsiVHHaVra8KMWUVwy7Ee+t/uZuQLruSzaJFUxw2U51F6WAxjeaXV5
         4ITzaH194SQ3y8sAPselBloAPvhmSL/b8sLOQrd9w+1dMdg19PSC+xlcH+NsnSPA1d
         hivnPn5Pzba/yZXb6dY5c/COdghhEv2D27K8/4alD2J/9l1sJw1NBNe1yicu4rc3cK
         PjqpLeB5XqMFs8WXfJ6kbIvG5MABD81Iln+9iTunyGH0+gVgYg4uD8wKbx65LoOKSQ
         GdplvWJKaj2Xg==
Message-ID: <7feca651-b87d-2d00-7a2e-5e66b4f81221@kernel.org>
Date:   Wed, 13 Oct 2021 22:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] f2fs: replace snprintf in show functions with sysfs_emit
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1634095744-4579-1-git-send-email-wangqing@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1634095744-4579-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/13 11:29, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> Fix the following coccicheck warning:
> fs/f2fs/sysfs.c:198:12-20: WARNING: use scnprintf or sprintf.
> fs/f2fs/sysfs.c:247:8-16: WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
