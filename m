Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0035D269
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhDLVNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 17:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbhDLVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 17:13:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5DCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qxt5hGUGCIOriu3kYww5GhknJDLjCA6JPdqgUUXGgoM=; b=VLET7wPtaKrRRfzF3FNJlosHRs
        53TLpy3ZIicI9BERoQtjnoFJlwpUzX8HnbaYJsoxLg5uBj+SKIZj6qAi3eWpDydUCJP9/HpJmwFAr
        Z56xeKGBAEub2TWsJq5FtlCH/A3wCmS4v0aEtWXrQcdSlDjaq42QuTNBbdJOukIrhyAa7UaePgnpe
        nKBsKF11XQGNYYBamyaHJHf+M1c3TOmzwEO7LD2xhMwJ53WoamQYVhMGwUIUj3iK5WfW7S7vmoiu9
        zXvWat8+TfVWJl3owoRTgnQMog6i6FUooBAO/LmAoGM2KcrdqVp310Y1NyVR4jSOCQzhil7G26Cpc
        ZRTeIWhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lW3rh-004tEt-Qe; Mon, 12 Apr 2021 21:13:04 +0000
Date:   Mon, 12 Apr 2021 22:13:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove
 camelcase
Message-ID: <20210412211301.GO2531743@casper.infradead.org>
References: <20210412210258.8061-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412210258.8061-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:02:58PM +0200, Fabio M. De Francesco wrote:
> Removed camelcase in (some) symbols. Further work is needed.

What would be more useful for this driver is making it use
drivers/net/wireless/realtek/rtlwifi/btcoexist/ which has already
graduated out of staging.  I haven't checked how closely it matches,
but this is surely a better use of time than "cleaning up" this version.
