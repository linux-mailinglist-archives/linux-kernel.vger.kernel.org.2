Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EC33F05EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhHRONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238320AbhHROMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:12:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66310610A7;
        Wed, 18 Aug 2021 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629295918;
        bh=AQfgKebWJLpeUBl2arSYIWfhz41gG8NbDvI7MDRVrSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hOeFRigng7zChfxruaxhq7Uqn6Bx6YDu948lJMmvuy1kzjuMZo8GSDqD2QdERXBPn
         2Uggqe0k/CDDxqPnO1+5pa4sQd8j9rpFSgl6Ayxm0eD9gcpyplPL303fvxW8/U97Jg
         lSexQmYBWQ2M8kd/do8MCkHQkrD8p+uM53SBVZHE6gkP/IV51GsKrmqH6x5cMGL+Ym
         VoPwLpIcKRwPSay8rRrYaJH91HBP94GKgFLmIlv/0KzDPbx+HZxqSiO2qMpKPUdXym
         8BI+9X02ct1IkGXQ0XgaMUl5XRYIbNezqmpj0knFnU3L7oFZ7xIQHOXC8hMkDQ/0fU
         wyonOm5Si/aIA==
Subject: Re: [PATCH 2/2] erofs: add fiemap support with iomap
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        nl6720 <nl6720@gmail.com>
References: <20210813052931.203280-1-hsiangkao@linux.alibaba.com>
 <20210813052931.203280-3-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <39e06954-8fc2-3d08-dff5-8e39c97ac259@kernel.org>
Date:   Wed, 18 Aug 2021 22:11:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813052931.203280-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/13 13:29, Gao Xiang wrote:
> This adds fiemap support for both uncompressed files and compressed
> files by using iomap infrastructure.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
