Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8D433670
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhJSM7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235689AbhJSM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:59:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED4461360;
        Tue, 19 Oct 2021 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648213;
        bh=rpzdWCUEobf/IDekmzPNEYMxSWhS5XWJoeBbvCLEQ2U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SkAI15oe3aJqLCpSAzrO1oNSzlppscoCUOiUzA7fi5zu5mUJQpLt+Sa3RWydsPguM
         dsNBiEP7+oW61RI4tzrMR0HfkwfNwH86kvNPsO+0v4pgkPLrX4itZVmg05Usljt3CS
         aTh0bKM+noFjYEpCyQEa9/GI6ANXD4XEXQ+JhJktuCUAJW8iNONdW7o4trS39Fnkc2
         vI5I9/+PAnkXymgQYL0ovGmzFysbOBVTavIqa+3EwcKrMQ3ZINlXokDxm0mEv2klK6
         xEpCCOLbDPkh3fonvx/HGEzuARRjoZIT5bPtjEbc+vyLnYBZNAmcx0/NJChmnE0zDp
         WTjbJoHioE+3A==
Message-ID: <bec868c6-02c3-5f6d-c5d4-84cb4e1c9cb1@kernel.org>
Date:   Tue, 19 Oct 2021 20:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 2/3] erofs: introduce the secondary compression head
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@yulong.com>
References: <20211009181209.23041-1-xiang@kernel.org>
 <20211017165721.2442-1-xiang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211017165721.2442-1-xiang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/18 0:57, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
> lcluster to indicate whether the whole pcluster is compressed or not.
> 
> In this patch, a new HEAD2 head type is introduced to specify another
> compression algorithm other than the primary algorithm for each
> compressed file, which can be used for upcoming LZMA compression and
> LZ4 range dictionary compression for various data patterns.
> 
> It has been stayed in the EROFS roadmap for years. Complete it now!
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
