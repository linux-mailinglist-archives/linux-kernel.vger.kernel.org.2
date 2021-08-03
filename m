Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41613DE3FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhHCBcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233208AbhHCBcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:32:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC3160F48;
        Tue,  3 Aug 2021 01:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627954310;
        bh=axpOchdr5vlkrhvkDUEdjCDRs8DN3pSH05qYR6dKJOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SUBfynMUq3I+JJ7il44iw4gcmWdwVhArW47qDaJKzcUVB/Banti8XtS1E9+6Gdb6e
         f+gKajdTxapUVsRl3fIryZ5+WHrLHvkmaQyKEj8MQtjssupponON/Ib9d1M+b1xVPN
         Uo31/RGqzDw3m/7Wt7uc/z4z54yvxTnm3UJqfaRbpzEY0q3Zukr073Qa4vHK+Yjnz9
         cFZE3zOnBjSzgFZWunEvqA0J7Nna8evSruh5iOZ8oOpVYAZC0jJn8FC1yzxcG4w+NS
         8FKzfdPdYJHEfC3dOf9Vqg1EF+g5KFoAowJ/z/ITyordquqc1XokOsOaSe6fJkFZyV
         q0rwh2lXVhhEw==
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
 <YQgziuikMr0fvlT7@google.com>
 <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
 <YQia9FBvQIRgr6cm@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <88858001-d5e0-257f-0b8f-97906ddfc43f@kernel.org>
Date:   Tue, 3 Aug 2021 09:31:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQia9FBvQIRgr6cm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/3 9:25, Jaegeuk Kim wrote:>> Please check description in patch message, now it was designed only for
>                                                   --
>                                                   what do you refer "it"?

Oh...I mean this feature I proposed: unaligned extent support.

Thanks,
