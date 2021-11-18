Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097DC4554E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243443AbhKRGuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242636AbhKRGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:50:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA74761B2B;
        Thu, 18 Nov 2021 06:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637218071;
        bh=DJpzKUbCCipn2+BKNfoZijfmyxFp2BqYSAJ04JRQyOo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UZMqTr92EsMWd+v4oNLGRfL20jTxirfEjoX/eNdJHTzcP2+S6HOkNrPjLsg05ZW+e
         8PPhS1qZIQa2SvQTvYZ0ICPuWjlJohsHnxvMyBGfoWwiYizybzpY82Qtktjg2Bwxpb
         2+WG0GejXJCEBfCQvXPNtU4u7XJX9AhyJcmPyxa9QB9ipUjlUcUwcZflgT00eXWUa1
         AjExjXWgAm3ePhlZnqP1wbzbPye4EdgtEdHBvq4z/bEh5e2drXbRlrO5go52LT/Q92
         0XVi39AfZZHBoDDZ2kNVNH1MZ19t3JxvGvGkWNWHnVeCAvg5Cmy8P1MGBunES94KKf
         jL+BxZlhFa8Kw==
Message-ID: <8d4dc13b-a4a8-0b17-fe0b-f2e343be0083@kernel.org>
Date:   Thu, 18 Nov 2021 14:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: rework write preallocations
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@google.com>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <e9cad692-148b-2d4b-2017-fd0a2ebd2833@kernel.org>
 <YZVXtAFIGqOAYYVF@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YZVXtAFIGqOAYYVF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/18 3:27, Jaegeuk Kim wrote:
>> /* do not preallocate block which is partially written */
>>
>> Otherwise, it looks good to me.
> 
> Applied with this.
> /* Do not preallocate blocks that will be written partially in 4KB. */

Better. :)

Thanks,
