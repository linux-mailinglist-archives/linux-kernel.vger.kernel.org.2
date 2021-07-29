Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9743D9A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhG2Ak5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhG2Ak4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:40:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A843C6103B;
        Thu, 29 Jul 2021 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627519254;
        bh=uNIc7pfoGu/FJThfBBj9+RPriWv7zO4JIA2SEJzetJU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OdyQCOsKhEDk9fPkieTeaxQN+hnutClJj5EUNp7HUhg8oXNR3w0AryUxZnQxWrUCv
         Eq66HIf/Y7hi8i2sG2U3ICf8Bpe08driDJnah557lnpQMWGVZuE+KHQ9YMFLo6iDEo
         2rCgB5+H90rEHaH2pdeeM5Sv1NOv1P22K58TWFyJDHgWWGU5Jmr5TH4G+aaXDUGvi/
         x1L2gA5CYtYWzK/CA5nXoOoizBq1AabMCzQKmo/AEtd3JNwSiE0PL9T6/lqYk42tZ7
         JnYCmWWUokYUJ2Mntn5gPWnPe7BmRQbmv7YQNM16u1Y3fzgbourJ9MXcBulFnWN++0
         ZT6jyeNs4HVSQ==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>
References: <20210726041819.2059593-1-daeho43@gmail.com>
 <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
 <YQA/orZ5wXjwWeyy@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8c0d05d2-3988-a8a4-5403-1173f25b822b@kernel.org>
Date:   Thu, 29 Jul 2021 08:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQA/orZ5wXjwWeyy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/28 1:17, Jaegeuk Kim wrote:
> Do we really need to catch this in fiemap? What about giving the current

Yes, I think so.

> layout with warning message and setting NEED_FSCK?

Sure,

How about doing sanity check on cluster metadata whenever it is going to
be accessed, like we did for single blkaddr with f2fs_is_valid_blkaddr()?

Thanks,
