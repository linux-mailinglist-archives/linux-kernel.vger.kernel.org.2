Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD78E445074
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKDIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhKDIkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 103906103C;
        Thu,  4 Nov 2021 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636015065;
        bh=UUdsOFrh+rc0mbbv6xSMpXFRcvxooFtztvPg94FpMFE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QQLDiPwlKQK00b9DSYsRq7gSj8PMyS3nylqUaUcN76Gr3L5cBeJSdjUST+tZh893v
         ymAlIbeZWF9IP0qwkbwuFDHDW/CAOk84T1sYPKDCeEpIkuMBog44bthgp3kpMT31dr
         OnIKDcYyjNcaPHGbpGQiZnaX9D0IWB0Gcr5MCFzYxzqkpj1EdZOyimb1K7/A+14gJK
         /M/dyBlubYu18/KMIszhn8//iAsx5Xb5cBa5ebNrr3wKfLwBbcppY9IZs8oacP2Mja
         +TxDDaz7dBMInLIKffffcrKxu0icseAfV6IG1x0zJreU3GS7acuH5dfm7O/0H5GzbW
         ZUeuMIKtEb7SA==
Message-ID: <b071e877-334e-b669-e2df-abe4d5927418@kernel.org>
Date:   Thu, 4 Nov 2021 16:37:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] fs: f2fs: fix UAF in f2fs_available_free_memory
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sahitya Tummala <stummala@codeaurora.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20211104082202.1286551-1-mudongliangabcd@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211104082202.1286551-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/4 16:22, Dongliang Mu wrote:
> if2fs_fill_super
> -> f2fs_build_segment_manager
>     -> create_discard_cmd_control
>        -> f2fs_start_discard_thread
> 
> It invokes kthread_run to create a thread and run issue_discard_thread.
> 
> However, if f2fs_build_node_manager fails, the control flow goes to
> free_nm and calls f2fs_destroy_node_manager. This function will free
> sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
> after the deallocation, but before the f2fs_stop_discard_thread, it will
> cause UAF(Use-after-free).
> 
> -> f2fs_destroy_segment_manager
>     -> destroy_discard_cmd_control
>        -> f2fs_stop_discard_thread
> 
> Fix this by stopping discard thread before f2fs_destroy_node_manager.
> 
> Note that, the commit d6d2b491a82e1 introduces the call of
> f2fs_available_free_memory into issue_discard_thread.
> 
> Fixes: d6d2b491a82e ("f2fs: allow to change discard policy based on cached discard cmds")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
