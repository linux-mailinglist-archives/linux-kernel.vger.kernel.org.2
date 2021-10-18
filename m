Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FE430F56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJREt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:49:59 -0400
Received: from verein.lst.de ([213.95.11.211]:60374 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhJREt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:49:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F39BA67373; Mon, 18 Oct 2021 06:47:45 +0200 (CEST)
Date:   Mon, 18 Oct 2021 06:47:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     Hao Sun <sunhao.th@gmail.com>, Hillf Danton <hdanton@sina.com>,
        hch@infradead.org, willy@infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __init_work
Message-ID: <20211018044745.GA23657@lst.de>
References: <CACkBjsZfAZpOFeYC8mQ03r_JB_eF-dNMEkXf3LNji7_CgOCF2Q@mail.gmail.com> <20210907074432.3711-1-hdanton@sina.com> <CACkBjsYsxNqkup1FQkP4eMzxZ_xNgifPx+gFxEo0gnBUYPp1PQ@mail.gmail.com> <d242861c-5c41-0d1b-3f71-43f50e5a3b68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d242861c-5c41-0d1b-3f71-43f50e5a3b68@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Oct 18, 2021 at 12:43:38PM +0800, Zqiang wrote:
> This is the details of the test, Hope it helps you

Call me stupid, but I can only find the trace and linked to unreadable
google sites that wan't me to log in somehow and no actual details.

If you have a direct link to the reproducer (an attachment would do
it as well) I'd love to try it myself.

Otherwise this commit in the block-5.15 tree should help to catch what
I suspect is the root cause (final ref drop before unregister) earlier
and with a better backtrace:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.15&id=a20417611b98e12a724e5c828c472ea16990b71f
