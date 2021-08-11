Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A243F3E87D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhHKCJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231675AbhHKCJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:09:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC2360184;
        Wed, 11 Aug 2021 02:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628647734;
        bh=3S2tMeEv9IRqGtcTdirfmJcSlo7WSmHQLt2P2gsdJzg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fO8/3/o3xQw3bG2kdDlIT+Pb9Db/amqnbIrfRaqBTmezaJXU6prnfXIZTnyOwPTrV
         uj0Cfsq+iMe5Vf2cGRwv2HHITOALaEZunnQNQfW6tMJxyk9FW9fWIh2X73Vq3Zjp1G
         LZC76xBDNouyzCKEAMFv196CZESPb02PeY89p7wRroZKpaf51ynRtkZZSzPJuJC5Es
         rNJAixjepFJHEa5SEkiLqHtV0nq6PdLUP7NtRkHJ2AbZmTG/aGL2fz/Ibm7DPqZe7V
         xWwDW1UGKStuiF8GRIOY7EGFSzgTxY1IJGDfRCiZo8gRYUBgF+X7XCnw2OtHDpL8nf
         YXLgVJoo90ZLg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: correct comment in segment.h
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210810132707.349147-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <de86a973-947c-d764-dac4-1f3da19980b5@kernel.org>
Date:   Wed, 11 Aug 2021 10:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810132707.349147-1-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/10 21:27, Yangtao Li wrote:
> s/two/three
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
