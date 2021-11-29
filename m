Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94395460CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 03:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbhK2C3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 21:29:38 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]:59006 "EHLO
        codeconstruct.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhK2C1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 21:27:35 -0500
Received: from [172.16.68.45] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4D55720181;
        Mon, 29 Nov 2021 10:24:17 +0800 (AWST)
Message-ID: <0b6aec80835439afe62010a4228fc1af49f68e2b.camel@codeconstruct.com.au>
Subject: Re: net/mctp/test/utils.c:15 mctp_test_dev_tx() error: use
 kfree_skb() here instead of kfree(skb)
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 10:24:15 +0800
In-Reply-To: <202111250652.KJ5iJFpx-lkp@intel.com>
References: <202111250652.KJ5iJFpx-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> smatch warnings:
> net/mctp/test/utils.c:15 mctp_test_dev_tx() error: use kfree_skb() here instead of kfree(skb)

Thanks for the report! I've sent a fix, you're CCed.

However, I can 't seem to recreate the smatch warning; could you include
the build command you're using for these? I've tried with

    make [...] C=1 CHECK=/path/to/smatch

using smatch 4f2585888, but that doesn't report the error you've listed
there. Do I need any specific CHECKFLAGS?

Cheers,


Jeremy

