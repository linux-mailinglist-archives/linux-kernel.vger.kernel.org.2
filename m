Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E643ECC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 03:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhHPBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 21:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhHPBqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 21:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852B361423;
        Mon, 16 Aug 2021 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629078353;
        bh=SxypeM9TWK13ioZ51PaTNuaWJ0+FJZrfKlInnOOdxc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TBqIfSmmtZFaKUUhJD03CwDMC/xHp3W1tDnY4nJpFKUbyOSfV/1k0Ep8NeAlTcrS9
         TU6OUaP8wQJno3hobTFj3lhKe1aXSH9DDNguOkXsWmzwgS1z4jOlB+NC5oHqr7mGzM
         kM7JwTm9AV7VeZ4y873WsvADrPuvZqh1CHO27lKj8vW0p9ZCktJTv2uIRGTLEiN7Rd
         X2KZE2q2Ypl8ozQIPFac8+P+U+wPXrb3Dsvw5JR0ifRVDcNSqd3lf9g+wq/z2wakwo
         KiWmnJtwYLYSjd9PbGYaKoO97sX5chOwudF/+xilGJVVS16q/gZM28BpfVY+xGDTmY
         ZKzWEUjKwxNJg==
Subject: Re: [PATCH] f2fs: convert S_IRUGO to 0444
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210814103702.52405-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a1294424-3ce8-37a4-a3b4-3252cc55458f@kernel.org>
Date:   Mon, 16 Aug 2021 09:45:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814103702.52405-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/14 18:37, Yangtao Li wrote:
> To fix:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
