Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB53FD29B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 06:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbhIAE61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 00:58:27 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45982 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhIAE60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 00:58:26 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLIH7-00092F-SR; Wed, 01 Sep 2021 04:55:02 +0000
Date:   Wed, 1 Sep 2021 04:55:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, song.bao.hua@hisilicon.com,
        linux-kernel@vger.kernel.org,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YS8HpUz9FUcFWt0V@zeniv-ca.linux.org.uk>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> Hi Everyone,
> 
>     In the NUMA, we only have one page cache for each file. For the
> program/shared libraries, the
> 
> remote-access delays longer then the  local-access.
> 
> So, is it possible to implement the per-node page cache for
> programs/libraries?

What do you mean, per-node page cache?  Multiple pages for the same
area of file?  That'd be bloody awful on coherency...
