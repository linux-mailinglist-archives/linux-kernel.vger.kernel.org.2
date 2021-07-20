Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9253CF11A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbhGTA1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242159AbhGTAXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:23:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB30C600D1;
        Tue, 20 Jul 2021 01:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626743074;
        bh=RPXkB20FKT91RU0xvgWTL8V/qTewlOmPJA7L6IT8MNQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I9iOc7Si61GdhzHbktPjMN/k9cChM95UflBRXWHCM6KojM9cnX9+6e1a6vJP/kDQN
         m5reAgiwr5qU2ZRbeAsRflNLRKjkz2eHpPHWc74zYSdmLq2PWPe3u9wfgAZbvNJe7R
         S6qGzwzAWzLM2aF7gr9nUayoCsvo4LAVn7TwuEPdyG2rX1gquXxnXWSFEVm5D/eir9
         ESsKS+znCSyCrGDJpLOC81nDUViiWaSStrW3zSoK1mNFNHWbHFDiw/CAAdJPg7ceSv
         o00Eg7sDDXRyVaMuxKbYoli1fAtjgWNJe1XHTl5QD4KHHKqhRot0gxQwmcRfSbdG9A
         uKKYBEGCSJ8wQ==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: let's keep writing IOs on
 SBI_NEED_FSCK
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@kernel.org
References: <20210714231850.2567509-1-jaegeuk@kernel.org>
 <YPXJj+63rNtcnGdy@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <89067443-81ad-ce81-2765-44625d59dbeb@kernel.org>
Date:   Tue, 20 Jul 2021 09:04:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPXJj+63rNtcnGdy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/20 2:50, Jaegeuk Kim wrote:
> SBI_NEED_FSCK is an indicator that fsck.f2fs needs to be triggered, so it
> is not fully critical to stop any IO writes. So, let's allow to write data
> instead of reporting EIO forever given SBI_NEED_FSCK, but do keep OPU.
> 
> Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
> Cc: <stable@kernel.org> # v5.13+
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
