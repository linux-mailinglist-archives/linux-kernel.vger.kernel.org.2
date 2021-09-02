Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0B3FEF3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345452AbhIBOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345380AbhIBOPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A65661057;
        Thu,  2 Sep 2021 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630592077;
        bh=DVAsHIsJD7iFHpLVGXizimiu/8do/vccItG0f7F+Iys=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=s+jwjSCy2dFMjEkXniOZnpqcviUIxHmjT+b50QoEHKXFvk6/J9VEG6GZaBGo+EWkw
         Gn+tw8y+DdlUGLrD99+wLQ9K1CmPDW3q/a8jWt4e9dN+ApKMWkG7B2ElGbQy4pmzTm
         kbCX+BaioAtZtrLNijSzmUwa3ojoQ0RNRzVUP2ukkzd9r1dSQ1faLqAtlSVKwVxGBG
         5DpnchAqUANnzQAjYyP/jsTH5+x+mX5WhS+NXI0DtTeeuciEfDIkhTy8PzPqWlQypx
         Yc8PeWDY0EUsCeL4ANav3JXAIzjmCaXEown9VqEDIAU7YZ8ltDmbMJQ/cYOP8dI7D1
         7pSnPhdofv9YQ==
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce fragment allocation mode
 mount option
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20210831051037.3108944-1-daeho43@gmail.com>
 <33e7e327-5318-e30f-4419-42497fe90b31@kernel.org>
 <CACOAw_wyLX_mnnPV0vWeAqTtEDx_bhG2c72jq6YmjQGOgtVLeg@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <04c6fb07-0e56-bfda-44b2-8fcb4a9fe72a@kernel.org>
Date:   Thu, 2 Sep 2021 22:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_wyLX_mnnPV0vWeAqTtEDx_bhG2c72jq6YmjQGOgtVLeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/1 23:17, Daeho Jeong wrote:
>>
>> if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG)?
>>
>> It needs to randomize position of next segment only in fragment_seg mode? IIRC.
>>
> 
> I want the randomness of segment allocation in fragment:*_block mode
> to simulate real filesystem fragmentation.
> How about just using fragment:rand_block for the simulation. I mean we
> can use segment randomness for fragment:segment and
> fragment:rand_block.

Okay, so it needs to describe that fragment:rand_block option has implicitly
enables fragment:segment option in document?

> 
