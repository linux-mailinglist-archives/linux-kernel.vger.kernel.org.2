Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554603DC1A5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhG3XlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234151AbhG3XlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:41:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B779660EE2;
        Fri, 30 Jul 2021 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627688478;
        bh=dBi7PUBE2gAdvWe3vzHih6pDhoOWgVe0oOpHF6CMmv0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K5bSvfe73MQxuPsUIQtW18p5P4kjucbXM28QkJf0LkNCJjBnF5y2tgrNNnXc7DbNw
         LzcNrLEA9+GD8aC0Y+BvuUId8xztzSYG4bya5iSwkx0Nr63cX5qXlCGNn6vphomzET
         esMGkYdMNV6XaCUZMGKs6i2r1qX7FIjZvJYe0IzvEW1h5KHwk3JrBAyZg5MPQCNVD4
         2xpjuORpF0QBWyO4oYvVoajlMD3OvBK1q46GjDc4zZ78q+EZkmPdDUegnpQzXqvODN
         XwToiCiXhT0UKH+UcOQogQ/sVKiHz9C0SvUCj/LvcdKfFwmPslduNajAFGEaM6jAXg
         rYhA7gktPFZ6w==
Subject: Re: [PATCH] f2fs: introduce nosmall_discard mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210730100530.4401-1-chao@kernel.org>
 <YQREtmDLBNKSQViC@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
Date:   Sat, 31 Jul 2021 07:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQREtmDLBNKSQViC@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/31 2:28, Jaegeuk Kim wrote:
> how about adding "discard_gran=[small|segment|section]", and keeping discard_map
> in the small case only? And, I think we should set the section mode for zoned
> device automatically.

Yup, better,

About the naming, it look discard_gran is not clear here, since there is another
sysfs entry /sys/fs/f2fs/<devname>/discard_granularity has the same name, and
also semantics of newly added mount option is not only control the smallest discard
size, but also indicate discard start offset should be aligned to segment or section.
So how about using: "aligned_discard=[none|segment|section]" instead?

Thanks,
