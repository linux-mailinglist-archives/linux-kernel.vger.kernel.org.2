Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F444AF41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhKIOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhKIOQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:16:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0D4A610F7;
        Tue,  9 Nov 2021 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636467222;
        bh=MGSLQGW0xc+DWm75GDocxEAYZtiWV6/1Wnd11MV/x94=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=oRrqWIRCbAaEdvxSdsHnyKJyAa/MADjFZmJ3o63qG24rIe09sW/RlgaARBniDC8Wu
         e7max1r7YnvQxCljCB44a5zYfm3o2UwkaxmL97h0eNT90nM8zQaoD/RCN1CWtYawp9
         Z5HwmnrrEqt7OE2ThrCToY974bmcwvvHoIMS5gr3/vXWOvBsYniBXjq77Y0zTrIfdh
         B+NrSJAc25dV9cuRLC2T67RePBSqDLgknlK997Cu+9CBv+VgFHSKVL1wvQBGTtlx88
         ljoYxyZhOKa1uV2Uuq7IAVAl+od35YnxCXhK2Dn6YEMqZNPz4bEOjvQNwih9ix7jzv
         /qU/dZB6vPfcw==
Message-ID: <e7a51ef7-730e-1fe1-8e2d-284bf70841e9@kernel.org>
Date:   Tue, 9 Nov 2021 22:13:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: provide a way to attach HIPRI for Direct
 IO
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211109021336.3796538-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211109021336.3796538-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/9 10:13, Jaegeuk Kim wrote:
> This patch adds a way to attach HIPRI by expanding the existing sysfs's
> data_io_flag. User can measure IO performance by enabling it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
