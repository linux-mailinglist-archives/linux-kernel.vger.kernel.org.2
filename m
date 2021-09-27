Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8323A418E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 06:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhI0Enx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 00:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhI0Enx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 00:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E08AD60FC2;
        Mon, 27 Sep 2021 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632717735;
        bh=pk7ao4lwSKT8hqV8of4HCbxjiNht+U6fu0GXzdmFxyU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kqyZ0MDU9gh8ewo+iNb92gbo8DLR7qb6XYNbz7wnYLg2D4vz2N9mYQ4W/hXIm2+iN
         8yRgKZXy6T8CbKgZm8xinEXAKNax8cnSnUmRtuXXVwYLnL7sXXnFIRKzU6Gv/BvW1M
         hC/xYj6LUuVfGxqcYIrinF2Bo5bZq0Np8yCw78NI=
Date:   Mon, 27 Sep 2021 06:42:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oskari Pirhonen <xxc3ncoredxx@gmail.com>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty/sysrq: More intuitive Shift handling
Message-ID: <YVFLo/aLbMWrmLtP@kroah.com>
References: <YU/6SCmUr9qGkqBu@dj3ntoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU/6SCmUr9qGkqBu@dj3ntoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 11:42:48PM -0500, Oskari Pirhonen wrote:
> Make Alt-SysRq-Shift-<key> behave like Alt-Shift-SysRq-<key>.

Does some documentation also need to be updated here?
