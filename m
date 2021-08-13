Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACF3EAE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 03:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhHMBLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 21:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhHMBLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:11:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0D9960E76;
        Fri, 13 Aug 2021 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628817036;
        bh=P7xrO+NWCshb+QKSx1kQ2DBMJrqKOnLzFvqQxOil/BE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kl7TrLP/5h9CvllOQjZR9r6uVrWwfMKkvLxNHVgyOnqQ7TMn7HAYXWpH0gXqKjQFe
         ywBo783miVG5l7P1ZkEyl1B8HTTzcH9QAunKRNpMp91vdbzsB1hWzVxlN41SuWPplf
         R6ck2Ds1i6mba//CD7+SLuc/2FUlRkRobN/3vV+do3+aO7+a19FKbc+q9xzF4U1voz
         FSrShmg2DtEO0HUMgb37LTw+JovpffqtUcTe48wD6PjhldmMX2Mm0ww0UrTQbJ5/hH
         y8b6uN2k90fR9BjKatRfK01zmxFPZkgn1sB1HvFUKajlUBd9MxNCXfQdEetEckZmvJ
         bHBr82LmeyDnA==
Subject: Re: [PATCH v2] f2fs: improve sbi status info in debugfs/f2fs/status
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210811044557.23951-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6b198991-f092-0350-2257-87a25812b5a0@kernel.org>
Date:   Fri, 13 Aug 2021 09:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811044557.23951-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 12:45, Yangtao Li wrote:
> Do not use numbers but strings to improve readability when flag is set.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
