Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1CA326B69
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhB0Dgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:36:54 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:43690 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhB0Dgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:36:47 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id EA1591B4053;
        Sat, 27 Feb 2021 12:36:05 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 11R3a4L9550499
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 27 Feb 2021 12:36:05 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 11R3a4mS2958395
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 27 Feb 2021 12:36:04 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 11R3a4MC2958394;
        Sat, 27 Feb 2021 12:36:04 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix zero_user_segments() with start > end
References: <87eeh2erm0.fsf@mail.parknet.co.jp>
        <20210226205139.GI2723601@casper.infradead.org>
Date:   Sat, 27 Feb 2021 12:36:04 +0900
In-Reply-To: <20210226205139.GI2723601@casper.infradead.org> (Matthew Wilcox's
        message of "Fri, 26 Feb 2021 20:51:39 +0000")
Message-ID: <87zgzq89nf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Feb 27, 2021 at 01:11:35AM +0900, OGAWA Hirofumi wrote:
>> zero_user_segments() is used from __block_write_begin_int(), for
>> example like the following
>> 
>> 	zero_user_segments(page, 4096, 1024, 512, 918)
>> 
>> But new zero_user_segments() implements for HIGMEM + TRANSPARENT_HUGEPAGE 
>> doesn't handle "start > end" case correctly, and hits BUG_ON(). (we
>> can fix __block_write_begin_int() instead though, it is the old and
>> multiple usage)
>
> Why don't we just take out the BUG_ON instead?  The function doesn't
> actually do the wrong thing.

end1 is underflow with

		if (start1 >= PAGE_SIZE) {
			start1 -= PAGE_SIZE;
			end1 -= PAGE_SIZE;
		}

>> Also it calls kmap_atomic() unnecessary while start == end == 0.
>
> I'm OK with that.  It always used to do that.

Old one is only one page, so it is always necessary if start1/end1 or
start2/end2 is valid range. But this one is multiple pages, so there are
completely unnecessary pages possibly.

>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Fixes: 0060ef3b4e6d ("mm: support THPs in zero_user_segments")

OK.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
