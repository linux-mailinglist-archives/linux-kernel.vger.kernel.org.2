Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0B3E92EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhHKNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhHKNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 839D160FA0;
        Wed, 11 Aug 2021 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628689496;
        bh=O8JVrrpaXEdBnuTdYmtvCs5et+qsGlYfUIcqodvrCBE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Yz74ZQLD53yvkil+NzYu2wm3YsMgcxktWknb8nC7AEKeFG+yvFgCXFTDUs5rfsBDd
         yqnZsm6sPsP1EozaxLn+8Jt+VHw92MXkVjbH2/DAIbQOg50bL5X+w6q8CJvfy1wkCf
         GcyHHEv+UJhch2vE+bF7sHp7tXcPNGWOi67HfjLYl3u68dAJVZecROITNUuaa0E1V5
         AyfTOt0kpDt3Cnd2lLtVLESeJvmOoBapYUtkGlnQgKsvDZGs55Vm791r7iqHtUDZP9
         HzTHVe//INUnEATMvKlWoYqUU5AS421qKZw/ws8VmQ28owyJt9qZPjMl+Ju/mXwHWB
         5MS3U4BQPRfAA==
Subject: Re: [PATCH 2/2] fs: Don't create discard thread when device not
 support realtime discard
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Fengnan Chang <changfengnan@vivo.com>
References: <20210811131826.223141-1-frank.li@vivo.com>
 <20210811131826.223141-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fc34fe7c-c7ec-3783-8cbc-de91ab81ee0a@kernel.org>
Date:   Wed, 11 Aug 2021 21:44:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811131826.223141-2-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/11 21:18, Yangtao Li wrote:
> From: Fengnan Chang <changfengnan@vivo.com>
> 
> Don't create discard thread when device not support realtime discard.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 363779a4402d..bc4ac46f3041 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2161,6 +2161,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	init_waitqueue_head(&dcc->discard_wait_queue);
>   	SM_I(sbi)->dcc_info = dcc;
>   init_thread:
> +	if (!f2fs_realtime_discard_enable(sbi))

How about below case:
- mount -o nodiscard <dev> <mp>
- mount -o remount,discard <dev> <mp>

Thanks,

> +		return err;
>   	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
>   				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(dcc->f2fs_issue_discard)) {
> 
