Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88520307A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhA1QOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232401AbhA1QN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:13:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9BF664DED;
        Thu, 28 Jan 2021 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611850366;
        bh=Fr4FmilKLR3go1KurekhCtnXdnRdts4djKUeKMq8EgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFgKayhn5J/n+Vz/FNdjK5zD7/6H+v1bg4SVq1QMisEEPoYrGbu3OJSDOWmkMXQVO
         gm3cFei93aeupg+Ne4kz2QBo91/mMqcdtVWe/d3UWz1X9qaydT3jeB/1spFkncd7yo
         4KTj+WvdBxq8jltpxWDqFZbQH0iN/ZYVIiueI5ydQExpqEw6Yys1aNUkToZOzIHxb5
         cf1RDh3um05fcTuCdf5sktcbPSzyazzSS19zKr6+z+WNW4aWSSNHlMQ4gYjAR4DQ2u
         ArgfbjWn/Ztmxg/F99u1ktNhmc1uDLtJE5jWcZcWDsX9CYNc5admjsxW/DoNqjFDxD
         Sn9Ojk2Qpq6RQ==
Date:   Thu, 28 Jan 2021 08:12:44 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3 1/5] f2fs: compress: add compress_inode to
 cache compressed blocks
Message-ID: <YBLifNK5EXedfhbs@google.com>
References: <abc09f9f-561d-df8a-b835-6b5d7a15232c@huawei.com>
 <X/8UtJU9Dy30kC7I@google.com>
 <37ba41db-2589-e155-c416-d0c8832026cb@huawei.com>
 <X//DPI10+ZXvHkYH@google.com>
 <8e88b1e2-0176-9487-b925-9c7a31a7e5cd@huawei.com>
 <YAGt0i244dWXym4H@google.com>
 <20a1dbd3-808e-e62a-53f3-7f1e2a316b3c@kernel.org>
 <YAdSTzYF8Hvxdcqy@google.com>
 <068da0d3-18c9-53f7-0f24-63b07e1af272@huawei.com>
 <9b982458-57e1-a04d-c5d4-f5ca775af1e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b982458-57e1-a04d-c5d4-f5ca775af1e7@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, Chao Yu wrote:
> On 2021/1/22 10:17, Chao Yu wrote:
> > > No, it seems this is not the case.
> > Oops, could you please help to remove all below codes and do the test again
> > to check whether they are the buggy codes? as I doubt there is use-after-free
> > bug.
> 
> Any test result? :)

It seems I don't see the errors anymore. Will you post another version?

> 
> Thanks,
